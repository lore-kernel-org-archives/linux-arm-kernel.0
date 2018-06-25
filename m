From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Mon, 25 Jun 2018 14:02:57 +0200
Subject: [PATCH v3 17/24] drm/sun4i: Don't change clock bits in DW HDMI PHY
 driver
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
Message-ID: <20180625120304.7543-18-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DW HDMI PHY driver and PHY clock driver share same registers. Make sure
that DW HDMI PHY setup code doesn't change any clock related bits.
During initialization, set PHY PLL parent bit to 0.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  |  2 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index 79154f0f674a..3ba71aff92fc 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -98,7 +98,7 @@
 #define SUN8I_HDMI_PHY_PLL_CFG1_LDO2_EN		BIT(29)
 #define SUN8I_HDMI_PHY_PLL_CFG1_LDO1_EN		BIT(28)
 #define SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33	BIT(27)
-#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL	BIT(26)
+#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK	BIT(26)
 #define SUN8I_HDMI_PHY_PLL_CFG1_PLLEN		BIT(25)
 #define SUN8I_HDMI_PHY_PLL_CFG1_LDO_VSET(x)	((x) << 22)
 #define SUN8I_HDMI_PHY_PLL_CFG1_UNKNOWN(x)	((x) << 20)
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 966688f04741..e56b9e5b1c42 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -183,7 +183,13 @@ static int sun8i_hdmi_phy_config_h3(struct dw_hdmi *hdmi,
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG,
 			   SUN8I_HDMI_PHY_ANA_CFG1_TXEN_MASK, 0);
 
-	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, pll_cfg1_init);
+	/*
+	 * NOTE: We have to be careful not to overwrite PHY parent
+	 * clock selection bit and clock divider.
+	 */
+	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
+			   (u32)~SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
+			   pll_cfg1_init);
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG,
 			   (u32)~SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK,
 			   pll_cfg2_init);
@@ -352,6 +358,10 @@ static void sun8i_hdmi_phy_init_h3(struct sun8i_hdmi_phy *phy)
 			   SUN8I_HDMI_PHY_ANA_CFG3_SCLEN |
 			   SUN8I_HDMI_PHY_ANA_CFG3_SDAEN);
 
+	/* reset PHY PLL clock parent */
+	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
+			   SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK, 0);
+
 	/* set HW control of CEC pins */
 	regmap_write(phy->regs, SUN8I_HDMI_PHY_CEC_REG, 0);
 
-- 
2.18.0
