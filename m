From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:41:25 +0100
Subject: [PATCH 117/222] net:fec: consolidate common parts of mdio read/write
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeVR-0007L2-2M@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a commonality to fec_enet_mdio_read() and fec_enet_mdio_write()
which can be factored out.  Factor that commonality out, since we need
to add some locking to prevent resets interfering with MDIO accesses.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/net/ethernet/freescale/fec_main.c | 41 +++++++++++++------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 40ab7b7ccacf..f6763686d5a9 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1305,23 +1305,27 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 		phy_print_status(phy_dev);
 }
 
-static int fec_enet_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
+static unsigned long fec_enet_mdio_op(struct fec_enet_private *fep,
+	unsigned data)
 {
-	struct fec_enet_private *fep = bus->priv;
-	unsigned long time_left;
-
 	fep->mii_timeout = 0;
 	init_completion(&fep->mdio_done);
 
-	/* start a read op */
-	writel(FEC_MMFR_ST | FEC_MMFR_OP_READ |
-		FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(regnum) |
-		FEC_MMFR_TA, fep->hwp + FEC_MII_DATA);
+	/* start operation */
+	writel(data, fep->hwp + FEC_MII_DATA);
 
 	/* wait for end of transfer */
-	time_left = wait_for_completion_timeout(&fep->mdio_done,
+	return wait_for_completion_timeout(&fep->mdio_done,
 			usecs_to_jiffies(FEC_MII_TIMEOUT));
-	if (time_left == 0) {
+}
+
+static int fec_enet_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
+{
+	struct fec_enet_private *fep = bus->priv;
+
+	if (fec_enet_mdio_op(fep, FEC_MMFR_ST | FEC_MMFR_OP_READ |
+				  FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(regnum) |
+				  FEC_MMFR_TA) == 0) {
 		fep->mii_timeout = 1;
 		netdev_err(fep->netdev, "MDIO read timeout\n");
 		return -ETIMEDOUT;
@@ -1335,21 +1339,10 @@ static int fec_enet_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 			   u16 value)
 {
 	struct fec_enet_private *fep = bus->priv;
-	unsigned long time_left;
-
-	fep->mii_timeout = 0;
-	init_completion(&fep->mdio_done);
 
-	/* start a write op */
-	writel(FEC_MMFR_ST | FEC_MMFR_OP_WRITE |
-		FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(regnum) |
-		FEC_MMFR_TA | FEC_MMFR_DATA(value),
-		fep->hwp + FEC_MII_DATA);
-
-	/* wait for end of transfer */
-	time_left = wait_for_completion_timeout(&fep->mdio_done,
-			usecs_to_jiffies(FEC_MII_TIMEOUT));
-	if (time_left == 0) {
+	if (fec_enet_mdio_op(fep, FEC_MMFR_ST | FEC_MMFR_OP_WRITE |
+				  FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(regnum) |
+				  FEC_MMFR_TA | FEC_MMFR_DATA(value)) == 0) {
 		fep->mii_timeout = 1;
 		netdev_err(fep->netdev, "MDIO write timeout\n");
 		return -ETIMEDOUT;
-- 
1.8.3.1
