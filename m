From: philippe.cornu@st.com (Philippe CORNU)
Date: Fri, 12 May 2017 16:56:29 +0200
Subject: [PATCH v1 3/3] drm/stm: Add STM32 DSI host driver
In-Reply-To: <1494600989-13507-1-git-send-email-philippe.cornu@st.com>
References: <1494600989-13507-1-git-send-email-philippe.cornu@st.com>
Message-ID: <1494600989-13507-4-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This mipi dsi host driver is based on the Rockchip version of the
Synopsys Designware mipi dsi driver (rockchip/dw-mipi-dsi.c)
modified for the stm32 family:
- replace Rockchip digital & phy specific extensions with stm32's ones.
- add a bridge

Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
---
 drivers/gpu/drm/stm/Kconfig       |    7 +
 drivers/gpu/drm/stm/Makefile      |    2 +
 drivers/gpu/drm/stm/dw-mipi-dsi.c | 1197 +++++++++++++++++++++++++++++++++++++
 3 files changed, 1206 insertions(+)
 create mode 100644 drivers/gpu/drm/stm/dw-mipi-dsi.c

diff --git a/drivers/gpu/drm/stm/Kconfig b/drivers/gpu/drm/stm/Kconfig
index 2c4817f..0007789 100644
--- a/drivers/gpu/drm/stm/Kconfig
+++ b/drivers/gpu/drm/stm/Kconfig
@@ -14,3 +14,10 @@ config DRM_STM
 	  STMicroelectronics STM32 MCUs.
 	  To compile this driver as a module, choose M here: the module
 	  will be called stm-drm.
+
+config DRM_STM_DSI
+	tristate "MIPI DSI support for STMicroelectronics SoC"
+	depends on DRM_STM
+	select DRM_MIPI_DSI
+	help
+	  Choose this option for MIPI DSI support on STMicroelectronics SoC.
diff --git a/drivers/gpu/drm/stm/Makefile b/drivers/gpu/drm/stm/Makefile
index e114d45..e448a93 100644
--- a/drivers/gpu/drm/stm/Makefile
+++ b/drivers/gpu/drm/stm/Makefile
@@ -4,4 +4,6 @@ stm-drm-y := \
 	drv.o \
 	ltdc.o
 
+obj-$(CONFIG_DRM_STM_DSI) += dw-mipi-dsi.o
+
 obj-$(CONFIG_DRM_STM) += stm-drm.o
diff --git a/drivers/gpu/drm/stm/dw-mipi-dsi.c b/drivers/gpu/drm/stm/dw-mipi-dsi.c
new file mode 100644
index 0000000..4b7f7b9
--- /dev/null
+++ b/drivers/gpu/drm/stm/dw-mipi-dsi.c
@@ -0,0 +1,1197 @@
+/*
+ * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Modified by Philippe Cornu <philippe.cornu@st.com> for the stm32 family.
+ */
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/iopoll.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/mfd/syscon.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
+#include <drm/drm_panel.h>
+#include <drm/drmP.h>
+#include <video/mipi_display.h>
+
+#define DRIVER_NAME    "dw-mipi-dsi"
+
+#define DSI_VERSION			0x00
+#define DSI_PWR_UP			0x04
+#define RESET				0
+#define POWERUP				BIT(0)
+
+#define DSI_CLKMGR_CFG			0x08
+#define TO_CLK_DIVIDSION(div)		(((div) & 0xff) << 8)
+#define TX_ESC_CLK_DIVIDSION(div)	(((div) & 0xff) << 0)
+
+#define DSI_DPI_VCID			0x0c
+#define DPI_VID(vid)			(((vid) & 0x3) << 0)
+
+#define DSI_DPI_COLOR_CODING		0x10
+#define EN18_LOOSELY			BIT(8)
+#define DPI_COLOR_CODING_16BIT_1	0x0
+#define DPI_COLOR_CODING_16BIT_2	0x1
+#define DPI_COLOR_CODING_16BIT_3	0x2
+#define DPI_COLOR_CODING_18BIT_1	0x3
+#define DPI_COLOR_CODING_18BIT_2	0x4
+#define DPI_COLOR_CODING_24BIT		0x5
+
+#define DSI_DPI_CFG_POL			0x14
+#define COLORM_ACTIVE_LOW		BIT(4)
+#define SHUTD_ACTIVE_LOW		BIT(3)
+#define HSYNC_ACTIVE_LOW		BIT(2)
+#define VSYNC_ACTIVE_LOW		BIT(1)
+#define DATAEN_ACTIVE_LOW		BIT(0)
+
+#define DSI_DPI_LP_CMD_TIM		0x18
+#define OUTVACT_LPCMD_TIME(p)		(((p) & 0xff) << 16)
+#define INVACT_LPCMD_TIME(p)		((p) & 0xff)
+
+#define DSI_DBI_CFG			0x20
+#define DSI_DBI_CMDSIZE			0x28
+
+#define DSI_PCKHDL_CFG			0x2c
+#define EN_CRC_RX			BIT(4)
+#define EN_ECC_RX			BIT(3)
+#define EN_BTA				BIT(2)
+#define EN_EOTP_RX			BIT(1)
+#define EN_EOTP_TX			BIT(0)
+
+#define DSI_MODE_CFG			0x34
+#define ENABLE_VIDEO_MODE		0
+#define ENABLE_CMD_MODE			BIT(0)
+
+#define DSI_VID_MODE_CFG		0x38
+#define FRAME_BTA_ACK			BIT(14)
+#define ENABLE_LOW_POWER		(0x3f << 8)
+#define ENABLE_LOW_POWER_MASK		(0x3f << 8)
+#define VID_MODE_TYPE_NON_BURST_SYNC_PULSES	0x0
+#define VID_MODE_TYPE_NON_BURST_SYNC_EVENTS	0x1
+#define VID_MODE_TYPE_BURST			0x2
+#define VID_MODE_TYPE_MASK			0x3
+
+#define DSI_VID_PKT_SIZE		0x3c
+#define VID_PKT_SIZE(p)			(((p) & 0x3fff) << 0)
+#define VID_PKT_MAX_SIZE		0x3fff
+
+#define DSI_VID_HSA_TIME		0x48
+#define DSI_VID_HBP_TIME		0x4c
+#define DSI_VID_HLINE_TIME		0x50
+#define DSI_VID_VSA_LINES		0x54
+#define DSI_VID_VBP_LINES		0x58
+#define DSI_VID_VFP_LINES		0x5c
+#define DSI_VID_VACTIVE_LINES		0x60
+#define DSI_CMD_MODE_CFG		0x68
+#define MAX_RD_PKT_SIZE_LP		BIT(24)
+#define DCS_LW_TX_LP			BIT(19)
+#define DCS_SR_0P_TX_LP			BIT(18)
+#define DCS_SW_1P_TX_LP			BIT(17)
+#define DCS_SW_0P_TX_LP			BIT(16)
+#define GEN_LW_TX_LP			BIT(14)
+#define GEN_SR_2P_TX_LP			BIT(13)
+#define GEN_SR_1P_TX_LP			BIT(12)
+#define GEN_SR_0P_TX_LP			BIT(11)
+#define GEN_SW_2P_TX_LP			BIT(10)
+#define GEN_SW_1P_TX_LP			BIT(9)
+#define GEN_SW_0P_TX_LP			BIT(8)
+#define EN_ACK_RQST			BIT(1)
+#define EN_TEAR_FX			BIT(0)
+
+#define CMD_MODE_ALL_LP			(MAX_RD_PKT_SIZE_LP | \
+					 DCS_LW_TX_LP | \
+					 DCS_SR_0P_TX_LP | \
+					 DCS_SW_1P_TX_LP | \
+					 DCS_SW_0P_TX_LP | \
+					 GEN_LW_TX_LP | \
+					 GEN_SR_2P_TX_LP | \
+					 GEN_SR_1P_TX_LP | \
+					 GEN_SR_0P_TX_LP | \
+					 GEN_SW_2P_TX_LP | \
+					 GEN_SW_1P_TX_LP | \
+					 GEN_SW_0P_TX_LP)
+
+#define DSI_GEN_HDR			0x6c
+#define GEN_HDATA(data)			(((data) & 0xffff) << 8)
+#define GEN_HDATA_MASK			(0xffff << 8)
+#define GEN_HTYPE(type)			(((type) & 0xff) << 0)
+#define GEN_HTYPE_MASK			0xff
+
+#define DSI_GEN_PLD_DATA		0x70
+
+#define DSI_CMD_PKT_STATUS		0x74
+#define GEN_CMD_EMPTY			BIT(0)
+#define GEN_CMD_FULL			BIT(1)
+#define GEN_PLD_W_EMPTY			BIT(2)
+#define GEN_PLD_W_FULL			BIT(3)
+#define GEN_PLD_R_EMPTY			BIT(4)
+#define GEN_PLD_R_FULL			BIT(5)
+#define GEN_RD_CMD_BUSY			BIT(6)
+
+#define DSI_TO_CNT_CFG			0x78
+#define HSTX_TO_CNT(p)			(((p) & 0xffff) << 16)
+#define LPRX_TO_CNT(p)			((p) & 0xffff)
+
+#define DSI_BTA_TO_CNT			0x8c
+#define DSI_LPCLK_CTRL			0x94
+#define AUTO_CLKLANE_CTRL		BIT(1)
+#define PHY_TXREQUESTCLKHS		BIT(0)
+
+#define DSI_PHY_TMR_LPCLK_CFG		0x98
+#define PHY_CLKHS2LP_TIME(lbcc)		(((lbcc) & 0x3ff) << 16)
+#define PHY_CLKLP2HS_TIME(lbcc)		((lbcc) & 0x3ff)
+
+#define DSI_PHY_TMR_CFG			0x9c
+#define PHY_HS2LP_TIME(lbcc)		(((lbcc) & 0xff) << 24)
+#define PHY_LP2HS_TIME(lbcc)		(((lbcc) & 0xff) << 16)
+#define MAX_RD_TIME(lbcc)		((lbcc) & 0x7fff)
+
+#define DSI_PHY_RSTZ			0xa0
+#define PHY_DISFORCEPLL			0
+#define PHY_ENFORCEPLL			BIT(3)
+#define PHY_DISABLECLK			0
+#define PHY_ENABLECLK			BIT(2)
+#define PHY_RSTZ			0
+#define PHY_UNRSTZ			BIT(1)
+#define PHY_SHUTDOWNZ			0
+#define PHY_UNSHUTDOWNZ			BIT(0)
+
+#define DSI_PHY_IF_CFG			0xa4
+#define N_LANES(n)			((((n) - 1) & 0x3) << 0)
+#define PHY_STOP_WAIT_TIME(cycle)	(((cycle) & 0xff) << 8)
+
+#define DSI_PHY_STATUS			0xb0
+#define LOCK				BIT(0)
+#define STOP_STATE_CLK_LANE		BIT(2)
+
+#define DSI_PHY_TST_CTRL0		0xb4
+#define PHY_TESTCLK			BIT(1)
+#define PHY_UNTESTCLK			0
+#define PHY_TESTCLR			BIT(0)
+#define PHY_UNTESTCLR			0
+
+#define DSI_PHY_TST_CTRL1		0xb8
+#define PHY_TESTEN			BIT(16)
+#define PHY_UNTESTEN			0
+#define PHY_TESTDOUT(n)			(((n) & 0xff) << 8)
+#define PHY_TESTDIN(n)			(((n) & 0xff) << 0)
+
+#define DSI_INT_ST0			0xbc
+#define DSI_INT_ST1			0xc0
+#define DSI_INT_MSK0			0xc4
+#define DSI_INT_MSK1			0xc8
+
+#define PHY_STATUS_TIMEOUT_US		10000
+#define CMD_PKT_STATUS_TIMEOUT_US	20000
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
+struct dw_mipi_dsi_plat_data {
+	unsigned int max_data_lanes;
+};
+
+struct dw_mipi_dsi {
+	struct drm_bridge bridge;
+	struct drm_connector connector;
+	struct mipi_dsi_host dsi_host;
+	struct drm_panel *panel;
+	struct device *dev;
+	struct regmap *grf_regmap;
+	void __iomem *base;
+
+	struct clk *pllref_clk;
+	struct clk *pclk;
+
+	int dpms_mode;
+	unsigned int lane_mbps; /* per lane */
+	u32 channel;
+	u32 lanes;
+	u32 format;
+	unsigned long mode_flags;
+
+	const struct dw_mipi_dsi_plat_data *pdata;
+};
+
+enum dw_mipi_dsi_mode {
+	DW_MIPI_DSI_CMD_MODE,
+	DW_MIPI_DSI_VID_MODE,
+};
+
+/*
+ * The controller should generate 2 frames before
+ * preparing the peripheral.
+ */
+static void dw_mipi_dsi_wait_for_two_frames(struct drm_display_mode *mode)
+{
+	int refresh, two_frames;
+
+	refresh = drm_mode_vrefresh(mode);
+	two_frames = DIV_ROUND_UP(MSEC_PER_SEC, refresh) * 2;
+	msleep(two_frames);
+}
+
+static inline struct dw_mipi_dsi *host_to_dsi(struct mipi_dsi_host *host)
+{
+	return container_of(host, struct dw_mipi_dsi, dsi_host);
+}
+
+static inline struct dw_mipi_dsi *con_to_dsi(struct drm_connector *con)
+{
+	return container_of(con, struct dw_mipi_dsi, connector);
+}
+
+static inline struct dw_mipi_dsi *bridge_to_dsi(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct dw_mipi_dsi, bridge);
+}
+
+static inline void dsi_write(struct dw_mipi_dsi *dsi, u32 reg, u32 val)
+{
+	writel_relaxed(val, dsi->base + reg);
+}
+
+static inline u32 dsi_read(struct dw_mipi_dsi *dsi, u32 reg)
+{
+	return readl_relaxed(dsi->base + reg);
+}
+
+static inline void dsi_set(struct dw_mipi_dsi *dsi, u32 reg, u32 mask)
+{
+	dsi_write(dsi, reg, dsi_read(dsi, reg) | mask);
+}
+
+static inline void dsi_clear(struct dw_mipi_dsi *dsi, u32 reg, u32 mask)
+{
+	dsi_write(dsi, reg, dsi_read(dsi, reg) & ~mask);
+}
+
+static inline void dsi_update_bits(struct dw_mipi_dsi *dsi, u32 reg, u32 mask,
+				   u32 val)
+{
+	dsi_write(dsi, reg, (dsi_read(dsi, reg) & ~mask) | val);
+}
+
+/*
+ * DSI HOST PHY
+ */
+
+/* todo remove me (used only once) */
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
+static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
+{
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
+static int dw_mipi_dsi_get_lane_bps(struct dw_mipi_dsi *dsi,
+				    struct drm_display_mode *mode)
+{
+	unsigned int idf, ndiv, odf, pll_in_khz, pll_out_khz;
+	u32 val;
+	int bpp;
+
+	pll_in_khz = (unsigned int)(clk_get_rate(dsi->pllref_clk) / 1000);
+
+	/* Compute requested pll out */
+	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
+	pll_out_khz = mode->clock * bpp / dsi->lanes;
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
+	clk_enable(dsi->pclk);
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
+	/* Select the color coding for host & wrapper (same value) */
+	dsi_update_bits(dsi, DSI_WCFGR, WCFGR_COLMUX,
+			dsi_color_from_mipi(dsi->format) << 1);
+
+	clk_disable(dsi->pclk);
+
+	dsi->lane_mbps = pll_out_khz / 1000;
+
+	return 0;
+}
+
+/*
+ * DSI HOST DIGITAL
+ */
+
+static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
+				   struct mipi_dsi_device *device)
+{
+	struct dw_mipi_dsi *dsi = host_to_dsi(host);
+
+	if (device->lanes > dsi->pdata->max_data_lanes) {
+		dev_err(dsi->dev, "the number of data lanes(%u) is too many\n",
+			device->lanes);
+		return -EINVAL;
+	}
+
+	dsi->lanes = device->lanes;
+	dsi->channel = device->channel;
+	dsi->format = device->format;
+	dsi->mode_flags = device->mode_flags;
+	dsi->panel = of_drm_find_panel(device->dev.of_node);
+	if (dsi->panel)
+		return drm_panel_attach(dsi->panel, &dsi->connector);
+
+	return -EINVAL;
+}
+
+static int dw_mipi_dsi_host_detach(struct mipi_dsi_host *host,
+				   struct mipi_dsi_device *device)
+{
+	struct dw_mipi_dsi *dsi = host_to_dsi(host);
+
+	drm_panel_detach(dsi->panel);
+
+	return 0;
+}
+
+static void dw_mipi_message_config(struct dw_mipi_dsi *dsi,
+				   const struct mipi_dsi_msg *msg)
+{
+	bool lpm = msg->flags & MIPI_DSI_MSG_USE_LPM;
+	u32 val = 0;
+
+	if (msg->flags & MIPI_DSI_MSG_REQ_ACK)
+		val |= EN_ACK_RQST;
+	if (lpm)
+		val |= CMD_MODE_ALL_LP;
+
+	dsi_write(dsi, DSI_LPCLK_CTRL, lpm ? 0 : PHY_TXREQUESTCLKHS);
+
+	/* todo debug force the PHY_TXREQUESTCLKHS, to be improved... */
+	dsi_write(dsi, DSI_LPCLK_CTRL, PHY_TXREQUESTCLKHS);
+
+	dsi_write(dsi, DSI_CMD_MODE_CFG, val);
+}
+
+static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
+{
+	int ret;
+	u32 val, mask;
+
+	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
+				 val, !(val & GEN_CMD_FULL), 1000,
+				 CMD_PKT_STATUS_TIMEOUT_US);
+	if (ret < 0) {
+		dev_err(dsi->dev, "failed to get available command FIFO\n");
+		return ret;
+	}
+
+	dsi_write(dsi, DSI_GEN_HDR, hdr_val);
+
+	mask = GEN_CMD_EMPTY | GEN_PLD_W_EMPTY;
+	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
+				 val, (val & mask) == mask,
+				 1000, CMD_PKT_STATUS_TIMEOUT_US);
+	if (ret < 0) {
+		dev_err(dsi->dev, "failed to write command FIFO\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dw_mipi_dsi_dcs_short_write(struct dw_mipi_dsi *dsi,
+				       const struct mipi_dsi_msg *msg)
+{
+	const u8 *tx_buf = msg->tx_buf;
+	u16 data = 0;
+	u32 val;
+
+	if (msg->tx_len > 0)
+		data |= tx_buf[0];
+	if (msg->tx_len > 1)
+		data |= tx_buf[1] << 8;
+
+	if (msg->tx_len > 2) {
+		dev_err(dsi->dev, "too long tx buf length %zu for short write\n",
+			msg->tx_len);
+		return -EINVAL;
+	}
+
+	val = GEN_HDATA(data) | GEN_HTYPE(msg->type);
+	return dw_mipi_dsi_gen_pkt_hdr_write(dsi, val);
+}
+
+static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
+				      const struct mipi_dsi_msg *msg)
+{
+	const u8 *tx_buf = msg->tx_buf;
+	int len = msg->tx_len, pld_data_bytes = sizeof(u32), ret;
+	u32 hdr_val = GEN_HDATA(msg->tx_len) | GEN_HTYPE(msg->type);
+	u32 remainder;
+	u32 val;
+
+	if (msg->tx_len < 3) {
+		dev_err(dsi->dev, "wrong tx buf length %zu for long write\n",
+			msg->tx_len);
+		return -EINVAL;
+	}
+
+	while (DIV_ROUND_UP(len, pld_data_bytes)) {
+		if (len < pld_data_bytes) {
+			remainder = 0;
+			memcpy(&remainder, tx_buf, len);
+			dsi_write(dsi, DSI_GEN_PLD_DATA, remainder);
+			len = 0;
+		} else {
+			memcpy(&remainder, tx_buf, pld_data_bytes);
+			dsi_write(dsi, DSI_GEN_PLD_DATA, remainder);
+			tx_buf += pld_data_bytes;
+			len -= pld_data_bytes;
+		}
+
+		ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
+					 val, !(val & GEN_PLD_W_FULL), 1000,
+					 CMD_PKT_STATUS_TIMEOUT_US);
+		if (ret < 0) {
+			dev_err(dsi->dev,
+				"failed to get available write payload FIFO\n");
+			return ret;
+		}
+	}
+
+	return dw_mipi_dsi_gen_pkt_hdr_write(dsi, hdr_val);
+}
+
+static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
+					 const struct mipi_dsi_msg *msg)
+{
+	struct dw_mipi_dsi *dsi = host_to_dsi(host);
+	int ret;
+
+	/*
+	 * todo dw drv improvements
+	 * use mipi_dsi_create_packet() instead of all following
+	 * functions and code (no switch cases, no
+	 * dw_mipi_dsi_dcs_short_write(), only the loop in long_write...)
+	 * and use packet.header...
+	 */
+	dw_mipi_message_config(dsi, msg);
+
+	switch (msg->type) {
+	case MIPI_DSI_DCS_SHORT_WRITE:
+	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
+	case MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE:
+		ret = dw_mipi_dsi_dcs_short_write(dsi, msg);
+		break;
+	case MIPI_DSI_DCS_LONG_WRITE:
+		ret = dw_mipi_dsi_dcs_long_write(dsi, msg);
+		break;
+	default:
+		dev_err(dsi->dev, "unsupported message type 0x%02x\n",
+			msg->type);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct mipi_dsi_host_ops dw_mipi_dsi_host_ops = {
+	.attach = dw_mipi_dsi_host_attach,
+	.detach = dw_mipi_dsi_host_detach,
+	.transfer = dw_mipi_dsi_host_transfer,
+};
+
+static void dw_mipi_dsi_video_mode_config(struct dw_mipi_dsi *dsi)
+{
+	u32 val;
+
+	/*
+	 * todo dw drv improvements
+	 * enabling low power is panel-dependent, we should use the
+	 * panel configuration here...
+	 */
+	val = ENABLE_LOW_POWER;
+
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		val |= VID_MODE_TYPE_BURST;
+	else if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
+		val |= VID_MODE_TYPE_NON_BURST_SYNC_PULSES;
+	else
+		val |= VID_MODE_TYPE_NON_BURST_SYNC_EVENTS;
+
+	dsi_write(dsi, DSI_VID_MODE_CFG, val);
+}
+
+static void dw_mipi_dsi_set_mode(struct dw_mipi_dsi *dsi,
+				 enum dw_mipi_dsi_mode mode)
+{
+	if (mode == DW_MIPI_DSI_CMD_MODE) {
+		dsi_write(dsi, DSI_PWR_UP, RESET);
+		dsi_write(dsi, DSI_MODE_CFG, ENABLE_CMD_MODE);
+		dsi_write(dsi, DSI_PWR_UP, POWERUP);
+	} else {
+		dsi_write(dsi, DSI_PWR_UP, RESET);
+		dsi_write(dsi, DSI_MODE_CFG, ENABLE_VIDEO_MODE);
+		dw_mipi_dsi_video_mode_config(dsi);
+		dsi_write(dsi, DSI_LPCLK_CTRL, PHY_TXREQUESTCLKHS);
+		dsi_write(dsi, DSI_PWR_UP, POWERUP);
+	}
+}
+
+static void dw_mipi_dsi_disable(struct dw_mipi_dsi *dsi)
+{
+	dsi_write(dsi, DSI_PWR_UP, RESET);
+	dsi_write(dsi, DSI_PHY_RSTZ, PHY_RSTZ);
+}
+
+static void dw_mipi_dsi_init(struct dw_mipi_dsi *dsi)
+{
+	/*
+	 * The maximum permitted escape clock is 20MHz and it is derived from
+	 * lanebyteclk, which is running at "lane_mbps / 8".  Thus we want:
+	 *
+	 *     (lane_mbps >> 3) / esc_clk_division < 20
+	 * which is:
+	 *     (lane_mbps >> 3) / 20 > esc_clk_division
+	 */
+	u32 esc_clk_division = (dsi->lane_mbps >> 3) / 20 + 1;
+
+	dsi_write(dsi, DSI_PWR_UP, RESET);
+	dsi_write(dsi, DSI_PHY_RSTZ, PHY_DISFORCEPLL | PHY_DISABLECLK
+		  | PHY_RSTZ | PHY_SHUTDOWNZ);
+	/*
+	 * todo dw drv improvements
+	 * timeout clock division should be computed with the
+	 * high speed transmission counter timeout and byte lane...
+	 */
+	dsi_write(dsi, DSI_CLKMGR_CFG, TO_CLK_DIVIDSION(10) |
+		  TX_ESC_CLK_DIVIDSION(esc_clk_division));
+}
+
+static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi,
+				   struct drm_display_mode *mode)
+{
+	u32 val = 0, color = 0;
+
+	switch (dsi->format) {
+	case MIPI_DSI_FMT_RGB888:
+		color = DPI_COLOR_CODING_24BIT;
+		break;
+	case MIPI_DSI_FMT_RGB666:
+		color = DPI_COLOR_CODING_18BIT_2 | EN18_LOOSELY;
+		break;
+	case MIPI_DSI_FMT_RGB666_PACKED:
+		color = DPI_COLOR_CODING_18BIT_1;
+		break;
+	case MIPI_DSI_FMT_RGB565:
+		color = DPI_COLOR_CODING_16BIT_1;
+		break;
+	}
+
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		val |= VSYNC_ACTIVE_LOW;
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		val |= HSYNC_ACTIVE_LOW;
+
+	dsi_write(dsi, DSI_DPI_VCID, DPI_VID(dsi->channel));
+	dsi_write(dsi, DSI_DPI_COLOR_CODING, color);
+	dsi_write(dsi, DSI_DPI_CFG_POL, val);
+	/*
+	 * todo dw drv improvements
+	 * largest packet sizes during hfp or during vsa/vpb/vfp
+	 * should be computed according to byte lane, lane number and only
+	 * if sending lp cmds in high speed is enable (PHY_TXREQUESTCLKHS)
+	 */
+	dsi_write(dsi, DSI_DPI_LP_CMD_TIM, OUTVACT_LPCMD_TIME(4)
+		  | INVACT_LPCMD_TIME(4));
+}
+
+static void dw_mipi_dsi_packet_handler_config(struct dw_mipi_dsi *dsi)
+{
+	dsi_write(dsi, DSI_PCKHDL_CFG, EN_CRC_RX | EN_ECC_RX | EN_BTA);
+}
+
+static void dw_mipi_dsi_video_packet_config(struct dw_mipi_dsi *dsi,
+					    struct drm_display_mode *mode)
+{
+	/*
+	 * todo dw drv improvements
+	 * only burst mode is supported here. For non-burst video modes,
+	 * we should compute DSI_VID_PKT_SIZE, DSI_VCCR.NUMC &
+	 * DSI_VNPCR.NPSIZE... especially because this driver supports
+	 * non-burst video modes, see dw_mipi_dsi_video_mode_config()...
+	 */
+	dsi_write(dsi, DSI_VID_PKT_SIZE, VID_PKT_SIZE(mode->hdisplay));
+}
+
+static void dw_mipi_dsi_command_mode_config(struct dw_mipi_dsi *dsi)
+{
+	/*
+	 * todo dw drv improvements
+	 * compute high speed transmission counter timeout according
+	 * to the timeout clock division (TO_CLK_DIVIDSION) and byte lane...
+	 */
+	dsi_write(dsi, DSI_TO_CNT_CFG, HSTX_TO_CNT(1000) | LPRX_TO_CNT(1000));
+	/*
+	 * todo dw drv improvements
+	 * the Bus-Turn-Around Timeout Counter should be computed
+	 * according to byte lane...
+	 */
+	dsi_write(dsi, DSI_BTA_TO_CNT, 0xd00);
+	dsi_write(dsi, DSI_MODE_CFG, ENABLE_CMD_MODE);
+}
+
+/* Get lane byte clock cycles. */
+static u32 dw_mipi_dsi_get_hcomponent_lbcc(struct dw_mipi_dsi *dsi,
+					   struct drm_display_mode *mode,
+					   u32 hcomponent)
+{
+	u32 frac, lbcc;
+
+	lbcc = hcomponent * dsi->lane_mbps * MSEC_PER_SEC / 8;
+
+	frac = lbcc % mode->clock;
+	lbcc = lbcc / mode->clock;
+	if (frac)
+		lbcc++;
+
+	return lbcc;
+}
+
+static void dw_mipi_dsi_line_timer_config(struct dw_mipi_dsi *dsi,
+					  struct drm_display_mode *mode)
+{
+	u32 htotal, hsa, hbp, lbcc;
+
+	htotal = mode->htotal;
+	hsa = mode->hsync_end - mode->hsync_start;
+	hbp = mode->htotal - mode->hsync_end;
+
+	/*
+	 * todo dw drv improvements
+	 * computations below may be improved...
+	 */
+	lbcc = dw_mipi_dsi_get_hcomponent_lbcc(dsi, mode, htotal);
+	dsi_write(dsi, DSI_VID_HLINE_TIME, lbcc);
+
+	lbcc = dw_mipi_dsi_get_hcomponent_lbcc(dsi, mode, hsa);
+	dsi_write(dsi, DSI_VID_HSA_TIME, lbcc);
+
+	lbcc = dw_mipi_dsi_get_hcomponent_lbcc(dsi, mode, hbp);
+	dsi_write(dsi, DSI_VID_HBP_TIME, lbcc);
+}
+
+static void dw_mipi_dsi_vertical_timing_config(struct dw_mipi_dsi *dsi,
+					       struct drm_display_mode *mode)
+{
+	u32 vactive, vsa, vfp, vbp;
+
+	vactive = mode->vdisplay;
+	vsa = mode->vsync_end - mode->vsync_start;
+	vfp = mode->vsync_start - mode->vdisplay;
+	vbp = mode->vtotal - mode->vsync_end;
+
+	dsi_write(dsi, DSI_VID_VACTIVE_LINES, vactive);
+	dsi_write(dsi, DSI_VID_VSA_LINES, vsa);
+	dsi_write(dsi, DSI_VID_VFP_LINES, vfp);
+	dsi_write(dsi, DSI_VID_VBP_LINES, vbp);
+}
+
+static void dw_mipi_dsi_dphy_timing_config(struct dw_mipi_dsi *dsi)
+{
+	/*
+	 * todo dw drv improvements
+	 * data & clock lane timers should be computed according to panel
+	 * blankings and to the automatic clock lane control mode...
+	 * note: DSI_PHY_TMR_CFG.MAX_RD_TIME should be in line with
+	 * DSI_CMD_MODE_CFG.MAX_RD_PKT_SIZE_LP (see CMD_MODE_ALL_LP)
+	 */
+	dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME(0x40)
+		  | PHY_LP2HS_TIME(0x40) | MAX_RD_TIME(10000));
+
+	dsi_write(dsi, DSI_PHY_TMR_LPCLK_CFG, PHY_CLKHS2LP_TIME(0x40)
+		  | PHY_CLKLP2HS_TIME(0x40));
+}
+
+static void dw_mipi_dsi_dphy_interface_config(struct dw_mipi_dsi *dsi)
+{
+	/*
+	 * todo dw drv improvements
+	 * stop wait time should be the maximum between host dsi
+	 * and panel stop wait times
+	 */
+	dsi_write(dsi, DSI_PHY_IF_CFG, PHY_STOP_WAIT_TIME(0x20) |
+		  N_LANES(dsi->lanes));
+}
+
+static void dw_mipi_dsi_clear_err(struct dw_mipi_dsi *dsi)
+{
+	dsi_read(dsi, DSI_INT_ST0);
+	dsi_read(dsi, DSI_INT_ST1);
+	dsi_write(dsi, DSI_INT_MSK0, 0);
+	dsi_write(dsi, DSI_INT_MSK1, 0);
+}
+
+static void dw_mipi_dsi_bridge_disable(struct drm_bridge *bridge)
+{
+	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
+
+	if (dsi->dpms_mode != DRM_MODE_DPMS_ON)
+		return;
+
+	if (clk_enable(dsi->pclk)) {
+		dev_err(dsi->dev, "%s: Failed to enable pclk\n", __func__);
+		return;
+	}
+
+	drm_panel_disable(dsi->panel);
+
+	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_CMD_MODE);
+	drm_panel_unprepare(dsi->panel);
+
+	dw_mipi_dsi_disable(dsi);
+	pm_runtime_put(dsi->dev);
+	clk_disable(dsi->pclk);
+	dsi->dpms_mode = DRM_MODE_DPMS_OFF;
+}
+
+static void dw_mipi_dsi_bridge_enable(struct drm_bridge *bridge)
+{
+	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
+	struct drm_encoder *encoder = bridge->encoder;
+	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
+	int ret;
+
+	ret = dw_mipi_dsi_get_lane_bps(dsi, mode);
+	if (ret < 0)
+		return;
+
+	if (dsi->dpms_mode == DRM_MODE_DPMS_ON)
+		return;
+
+	if (clk_enable(dsi->pclk)) {
+		dev_err(dsi->dev, "%s: Failed to enable pclk\n", __func__);
+		return;
+	}
+
+	pm_runtime_get_sync(dsi->dev);
+	dw_mipi_dsi_init(dsi);
+	dw_mipi_dsi_dpi_config(dsi, mode);
+	dw_mipi_dsi_packet_handler_config(dsi);
+	dw_mipi_dsi_video_mode_config(dsi);
+	dw_mipi_dsi_video_packet_config(dsi, mode);
+	dw_mipi_dsi_command_mode_config(dsi);
+	dw_mipi_dsi_line_timer_config(dsi, mode);
+	dw_mipi_dsi_vertical_timing_config(dsi, mode);
+	dw_mipi_dsi_dphy_timing_config(dsi);
+	dw_mipi_dsi_dphy_interface_config(dsi);
+	dw_mipi_dsi_clear_err(dsi);
+
+	/*
+	 * todo dw drv improvements
+	 * following command is inside dw_mipi_dsi_phy_init()
+	 * but this function is also required here. We way move it in the
+	 * phy but here we are using dsi regs...
+	 * maybe add the waiting loop here too...
+	 */
+	dsi_write(dsi, DSI_PHY_RSTZ, PHY_ENFORCEPLL | PHY_ENABLECLK |
+				     PHY_UNRSTZ | PHY_UNSHUTDOWNZ);
+
+	dw_mipi_dsi_phy_init(dsi);
+	dw_mipi_dsi_wait_for_two_frames(mode);
+
+	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_CMD_MODE);
+	if (drm_panel_prepare(dsi->panel))
+		dev_err(dsi->dev, "failed to prepare panel\n");
+
+	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_VID_MODE);
+	drm_panel_enable(dsi->panel);
+
+	clk_disable(dsi->pclk);
+
+	dsi->dpms_mode = DRM_MODE_DPMS_ON;
+}
+
+static int dw_mipi_dsi_connector_get_modes(struct drm_connector *connector)
+{
+	struct dw_mipi_dsi *dsi = con_to_dsi(connector);
+
+	return drm_panel_get_modes(dsi->panel);
+}
+
+static struct drm_connector_helper_funcs dw_mipi_dsi_connector_helper_funcs = {
+	.get_modes = dw_mipi_dsi_connector_get_modes,
+};
+
+static void dw_mipi_dsi_drm_connector_destroy(struct drm_connector *connector)
+{
+	drm_connector_unregister(connector);
+	drm_connector_cleanup(connector);
+}
+
+static const struct drm_connector_funcs dw_mipi_dsi_atomic_connector_funcs = {
+	.dpms = drm_atomic_helper_connector_dpms,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = dw_mipi_dsi_drm_connector_destroy,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static int dw_mipi_dsi_bridge_attach(struct drm_bridge *bridge)
+{
+	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
+	struct drm_connector *connector = &dsi->connector;
+
+	if (!bridge->encoder) {
+		DRM_ERROR("Parent encoder object not found");
+		return -ENODEV;
+	}
+
+	/* Set the encoder type as caller does not know it */
+	bridge->encoder->encoder_type = DRM_MODE_ENCODER_DSI;
+
+	connector->polled = DRM_CONNECTOR_POLL_HPD;
+
+	drm_connector_helper_add(connector,
+				 &dw_mipi_dsi_connector_helper_funcs);
+
+	drm_connector_init(bridge->dev, connector,
+			   &dw_mipi_dsi_atomic_connector_funcs,
+			   DRM_MODE_CONNECTOR_DSI);
+
+	drm_mode_connector_attach_encoder(connector, bridge->encoder);
+
+	return 0;
+}
+
+static struct drm_bridge_funcs dw_mipi_dsi_bridge_funcs = {
+	.enable = dw_mipi_dsi_bridge_enable,
+	.disable = dw_mipi_dsi_bridge_disable,
+	.attach = dw_mipi_dsi_bridge_attach,
+};
+
+static struct dw_mipi_dsi_plat_data stm_mipi_dsi_drv_data = {
+	.max_data_lanes = 2,
+};
+
+static const struct of_device_id dw_mipi_dsi_dt_ids[] = {
+	{
+	 .compatible = "st,stm32-dsi_host",
+	 .data = &stm_mipi_dsi_drv_data,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, dw_mipi_dsi_dt_ids);
+
+static int dw_mipi_dsi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *of_id =
+			of_match_device(dw_mipi_dsi_dt_ids, dev);
+	const struct dw_mipi_dsi_plat_data *pdata = of_id->data;
+	struct reset_control *apb_rst;
+	struct dw_mipi_dsi *dsi;
+	struct resource *res;
+	int ret;
+
+	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
+	if (!dsi)
+		return -ENOMEM;
+
+	dsi->dev = dev;
+	dsi->pdata = pdata;
+	dsi->dpms_mode = DRM_MODE_DPMS_OFF;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	dsi->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dsi->base))
+		return PTR_ERR(dsi->base);
+
+	dsi->pllref_clk = devm_clk_get(dev, "ref");
+	if (IS_ERR(dsi->pllref_clk)) {
+		ret = PTR_ERR(dsi->pllref_clk);
+		dev_err(dev, "Unable to get pll reference clock: %d\n", ret);
+		return ret;
+	}
+
+	dsi->pclk = devm_clk_get(dev, "pclk");
+	if (IS_ERR(dsi->pclk)) {
+		ret = PTR_ERR(dsi->pclk);
+		dev_err(dev, "Unable to get pclk: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Note that the reset was not defined in the initial device tree, so
+	 * we have to be prepared for it not being found.
+	 */
+	apb_rst = devm_reset_control_get(dev, "apb");
+	if (IS_ERR(apb_rst)) {
+		ret = PTR_ERR(apb_rst);
+		if (ret == -ENOENT) {
+			apb_rst = NULL;
+		} else {
+			dev_err(dev, "Unable to get reset control: %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (apb_rst) {
+		ret = clk_prepare_enable(dsi->pclk);
+		if (ret) {
+			dev_err(dev, "%s: Failed to enable pclk\n", __func__);
+			return ret;
+		}
+
+		reset_control_assert(apb_rst);
+		usleep_range(10, 20);
+		reset_control_deassert(apb_rst);
+
+		clk_disable(dsi->pclk);
+	}
+
+	ret = clk_prepare_enable(dsi->pllref_clk);
+	if (ret) {
+		dev_err(dev, "%s: Failed to enable pllref_clk\n", __func__);
+		return ret;
+	}
+
+	pm_runtime_enable(dev);
+
+	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
+	dsi->dsi_host.dev = dev;
+	ret = mipi_dsi_host_register(&dsi->dsi_host);
+	if (ret) {
+		dev_err(dev, "Failed to register MIPI host: %d\n", ret);
+		goto err_cleanup;
+	}
+
+	dsi->bridge.driver_private = dsi;
+	dsi->bridge.funcs = &dw_mipi_dsi_bridge_funcs;
+#ifdef CONFIG_OF
+	dsi->bridge.of_node = pdev->dev.of_node;
+#endif
+	ret = drm_bridge_add(&dsi->bridge);
+	if (ret) {
+		dev_err(dev, "Failed to add bridge: %d\n", ret);
+		goto err_mipi_dsi_host;
+	}
+
+	clk_enable(dsi->pclk);
+
+	dev_set_drvdata(dev, dsi);
+	return 0;
+
+err_mipi_dsi_host:
+	mipi_dsi_host_unregister(&dsi->dsi_host);
+err_cleanup:
+	clk_disable_unprepare(dsi->pllref_clk);
+	return ret;
+}
+
+static int dw_mipi_dsi_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dw_mipi_dsi *dsi = dev_get_drvdata(dev);
+
+	drm_bridge_remove(&dsi->bridge);
+	mipi_dsi_host_unregister(&dsi->dsi_host);
+	pm_runtime_disable(dev);
+	clk_disable_unprepare(dsi->pllref_clk);
+
+	return 0;
+}
+
+static struct platform_driver dw_mipi_dsi_driver = {
+	.probe		= dw_mipi_dsi_probe,
+	.remove		= dw_mipi_dsi_remove,
+	.driver		= {
+		.of_match_table = dw_mipi_dsi_dt_ids,
+		.name	= DRIVER_NAME,
+	},
+};
+
+module_platform_driver(dw_mipi_dsi_driver);
+
+MODULE_DESCRIPTION("ROCKCHIP MIPI DSI host controller driver");
+MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
+MODULE_AUTHOR("Philippe Cornu <philippe.cornu@st.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.9.1
