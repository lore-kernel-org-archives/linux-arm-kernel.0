From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 31 Mar 2017 15:35:32 +0800
Subject: [PATCH v5 6/9] phy: phy-mt65xx-usb3: disable 100uA extraction from SS
 port to HS port
In-Reply-To: <1490945735-9531-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1490945735-9531-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1490945735-9531-6-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There will be a problem if SS port is diasbled and HS port extracts
100uA from SS port, so disable extract 100uA from SS port in the case,
when disable it, PA0_RG_USB20_INTR_EN should be set, otherwise HS port
only works on LS.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/phy-mt65xx-usb3.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
index 5eea65c..ee83d93 100644
--- a/drivers/phy/phy-mt65xx-usb3.c
+++ b/drivers/phy/phy-mt65xx-usb3.c
@@ -46,6 +46,7 @@
 
 #define U3P_USBPHYACR0		0x000
 #define PA0_RG_U2PLL_FORCE_ON		BIT(15)
+#define PA0_RG_USB20_INTR_EN		BIT(5)
 
 #define U3P_USBPHYACR2		0x008
 #define PA2_RG_SIF_U2PLL_FORCE_EN	BIT(18)
@@ -339,6 +340,15 @@ static void phy_instance_init(struct mt65xx_u3phy *u3phy,
 	tmp &= ~P2C_RG_UART_EN;
 	writel(tmp, com + U3P_U2PHYDTM1);
 
+	tmp = readl(com + U3P_USBPHYACR0);
+	tmp |= PA0_RG_USB20_INTR_EN;
+	writel(tmp, com + U3P_USBPHYACR0);
+
+	/* disable switch 100uA current to SSUSB */
+	tmp = readl(com + U3P_USBPHYACR5);
+	tmp &= ~PA5_RG_U2_HS_100U_U3_EN;
+	writel(tmp, com + U3P_USBPHYACR5);
+
 	if (!index) {
 		tmp = readl(com + U3P_U2PHYACR4);
 		tmp &= ~P2C_U2_GPIO_CTR_MSK;
@@ -393,13 +403,6 @@ static void phy_instance_power_on(struct mt65xx_u3phy *u3phy,
 	tmp |= PA6_RG_U2_OTG_VBUSCMP_EN;
 	writel(tmp, com + U3P_USBPHYACR6);
 
-	if (!index) {
-		/* switch 100uA current to SSUSB */
-		tmp = readl(com + U3P_USBPHYACR5);
-		tmp |= PA5_RG_U2_HS_100U_U3_EN;
-		writel(tmp, com + U3P_USBPHYACR5);
-	}
-
 	tmp = readl(com + U3P_U2PHYDTM1);
 	tmp |= P2C_RG_VBUSVALID | P2C_RG_AVALID;
 	tmp &= ~P2C_RG_SESSEND;
@@ -435,13 +438,6 @@ static void phy_instance_power_off(struct mt65xx_u3phy *u3phy,
 	tmp &= ~PA6_RG_U2_OTG_VBUSCMP_EN;
 	writel(tmp, com + U3P_USBPHYACR6);
 
-	if (!index) {
-		/* switch 100uA current back to USB2.0 */
-		tmp = readl(com + U3P_USBPHYACR5);
-		tmp &= ~PA5_RG_U2_HS_100U_U3_EN;
-		writel(tmp, com + U3P_USBPHYACR5);
-	}
-
 	/* let suspendm=0, set utmi into analog power down */
 	tmp = readl(com + U3P_U2PHYDTM0);
 	tmp &= ~P2C_RG_SUSPENDM;
-- 
1.7.9.5
