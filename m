From: tklauser@distanz.ch (Tobias Klauser)
Date: Tue, 22 Sep 2015 13:41:57 +0200
Subject: [PATCH] net: ll_temac: Use of_property_read_u32 instead of
 open-coding it
Message-ID: <1442922117-18420-1-git-send-email-tklauser@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of_property_read_u32 to read the "clock-frequency" property instead
of using of_get_property with return value checks.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/net/ethernet/xilinx/ll_temac_mdio.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_mdio.c b/drivers/net/ethernet/xilinx/ll_temac_mdio.c
index 8cf9d4f..415de1e 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_mdio.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_mdio.c
@@ -59,16 +59,15 @@ static int temac_mdio_write(struct mii_bus *bus, int phy_id, int reg, u16 val)
 int temac_mdio_setup(struct temac_local *lp, struct device_node *np)
 {
 	struct mii_bus *bus;
-	const u32 *bus_hz;
+	u32 bus_hz;
 	int clk_div;
-	int rc, size;
+	int rc;
 	struct resource res;
 
 	/* Calculate a reasonable divisor for the clock rate */
 	clk_div = 0x3f; /* worst-case default setting */
-	bus_hz = of_get_property(np, "clock-frequency", &size);
-	if (bus_hz && size >= sizeof(*bus_hz)) {
-		clk_div = (*bus_hz) / (2500 * 1000 * 2) - 1;
+	if (of_property_read_u32(np, "clock-frequency", &bus_hz) == 0) {
+		clk_div = bus_hz / (2500 * 1000 * 2) - 1;
 		if (clk_div < 1)
 			clk_div = 1;
 		if (clk_div > 0x3f)
-- 
2.5.0
