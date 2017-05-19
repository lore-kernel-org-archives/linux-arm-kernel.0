From: philippe.cornu@st.com (Philippe CORNU)
Date: Fri, 19 May 2017 17:20:18 +0200
Subject: [PATCH v2 5/5] drm/stm: Add STM32 DSI host driver
In-Reply-To: <1495207218-11372-1-git-send-email-philippe.cornu@st.com>
References: <1495207218-11372-1-git-send-email-philippe.cornu@st.com>
Message-ID: <1495207218-11372-6-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the STM32 DSI host driver that uses the Synopsys DesignWare
MIPI DSI DRM bridge.

Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
---
 drivers/gpu/drm/stm/Kconfig           |   8 +
 drivers/gpu/drm/stm/Makefile          |   2 +
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 328 ++++++++++++++++++++++++++++++++++
 3 files changed, 338 insertions(+)
 create mode 100644 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c

diff --git a/drivers/gpu/drm/stm/Kconfig b/drivers/gpu/drm/stm/Kconfig
index 2c4817f..cbda4df 100644
--- a/drivers/gpu/drm/stm/Kconfig
+++ b/drivers/gpu/drm/stm/Kconfig
@@ -14,3 +14,11 @@ config DRM_STM
 	  STMicroelectronics STM32 MCUs.
 	  To compile this driver as a module, choose M here: the module
 	  will be called stm-drm.
+
+config DRM_STM_DSI
+	tristate "STMicroelectronics specific extensions for Synopsys MIPI DSI"
+	depends on DRM_STM
+	select DRM_MIPI_DSI
+	select DRM_DW_MIPI_DSI
+	help
+	  Choose this option for MIPI DSI support on STMicroelectronics SoC.
diff --git a/drivers/gpu/drm/stm/Makefile b/drivers/gpu/drm/stm/Makefile
index e114d45..8730a59 100644
--- a/drivers/gpu/drm/stm/Makefile
+++ b/drivers/gpu/drm/stm/Makefile
@@ -4,4 +4,6 @@ stm-drm-y := \
 	drv.o \
 	ltdc.o
 
+obj-$(CONFIG_DRM_STM_DSI) += dw_mipi_dsi-stm.o
+
 obj-$(CONFIG_DRM_STM) += stm-drm.o
diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
new file mode 100644
index 0000000..914f203
--- /dev/null
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -0,0 +1,328 @@
+/*
+ * Copyright (C) STMicroelectronics SA 2017
+ *
+ * Authors: Philippe Cornu <philippe.cornu@st.com>
+ *          Yannick Fertre <yannick.fertre@st.com>
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/clk.h>
+#include <linux/iopoll.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <drm/drmP.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/bridge/dw_mipi_dsi.h>
+#include <video/mipi_display.h>
+
+/* DSI wrapper register & bit definitions */
+/* Note: registers are named as in the Reference Manual */
+#define DSI_WCFGR	0x0400		/* Wrapper ConFiGuration Reg */
+#define WCFGR_DSIM	BIT(0)		/* DSI Mode */
+#define WCFGR_COLMUX	GENMASK(3, 1)	/* COLor MUltipleXing */
+
+#define DSI_WCR		0x0404		/* Wrapper Control Reg */
+#define WCR_DSIEN	BIT(3)		/* DSI ENable */
+
+#define DSI_WISR	0x040C		/* Wrapper Interrupt and Status Reg */
+#define WISR_PLLLS	BIT(8)		/* PLL Lock Status */
+#define WISR_RRS	BIT(12)		/* Regulator Ready Status */
+
+#define DSI_WPCR0	0x0418		/* Wrapper Phy Conf Reg 0 */
+#define WPCR0_UIX4	GENMASK(5, 0)	/* Unit Interval X 4 */
+#define WPCR0_TDDL	BIT(16)		/* Turn Disable Data Lanes */
+
+#define DSI_WRPCR	0x0430		/* Wrapper Regulator & Pll Ctrl Reg */
+#define WRPCR_PLLEN	BIT(0)		/* PLL ENable */
+#define WRPCR_NDIV	GENMASK(8, 2)	/* pll loop DIVision Factor */
+#define WRPCR_IDF	GENMASK(14, 11)	/* pll Input Division Factor */
+#define WRPCR_ODF	GENMASK(17, 16)	/* pll Output Division Factor */
+#define WRPCR_REGEN	BIT(24)		/* REGulator ENable */
+#define WRPCR_BGREN	BIT(28)		/* BandGap Reference ENable */
+#define IDF_MIN		1
+#define IDF_MAX		7
+#define NDIV_MIN	10
+#define NDIV_MAX	125
+#define ODF_MIN		1
+#define ODF_MAX		8
+
+/* dsi color format coding according to the datasheet */
+enum dsi_color {
+	DSI_RGB565_CONF1, DSI_RGB565_CONF2, DSI_RGB565_CONF3,
+	DSI_RGB666_CONF1, DSI_RGB666_CONF2,
+	DSI_RGB888,
+};
+
+#define LANE_MIN_KBPS	31250
+#define LANE_MAX_KBPS	500000
+
+/* Sleep & timeout for regulator on/off, pll lock/unlock & fifo empty */
+#define SLEEP_US	1000
+#define TIMEOUT_US	200000
+
+struct dw_mipi_dsi_stm {
+	void __iomem *base;
+};
+
+static inline void dsi_write(struct dw_mipi_dsi_stm *dsi, u32 reg, u32 val)
+{
+	writel_relaxed(val, dsi->base + reg);
+}
+
+static inline u32 dsi_read(struct dw_mipi_dsi_stm *dsi, u32 reg)
+{
+	return readl_relaxed(dsi->base + reg);
+}
+
+static inline void dsi_set(struct dw_mipi_dsi_stm *dsi, u32 reg, u32 mask)
+{
+	dsi_write(dsi, reg, dsi_read(dsi, reg) | mask);
+}
+
+static inline void dsi_clear(struct dw_mipi_dsi_stm *dsi, u32 reg, u32 mask)
+{
+	dsi_write(dsi, reg, dsi_read(dsi, reg) & ~mask);
+}
+
+static inline void dsi_update_bits(struct dw_mipi_dsi_stm *dsi, u32 reg,
+				   u32 mask, u32 val)
+{
+	dsi_write(dsi, reg, (dsi_read(dsi, reg) & ~mask) | val);
+}
+
+static enum dsi_color dsi_color_from_mipi(enum mipi_dsi_pixel_format fmt)
+{
+	switch (fmt) {
+	case MIPI_DSI_FMT_RGB888:
+		return DSI_RGB888;
+	case MIPI_DSI_FMT_RGB666:
+		return DSI_RGB666_CONF2;
+	case MIPI_DSI_FMT_RGB666_PACKED:
+		return DSI_RGB666_CONF1;
+	case MIPI_DSI_FMT_RGB565:
+		return DSI_RGB565_CONF1;
+	default:
+		DRM_DEBUG_DRIVER("MIPI color invalid, so we use rgb888\n");
+	}
+	return DSI_RGB888;
+}
+
+static int dsi_pll_get_clkout_khz(int clkin_khz, int idf, int ndiv, int odf)
+{
+	/* prevent from division by 0 */
+	if (idf * odf)
+		return DIV_ROUND_CLOSEST(clkin_khz * ndiv, idf * odf);
+	else
+		return 0;
+}
+
+static int dsi_pll_get_params(int clkin_khz, int clkout_khz,
+			      int *idf, int *ndiv, int *odf)
+{
+	int i, o, n, n_min, n_max;
+	int fvco_min, fvco_max, delta, best_delta; /* all in khz */
+
+	/* Early checks preventing division by 0 & odd results */
+	if ((clkin_khz <= 0) || (clkout_khz <= 0))
+		return 0;
+
+	fvco_min = LANE_MIN_KBPS * 2 * ODF_MAX;
+	fvco_max = LANE_MAX_KBPS * 2 * ODF_MIN;
+
+	best_delta = 1000000; /* big started value (1000000khz) */
+
+	for (i = IDF_MIN; i <= IDF_MAX; i++) {
+		/* Compute ndiv range according to Fvco */
+		n_min = ((fvco_min * i) / (2 * clkin_khz)) + 1;
+		n_max = (fvco_max * i) / (2 * clkin_khz);
+
+		/* No need to continue idf loop if we reach ndiv max */
+		if (n_min >= NDIV_MAX)
+			break;
+
+		/* Clamp ndiv to valid values */
+		if (n_min < NDIV_MIN)
+			n_min = NDIV_MIN;
+		if (n_max > NDIV_MAX)
+			n_max = NDIV_MAX;
+
+		for (o = ODF_MIN; o <= ODF_MAX; o *= 2) {
+			n = DIV_ROUND_CLOSEST(i * o * clkout_khz, clkin_khz);
+			/* Check ndiv according to vco range */
+			if ((n < n_min) || (n > n_max))
+				continue;
+			/* Check if new delta is better & saves parameters */
+			delta = dsi_pll_get_clkout_khz(clkin_khz, i, n, o) -
+				clkout_khz;
+			if (delta < 0)
+				delta = -delta;
+			if (delta < best_delta) {
+				*idf = i;
+				*ndiv = n;
+				*odf = o;
+				best_delta = delta;
+			}
+			/* fast return in case of "perfect result" */
+			if (!delta)
+				return 1;
+		}
+	}
+
+	return 1;
+}
+
+static int dw_mipi_dsi_phy_init(void *priv_data)
+{
+	struct dw_mipi_dsi_stm *dsi = priv_data;
+	u32 val;
+	int ret;
+
+	/* Enable the regulator */
+	dsi_set(dsi, DSI_WRPCR, WRPCR_REGEN | WRPCR_BGREN);
+	ret = readl_poll_timeout(dsi->base + DSI_WISR, val, val & WISR_RRS,
+				 SLEEP_US, TIMEOUT_US);
+	if (ret)
+		DRM_DEBUG_DRIVER("!TIMEOUT! waiting REGU, let's continue\n");
+
+	/* Enable the DSI PLL & wait for its lock */
+	dsi_set(dsi, DSI_WRPCR, WRPCR_PLLEN);
+	ret = readl_poll_timeout(dsi->base + DSI_WISR, val, val & WISR_PLLLS,
+				 SLEEP_US, TIMEOUT_US);
+	if (ret)
+		DRM_DEBUG_DRIVER("!TIMEOUT! waiting PLL, let's continue\n");
+
+	/* Enable the DSI wrapper */
+	dsi_set(dsi, DSI_WCR, WCR_DSIEN);
+
+	return 0;
+}
+
+static int
+dw_mipi_dsi_get_lane_mbps(void *priv_data, struct drm_display_mode *mode,
+			  struct clk *input_clk, u32 lanes, u32 format,
+			  unsigned int *lane_mbps)
+{
+	struct dw_mipi_dsi_stm *dsi = priv_data;
+	unsigned int idf, ndiv, odf, pll_in_khz, pll_out_khz;
+	int bpp;
+	u32 val;
+
+	pll_in_khz = (unsigned int)(clk_get_rate(input_clk) / 1000);
+
+	/* Compute requested pll out */
+	bpp = mipi_dsi_pixel_format_to_bpp(format);
+	pll_out_khz = mode->clock * bpp / lanes;
+	/* Add 20% to pll out to be higher than pixel bw (burst mode only) */
+	pll_out_khz = (pll_out_khz * 12) / 10;
+	if (pll_out_khz > LANE_MAX_KBPS) {
+		pll_out_khz = LANE_MAX_KBPS;
+		DRM_DEBUG_DRIVER("Warning max phy mbps is used\n");
+	} else if (pll_out_khz < LANE_MIN_KBPS) {
+		pll_out_khz = LANE_MIN_KBPS;
+		DRM_DEBUG_DRIVER("Warning min phy mbps is used\n");
+	}
+
+	/* Compute best pll parameters */
+	dsi_pll_get_params(pll_in_khz, pll_out_khz, &idf, &ndiv, &odf);
+
+	/* Get the adjusted pll out value */
+	pll_out_khz = dsi_pll_get_clkout_khz(pll_in_khz, idf, ndiv, odf);
+
+	/* Set the PLL division factors */
+	dsi_update_bits(dsi, DSI_WRPCR,	WRPCR_NDIV | WRPCR_IDF | WRPCR_ODF,
+			(ndiv << 2) | (idf << 11) | ((ffs(odf) - 1) << 16));
+
+	/* Compute uix4 & set the bit period in high-speed mode */
+	val = 4000000 / pll_out_khz;
+	dsi_update_bits(dsi, DSI_WPCR0, WPCR0_UIX4, val);
+
+	/* Select video mode by resetting DSIM bit */
+	dsi_clear(dsi, DSI_WCFGR, WCFGR_DSIM);
+
+	/* Select the color coding */
+	dsi_update_bits(dsi, DSI_WCFGR, WCFGR_COLMUX,
+			dsi_color_from_mipi(format) << 1);
+
+	*lane_mbps = pll_out_khz / 1000;
+
+	DRM_DEBUG_DRIVER("pll_in %ukHz pll_out %ukHz lane_mbps %uMHz\n",
+			 pll_in_khz, pll_out_khz, *lane_mbps);
+
+	return 0;
+}
+
+static struct dw_mipi_dsi_phy_ops dw_mipi_dsi_stm_phy_ops = {
+	.init = dw_mipi_dsi_phy_init,
+	.get_lane_mbps = dw_mipi_dsi_get_lane_mbps,
+};
+
+static struct dw_mipi_dsi_plat_data dw_mipi_dsi_stm_plat_data = {
+	.max_data_lanes = 2,
+	.phy_ops = &dw_mipi_dsi_stm_phy_ops,
+};
+
+static const struct of_device_id dw_mipi_dsi_stm_dt_ids[] = {
+	{
+	 .compatible = "st,stm32-dsi",
+	 .data = &dw_mipi_dsi_stm_plat_data,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, dw_mipi_dsi_stm_dt_ids);
+
+static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dw_mipi_dsi_stm *dsi;
+	struct resource *res;
+	int ret;
+
+	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
+	if (!dsi)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		DRM_ERROR("Unable to get resource\n");
+		return -ENODEV;
+	}
+
+	dsi->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dsi->base)) {
+		DRM_ERROR("Unable to get dsi registers\n");
+		return PTR_ERR(dsi->base);
+	}
+
+	dw_mipi_dsi_stm_plat_data.base = dsi->base;
+	dw_mipi_dsi_stm_plat_data.priv_data = dsi;
+
+	ret = dw_mipi_dsi_probe(pdev, &dw_mipi_dsi_stm_plat_data);
+	if (ret)
+		DRM_ERROR("Failed to initialize mipi dsi host\n");
+
+	return ret;
+}
+
+static int dw_mipi_dsi_stm_remove(struct platform_device *pdev)
+{
+	dw_mipi_dsi_remove(pdev);
+
+	return 0;
+}
+
+static struct platform_driver dw_mipi_dsi_stm_driver = {
+	.probe		= dw_mipi_dsi_stm_probe,
+	.remove		= dw_mipi_dsi_stm_remove,
+	.driver		= {
+		.of_match_table = dw_mipi_dsi_stm_dt_ids,
+		.name	= "dw_mipi_dsi-stm",
+	},
+};
+
+module_platform_driver(dw_mipi_dsi_stm_driver);
+
+MODULE_AUTHOR("Philippe Cornu <philippe.cornu@st.com>");
+MODULE_AUTHOR("Yannick Fertre <yannick.fertre@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics DW MIPI DSI host controller driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
