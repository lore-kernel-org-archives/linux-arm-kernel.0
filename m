From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Wed, 13 Jun 2018 12:05:16 +0530
Subject: [PATCH 1/4] net: emaclite: Fix position of lp->mii_bus assignment
In-Reply-To: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1528871719-1681-2-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To ensure MDIO bus is not double freed in remove() path
assign lp->mii_bus after MDIO bus registration.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 69e31ce..37989ce 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -863,14 +863,14 @@ static int xemaclite_mdio_setup(struct net_local *lp, struct device *dev)
 	bus->write = xemaclite_mdio_write;
 	bus->parent = dev;
 
-	lp->mii_bus = bus;
-
 	rc = of_mdiobus_register(bus, np);
 	if (rc) {
 		dev_err(dev, "Failed to register mdio bus.\n");
 		goto err_register;
 	}
 
+	lp->mii_bus = bus;
+
 	return 0;
 
 err_register:
-- 
1.7.1
