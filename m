From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  2 Jun 2017 18:10:19 +0800
Subject: [PATCH 14/19] drm/sun4i: hdmi: Add support for A31's HDMI controller
In-Reply-To: <20170602101024.18940-1-wens@csie.org>
References: <20170602101024.18940-1-wens@csie.org>
Message-ID: <20170602101024.18940-15-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HDMI controller found in the A31 SoCs is slightly different
from the one already supported, which is found in the A10s:

  - Need different initial values for the PLL related registers

  - Different behavior of the DDC and TMDS clocks

  - Different register layout for the DDC portion

  - Separate DDC parent clock

This patch adds support for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi.h     |   3 +
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 141 +++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
index c63d0bd95963..2589bc92be59 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
@@ -56,10 +56,13 @@
 #define SUN4I_HDMI_PAD_CTRL0_TXEN		BIT(23)
 
 #define SUN4I_HDMI_PAD_CTRL1_REG	0x204
+#define SUN4I_HDMI_PAD_CTRL1_UNKNOWN		BIT(24)	/* set on A31 */
 #define SUN4I_HDMI_PAD_CTRL1_AMP_OPT		BIT(23)
 #define SUN4I_HDMI_PAD_CTRL1_AMPCK_OPT		BIT(22)
 #define SUN4I_HDMI_PAD_CTRL1_EMP_OPT		BIT(20)
 #define SUN4I_HDMI_PAD_CTRL1_EMPCK_OPT		BIT(19)
+#define SUN4I_HDMI_PAD_CTRL1_PWSCK		BIT(18)
+#define SUN4I_HDMI_PAD_CTRL1_PWSDT		BIT(17)
 #define SUN4I_HDMI_PAD_CTRL1_REG_DEN		BIT(15)
 #define SUN4I_HDMI_PAD_CTRL1_REG_DENCK		BIT(14)
 #define SUN4I_HDMI_PAD_CTRL1_REG_EMP(n)		(((n) & 7) << 10)
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 9ded40aaed32..e9abf93eb41c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -293,6 +293,109 @@ static const struct drm_connector_helper_funcs sun4i_hdmi_connector_helper_funcs
 	.get_modes	= sun4i_hdmi_get_modes,
 };
 
+static int sun6i_hdmi_read_sub_block(struct sun4i_hdmi *hdmi,
+				     unsigned int blk, unsigned int offset,
+				     u8 *buf, unsigned int count)
+{
+	unsigned long reg;
+	int i;
+
+	reg = readl(hdmi->base + SUN6I_HDMI_DDC_FIFO_CTRL_REG);
+	writel(reg | SUN6I_HDMI_DDC_FIFO_CTRL_CLEAR,
+	       hdmi->base + SUN6I_HDMI_DDC_FIFO_CTRL_REG);
+	writel(SUN6I_HDMI_DDC_ADDR_SEGMENT(offset >> 8) |
+	       SUN6I_HDMI_DDC_ADDR_EDDC(DDC_SEGMENT_ADDR << 1) |
+	       SUN6I_HDMI_DDC_ADDR_OFFSET(offset) |
+	       SUN6I_HDMI_DDC_ADDR_SLAVE(DDC_ADDR),
+	       hdmi->base + SUN6I_HDMI_DDC_ADDR_REG);
+
+	writel(SUN6I_HDMI_DDC_CMD_EXPLICIT_EDDC_READ |
+	       SUN6I_HDMI_DDC_CMD_BYTE_COUNT(count),
+	       hdmi->base + SUN6I_HDMI_DDC_CMD_REG);
+
+	reg = readl(hdmi->base + SUN6I_HDMI_DDC_CTRL_REG);
+	writel(reg | SUN6I_HDMI_DDC_CTRL_START_CMD,
+	       hdmi->base + SUN6I_HDMI_DDC_CTRL_REG);
+
+	if (readl_poll_timeout(hdmi->base + SUN6I_HDMI_DDC_CTRL_REG, reg,
+			       !(reg & SUN6I_HDMI_DDC_CTRL_START_CMD),
+			       100, 100000))
+		return -EIO;
+
+	for (i = 0; i < count; i++)
+		buf[i] = readb(hdmi->base + SUN6I_HDMI_DDC_FIFO_DATA_REG);
+
+	return 0;
+}
+
+static int sun6i_hdmi_read_edid_block(void *data, u8 *buf, unsigned int blk,
+				      size_t length)
+{
+	struct sun4i_hdmi *hdmi = data;
+	int retry = 2, i;
+
+	do {
+		for (i = 0; i < length; i += SUN4I_HDMI_DDC_FIFO_SIZE) {
+			unsigned char offset = blk * EDID_LENGTH + i;
+			unsigned int count = min((unsigned int)SUN4I_HDMI_DDC_FIFO_SIZE,
+						 length - i);
+			int ret;
+
+			ret = sun6i_hdmi_read_sub_block(hdmi, blk, offset,
+							buf + i, count);
+			if (ret)
+				return ret;
+		}
+	} while (!drm_edid_block_valid(buf, blk, true, NULL) && (retry--));
+
+	return 0;
+}
+
+static int sun6i_hdmi_get_modes(struct drm_connector *connector)
+{
+	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
+	u32 reg;
+	struct edid *edid;
+	int ret;
+
+	clk_set_rate(hdmi->ddc_clk, 100000);
+	clk_prepare_enable(hdmi->ddc_clk);
+
+	/* Reset i2c controller */
+	writel(SUN6I_HDMI_DDC_CTRL_ENABLE | SUN6I_HDMI_DDC_CTRL_RESET |
+	       SUN6I_HDMI_DDC_CTRL_SDA_ENABLE |
+	       SUN6I_HDMI_DDC_CTRL_SCL_ENABLE,
+	       hdmi->base + SUN6I_HDMI_DDC_CTRL_REG);
+	if (readl_poll_timeout(hdmi->base + SUN6I_HDMI_DDC_CTRL_REG, reg,
+			       !(reg & SUN6I_HDMI_DDC_CTRL_RESET),
+			       100, 2000)) {
+		dev_err(hdmi->dev, "DDC reset timeout: %08x\n", reg);
+		clk_disable_unprepare(hdmi->ddc_clk);
+		return -EIO;
+	}
+
+	edid = drm_do_get_edid(connector, sun6i_hdmi_read_edid_block, hdmi);
+
+	clk_disable_unprepare(hdmi->ddc_clk);
+
+	if (!edid)
+		return 0;
+
+	hdmi->hdmi_monitor = drm_detect_hdmi_monitor(edid);
+	DRM_DEBUG_DRIVER("Monitor is %s monitor\n",
+			 hdmi->hdmi_monitor ? "an HDMI" : "a DVI");
+
+	drm_mode_connector_update_edid_property(connector, edid);
+	ret = drm_add_edid_modes(connector, edid);
+	kfree(edid);
+
+	return ret;
+}
+
+static const struct drm_connector_helper_funcs sun6i_hdmi_connector_helper_funcs = {
+	.get_modes	= sun6i_hdmi_get_modes,
+};
+
 static enum drm_connector_status
 sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -367,6 +470,43 @@ static const struct sun4i_hdmi_variant sun5i_variant = {
 				  SUN4I_HDMI_PLL_CTRL_PLL_EN,
 };
 
+static const struct sun4i_hdmi_variant sun6i_variant = {
+	.connector_helpers	= &sun6i_hdmi_connector_helper_funcs,
+	.ddc_create		= sun6i_ddc_create,
+	.tmds_create		= sun6i_tmds_create,
+	.has_ddc_parent_clk	= true,
+	.has_reset_control	= true,
+	.pad_ctrl0_init_val	= 0xff |
+				  SUN4I_HDMI_PAD_CTRL0_TXEN |
+				  SUN4I_HDMI_PAD_CTRL0_CKEN |
+				  SUN4I_HDMI_PAD_CTRL0_PWENG |
+				  SUN4I_HDMI_PAD_CTRL0_PWEND |
+				  SUN4I_HDMI_PAD_CTRL0_PWENC |
+				  SUN4I_HDMI_PAD_CTRL0_LDODEN |
+				  SUN4I_HDMI_PAD_CTRL0_LDOCEN,
+	.pad_ctrl1_init_val	= SUN4I_HDMI_PAD_CTRL1_REG_AMP(6) |
+				  SUN4I_HDMI_PAD_CTRL1_REG_EMP(4) |
+				  SUN4I_HDMI_PAD_CTRL1_REG_DENCK |
+				  SUN4I_HDMI_PAD_CTRL1_REG_DEN |
+				  SUN4I_HDMI_PAD_CTRL1_EMPCK_OPT |
+				  SUN4I_HDMI_PAD_CTRL1_EMP_OPT |
+				  SUN4I_HDMI_PAD_CTRL1_PWSDT |
+				  SUN4I_HDMI_PAD_CTRL1_PWSCK |
+				  SUN4I_HDMI_PAD_CTRL1_AMPCK_OPT |
+				  SUN4I_HDMI_PAD_CTRL1_AMP_OPT |
+				  SUN4I_HDMI_PAD_CTRL1_UNKNOWN,
+	.pll_ctrl_init_val	= SUN4I_HDMI_PLL_CTRL_VCO_S(8) |
+				  SUN4I_HDMI_PLL_CTRL_CS(3) |
+				  SUN4I_HDMI_PLL_CTRL_CP_S(10) |
+				  SUN4I_HDMI_PLL_CTRL_S(4) |
+				  SUN4I_HDMI_PLL_CTRL_VCO_GAIN(4) |
+				  SUN4I_HDMI_PLL_CTRL_SDIV2 |
+				  SUN4I_HDMI_PLL_CTRL_LDO2_EN |
+				  SUN4I_HDMI_PLL_CTRL_LDO1_EN |
+				  SUN4I_HDMI_PLL_CTRL_HV_IS_33 |
+				  SUN4I_HDMI_PLL_CTRL_PLL_EN,
+};
+
 static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 			   void *data)
 {
@@ -559,6 +699,7 @@ static int sun4i_hdmi_remove(struct platform_device *pdev)
 
 static const struct of_device_id sun4i_hdmi_of_table[] = {
 	{ .compatible = "allwinner,sun5i-a10s-hdmi", .data = &sun5i_variant, },
+	{ .compatible = "allwinner,sun6i-a31-hdmi", .data = &sun6i_variant, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_hdmi_of_table);
-- 
2.11.0
