From: romain.perier@free-electrons.com (Romain Perier)
Date: Wed, 21 Dec 2016 13:57:33 +0100
Subject: [PATCH net-next v4 1/2] net: dsa: mv88e6xxx: Don't forbid MDIO I/Os
 for PHY addr >= num_of_ports
In-Reply-To: <20161221125734.1034-1-romain.perier@free-electrons.com>
References: <20161221125734.1034-1-romain.perier@free-electrons.com>
Message-ID: <20161221125734.1034-2-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Marvell ethernet switches have internal ethernet transceivers with
hardcoded phy addresses. These addresses can be greater than the number
of ports or its value might be different than the associated port number.
This is for example the case for MV88E6341 that has 6 ports and internal
Port 1 to Port4 PHYs mapped at SMI addresses from 0x11 to 0x14.

This commits fixes the issue by removing the condition in MDIO callbacks.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

Changes in v4:
 - Fixed typo in the commit log

Changes in v2:
 - Added tag "Reviewed-by" by Andrew
 - Fixed typo in the commit log

 drivers/net/dsa/mv88e6xxx/chip.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index b5f0e1e..76d944e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2881,9 +2881,6 @@ static int mv88e6xxx_mdio_read(struct mii_bus *bus, int phy, int reg)
 	u16 val;
 	int err;
 
-	if (phy >= mv88e6xxx_num_ports(chip))
-		return 0xffff;
-
 	mutex_lock(&chip->reg_lock);
 	err = mv88e6xxx_phy_read(chip, phy, reg, &val);
 	mutex_unlock(&chip->reg_lock);
@@ -2896,9 +2893,6 @@ static int mv88e6xxx_mdio_write(struct mii_bus *bus, int phy, int reg, u16 val)
 	struct mv88e6xxx_chip *chip = bus->priv;
 	int err;
 
-	if (phy >= mv88e6xxx_num_ports(chip))
-		return 0xffff;
-
 	mutex_lock(&chip->reg_lock);
 	err = mv88e6xxx_phy_write(chip, phy, reg, val);
 	mutex_unlock(&chip->reg_lock);
-- 
2.9.3
