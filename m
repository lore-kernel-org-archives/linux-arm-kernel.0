From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 13 Jan 2017 15:21:53 +0000
Subject: [PATCH RFC 3/7] net: lan78xx: update for
 phy_(read|write)_mmd_indirect() removal
In-Reply-To: <20170113152059.GR14217@n2100.armlinux.org.uk>
References: <20170113152059.GR14217@n2100.armlinux.org.uk>
Message-ID: <E1cS3ft-0003Xc-OH@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

lan78xx appears to use phylib in a rather weird way, accessing the PHY
partly through phylib, and partly by makign direct accesses to it,
including to the Clause 45 registers.  As the indirect MMD accessors are
going away, update this driver to use the plain phy_(read|write)_mmd()
accessors instead.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/usb/lan78xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 08f8703e4d54..5e222d47f212 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1951,10 +1951,10 @@ static int lan8835_fixup(struct phy_device *phydev)
 	struct lan78xx_net *dev = netdev_priv(phydev->attached_dev);
 
 	/* LED2/PME_N/IRQ_N/RGMII_ID pin to IRQ_N mode */
-	buf = phy_read_mmd_indirect(phydev, 0x8010, 3);
+	buf = phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8010);
 	buf &= ~0x1800;
 	buf |= 0x0800;
-	phy_write_mmd_indirect(phydev, 0x8010, 3, buf);
+	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8010, buf);
 
 	/* RGMII MAC TXC Delay Enable */
 	ret = lan78xx_write_reg(dev, MAC_RGMII_ID,
@@ -1974,11 +1974,11 @@ static int ksz9031rnx_fixup(struct phy_device *phydev)
 
 	/* Micrel9301RNX PHY configuration */
 	/* RGMII Control Signal Pad Skew */
-	phy_write_mmd_indirect(phydev, 4, 2, 0x0077);
+	phy_write_mmd(phydev, MDIO_MMD_WIS, 4, 0x0077);
 	/* RGMII RX Data Pad Skew */
-	phy_write_mmd_indirect(phydev, 5, 2, 0x7777);
+	phy_write_mmd(phydev, MDIO_MMD_WIS, 5, 0x7777);
 	/* RGMII RX Clock Pad Skew */
-	phy_write_mmd_indirect(phydev, 8, 2, 0x1FF);
+	phy_write_mmd(phydev, MDIO_MMD_WIS, 8, 0x1FF);
 
 	dev->interface = PHY_INTERFACE_MODE_RGMII_RXID;
 
-- 
2.7.4
