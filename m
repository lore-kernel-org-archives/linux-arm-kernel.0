From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sat, 30 Dec 2017 22:02:01 +0100
Subject: [PATCH 09/11] drm/sun4i: Implement A83T HDMI driver
In-Reply-To: <20171230210203.24115-1-jernej.skrabec@siol.net>
References: <20171230210203.24115-1-jernej.skrabec@siol.net>
Message-ID: <20171230210203.24115-10-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A83T has DW HDMI IP block with a custom PHY similar to Synopsys gen2
HDMI PHY.

Only video output was tested, while HW also supports audio and CEC.
Support for them will be added later.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/Kconfig         |   9 +
 drivers/gpu/drm/sun4i/Makefile        |   1 +
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 367 ++++++++++++++++++++++++++++++++++
 3 files changed, 377 insertions(+)
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 882d85db9053..7327da3bc94f 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -40,6 +40,15 @@ config DRM_SUN4I_BACKEND
 	  do some alpha blending and feed graphics to TCON. If M is
 	  selected the module will be called sun4i-backend.
 
+config DRM_SUN8I_DW_HDMI
+	tristate "Support for Allwinner version of DesignWare HDMI"
+	depends on DRM_SUN4I
+	select DRM_DW_HDMI
+	help
+	  Choose this option if you have an Allwinner SoC with the
+	  DesignWare HDMI controller with custom HDMI PHY. If M is
+	  selected the module will be called sun8i_dw_hdmi.
+
 config DRM_SUN8I_MIXER
 	tristate "Support for Allwinner Display Engine 2.0 Mixer"
 	default MACH_SUN8I
diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index 2b37a6abbb1d..d633d2b816fd 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -26,4 +26,5 @@ obj-$(CONFIG_DRM_SUN4I)		+= sun6i_drc.o
 
 obj-$(CONFIG_DRM_SUN4I_BACKEND)	+= sun4i-backend.o
 obj-$(CONFIG_DRM_SUN4I_HDMI)	+= sun4i-drm-hdmi.o
+obj-$(CONFIG_DRM_SUN8I_DW_HDMI)	+= sun8i_dw_hdmi.o
 obj-$(CONFIG_DRM_SUN8I_MIXER)	+= sun8i-mixer.o
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
new file mode 100644
index 000000000000..462bb81f11ed
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2017 Jernej Skrabec <jernej.skrabec@siol.net>
+ */
+
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include <drm/drm_of.h>
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_edid.h>
+#include <drm/bridge/dw_hdmi.h>
+
+#define SUN8I_HDMI_PHY_REG_UNK1		0x0000
+#define SUN8I_HDMI_PHY_REG_POL		0x0001
+#define SUN8I_HDMI_PHY_REG_UNK2		0x0002
+#define SUN8I_HDMI_PHY_REG_UNK3		0x0003
+#define SUN8I_HDMI_PHY_REG_UNK4		0x0007
+
+#define SUN8I_HDMI_PHY_REG_READ_EN	0x0010
+#define SUN8I_HDMI_PHY_REG_READ_EN_MAGIC	0x54524545
+
+#define SUN8I_HDMI_PHY_REG_UNSCRAMBLE	0x0014
+#define SUN8I_HDMI_PHY_REG_UNSCRAMBLE_MAGIC	0x42494E47
+
+#define to_sun8i_dw_hdmi(x)	container_of(x, struct sun8i_dw_hdmi, x)
+
+struct sun8i_dw_hdmi {
+	struct clk *clk_ahb;
+	struct clk *clk_sfr;
+	struct clk *clk_tmds;
+	struct device *dev;
+	struct drm_encoder encoder;
+	void __iomem *phy_base;
+	struct dw_hdmi_plat_data plat_data;
+	struct reset_control *rst_ctrl;
+	struct reset_control *rst_phy;
+};
+
+static void sun8i_dw_hdmi_encoder_mode_set(struct drm_encoder *encoder,
+					   struct drm_display_mode *mode,
+					   struct drm_display_mode *adj_mode)
+{
+	struct sun8i_dw_hdmi *hdmi = to_sun8i_dw_hdmi(encoder);
+
+	clk_set_rate(hdmi->clk_tmds, mode->crtc_clock * 1000);
+}
+
+static const struct drm_encoder_helper_funcs
+sun8i_dw_hdmi_encoder_helper_funcs = {
+	.mode_set = sun8i_dw_hdmi_encoder_mode_set,
+};
+
+static void sun8i_dw_hdmi_init(struct sun8i_dw_hdmi *hdmi)
+{
+	/* enable read access to HDMI controller */
+	writel(SUN8I_HDMI_PHY_REG_READ_EN_MAGIC,
+	       hdmi->phy_base + SUN8I_HDMI_PHY_REG_READ_EN);
+
+	/*
+	 * HDMI PHY settings are taken as-is from Allwinner BSP code.
+	 * There is no documentation.
+	 */
+	writeb(0x01, hdmi->phy_base + SUN8I_HDMI_PHY_REG_UNK1);
+	writeb(0x00, hdmi->phy_base + SUN8I_HDMI_PHY_REG_POL);
+	writeb(0x69, hdmi->phy_base + SUN8I_HDMI_PHY_REG_UNK2);
+	writeb(0x00, hdmi->phy_base + SUN8I_HDMI_PHY_REG_UNK3);
+
+	/* unscramble register offsets */
+	writel(SUN8I_HDMI_PHY_REG_UNSCRAMBLE_MAGIC,
+	       hdmi->phy_base + SUN8I_HDMI_PHY_REG_UNSCRAMBLE);
+}
+
+static const struct drm_encoder_funcs sun8i_dw_hdmi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static int sun8i_dw_hdmi_phy_init(struct dw_hdmi *dw_hdmi, void *data,
+				  struct drm_display_mode *mode)
+{
+	struct sun8i_dw_hdmi *hdmi = (struct sun8i_dw_hdmi *)data;
+	u8 val = 0;
+
+	if ((mode->flags & DRM_MODE_FLAG_NHSYNC) &&
+	    (mode->flags & DRM_MODE_FLAG_NHSYNC)) {
+		val = 0x03;
+	}
+
+	writeb(0xa0, hdmi->phy_base + SUN8I_HDMI_PHY_REG_UNK4);
+
+	writeb(val, hdmi->phy_base + SUN8I_HDMI_PHY_REG_POL);
+
+	dw_hdmi_phy_gen2_reset(dw_hdmi, 1);
+
+	dw_hdmi_phy_gen2_txpwron(dw_hdmi, 0);
+	dw_hdmi_phy_gen2_pddq(dw_hdmi, 1);
+
+	dw_hdmi_phy_gen2_reset(dw_hdmi, 0);
+	dw_hdmi_phy_gen2_pddq(dw_hdmi, 0);
+
+	dw_hdmi_phy_set_slave_addr(dw_hdmi);
+
+	if (mode->crtc_clock <= 27000) {
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x01e0, 0x06);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x0000, 0x15);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x08da, 0x10);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x0007, 0x19);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x0318, 0x0e);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x8009, 0x09);
+	} else if (mode->crtc_clock <= 74250) {
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x0540, 0x06);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x0005, 0x15);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x0000, 0x10);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x0007, 0x19);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x02b5, 0x0e);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x8009, 0x09);
+	} else if (mode->crtc_clock <= 148500) {
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x04a0, 0x06);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x000a, 0x15);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x0000, 0x10);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x0002, 0x19);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x0021, 0x0e);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x8029, 0x09);
+	} else {
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x0000, 0x06);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x000f, 0x15);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x0000, 0x10);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x0002, 0x19);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x0000, 0x0e);
+		dw_hdmi_phy_i2c_write(dw_hdmi, 0x802b, 0x09);
+	}
+
+	dw_hdmi_phy_i2c_write(dw_hdmi, 0x0000, 0x1e);
+	dw_hdmi_phy_i2c_write(dw_hdmi, 0x0000, 0x13);
+	dw_hdmi_phy_i2c_write(dw_hdmi, 0x0000, 0x17);
+
+	dw_hdmi_phy_gen2_txpwron(dw_hdmi, 1);
+
+	return 0;
+};
+
+static void sun8i_dw_hdmi_phy_disable(struct dw_hdmi *dw_hdmi, void *data)
+{
+	struct sun8i_dw_hdmi *hdmi = (struct sun8i_dw_hdmi *)data;
+
+	dw_hdmi_phy_gen2_txpwron(dw_hdmi, 0);
+	dw_hdmi_phy_gen2_pddq(dw_hdmi, 1);
+
+	writeb(0x20, hdmi->phy_base + SUN8I_HDMI_PHY_REG_UNK4);
+}
+
+static const struct dw_hdmi_phy_ops sun8i_dw_hdmi_phy_ops = {
+	.init = &sun8i_dw_hdmi_phy_init,
+	.disable = &sun8i_dw_hdmi_phy_disable,
+	.read_hpd = &dw_hdmi_phy_read_hpd,
+	.update_hpd = &dw_hdmi_phy_update_hpd,
+	.setup_hpd = &dw_hdmi_phy_setup_hpd,
+};
+
+static enum drm_mode_status
+sun8i_dw_hdmi_mode_valid(struct drm_connector *connector,
+			 const struct drm_display_mode *mode)
+{
+	if (mode->clock > 297000)
+		return MODE_BAD;
+
+	return MODE_OK;
+}
+
+static void sun8i_dw_hdmi_deinit(const struct dw_hdmi_plat_data *plat_data)
+{
+	struct sun8i_dw_hdmi *hdmi = to_sun8i_dw_hdmi(plat_data);
+
+	clk_disable_unprepare(hdmi->clk_tmds);
+	clk_disable_unprepare(hdmi->clk_sfr);
+	clk_disable_unprepare(hdmi->clk_ahb);
+
+	reset_control_assert(hdmi->rst_phy);
+	reset_control_assert(hdmi->rst_ctrl);
+}
+
+static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
+			      void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_hdmi_plat_data *plat_data;
+	struct drm_device *drm = data;
+	struct drm_encoder *encoder;
+	struct sun8i_dw_hdmi *hdmi;
+	struct resource *res;
+	int ret;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	hdmi = devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);
+	if (!hdmi)
+		return -ENOMEM;
+
+	plat_data = &hdmi->plat_data;
+	hdmi->dev = &pdev->dev;
+	encoder = &hdmi->encoder;
+
+	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
+	/*
+	 * If we failed to find the CRTC(s) which this encoder is
+	 * supposed to be connected to, it's because the CRTC has
+	 * not been registered yet.  Defer probing, and hope that
+	 * the required CRTC is added later.
+	 */
+	if (encoder->possible_crtcs == 0)
+		return -EPROBE_DEFER;
+
+	/* resource 0 is the memory region for the core controller */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	hdmi->phy_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(hdmi->phy_base))
+		return PTR_ERR(hdmi->phy_base);
+
+	hdmi->clk_ahb = devm_clk_get(dev, "iahb");
+	if (IS_ERR(hdmi->clk_ahb)) {
+		dev_err(dev, "Could not get iahb clock\n");
+		return PTR_ERR(hdmi->clk_ahb);
+	}
+
+	hdmi->clk_sfr = devm_clk_get(dev, "isfr");
+	if (IS_ERR(hdmi->clk_sfr)) {
+		dev_err(dev, "Could not get isfr clock\n");
+		return PTR_ERR(hdmi->clk_sfr);
+	}
+
+	hdmi->clk_tmds = devm_clk_get(dev, "tmds");
+	if (IS_ERR(hdmi->clk_tmds)) {
+		dev_err(dev, "Could not get tmds clock\n");
+		return PTR_ERR(hdmi->clk_tmds);
+	}
+
+	hdmi->rst_ctrl = devm_reset_control_get(dev, "ctrl");
+	if (IS_ERR(hdmi->rst_ctrl)) {
+		dev_err(dev, "Could not get ctrl reset control\n");
+		return PTR_ERR(hdmi->rst_ctrl);
+	}
+
+	hdmi->rst_phy = devm_reset_control_get(dev, "phy");
+	if (IS_ERR(hdmi->rst_phy)) {
+		dev_err(dev, "Could not get phy reset control\n");
+		return PTR_ERR(hdmi->rst_phy);
+	}
+
+	ret = reset_control_deassert(hdmi->rst_ctrl);
+	if (ret) {
+		dev_err(dev, "Could not deassert ctrl reset control\n");
+		return ret;
+	}
+
+	ret = reset_control_deassert(hdmi->rst_phy);
+	if (ret) {
+		dev_err(dev, "Could not deassert phy reset control\n");
+		goto err_assert_ctrl_reset;
+	}
+
+	ret = clk_prepare_enable(hdmi->clk_ahb);
+	if (ret) {
+		dev_err(dev, "Cannot enable ahb clock: %d\n", ret);
+		goto err_assert_phy_reset;
+	}
+
+	ret = clk_prepare_enable(hdmi->clk_sfr);
+	if (ret) {
+		dev_err(dev, "Cannot enable isfr clock: %d\n", ret);
+		goto err_ahb_clk;
+	}
+
+	/* A83T defaults to 1188 MHz, which is a bit high */
+	clk_set_rate(hdmi->clk_tmds, 297000000);
+
+	ret = clk_prepare_enable(hdmi->clk_tmds);
+	if (ret) {
+		dev_err(dev, "Cannot enable tmds clock: %d\n", ret);
+		goto err_sfr_clk;
+	}
+
+	drm_encoder_helper_add(encoder, &sun8i_dw_hdmi_encoder_helper_funcs);
+	drm_encoder_init(drm, encoder, &sun8i_dw_hdmi_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
+
+	sun8i_dw_hdmi_init(hdmi);
+
+	plat_data->deinit = &sun8i_dw_hdmi_deinit;
+	plat_data->mode_valid = &sun8i_dw_hdmi_mode_valid;
+	plat_data->phy_ops = &sun8i_dw_hdmi_phy_ops;
+	plat_data->phy_name = "sun8i_dw_hdmi_phy";
+	plat_data->phy_data = hdmi;
+
+	ret = dw_hdmi_bind(pdev, encoder, plat_data);
+
+	/*
+	 * If dw_hdmi_bind() fails we'll never call dw_hdmi_unbind(),
+	 * which would have called the encoder cleanup.  Do it manually.
+	 */
+	if (ret)
+		goto cleanup_encoder;
+
+	return 0;
+
+cleanup_encoder:
+	drm_encoder_cleanup(encoder);
+	clk_disable_unprepare(hdmi->clk_tmds);
+err_sfr_clk:
+	clk_disable_unprepare(hdmi->clk_sfr);
+err_ahb_clk:
+	clk_disable_unprepare(hdmi->clk_ahb);
+err_assert_phy_reset:
+	reset_control_assert(hdmi->rst_phy);
+err_assert_ctrl_reset:
+	reset_control_assert(hdmi->rst_ctrl);
+
+	return ret;
+}
+
+static void sun8i_dw_hdmi_unbind(struct device *dev, struct device *master,
+				 void *data)
+{
+	return dw_hdmi_unbind(dev);
+}
+
+static const struct component_ops sun8i_dw_hdmi_ops = {
+	.bind	= sun8i_dw_hdmi_bind,
+	.unbind	= sun8i_dw_hdmi_unbind,
+};
+
+static int sun8i_dw_hdmi_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &sun8i_dw_hdmi_ops);
+}
+
+static int sun8i_dw_hdmi_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &sun8i_dw_hdmi_ops);
+
+	return 0;
+}
+
+static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
+	{ .compatible = "allwinner,sun8i-a83t-dw-hdmi" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, sun8i_dw_hdmi_dt_ids);
+
+struct platform_driver sun8i_dw_hdmi_pltfm_driver = {
+	.probe  = sun8i_dw_hdmi_probe,
+	.remove = sun8i_dw_hdmi_remove,
+	.driver = {
+		.name = "sun8i-dw-hdmi",
+		.of_match_table = sun8i_dw_hdmi_dt_ids,
+	},
+};
+module_platform_driver(sun8i_dw_hdmi_pltfm_driver);
+
+MODULE_AUTHOR("Jernej Skrabec <jernej.skrabec@siol.net>");
+MODULE_DESCRIPTION("Allwinner DW HDMI bridge");
+MODULE_LICENSE("GPL");
-- 
2.15.1
