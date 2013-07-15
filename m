From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Jul 2013 17:34:09 +0200
Subject: [RFC PATCH 2/3] net: phy: call mdiobus_scan() after adding a fixed PHY
In-Reply-To: <1373902450-11857-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1373902450-11857-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1373902450-11857-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fixed_phy_add() function allows to register a fixed PHY. However,
when this function gets called *after* fixed_mdio_bus_init() (which
gets called at the module_init stage), then the fixed PHY is not
registered into the phylib.

In order to address this, we add a call to mdiobus_scan() in
fixed_phy_add() to ensure that the PHY indeed gets registered into the
phylib, even if the fixed_phy_add() is called after
fixed_mdio_bus_init().

This is needed because until now, the only code that was calling the
fixed_add_phy() function was PowerPC-specific platform code, which
could ensure that such fixed PHYs get registered before
fixed_mdio_bus_init() is called.

However, with the new of_phy_register_fixed_link() function, device
drivers can parse their 'fixed-link' property and register a fixed PHY
at ->probe() time, which may happen after fixed_mdio_bus_init() is
called.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/phy/fixed.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/fixed.c b/drivers/net/phy/fixed.c
index ba55adf..bd1e67a 100644
--- a/drivers/net/phy/fixed.c
+++ b/drivers/net/phy/fixed.c
@@ -195,6 +195,8 @@ int fixed_phy_add(unsigned int irq, int phy_id,
 
 	list_add_tail(&fp->node, &fmb->phys);
 
+	mdiobus_scan(fmb->mii_bus, phy_id);
+
 	return 0;
 
 err_regs:
-- 
1.8.1.2
