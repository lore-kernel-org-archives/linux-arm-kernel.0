From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Thu, 11 May 2017 15:29:21 +0200
Subject: [PATCH 1/5] phy: bcm-ns-usb3: always wait for idle after writing to
 the PHY reg
In-Reply-To: <20170511132925.14564-1-zajec5@gmail.com>
References: <20170511132925.14564-1-zajec5@gmail.com>
Message-ID: <20170511132925.14564-2-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Move MDIO specific code to the writing helper function. This makes init
code a bit more generic and doesn't require it to track what happens
after every write.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 drivers/phy/phy-bcm-ns-usb3.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/phy/phy-bcm-ns-usb3.c b/drivers/phy/phy-bcm-ns-usb3.c
index 22b5e7047fa6..5e89326886dc 100644
--- a/drivers/phy/phy-bcm-ns-usb3.c
+++ b/drivers/phy/phy-bcm-ns-usb3.c
@@ -112,7 +112,7 @@ static int bcm_ns_usb3_mdio_phy_write(struct bcm_ns_usb3 *usb3, u16 reg,
 	tmp |= value;
 	writel(tmp, usb3->ccb_mii + BCMA_CCB_MII_MNG_CMD_DATA);
 
-	return 0;
+	return bcm_ns_usb3_mii_mng_wait_idle(usb3);
 }
 
 static int bcm_ns_usb3_phy_init_ns_bx(struct bcm_ns_usb3 *usb3)
@@ -143,9 +143,6 @@ static int bcm_ns_usb3_phy_init_ns_bx(struct bcm_ns_usb3 *usb3)
 	/* Deaaserting PLL Reset */
 	bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_PLLA_CONTROL1, 0x8000);
 
-	/* Waiting MII Mgt interface idle */
-	bcm_ns_usb3_mii_mng_wait_idle(usb3);
-
 	/* Deasserting USB3 system reset */
 	writel(0, usb3->dmp + BCMA_RESET_CTL);
 
@@ -169,9 +166,6 @@ static int bcm_ns_usb3_phy_init_ns_bx(struct bcm_ns_usb3 *usb3)
 	/* Enabling SSC */
 	bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_TX_PMD_CONTROL1, 0x1003);
 
-	/* Waiting MII Mgt interface idle */
-	bcm_ns_usb3_mii_mng_wait_idle(usb3);
-
 	return 0;
 }
 
@@ -205,9 +199,6 @@ static int bcm_ns_usb3_phy_init_ns_ax(struct bcm_ns_usb3 *usb3)
 
 	bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_TX_PMD_CONTROL1, 0x1003);
 
-	/* Waiting MII Mgt interface idle */
-	bcm_ns_usb3_mii_mng_wait_idle(usb3);
-
 	/* Deasserting USB3 system reset */
 	writel(0, usb3->dmp + BCMA_RESET_CTL);
 
-- 
2.11.0
