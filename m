From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 20:18:00 +0800
Subject: [PATCH 03/10] drm/sun4i: hdmi: Support HDMI controller on A10
In-Reply-To: <20171017121807.2994-1-wens@csie.org>
References: <20171017121807.2994-1-wens@csie.org>
Message-ID: <20171017121807.2994-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HDMI controller in the A10 SoC is the same as the one currently
supported in the A10s. It has slightly different setup parameters.
Since these parameters are not thoroughly understood, we add support
for this variant by copying these parameters verbatim.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../bindings/display/sunxi/sun4i-drm.txt           |  1 +
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             | 53 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index b2c08af73a95..5650efcfd2ac 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -40,6 +40,7 @@ CEC. It is one end of the pipeline.
 
 Required properties:
   - compatible: value must be one of:
+    * allwinner,sun4i-a10-hdmi
     * allwinner,sun5i-a10s-hdmi
     * allwinner,sun6i-a31-hdmi
   - reg: base address and size of memory-mapped region
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 6ca6e6a74c4a..bc2ba74d2ae5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -289,6 +289,58 @@ static const struct cec_pin_ops sun4i_hdmi_cec_pin_ops = {
 #define SUN4I_HDMI_PAD_CTRL1_MASK	(GENMASK(24, 7) | GENMASK(5, 0))
 #define SUN4I_HDMI_PLL_CTRL_MASK	(GENMASK(31, 8) | GENMASK(3, 0))
 
+/* Only difference from sun5i is AMP is 4 instead of 6 */
+static const struct sun4i_hdmi_variant sun4i_variant = {
+	.pad_ctrl0_init_val	= SUN4I_HDMI_PAD_CTRL0_TXEN |
+				  SUN4I_HDMI_PAD_CTRL0_CKEN |
+				  SUN4I_HDMI_PAD_CTRL0_PWENG |
+				  SUN4I_HDMI_PAD_CTRL0_PWEND |
+				  SUN4I_HDMI_PAD_CTRL0_PWENC |
+				  SUN4I_HDMI_PAD_CTRL0_LDODEN |
+				  SUN4I_HDMI_PAD_CTRL0_LDOCEN |
+				  SUN4I_HDMI_PAD_CTRL0_BIASEN,
+	.pad_ctrl1_init_val	= SUN4I_HDMI_PAD_CTRL1_REG_AMP(4) |
+				  SUN4I_HDMI_PAD_CTRL1_REG_EMP(2) |
+				  SUN4I_HDMI_PAD_CTRL1_REG_DENCK |
+				  SUN4I_HDMI_PAD_CTRL1_REG_DEN |
+				  SUN4I_HDMI_PAD_CTRL1_EMPCK_OPT |
+				  SUN4I_HDMI_PAD_CTRL1_EMP_OPT |
+				  SUN4I_HDMI_PAD_CTRL1_AMPCK_OPT |
+				  SUN4I_HDMI_PAD_CTRL1_AMP_OPT,
+	.pll_ctrl_init_val	= SUN4I_HDMI_PLL_CTRL_VCO_S(8) |
+				  SUN4I_HDMI_PLL_CTRL_CS(7) |
+				  SUN4I_HDMI_PLL_CTRL_CP_S(15) |
+				  SUN4I_HDMI_PLL_CTRL_S(7) |
+				  SUN4I_HDMI_PLL_CTRL_VCO_GAIN(4) |
+				  SUN4I_HDMI_PLL_CTRL_SDIV2 |
+				  SUN4I_HDMI_PLL_CTRL_LDO2_EN |
+				  SUN4I_HDMI_PLL_CTRL_LDO1_EN |
+				  SUN4I_HDMI_PLL_CTRL_HV_IS_33 |
+				  SUN4I_HDMI_PLL_CTRL_BWS |
+				  SUN4I_HDMI_PLL_CTRL_PLL_EN,
+
+	.ddc_clk_reg		= REG_FIELD(SUN4I_HDMI_DDC_CLK_REG, 0, 6),
+	.ddc_clk_pre_divider	= 2,
+	.ddc_clk_m_offset	= 1,
+
+	.field_ddc_en		= REG_FIELD(SUN4I_HDMI_DDC_CTRL_REG, 31, 31),
+	.field_ddc_start	= REG_FIELD(SUN4I_HDMI_DDC_CTRL_REG, 30, 30),
+	.field_ddc_reset	= REG_FIELD(SUN4I_HDMI_DDC_CTRL_REG, 0, 0),
+	.field_ddc_addr_reg	= REG_FIELD(SUN4I_HDMI_DDC_ADDR_REG, 0, 31),
+	.field_ddc_slave_addr	= REG_FIELD(SUN4I_HDMI_DDC_ADDR_REG, 0, 6),
+	.field_ddc_int_status	= REG_FIELD(SUN4I_HDMI_DDC_INT_STATUS_REG, 0, 8),
+	.field_ddc_fifo_clear	= REG_FIELD(SUN4I_HDMI_DDC_FIFO_CTRL_REG, 31, 31),
+	.field_ddc_fifo_rx_thres = REG_FIELD(SUN4I_HDMI_DDC_FIFO_CTRL_REG, 4, 7),
+	.field_ddc_fifo_tx_thres = REG_FIELD(SUN4I_HDMI_DDC_FIFO_CTRL_REG, 0, 3),
+	.field_ddc_byte_count	= REG_FIELD(SUN4I_HDMI_DDC_BYTE_COUNT_REG, 0, 9),
+	.field_ddc_cmd		= REG_FIELD(SUN4I_HDMI_DDC_CMD_REG, 0, 2),
+	.field_ddc_sda_en	= REG_FIELD(SUN4I_HDMI_DDC_LINE_CTRL_REG, 9, 9),
+	.field_ddc_sck_en	= REG_FIELD(SUN4I_HDMI_DDC_LINE_CTRL_REG, 8, 8),
+
+	.ddc_fifo_reg		= SUN4I_HDMI_DDC_FIFO_DATA_REG,
+	.ddc_fifo_has_dir	= true,
+};
+
 static const struct sun4i_hdmi_variant sun5i_variant = {
 	.pad_ctrl0_init_val	= SUN4I_HDMI_PAD_CTRL0_TXEN |
 				  SUN4I_HDMI_PAD_CTRL0_CKEN |
@@ -613,6 +665,7 @@ static int sun4i_hdmi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sun4i_hdmi_of_table[] = {
+	{ .compatible = "allwinner,sun4i-a10-hdmi", .data = &sun4i_variant, },
 	{ .compatible = "allwinner,sun5i-a10s-hdmi", .data = &sun5i_variant, },
 	{ .compatible = "allwinner,sun6i-a31-hdmi", .data = &sun6i_variant, },
 	{ }
-- 
2.14.2
