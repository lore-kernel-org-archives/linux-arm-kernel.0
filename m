From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Aug 2017 16:14:07 +0800
Subject: [PATCH 4/8] phy: sun4i-usb: Support A83T USB PHYs
In-Reply-To: <20170803081411.22389-1-wens@csie.org>
References: <20170803081411.22389-1-wens@csie.org>
Message-ID: <20170803081411.22389-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T has 3 USB PHYs, 1 for OTG, 1 for standard USB, 1 for USB HSIC.
The phy initialization procedure is very different from other SoCs, but
the PMU bits are the same, with additional bits for HSIC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 66 ++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 79157eced75a..af16f4fb9707 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -87,6 +87,16 @@
 #define PHY_DISCON_TH_SEL		0x2a
 #define PHY_SQUELCH_DETECT		0x3c
 
+/* A83T specific control bits for PHY0 */
+#define PHY_CTL_VBUSVLDEXT		BIT(5)
+#define PHY_CTL_SIDDQ			BIT(3)
+
+/* A83T specific control bits for PHY2 HSIC */
+#define SUNXI_EHCI_HS_FORCE		BIT(20)
+#define SUNXI_HSIC_CONNECT_DET		BIT(17)
+#define SUNXI_HSIC_CONNECT_INT		BIT(16)
+#define SUNXI_HSIC			BIT(1)
+
 #define MAX_PHYS			4
 
 /*
@@ -100,6 +110,7 @@ enum sun4i_usb_phy_type {
 	sun4i_a10_phy,
 	sun6i_a31_phy,
 	sun8i_a33_phy,
+	sun8i_a83t_phy,
 	sun8i_h3_phy,
 	sun8i_v3s_phy,
 	sun50i_a64_phy,
@@ -234,6 +245,7 @@ static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
 
 static void sun4i_usb_phy_passby(struct sun4i_usb_phy *phy, int enable)
 {
+	struct sun4i_usb_phy_data *phy_data = to_sun4i_usb_phy_data(phy);
 	u32 bits, reg_value;
 
 	if (!phy->pmu)
@@ -242,6 +254,11 @@ static void sun4i_usb_phy_passby(struct sun4i_usb_phy *phy, int enable)
 	bits = SUNXI_AHB_ICHR8_EN | SUNXI_AHB_INCR4_BURST_EN |
 		SUNXI_AHB_INCRX_ALIGN_EN | SUNXI_ULPI_BYPASS_EN;
 
+	/* A83T USB2 is HSIC */
+	if (phy_data->cfg->type == sun8i_a83t_phy && phy->index == 2)
+		bits |= SUNXI_EHCI_HS_FORCE | SUNXI_HSIC_CONNECT_INT |
+			SUNXI_HSIC;
+
 	reg_value = readl(phy->pmu);
 
 	if (enable)
@@ -276,21 +293,30 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 		return ret;
 	}
 
-	if (phy->pmu && data->cfg->enable_pmu_unk1) {
-		val = readl(phy->pmu + REG_PMU_UNK1);
-		writel(val & ~2, phy->pmu + REG_PMU_UNK1);
-	}
+	if (data->cfg->type == sun8i_a83t_phy) {
+		if (phy->index == 0) {
+			val = readl(data->base + data->cfg->phyctl_offset);
+			val |= PHY_CTL_VBUSVLDEXT;
+			val &= ~PHY_CTL_SIDDQ;
+			writel(val, data->base + data->cfg->phyctl_offset);
+		}
+	} else {
+		if (phy->pmu && data->cfg->enable_pmu_unk1) {
+			val = readl(phy->pmu + REG_PMU_UNK1);
+			writel(val & ~2, phy->pmu + REG_PMU_UNK1);
+		}
 
-	/* Enable USB 45 Ohm resistor calibration */
-	if (phy->index == 0)
-		sun4i_usb_phy_write(phy, PHY_RES45_CAL_EN, 0x01, 1);
+		/* Enable USB 45 Ohm resistor calibration */
+		if (phy->index == 0)
+			sun4i_usb_phy_write(phy, PHY_RES45_CAL_EN, 0x01, 1);
 
-	/* Adjust PHY's magnitude and rate */
-	sun4i_usb_phy_write(phy, PHY_TX_AMPLITUDE_TUNE, 0x14, 5);
+		/* Adjust PHY's magnitude and rate */
+		sun4i_usb_phy_write(phy, PHY_TX_AMPLITUDE_TUNE, 0x14, 5);
 
-	/* Disconnect threshold adjustment */
-	sun4i_usb_phy_write(phy, PHY_DISCON_TH_SEL,
-			    data->cfg->disc_thresh, 2);
+		/* Disconnect threshold adjustment */
+		sun4i_usb_phy_write(phy, PHY_DISCON_TH_SEL,
+				    data->cfg->disc_thresh, 2);
+	}
 
 	sun4i_usb_phy_passby(phy, 1);
 
@@ -316,6 +342,13 @@ static int sun4i_usb_phy_exit(struct phy *_phy)
 	struct sun4i_usb_phy_data *data = to_sun4i_usb_phy_data(phy);
 
 	if (phy->index == 0) {
+		if (data->cfg->type == sun8i_a83t_phy) {
+			void __iomem *phyctl = data->base +
+				data->cfg->phyctl_offset;
+
+			writel(readl(phyctl) | PHY_CTL_SIDDQ, phyctl);
+		}
+
 		/* Disable pull-ups */
 		sun4i_usb_phy0_update_iscr(_phy, ISCR_DPDM_PULLUP_EN, 0);
 		sun4i_usb_phy0_update_iscr(_phy, ISCR_ID_PULLUP_EN, 0);
@@ -853,6 +886,14 @@ static const struct sun4i_usb_phy_cfg sun8i_a33_cfg = {
 	.enable_pmu_unk1 = false,
 };
 
+static const struct sun4i_usb_phy_cfg sun8i_a83t_cfg = {
+	.num_phys = 3,
+	.hsic_index = 2,
+	.type = sun8i_a83t_phy,
+	.phyctl_offset = REG_PHYCTL_A33,
+	.dedicated_clocks = true,
+};
+
 static const struct sun4i_usb_phy_cfg sun8i_h3_cfg = {
 	.num_phys = 4,
 	.type = sun8i_h3_phy,
@@ -889,6 +930,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun7i-a20-usb-phy", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun8i-a23-usb-phy", .data = &sun8i_a23_cfg },
 	{ .compatible = "allwinner,sun8i-a33-usb-phy", .data = &sun8i_a33_cfg },
+	{ .compatible = "allwinner,sun8i-a83t-usb-phy", .data = &sun8i_a83t_cfg },
 	{ .compatible = "allwinner,sun8i-h3-usb-phy", .data = &sun8i_h3_cfg },
 	{ .compatible = "allwinner,sun8i-v3s-usb-phy", .data = &sun8i_v3s_cfg },
 	{ .compatible = "allwinner,sun50i-a64-usb-phy",
-- 
2.13.3
