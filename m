From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 28 Feb 2017 23:27:00 +0800
Subject: [PATCH 1/3] phy: sun4i-usb: support automatically switch PHY0 route
 to MUSB/HCI
Message-ID: <20170228152702.42602-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On newer Allwinner SoCs (H3 and after), the PHY0 node is routed to both
MUSB controller for peripheral and host support (the host support is
slightly broken), and a pair of EHCI/OHCI controllers, which provide a
better support for host mode.

Add support for automatically switch the route of PHY0 according to the
status of dr_mode and id det pin.

Only H3 have this function enabled in this patch, as further SoCs will
be tested later and then have it enabled.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/phy/phy-sun4i-usb.c | 55 +++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index a21b5f24a340..8b91afe8f42d 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -49,12 +49,14 @@
 #define REG_PHYBIST			0x08
 #define REG_PHYTUNE			0x0c
 #define REG_PHYCTL_A33			0x10
-#define REG_PHY_UNK_H3			0x20
+#define REG_PHY_OTGCTL			0x20
 
 #define REG_PMU_UNK1			0x10
 
 #define PHYCTL_DATA			BIT(7)
 
+#define OTGCTL_ROUTE_MUSB		BIT(0)
+
 #define SUNXI_AHB_ICHR8_EN		BIT(10)
 #define SUNXI_AHB_INCR4_BURST_EN	BIT(9)
 #define SUNXI_AHB_INCRX_ALIGN_EN	BIT(8)
@@ -110,6 +112,7 @@ struct sun4i_usb_phy_cfg {
 	u8 phyctl_offset;
 	bool dedicated_clocks;
 	bool enable_pmu_unk1;
+	bool phy0_dual_route;
 };
 
 struct sun4i_usb_phy_data {
@@ -271,23 +274,16 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 		writel(val & ~2, phy->pmu + REG_PMU_UNK1);
 	}
 
-	if (data->cfg->type == sun8i_h3_phy) {
-		if (phy->index == 0) {
-			val = readl(data->base + REG_PHY_UNK_H3);
-			writel(val & ~1, data->base + REG_PHY_UNK_H3);
-		}
-	} else {
-		/* Enable USB 45 Ohm resistor calibration */
-		if (phy->index == 0)
-			sun4i_usb_phy_write(phy, PHY_RES45_CAL_EN, 0x01, 1);
+	/* Enable USB 45 Ohm resistor calibration */
+	if (phy->index == 0)
+		sun4i_usb_phy_write(phy, PHY_RES45_CAL_EN, 0x01, 1);
 
-		/* Adjust PHY's magnitude and rate */
-		sun4i_usb_phy_write(phy, PHY_TX_AMPLITUDE_TUNE, 0x14, 5);
+	/* Adjust PHY's magnitude and rate */
+	sun4i_usb_phy_write(phy, PHY_TX_AMPLITUDE_TUNE, 0x14, 5);
 
-		/* Disconnect threshold adjustment */
-		sun4i_usb_phy_write(phy, PHY_DISCON_TH_SEL,
-				    data->cfg->disc_thresh, 2);
-	}
+	/* Disconnect threshold adjustment */
+	sun4i_usb_phy_write(phy, PHY_DISCON_TH_SEL,
+			    data->cfg->disc_thresh, 2);
 
 	sun4i_usb_phy_passby(phy, 1);
 
@@ -486,6 +482,26 @@ static const struct phy_ops sun4i_usb_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static void sun4i_usb_phy0_reroute(struct sun4i_usb_phy_data *data, int id_det)
+{
+	u32 regval;
+
+	if (data->dr_mode == USB_DR_MODE_HOST)
+		id_det = 0; /* Force host */
+	if (data->dr_mode == USB_DR_MODE_PERIPHERAL)
+		id_det = 1; /* Force peripheral*/
+
+	regval = readl(data->base + REG_PHY_OTGCTL);
+	if (id_det == 0) {
+		/* Host mode. Route phy0 to EHCI/OHCI */
+		regval &= ~OTGCTL_ROUTE_MUSB;
+	} else {
+		/* Peripheral mode. Route phy0 to MUSB */
+		regval |= OTGCTL_ROUTE_MUSB;
+	}
+	writel(regval, data->base + REG_PHY_OTGCTL);
+}
+
 static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 {
 	struct sun4i_usb_phy_data *data =
@@ -511,6 +527,10 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 	data->force_session_end = false;
 
 	if (id_det != data->id_det) {
+		/* Re-route PHY0 if necessary */
+		if (data->cfg->phy0_dual_route)
+			sun4i_usb_phy0_reroute(data, id_det);
+
 		/* id-change, force session end if we've no vbus detection */
 		if (data->dr_mode == USB_DR_MODE_OTG &&
 		    !sun4i_usb_phy0_have_vbus_det(data))
@@ -700,7 +720,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 			return PTR_ERR(phy->reset);
 		}
 
-		if (i) { /* No pmu for usbc0 */
+		if (i || data->cfg->phy0_dual_route) { /* No pmu for musb */
 			snprintf(name, sizeof(name), "pmu%d", i);
 			res = platform_get_resource_byname(pdev,
 							IORESOURCE_MEM, name);
@@ -825,6 +845,7 @@ static const struct sun4i_usb_phy_cfg sun8i_h3_cfg = {
 	.disc_thresh = 3,
 	.dedicated_clocks = true,
 	.enable_pmu_unk1 = true,
+	.phy0_dual_route = true,
 };
 
 static const struct sun4i_usb_phy_cfg sun8i_v3s_cfg = {
-- 
2.11.1
