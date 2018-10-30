From: kurt@linutronix.de (Kurt Kanzenbach)
Date: Tue, 30 Oct 2018 10:31:38 +0100
Subject: [PATCH 1/2] net: axienet: recheck condition after timeout in
 mdio_wait()
In-Reply-To: <20181030093139.10226-1-kurt@linutronix.de>
References: <20181030093139.10226-1-kurt@linutronix.de>
Message-ID: <20181030093139.10226-2-kurt@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function could report a false positive if it gets preempted between reading
the XAE_MDIO_MCR_OFFSET register and checking for the timeout.  In such a case,
the condition has to be rechecked to avoid false positives.

Therefore, check for expected condition even after the timeout occurred.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
index 757a3b37ae8a..4f13125e4942 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -21,15 +21,26 @@
 int axienet_mdio_wait_until_ready(struct axienet_local *lp)
 {
 	unsigned long end = jiffies + 2;
-	while (!(axienet_ior(lp, XAE_MDIO_MCR_OFFSET) &
-		 XAE_MDIO_MCR_READY_MASK)) {
+	u32 val;
+
+	while (1) {
+		val = axienet_ior(lp, XAE_MDIO_MCR_OFFSET);
+
+		if (val & XAE_MDIO_MCR_READY_MASK)
+			return 0;
+
 		if (time_before_eq(end, jiffies)) {
-			WARN_ON(1);
-			return -ETIMEDOUT;
+			val = axienet_ior(lp, XAE_MDIO_MCR_OFFSET);
+			break;
 		}
+
 		udelay(1);
 	}
-	return 0;
+	if (val & XAE_MDIO_MCR_READY_MASK)
+		return 0;
+
+	WARN_ON(1);
+	return -ETIMEDOUT;
 }
 
 /**
-- 
2.11.0
