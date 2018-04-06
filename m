From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  6 Apr 2018 17:26:30 +0100
Subject: [PATCH 2/2] irqchip/gic-v3: use readl_poll_timeout_relaxed()
In-Reply-To: <20180406162630.3244-1-mark.rutland@arm.com>
References: <20180406162630.3244-1-mark.rutland@arm.com>
Message-ID: <20180406162630.3244-3-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GICv3 driver open-codes IO polling loops. Let's use the standard
iopoll helpers to make things more consistent. At the same time, let's
use the USEC_PER_SEC mnemonic to make the timeout behaviour clearer.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d99cc07903ec..9fd777a8398f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -23,11 +23,13 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/time64.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-common.h>
@@ -97,17 +99,13 @@ static inline void __iomem *gic_dist_base(struct irq_data *d)
 
 static void gic_do_wait_for_rwp(void __iomem *base)
 {
-	u32 count = 1000000;	/* 1s! */
+	u32 val;
 
-	while (readl_relaxed(base + GICD_CTLR) & GICD_CTLR_RWP) {
-		count--;
-		if (!count) {
-			pr_err_ratelimited("RWP timeout, gone fishing\n");
-			return;
-		}
-		cpu_relax();
-		udelay(1);
-	};
+	if (readl_relaxed_poll_timeout(base + GICD_CTLR, val,
+				       !(val & GICD_CTLR_RWP), 1,
+				       USEC_PER_SEC)) {
+		pr_err_ratelimited("RWP timeout, gone fishing\n");
+	}
 }
 
 /* Wait for completion of a distributor change */
@@ -136,7 +134,6 @@ static u64 __maybe_unused gic_read_iar(void)
 static void gic_enable_redist(bool enable)
 {
 	void __iomem *rbase;
-	u32 count = 1000000;	/* 1s! */
 	u32 val;
 
 	rbase = gic_data_rdist_rd_base();
@@ -155,16 +152,12 @@ static void gic_enable_redist(bool enable)
 			return;	/* No PM support in this redistributor */
 	}
 
-	while (--count) {
-		val = readl_relaxed(rbase + GICR_WAKER);
-		if (enable ^ (bool)(val & GICR_WAKER_ChildrenAsleep))
-			break;
-		cpu_relax();
-		udelay(1);
-	};
-	if (!count)
+	if (readl_relaxed_poll_timeout(rbase + GICR_WAKER, val,
+				       enable ^ (bool)(val & GICR_WAKER_ChildrenAsleep),
+				       1, USEC_PER_SEC)) {
 		pr_err_ratelimited("redistributor failed to %s...\n",
 				   enable ? "wakeup" : "sleep");
+	}
 }
 
 /*
-- 
2.11.0
