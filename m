From: kurt@linutronix.de (Kurt Kanzenbach)
Date: Tue, 30 Oct 2018 10:31:39 +0100
Subject: [PATCH 2/2] net: xilinx_emaclite: recheck condition after timeout in
 mdio_wait()
In-Reply-To: <20181030093139.10226-1-kurt@linutronix.de>
References: <20181030093139.10226-1-kurt@linutronix.de>
Message-ID: <20181030093139.10226-3-kurt@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function could report a false positive if it gets preempted between reading
the XEL_MDIOCTRL_OFFSET register and checking for the timeout.  In such a case,
the condition has to be rechecked to avoid false positives.

Therefore, check for expected condition even after the timeout occurred.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 639e3e99af46..957d03085bd0 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -714,19 +714,29 @@ static irqreturn_t xemaclite_interrupt(int irq, void *dev_id)
 static int xemaclite_mdio_wait(struct net_local *lp)
 {
 	unsigned long end = jiffies + 2;
+	u32 val;
 
 	/* wait for the MDIO interface to not be busy or timeout
 	 * after some time.
 	 */
-	while (xemaclite_readl(lp->base_addr + XEL_MDIOCTRL_OFFSET) &
-			XEL_MDIOCTRL_MDIOSTS_MASK) {
+	while (1) {
+		val = xemaclite_readl(lp->base_addr + XEL_MDIOCTRL_OFFSET);
+
+		if (!(val & XEL_MDIOCTRL_MDIOSTS_MASK))
+			return 0;
+
 		if (time_before_eq(end, jiffies)) {
-			WARN_ON(1);
-			return -ETIMEDOUT;
+			val = xemaclite_readl(lp->base_addr + XEL_MDIOCTRL_OFFSET);
+			break;
 		}
+
 		msleep(1);
 	}
-	return 0;
+	if (!(val & XEL_MDIOCTRL_MDIOSTS_MASK))
+		return 0;
+
+	WARN_ON(1);
+	return -ETIMEDOUT;
 }
 
 /**
-- 
2.11.0
