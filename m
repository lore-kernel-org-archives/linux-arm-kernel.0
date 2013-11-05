From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Nov 2013 09:49:34 +0800
Subject: [PATCH v3 02/11] usb: phy-mxs: Add auto clock and power setting
In-Reply-To: <1383616183-10511-1-git-send-email-peter.chen@freescale.com>
References: <1383616183-10511-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1383616183-10511-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the auto setting, the PHY's clock and power can be
recovered correctly from low power mode, it is ganranteed by IC logic.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 8b9d80c..472fe36 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -31,6 +31,11 @@
 
 #define BM_USBPHY_CTRL_SFTRST			BIT(31)
 #define BM_USBPHY_CTRL_CLKGATE			BIT(30)
+#define BM_USBPHY_CTRL_ENAUTOSET_USBCLKS	BIT(26)
+#define BM_USBPHY_CTRL_ENAUTOCLR_USBCLKGATE	BIT(25)
+#define BM_USBPHY_CTRL_ENAUTOCLR_PHY_PWD	BIT(20)
+#define BM_USBPHY_CTRL_ENAUTOCLR_CLKGATE	BIT(19)
+#define BM_USBPHY_CTRL_ENAUTO_PWRON_PLL		BIT(18)
 #define BM_USBPHY_CTRL_ENUTMILEVEL3		BIT(15)
 #define BM_USBPHY_CTRL_ENUTMILEVEL2		BIT(14)
 #define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	BIT(1)
@@ -96,9 +101,18 @@ static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
 	/* Power up the PHY */
 	writel(0, base + HW_USBPHY_PWD);
 
-	/* enable FS/LS device */
-	writel(BM_USBPHY_CTRL_ENUTMILEVEL2 |
-	       BM_USBPHY_CTRL_ENUTMILEVEL3,
+	/*
+	 * USB PHY Ctrl Setting
+	 * - Auto clock/power on
+	 * - Enable full/low speed support
+	 */
+	writel(BM_USBPHY_CTRL_ENAUTOSET_USBCLKS |
+		BM_USBPHY_CTRL_ENAUTOCLR_USBCLKGATE |
+		BM_USBPHY_CTRL_ENAUTOCLR_PHY_PWD |
+		BM_USBPHY_CTRL_ENAUTOCLR_CLKGATE |
+		BM_USBPHY_CTRL_ENAUTO_PWRON_PLL |
+		BM_USBPHY_CTRL_ENUTMILEVEL2 |
+		BM_USBPHY_CTRL_ENUTMILEVEL3,
 	       base + HW_USBPHY_CTRL_SET);
 
 	return 0;
-- 
1.7.1
