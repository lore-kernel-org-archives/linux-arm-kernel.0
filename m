From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 21:27:17 +0000
Subject: [PATCH RFC 18/46] imx-drm: imx-hdmi: provide register modification
 function
In-Reply-To: <20140102212528.GD7383@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
Message-ID: <E1VypnR-0007Ei-Pd@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a load of read-modify-write patterns to change bitfields in
various registers in this driver; provide a helper to perform this
manipulation.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/imx-hdmi.c |  188 +++++++++++++-----------------------
 1 files changed, 68 insertions(+), 120 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index dc46d2acd9c5..f8c652e58a6d 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -160,37 +160,34 @@ static inline u8 hdmi_readb(struct imx_hdmi *hdmi, int offset)
 	return readb(hdmi->regs + offset);
 }
 
+static void hdmi_modb(struct imx_hdmi *hdmi, u8 data, u8 mask, unsigned reg)
+{
+	u8 val = hdmi_readb(hdmi, reg) & ~mask;
+	val |= data & mask;
+	hdmi_writeb(hdmi, val, reg);
+}
+
 static void hdmi_mask_writeb(struct imx_hdmi *hdmi, u8 data, unsigned int reg,
 		      u8 shift, u8 mask)
 {
-	u8 value = hdmi_readb(hdmi, reg) & ~mask;
-	value |= (data << shift) & mask;
-	hdmi_writeb(hdmi, value, reg);
+	hdmi_modb(hdmi, data << shift, mask, reg);
 }
 
 static void hdmi_set_clock_regenerator_n(struct imx_hdmi *hdmi,
 					 unsigned int value)
 {
-	u8 val;
-
 	hdmi_writeb(hdmi, value & 0xff, HDMI_AUD_N1);
 	hdmi_writeb(hdmi, (value >> 8) & 0xff, HDMI_AUD_N2);
 	hdmi_writeb(hdmi, (value >> 16) & 0x0f, HDMI_AUD_N3);
 
 	/* nshift factor = 0 */
-	val = hdmi_readb(hdmi, HDMI_AUD_CTS3);
-	val &= ~HDMI_AUD_CTS3_N_SHIFT_MASK;
-	hdmi_writeb(hdmi, val, HDMI_AUD_CTS3);
+	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_N_SHIFT_MASK, HDMI_AUD_CTS3);
 }
 
 static void hdmi_regenerate_cts(struct imx_hdmi *hdmi, unsigned int cts)
 {
-	u8 val;
-
 	/* Must be set/cleared first */
-	val = hdmi_readb(hdmi, HDMI_AUD_CTS3);
-	val &= ~HDMI_AUD_CTS3_CTS_MANUAL;
-	hdmi_writeb(hdmi, val, HDMI_AUD_CTS3);
+	hdmi_modb(hdmi, 0, HDMI_AUD_CTS3_CTS_MANUAL, HDMI_AUD_CTS3);
 
 	hdmi_writeb(hdmi, cts & 0xff, HDMI_AUD_CTS1);
 	hdmi_writeb(hdmi, (cts >> 8) & 0xff, HDMI_AUD_CTS2);
@@ -486,7 +483,6 @@ static void imx_hdmi_update_csc_coeffs(struct imx_hdmi *hdmi)
 	const u16 (*csc_coeff)[3][4] = &csc_coeff_default;
 	unsigned i;
 	u32 csc_scale = 1;
-	u8 val;
 
 	if (is_color_space_conversion(hdmi)) {
 		if (hdmi->hdmi_data.enc_out_format == RGB) {
@@ -517,10 +513,8 @@ static void imx_hdmi_update_csc_coeffs(struct imx_hdmi *hdmi)
 		hdmi_writeb(hdmi, coeff_c >> 8, HDMI_CSC_COEF_C1_MSB + i * 2);
 	}
 
-	val = hdmi_readb(hdmi, HDMI_CSC_SCALE);
-	val &= ~HDMI_CSC_SCALE_CSCSCALE_MASK;
-	val |= csc_scale & HDMI_CSC_SCALE_CSCSCALE_MASK;
-	hdmi_writeb(hdmi, val, HDMI_CSC_SCALE);
+	hdmi_modb(hdmi, csc_scale, HDMI_CSC_SCALE_CSCSCALE_MASK,
+		  HDMI_CSC_SCALE);
 }
 
 static void hdmi_video_csc(struct imx_hdmi *hdmi)
@@ -528,7 +522,6 @@ static void hdmi_video_csc(struct imx_hdmi *hdmi)
 	int color_depth = 0;
 	int interpolation = HDMI_CSC_CFG_INTMODE_DISABLE;
 	int decimation = 0;
-	u8 val;
 
 	/* YCC422 interpolation to 444 mode */
 	if (is_color_space_interpolation(hdmi))
@@ -549,10 +542,8 @@ static void hdmi_video_csc(struct imx_hdmi *hdmi)
 
 	/* Configure the CSC registers */
 	hdmi_writeb(hdmi, interpolation | decimation, HDMI_CSC_CFG);
-	val = hdmi_readb(hdmi, HDMI_CSC_SCALE);
-	val &= ~HDMI_CSC_SCALE_CSC_COLORDE_PTH_MASK;
-	val |= color_depth;
-	hdmi_writeb(hdmi, val, HDMI_CSC_SCALE);
+	hdmi_modb(hdmi, color_depth, HDMI_CSC_SCALE_CSC_COLORDE_PTH_MASK,
+		  HDMI_CSC_SCALE);
 
 	imx_hdmi_update_csc_coeffs(hdmi);
 }
@@ -607,107 +598,80 @@ static void hdmi_video_packetize(struct imx_hdmi *hdmi)
 		HDMI_VP_PR_CD_DESIRED_PR_FACTOR_MASK);
 	hdmi_writeb(hdmi, val, HDMI_VP_PR_CD);
 
-	val = hdmi_readb(hdmi, HDMI_VP_STUFF);
-	val &= ~HDMI_VP_STUFF_PR_STUFFING_MASK;
-	val |= HDMI_VP_STUFF_PR_STUFFING_STUFFING_MODE;
-	hdmi_writeb(hdmi, val, HDMI_VP_STUFF);
+	hdmi_modb(hdmi, HDMI_VP_STUFF_PR_STUFFING_STUFFING_MODE,
+		  HDMI_VP_STUFF_PR_STUFFING_MASK, HDMI_VP_STUFF);
 
 	/* Data from pixel repeater block */
 	if (hdmi_data->pix_repet_factor > 1) {
-		val = hdmi_readb(hdmi, HDMI_VP_CONF);
-		val &= ~(HDMI_VP_CONF_PR_EN_MASK |
-			HDMI_VP_CONF_BYPASS_SELECT_MASK);
-		val |= HDMI_VP_CONF_PR_EN_ENABLE |
-			HDMI_VP_CONF_BYPASS_SELECT_PIX_REPEATER;
-		hdmi_writeb(hdmi, val, HDMI_VP_CONF);
+		hdmi_modb(hdmi, HDMI_VP_CONF_PR_EN_ENABLE |
+				HDMI_VP_CONF_BYPASS_SELECT_PIX_REPEATER,
+			  HDMI_VP_CONF_PR_EN_MASK |
+			  HDMI_VP_CONF_BYPASS_SELECT_MASK, HDMI_VP_CONF);
 	} else { /* data from packetizer block */
-		val = hdmi_readb(hdmi, HDMI_VP_CONF);
-		val &= ~(HDMI_VP_CONF_PR_EN_MASK |
-			HDMI_VP_CONF_BYPASS_SELECT_MASK);
-		val |= HDMI_VP_CONF_PR_EN_DISABLE |
-			HDMI_VP_CONF_BYPASS_SELECT_VID_PACKETIZER;
-		hdmi_writeb(hdmi, val, HDMI_VP_CONF);
+		hdmi_modb(hdmi, HDMI_VP_CONF_PR_EN_DISABLE |
+				HDMI_VP_CONF_BYPASS_SELECT_VID_PACKETIZER,
+			  HDMI_VP_CONF_PR_EN_MASK |
+			  HDMI_VP_CONF_BYPASS_SELECT_MASK, HDMI_VP_CONF);
 	}
 
-	val = hdmi_readb(hdmi, HDMI_VP_STUFF);
-	val &= ~HDMI_VP_STUFF_IDEFAULT_PHASE_MASK;
-	val |= 1 << HDMI_VP_STUFF_IDEFAULT_PHASE_OFFSET;
-	hdmi_writeb(hdmi, val, HDMI_VP_STUFF);
+	hdmi_modb(hdmi, 1 << HDMI_VP_STUFF_IDEFAULT_PHASE_OFFSET,
+		  HDMI_VP_STUFF_IDEFAULT_PHASE_MASK, HDMI_VP_STUFF);
 
 	hdmi_writeb(hdmi, remap_size, HDMI_VP_REMAP);
 
 	if (output_select == HDMI_VP_CONF_OUTPUT_SELECTOR_PP) {
-		val = hdmi_readb(hdmi, HDMI_VP_CONF);
-		val &= ~(HDMI_VP_CONF_BYPASS_EN_MASK |
-			HDMI_VP_CONF_PP_EN_ENMASK |
-			HDMI_VP_CONF_YCC422_EN_MASK);
-		val |= HDMI_VP_CONF_BYPASS_EN_DISABLE |
-			HDMI_VP_CONF_PP_EN_ENABLE |
-			HDMI_VP_CONF_YCC422_EN_DISABLE;
-		hdmi_writeb(hdmi, val, HDMI_VP_CONF);
+		hdmi_modb(hdmi, HDMI_VP_CONF_BYPASS_EN_DISABLE |
+				HDMI_VP_CONF_PP_EN_ENABLE |
+				HDMI_VP_CONF_YCC422_EN_DISABLE,
+			  HDMI_VP_CONF_BYPASS_EN_MASK |
+			  HDMI_VP_CONF_PP_EN_ENMASK |
+			  HDMI_VP_CONF_YCC422_EN_MASK, HDMI_VP_CONF);
 	} else if (output_select == HDMI_VP_CONF_OUTPUT_SELECTOR_YCC422) {
-		val = hdmi_readb(hdmi, HDMI_VP_CONF);
-		val &= ~(HDMI_VP_CONF_BYPASS_EN_MASK |
-			HDMI_VP_CONF_PP_EN_ENMASK |
-			HDMI_VP_CONF_YCC422_EN_MASK);
-		val |= HDMI_VP_CONF_BYPASS_EN_DISABLE |
-			HDMI_VP_CONF_PP_EN_DISABLE |
-			HDMI_VP_CONF_YCC422_EN_ENABLE;
-		hdmi_writeb(hdmi, val, HDMI_VP_CONF);
+		hdmi_modb(hdmi, HDMI_VP_CONF_BYPASS_EN_DISABLE |
+				HDMI_VP_CONF_PP_EN_DISABLE |
+				HDMI_VP_CONF_YCC422_EN_ENABLE,
+			  HDMI_VP_CONF_BYPASS_EN_MASK |
+			  HDMI_VP_CONF_PP_EN_ENMASK |
+			  HDMI_VP_CONF_YCC422_EN_MASK, HDMI_VP_CONF);
 	} else if (output_select == HDMI_VP_CONF_OUTPUT_SELECTOR_BYPASS) {
-		val = hdmi_readb(hdmi, HDMI_VP_CONF);
-		val &= ~(HDMI_VP_CONF_BYPASS_EN_MASK |
-			HDMI_VP_CONF_PP_EN_ENMASK |
-			HDMI_VP_CONF_YCC422_EN_MASK);
-		val |= HDMI_VP_CONF_BYPASS_EN_ENABLE |
-			HDMI_VP_CONF_PP_EN_DISABLE |
-			HDMI_VP_CONF_YCC422_EN_DISABLE;
-		hdmi_writeb(hdmi, val, HDMI_VP_CONF);
+		hdmi_modb(hdmi, HDMI_VP_CONF_BYPASS_EN_ENABLE |
+				HDMI_VP_CONF_PP_EN_DISABLE |
+				HDMI_VP_CONF_YCC422_EN_DISABLE,
+			  HDMI_VP_CONF_BYPASS_EN_MASK |
+			  HDMI_VP_CONF_PP_EN_ENMASK |
+			  HDMI_VP_CONF_YCC422_EN_MASK, HDMI_VP_CONF);
 	} else {
 		return;
 	}
 
-	val = hdmi_readb(hdmi, HDMI_VP_STUFF);
-	val &= ~(HDMI_VP_STUFF_PP_STUFFING_MASK |
-		HDMI_VP_STUFF_YCC422_STUFFING_MASK);
-	val |= HDMI_VP_STUFF_PP_STUFFING_STUFFING_MODE |
-		HDMI_VP_STUFF_YCC422_STUFFING_STUFFING_MODE;
-	hdmi_writeb(hdmi, val, HDMI_VP_STUFF);
+	hdmi_modb(hdmi, HDMI_VP_STUFF_PP_STUFFING_STUFFING_MODE |
+			HDMI_VP_STUFF_YCC422_STUFFING_STUFFING_MODE,
+		  HDMI_VP_STUFF_PP_STUFFING_MASK |
+		  HDMI_VP_STUFF_YCC422_STUFFING_MASK, HDMI_VP_STUFF);
 
-	val = hdmi_readb(hdmi, HDMI_VP_CONF);
-	val &= ~HDMI_VP_CONF_OUTPUT_SELECTOR_MASK;
-	val |= output_select;
-	hdmi_writeb(hdmi, val, HDMI_VP_CONF);
+	hdmi_modb(hdmi, output_select, HDMI_VP_CONF_OUTPUT_SELECTOR_MASK,
+		  HDMI_VP_CONF);
 }
 
 static inline void hdmi_phy_test_clear(struct imx_hdmi *hdmi,
 						unsigned char bit)
 {
-	u8 val = hdmi_readb(hdmi, HDMI_PHY_TST0);
-	val &= ~HDMI_PHY_TST0_TSTCLR_MASK;
-	val |= (bit << HDMI_PHY_TST0_TSTCLR_OFFSET) &
-		HDMI_PHY_TST0_TSTCLR_MASK;
-	hdmi_writeb(hdmi, val, HDMI_PHY_TST0);
+	hdmi_modb(hdmi, bit << HDMI_PHY_TST0_TSTCLR_OFFSET,
+		  HDMI_PHY_TST0_TSTCLR_MASK, HDMI_PHY_TST0);
 }
 
 static inline void hdmi_phy_test_enable(struct imx_hdmi *hdmi,
 						unsigned char bit)
 {
-	u8 val = hdmi_readb(hdmi, HDMI_PHY_TST0);
-	val &= ~HDMI_PHY_TST0_TSTEN_MASK;
-	val |= (bit << HDMI_PHY_TST0_TSTEN_OFFSET) &
-		HDMI_PHY_TST0_TSTEN_MASK;
-	hdmi_writeb(hdmi, val, HDMI_PHY_TST0);
+	hdmi_modb(hdmi, bit << HDMI_PHY_TST0_TSTEN_OFFSET,
+		  HDMI_PHY_TST0_TSTEN_MASK, HDMI_PHY_TST0);
 }
 
 static inline void hdmi_phy_test_clock(struct imx_hdmi *hdmi,
 						unsigned char bit)
 {
-	u8 val = hdmi_readb(hdmi, HDMI_PHY_TST0);
-	val &= ~HDMI_PHY_TST0_TSTCLK_MASK;
-	val |= (bit << HDMI_PHY_TST0_TSTCLK_OFFSET) &
-		HDMI_PHY_TST0_TSTCLK_MASK;
-	hdmi_writeb(hdmi, val, HDMI_PHY_TST0);
+	hdmi_modb(hdmi, bit << HDMI_PHY_TST0_TSTCLK_OFFSET,
+		  HDMI_PHY_TST0_TSTCLK_MASK, HDMI_PHY_TST0);
 }
 
 static inline void hdmi_phy_test_din(struct imx_hdmi *hdmi,
@@ -1004,7 +968,7 @@ static int imx_hdmi_phy_init(struct imx_hdmi *hdmi)
 
 static void hdmi_tx_hdcp_config(struct imx_hdmi *hdmi)
 {
-	u8 de, val;
+	u8 de;
 
 	if (hdmi->hdmi_data.video_mode.mdataenablepolarity)
 		de = HDMI_A_VIDPOLCFG_DATAENPOL_ACTIVE_HIGH;
@@ -1012,20 +976,13 @@ static void hdmi_tx_hdcp_config(struct imx_hdmi *hdmi)
 		de = HDMI_A_VIDPOLCFG_DATAENPOL_ACTIVE_LOW;
 
 	/* disable rx detect */
-	val = hdmi_readb(hdmi, HDMI_A_HDCPCFG0);
-	val &= HDMI_A_HDCPCFG0_RXDETECT_MASK;
-	val |= HDMI_A_HDCPCFG0_RXDETECT_DISABLE;
-	hdmi_writeb(hdmi, val, HDMI_A_HDCPCFG0);
+	hdmi_modb(hdmi, HDMI_A_HDCPCFG0_RXDETECT_DISABLE,
+		  HDMI_A_HDCPCFG0_RXDETECT_MASK, HDMI_A_HDCPCFG0);
 
-	val = hdmi_readb(hdmi, HDMI_A_VIDPOLCFG);
-	val &= HDMI_A_VIDPOLCFG_DATAENPOL_MASK;
-	val |= de;
-	hdmi_writeb(hdmi, val, HDMI_A_VIDPOLCFG);
+	hdmi_modb(hdmi, de, HDMI_A_VIDPOLCFG_DATAENPOL_MASK, HDMI_A_VIDPOLCFG);
 
-	val = hdmi_readb(hdmi, HDMI_A_HDCPCFG1);
-	val &= HDMI_A_HDCPCFG1_ENCRYPTIONDISABLE_MASK;
-	val |= HDMI_A_HDCPCFG1_ENCRYPTIONDISABLE_DISABLE;
-	hdmi_writeb(hdmi, val, HDMI_A_HDCPCFG1);
+	hdmi_modb(hdmi, HDMI_A_HDCPCFG1_ENCRYPTIONDISABLE_DISABLE,
+		  HDMI_A_HDCPCFG1_ENCRYPTIONDISABLE_MASK, HDMI_A_HDCPCFG1);
 }
 
 static void hdmi_config_AVI(struct imx_hdmi *hdmi)
@@ -1249,11 +1206,7 @@ static void imx_hdmi_enable_video_path(struct imx_hdmi *hdmi)
 
 static void hdmi_enable_audio_clk(struct imx_hdmi *hdmi)
 {
-	u8 clkdis;
-
-	clkdis = hdmi_readb(hdmi, HDMI_MC_CLKDIS);
-	clkdis &= ~HDMI_MC_CLKDIS_AUDCLK_DISABLE;
-	hdmi_writeb(hdmi, clkdis, HDMI_MC_CLKDIS);
+	hdmi_modb(hdmi, 0, HDMI_MC_CLKDIS_AUDCLK_DISABLE, HDMI_MC_CLKDIS);
 }
 
 /* Workaround to clear the overflow condition */
@@ -1597,7 +1550,6 @@ static irqreturn_t imx_hdmi_irq(int irq, void *dev_id)
 	struct imx_hdmi *hdmi = dev_id;
 	u8 intr_stat;
 	u8 phy_int_pol;
-	u8 val;
 
 	intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0);
 
@@ -1607,17 +1559,13 @@ static irqreturn_t imx_hdmi_irq(int irq, void *dev_id)
 		if (phy_int_pol & HDMI_PHY_HPD) {
 			dev_dbg(hdmi->dev, "EVENT=plugin\n");
 
-			val = hdmi_readb(hdmi, HDMI_PHY_POL0);
-			val &= ~HDMI_PHY_HPD;
-			hdmi_writeb(hdmi, val, HDMI_PHY_POL0);
+			hdmi_modb(hdmi, 0, HDMI_PHY_HPD, HDMI_PHY_POL0);
 
 			imx_hdmi_poweron(hdmi);
 		} else {
 			dev_dbg(hdmi->dev, "EVENT=plugout\n");
 
-			val = hdmi_readb(hdmi, HDMI_PHY_POL0);
-			val |= HDMI_PHY_HPD;
-			hdmi_writeb(hdmi, val, HDMI_PHY_POL0);
+			hdmi_modb(hdmi, HDMI_PHY_HPD, HDMI_PHY_HPD, HDMI_PHY_POL0);
 
 			imx_hdmi_poweroff(hdmi);
 		}
-- 
1.7.4.4
