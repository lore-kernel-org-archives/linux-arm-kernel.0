From: mw@semihalf.com (Marcin Wojtas)
Date: Fri,  1 Apr 2016 15:21:18 +0200
Subject: [PATCH] net: mvneta: fix changing MTU when using per-cpu processing
Message-ID: <1459516878-2802-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After enabling per-cpu processing it appeared that under heavy load
changing MTU can result in blocking all port's interrupts and transmitting
data is not possible after the change.

This commit fixes above issue by disabling percpu interrupts for the
time, when TXQs and RXQs are reconfigured.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index fee6a91..a433de9 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3083,6 +3083,20 @@ static int mvneta_check_mtu_valid(struct net_device *dev, int mtu)
 	return mtu;
 }
 
+static void mvneta_percpu_enable(void *arg)
+{
+	struct mvneta_port *pp = arg;
+
+	enable_percpu_irq(pp->dev->irq, IRQ_TYPE_NONE);
+}
+
+static void mvneta_percpu_disable(void *arg)
+{
+	struct mvneta_port *pp = arg;
+
+	disable_percpu_irq(pp->dev->irq);
+}
+
 /* Change the device mtu */
 static int mvneta_change_mtu(struct net_device *dev, int mtu)
 {
@@ -3107,6 +3121,7 @@ static int mvneta_change_mtu(struct net_device *dev, int mtu)
 	 * reallocation of the queues
 	 */
 	mvneta_stop_dev(pp);
+	on_each_cpu(mvneta_percpu_disable, pp, true);
 
 	mvneta_cleanup_txqs(pp);
 	mvneta_cleanup_rxqs(pp);
@@ -3130,6 +3145,7 @@ static int mvneta_change_mtu(struct net_device *dev, int mtu)
 		return ret;
 	}
 
+	on_each_cpu(mvneta_percpu_enable, pp, true);
 	mvneta_start_dev(pp);
 	mvneta_port_up(pp);
 
@@ -3283,20 +3299,6 @@ static void mvneta_mdio_remove(struct mvneta_port *pp)
 	pp->phy_dev = NULL;
 }
 
-static void mvneta_percpu_enable(void *arg)
-{
-	struct mvneta_port *pp = arg;
-
-	enable_percpu_irq(pp->dev->irq, IRQ_TYPE_NONE);
-}
-
-static void mvneta_percpu_disable(void *arg)
-{
-	struct mvneta_port *pp = arg;
-
-	disable_percpu_irq(pp->dev->irq);
-}
-
 /* Electing a CPU must be done in an atomic way: it should be done
  * after or before the removal/insertion of a CPU and this function is
  * not reentrant.
-- 
1.8.3.1
