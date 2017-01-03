From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue,  3 Jan 2017 23:25:31 +0800
Subject: [PATCH 1/4] phy: sun4i-usb: add support for V3s USB PHY
In-Reply-To: <20170103152534.20118-1-icenowy@aosc.xyz>
References: <20170103152534.20118-1-icenowy@aosc.xyz>
Message-ID: <20170103152534.20118-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s come with a USB PHY controller slightly different to other
SoCs, with only one PHY.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt |  1 +
 drivers/phy/phy-sun4i-usb.c                             | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
index 287150db6db4..e42334258185 100644
--- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
@@ -10,6 +10,7 @@ Required properties:
   * allwinner,sun8i-a23-usb-phy
   * allwinner,sun8i-a33-usb-phy
   * allwinner,sun8i-h3-usb-phy
+  * allwinner,sun8i-v3s-usb-phy
   * allwinner,sun50i-a64-usb-phy
 - reg : a list of offset + length pairs
 - reg-names :
diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index bf28a0fdd569..4102841a8ad2 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -99,6 +99,7 @@ enum sun4i_usb_phy_type {
 	sun6i_a31_phy,
 	sun8i_a33_phy,
 	sun8i_h3_phy,
+	sun8i_v3s_phy,
 	sun50i_a64_phy,
 };
 
@@ -188,7 +189,8 @@ static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
 	spin_lock_irqsave(&phy_data->reg_lock, flags);
 
 	if (phy_data->cfg->type == sun8i_a33_phy ||
-	    phy_data->cfg->type == sun50i_a64_phy) {
+	    phy_data->cfg->type == sun50i_a64_phy ||
+	    phy_data->cfg->type == sun8i_v3s_phy) {
 		/* A33 or A64 needs us to set phyctl to 0 explicitly */
 		writel(0, phyctl);
 	}
@@ -825,6 +827,15 @@ static const struct sun4i_usb_phy_cfg sun8i_h3_cfg = {
 	.enable_pmu_unk1 = true,
 };
 
+static const struct sun4i_usb_phy_cfg sun8i_v3s_cfg = {
+	.num_phys = 1,
+	.type = sun8i_v3s_phy,
+	.disc_thresh = 3,
+	.phyctl_offset = REG_PHYCTL_A33,
+	.dedicated_clocks = true,
+	.enable_pmu_unk1 = true,
+};
+
 static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
 	.num_phys = 2,
 	.type = sun50i_a64_phy,
@@ -842,6 +853,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun8i-a23-usb-phy", .data = &sun8i_a23_cfg },
 	{ .compatible = "allwinner,sun8i-a33-usb-phy", .data = &sun8i_a33_cfg },
 	{ .compatible = "allwinner,sun8i-h3-usb-phy", .data = &sun8i_h3_cfg },
+	{ .compatible = "allwinner,sun8i-v3s-usb-phy", .data = &sun8i_v3s_cfg },
 	{ .compatible = "allwinner,sun50i-a64-usb-phy",
 	  .data = &sun50i_a64_cfg},
 	{ },
-- 
2.11.0
