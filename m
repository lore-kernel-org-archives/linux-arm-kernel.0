From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 18 Feb 2017 01:37:20 +0800
Subject: [PATCH 7/9] phy: sun4i-usb: add support for R40 USB PHY
In-Reply-To: <20170217173722.6477-1-icenowy@aosc.xyz>
References: <20170217173722.6477-1-icenowy@aosc.xyz>
Message-ID: <20170217173722.6477-8-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner R40 features a USB PHY like the one in A64, but with 3 ports.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt |  1 +
 drivers/phy/phy-sun4i-usb.c                             | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
index e42334258185..184a1d7af352 100644
--- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
@@ -11,6 +11,7 @@ Required properties:
   * allwinner,sun8i-a33-usb-phy
   * allwinner,sun8i-h3-usb-phy
   * allwinner,sun8i-v3s-usb-phy
+  * allwinner,sun8i-r40-usb-phy
   * allwinner,sun50i-a64-usb-phy
 - reg : a list of offset + length pairs
 - reg-names :
diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index a21b5f24a340..3c6ddd6750dd 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -100,6 +100,7 @@ enum sun4i_usb_phy_type {
 	sun8i_a33_phy,
 	sun8i_h3_phy,
 	sun8i_v3s_phy,
+	sun8i_r40_phy,
 	sun50i_a64_phy,
 };
 
@@ -188,10 +189,8 @@ static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
 
 	spin_lock_irqsave(&phy_data->reg_lock, flags);
 
-	if (phy_data->cfg->type == sun8i_a33_phy ||
-	    phy_data->cfg->type == sun50i_a64_phy ||
-	    phy_data->cfg->type == sun8i_v3s_phy) {
-		/* A33 or A64 needs us to set phyctl to 0 explicitly */
+	if (phy_data->cfg->phyctl_offset == REG_PHYCTL_A33) {
+		/* A33-style phyctl register needs to be set to 0 explicitly */
 		writel(0, phyctl);
 	}
 
@@ -845,6 +844,15 @@ static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
 	.enable_pmu_unk1 = true,
 };
 
+static const struct sun4i_usb_phy_cfg sun8i_r40_cfg = {
+	.num_phys = 3,
+	.type = sun8i_r40_phy,
+	.disc_thresh = 3,
+	.phyctl_offset = REG_PHYCTL_A33,
+	.dedicated_clocks = true,
+	.enable_pmu_unk1 = true,
+};
+
 static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-usb-phy", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-usb-phy", .data = &sun5i_a13_cfg },
@@ -854,6 +862,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun8i-a33-usb-phy", .data = &sun8i_a33_cfg },
 	{ .compatible = "allwinner,sun8i-h3-usb-phy", .data = &sun8i_h3_cfg },
 	{ .compatible = "allwinner,sun8i-v3s-usb-phy", .data = &sun8i_v3s_cfg },
+	{ .compatible = "allwinner,sun8i-r40-usb-phy", .data = &sun8i_r40_cfg },
 	{ .compatible = "allwinner,sun50i-a64-usb-phy",
 	  .data = &sun50i_a64_cfg},
 	{ },
-- 
2.11.1
