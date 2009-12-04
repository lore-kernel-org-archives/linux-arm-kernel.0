From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Fri,  4 Dec 2009 04:47:06 +0200
Subject: [RFC][PATCH 06/10] fec: fix uninitialized rx buffer usage
In-Reply-To: <0559d42bc9f32e30264fea6ca6fa679121f6a241.1259893118.git.amit.kucheria@canonical.com>
References: <cover.1259893118.git.amit.kucheria@canonical.com>
	<e99e70e2a619693064130a747b6ee3a93273337b.1259893118.git.amit.kucheria@canonical.com>
	<6608c4dca645d87efce78ae0b7dbad265004f482.1259893118.git.amit.kucheria@canonical.com>
	<58eb7d14c6cf56cbc874657dff5789c47116b49e.1259893118.git.amit.kucheria@canonical.com>
	<a079a0627e77f2df590840e4798fc067f4436160.1259893118.git.amit.kucheria@canonical.com>
	<0559d42bc9f32e30264fea6ca6fa679121f6a241.1259893118.git.amit.kucheria@canonical.com>
Message-ID: <7a49f4c0ea2f5030068729978c2cb173a6e15857.1259893118.git.amit.kucheria@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <r.herring@freescale.com>

The fec driver was enabling receive buffer descriptor without allocating
the buffers. Make sure the buffer descriptors are initialized to not
start receiving packets.

Signed-off-by: Rob Herring <r.herring@freescale.com>
Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: netdev at vger.kernel.org
---
 drivers/net/fec.c |   57 +++++++++++++++++++++++++++--------------------------
 1 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/net/fec.c b/drivers/net/fec.c
index 16a1d58..9a8743d 100644
--- a/drivers/net/fec.c
+++ b/drivers/net/fec.c
@@ -1658,6 +1658,7 @@ static int fec_enet_init(struct net_device *dev, int index)
 {
 	struct fec_enet_private *fep = netdev_priv(dev);
 	struct bufdesc *cbd_base;
+	struct bufdesc *bdp;
 	int i;
 
 	/* Allocate memory for buffer descriptors. */
@@ -1710,6 +1711,34 @@ static int fec_enet_init(struct net_device *dev, int index)
 	/* Set MII speed to 2.5 MHz */
 	fep->phy_speed = ((((clk_get_rate(fep->clk) / 2 + 4999999)
 					/ 2500000) / 2) & 0x3F) << 1;
+
+	/* Initialize the receive buffer descriptors. */
+	bdp = fep->rx_bd_base;
+	for (i = 0; i < RX_RING_SIZE; i++) {
+
+		/* Initialize the BD for every fragment in the page. */
+		bdp->cbd_sc = 0;
+		bdp++;
+	}
+
+	/* Set the last buffer to wrap */
+	bdp--;
+	bdp->cbd_sc |= BD_SC_WRAP;
+
+	/* ...and the same for transmit */
+	bdp = fep->tx_bd_base;
+	for (i = 0; i < TX_RING_SIZE; i++) {
+
+		/* Initialize the BD for every fragment in the page. */
+		bdp->cbd_sc = 0;
+		bdp->cbd_bufaddr = 0;
+		bdp++;
+	}
+
+	/* Set the last buffer to wrap */
+	bdp--;
+	bdp->cbd_sc |= BD_SC_WRAP;
+
 	fec_restart(dev, 0);
 
 	/* Queue up command to detect the PHY and initialize the
@@ -1730,7 +1759,6 @@ static void
 fec_restart(struct net_device *dev, int duplex)
 {
 	struct fec_enet_private *fep = netdev_priv(dev);
-	struct bufdesc *bdp;
 	int i;
 
 	/* Whack a reset.  We should wait for this. */
@@ -1768,33 +1796,6 @@ fec_restart(struct net_device *dev, int duplex)
 		}
 	}
 
-	/* Initialize the receive buffer descriptors. */
-	bdp = fep->rx_bd_base;
-	for (i = 0; i < RX_RING_SIZE; i++) {
-
-		/* Initialize the BD for every fragment in the page. */
-		bdp->cbd_sc = BD_ENET_RX_EMPTY;
-		bdp++;
-	}
-
-	/* Set the last buffer to wrap */
-	bdp--;
-	bdp->cbd_sc |= BD_SC_WRAP;
-
-	/* ...and the same for transmit */
-	bdp = fep->tx_bd_base;
-	for (i = 0; i < TX_RING_SIZE; i++) {
-
-		/* Initialize the BD for every fragment in the page. */
-		bdp->cbd_sc = 0;
-		bdp->cbd_bufaddr = 0;
-		bdp++;
-	}
-
-	/* Set the last buffer to wrap */
-	bdp--;
-	bdp->cbd_sc |= BD_SC_WRAP;
-
 	/* Enable MII mode */
 	if (duplex) {
 		/* MII enable / FD enable */
-- 
1.6.3.3
