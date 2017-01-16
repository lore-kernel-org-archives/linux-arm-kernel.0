From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 17 Jan 2017 03:14:46 +0800
Subject: [PATCH 1/4] phy: sun4i-usb: support PHY0 on H3 in MUSB mode
In-Reply-To: <20170116191449.50397-1-icenowy@aosc.xyz>
References: <20170116191449.50397-1-icenowy@aosc.xyz>
Message-ID: <20170116191449.50397-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PHY0 on H3 can be wired either to MUSB controller or OHCI/EHCI
controller.

The original driver wired it to OHCI/EHCI controller; however, as the
code to use PHY0 as OHCI/EHCI is missing, it makes the PHY fully
unusable.

Rename the register (according to its function and the name in BSP
driver), and remove the code which wires the PHY0 to OHCI/EHCI, as MUSB
can support both peripheral and host mode (although the host mode of
MUSB is buggy).

The register that is renamed is now unused, as its initial value is just
MUSB mode. However, when OHCI/EHCI mode support is added, the register
can be used again.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/phy/phy-sun4i-usb.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index bf28a0fdd569..6b193a635c6b 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -49,7 +49,7 @@
 #define REG_PHYBIST			0x08
 #define REG_PHYTUNE			0x0c
 #define REG_PHYCTL_A33			0x10
-#define REG_PHY_UNK_H3			0x20
+#define REG_PHY_OTGCTL			0x20
 
 #define REG_PMU_UNK1			0x10
 
@@ -269,23 +269,16 @@ static int sun4i_usb_phy_init(struct phy *_phy)
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
 
-- 
2.11.0
