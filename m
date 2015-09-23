From: tklauser@distanz.ch (Tobias Klauser)
Date: Wed, 23 Sep 2015 09:20:55 +0200
Subject: [PATCH v2] net: axinet: Use of_property_read_u32 instead of
 open-coding it
In-Reply-To: <1442922357-18815-1-git-send-email-tklauser@distanz.ch>
References: <1442922357-18815-1-git-send-email-tklauser@distanz.ch>
Message-ID: <1442992855-6164-1-git-send-email-tklauser@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of_property_read_u32 instead of of_get_property with return value
checks and endianness conversion.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
---
v2: Resending with Cc to netdev

 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
index 2a5a168..507bbb0 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -129,7 +129,6 @@ int axienet_mdio_setup(struct axienet_local *lp, struct device_node *np)
 {
 	int ret;
 	u32 clk_div, host_clock;
-	u32 *property_p;
 	struct mii_bus *bus;
 	struct resource res;
 	struct device_node *np1;
@@ -168,8 +167,7 @@ int axienet_mdio_setup(struct axienet_local *lp, struct device_node *np)
 		clk_div = DEFAULT_CLOCK_DIVISOR;
 		goto issue;
 	}
-	property_p = (u32 *) of_get_property(np1, "clock-frequency", NULL);
-	if (!property_p) {
+	if (of_property_read_u32(np1, "clock-frequency", &host_clock)) {
 		netdev_warn(lp->ndev, "clock-frequency property not found.\n");
 		netdev_warn(lp->ndev,
 			    "Setting MDIO clock divisor to default %d\n",
@@ -179,7 +177,6 @@ int axienet_mdio_setup(struct axienet_local *lp, struct device_node *np)
 		goto issue;
 	}
 
-	host_clock = be32_to_cpup(property_p);
 	clk_div = (host_clock / (MAX_MDIO_FREQ * 2)) - 1;
 	/* If there is any remainder from the division of
 	 * fHOST / (MAX_MDIO_FREQ * 2), then we need to add
-- 
2.5.0
