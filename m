From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Thu, 11 May 2017 15:29:23 +0200
Subject: [PATCH 3/5] phy: bcm-ns-usb3: enable MDIO in the platform specific
 code
In-Reply-To: <20170511132925.14564-1-zajec5@gmail.com>
References: <20170511132925.14564-1-zajec5@gmail.com>
Message-ID: <20170511132925.14564-4-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

When we finally start using MDIO layer then bus initialization will be
handled in a separated driver. It means our code handling this has to be
used for the platform driver only.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 drivers/phy/phy-bcm-ns-usb3.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/phy-bcm-ns-usb3.c b/drivers/phy/phy-bcm-ns-usb3.c
index 3d0fe5728029..2c9a0d5f43d8 100644
--- a/drivers/phy/phy-bcm-ns-usb3.c
+++ b/drivers/phy/phy-bcm-ns-usb3.c
@@ -80,12 +80,6 @@ static int bcm_ns_usb3_phy_init_ns_bx(struct bcm_ns_usb3 *usb3)
 {
 	int err;
 
-	/* Enable MDIO. Setting MDCDIV as 26  */
-	writel(0x0000009a, usb3->ccb_mii + BCMA_CCB_MII_MNG_CTL);
-
-	/* Wait for MDIO? */
-	udelay(2);
-
 	/* USB3 PLL Block */
 	err = bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_PHY_BASE_ADDR_REG,
 					 BCM_NS_USB3_PHY_PLL30_BLOCK);
@@ -134,12 +128,6 @@ static int bcm_ns_usb3_phy_init_ns_ax(struct bcm_ns_usb3 *usb3)
 {
 	int err;
 
-	/* Enable MDIO. Setting MDCDIV as 26  */
-	writel(0x0000009a, usb3->ccb_mii + BCMA_CCB_MII_MNG_CTL);
-
-	/* Wait for MDIO? */
-	udelay(2);
-
 	/* PLL30 block */
 	err = bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_PHY_BASE_ADDR_REG,
 					 BCM_NS_USB3_PHY_PLL30_BLOCK);
@@ -278,6 +266,12 @@ static int bcm_ns_usb3_probe(struct platform_device *pdev)
 		return PTR_ERR(usb3->ccb_mii);
 	}
 
+	/* Enable MDIO. Setting MDCDIV as 26  */
+	writel(0x0000009a, usb3->ccb_mii + BCMA_CCB_MII_MNG_CTL);
+
+	/* Wait for MDIO? */
+	udelay(2);
+
 	usb3->phy_write = bcm_ns_usb3_platform_phy_write;
 
 	usb3->phy = devm_phy_create(dev, NULL, &ops);
-- 
2.11.0
