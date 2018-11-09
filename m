From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Fri, 9 Nov 2018 18:16:28 +0100
Subject: [PATCH net-next v3 1/2] net: phy: replace PHY_HAS_INTERRUPT with a
 check for config_intr and ack_interrupt
In-Reply-To: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
Message-ID: <fd9674b3-4033-95c6-a93e-10c8b5ba2e6a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Flag PHY_HAS_INTERRUPT is used only here for this small check. I think
using interrupts isn't possible if a driver defines neither
config_intr nor ack_interrupts callback. So we can replace checking
flag PHY_HAS_INTERRUPT with checking for these callbacks.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- add helper for the check
v3:
- no changes
---
 drivers/net/phy/phy_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index ab33d1777..00a46218c 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2074,6 +2074,11 @@ static void of_set_phy_eee_broken(struct phy_device *phydev)
 	phydev->eee_broken_modes = broken;
 }
 
+static bool phy_drv_supports_irq(struct phy_driver *phydrv)
+{
+	return phydrv->config_intr || phydrv->ack_interrupt;
+}
+
 /**
  * phy_probe - probe and init a PHY device
  * @dev: device to probe and init
@@ -2095,8 +2100,7 @@ static int phy_probe(struct device *dev)
 	/* Disable the interrupt if the PHY doesn't support it
 	 * but the interrupt is still a valid one
 	 */
-	if (!(phydrv->flags & PHY_HAS_INTERRUPT) &&
-	    phy_interrupt_is_valid(phydev))
+	 if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
 		phydev->irq = PHY_POLL;
 
 	if (phydrv->flags & PHY_IS_INTERNAL)
-- 
2.19.1
