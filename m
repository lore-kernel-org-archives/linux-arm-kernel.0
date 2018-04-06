From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  6 Apr 2018 17:26:29 +0100
Subject: [PATCH 1/2] irqchip/gic-v3-its: use readl_poll_timeout_relaxed()
In-Reply-To: <20180406162630.3244-1-mark.rutland@arm.com>
References: <20180406162630.3244-1-mark.rutland@arm.com>
Message-ID: <20180406162630.3244-2-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GICv3 ITS driver open-codes IO polling loops. Let's use the standard
iopoll helpers to make things more consistent. At the same time, let's
use the USEC_PER_SEC mnemonic to make the timeout behaviour clearer.

This change means that we return -ETIMEDOUT rather than 1 or -EBUSY, but
in all cases the caller only cares as to whether the return value is
non-zero, so this should not be problematic.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 59 +++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2cbb19cddbf8..ca45fec77be1 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -23,6 +23,7 @@
 #include <linux/dma-iommu.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
+#include <linux/iopoll.h>
 #include <linux/log2.h>
 #include <linux/mm.h>
 #include <linux/msi.h>
@@ -33,6 +34,7 @@
 #include <linux/of_platform.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/time64.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v3.h>
@@ -711,38 +713,37 @@ static void its_flush_cmd(struct its_node *its, struct its_cmd_block *cmd)
 		dsb(ishst);
 }
 
+static bool __its_range_complete(u64 rd_idx, u64 from_idx, u64 to_idx)
+{
+	/* direct case */
+	if (from_idx < to_idx && rd_idx >= to_idx)
+		return true;
+
+	/* Wrapped case */
+	if (from_idx >= to_idx && rd_idx >= to_idx && rd_idx < from_idx)
+		return true;
+
+	return false;
+}
+
 static int its_wait_for_range_completion(struct its_node *its,
 					 struct its_cmd_block *from,
 					 struct its_cmd_block *to)
 {
 	u64 rd_idx, from_idx, to_idx;
-	u32 count = 1000000;	/* 1s! */
+	int ret;
 
 	from_idx = its_cmd_ptr_to_offset(its, from);
 	to_idx = its_cmd_ptr_to_offset(its, to);
 
-	while (1) {
-		rd_idx = readl_relaxed(its->base + GITS_CREADR);
-
-		/* Direct case */
-		if (from_idx < to_idx && rd_idx >= to_idx)
-			break;
-
-		/* Wrapped case */
-		if (from_idx >= to_idx && rd_idx >= to_idx && rd_idx < from_idx)
-			break;
-
-		count--;
-		if (!count) {
-			pr_err_ratelimited("ITS queue timeout (%llu %llu %llu)\n",
+	ret = readl_relaxed_poll_timeout(its->base + GITS_CREADR, rd_idx,
+					 __its_range_complete(rd_idx, from_idx, to_idx),
+					 1, USEC_PER_SEC);
+	if (ret)
+		pr_err_ratelimited("ITS queue timeout (%llu %llu %llu)\n",
 					   from_idx, to_idx, rd_idx);
-			return -1;
-		}
-		cpu_relax();
-		udelay(1);
-	}
 
-	return 0;
+	return ret;
 }
 
 /* Warning, macro hell follows */
@@ -2872,7 +2873,6 @@ static const struct irq_domain_ops its_vpe_domain_ops = {
 
 static int its_force_quiescent(void __iomem *base)
 {
-	u32 count = 1000000;	/* 1s */
 	u32 val;
 
 	val = readl_relaxed(base + GITS_CTLR);
@@ -2889,18 +2889,9 @@ static int its_force_quiescent(void __iomem *base)
 	writel_relaxed(val, base + GITS_CTLR);
 
 	/* Poll GITS_CTLR and wait until ITS becomes quiescent */
-	while (1) {
-		val = readl_relaxed(base + GITS_CTLR);
-		if (val & GITS_CTLR_QUIESCENT)
-			return 0;
-
-		count--;
-		if (!count)
-			return -EBUSY;
-
-		cpu_relax();
-		udelay(1);
-	}
+	return readl_relaxed_poll_timeout(base + GITS_CTLR, val,
+					  val & GITS_CTLR_QUIESCENT, 1,
+					  USEC_PER_SEC);
 }
 
 static bool __maybe_unused its_enable_quirk_cavium_22375(void *data)
-- 
2.11.0
