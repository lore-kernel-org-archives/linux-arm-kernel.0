From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 29 Jan 2016 14:57:04 +0000
Subject: [PATCH] clocksource/arm_arch_timer: Enable and verify MMIO access
Message-ID: <b4ccba950f8fe0433b8e258a1fc0b8977bbe82d5.1454079150.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, we have been blindly assuming that if a memory-mapped timer
frame exists, then we have access to it. Whilst it's the firmware's
job to give us non-secure access to frames in the first place, we
should not rely on it always being generous enough to also configure
CNTACR if it's not even using those frames itself.

Explicitly enable feature-level access per-frame, and verify that the
access we want is really implemented before trying to make use of it.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 39 ++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index c64d543..c88485d 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -32,6 +32,14 @@
 #define CNTTIDR		0x08
 #define CNTTIDR_VIRT(n)	(BIT(1) << ((n) * 4))
 
+#define CNTACR(n)	(0x40 + ((n) * 4))
+#define CNTACR_RPCT	BIT(0)
+#define CNTACR_RVCT	BIT(1)
+#define CNTACR_RFRQ	BIT(2)
+#define CNTACR_RVOFF	BIT(3)
+#define CNTACR_RWVT	BIT(4)
+#define CNTACR_RWPT	BIT(5)
+
 #define CNTVCT_LO	0x08
 #define CNTVCT_HI	0x0c
 #define CNTFRQ		0x10
@@ -757,7 +765,6 @@ static void __init arch_timer_mem_init(struct device_node *np)
 	}
 
 	cnttidr = readl_relaxed(cntctlbase + CNTTIDR);
-	iounmap(cntctlbase);
 
 	/*
 	 * Try to find a virtual capable frame. Otherwise fall back to a
@@ -765,20 +772,34 @@ static void __init arch_timer_mem_init(struct device_node *np)
 	 */
 	for_each_available_child_of_node(np, frame) {
 		int n;
+		u32 cntacr;
 
 		if (of_property_read_u32(frame, "frame-number", &n)) {
 			pr_err("arch_timer: Missing frame-number\n");
-			of_node_put(best_frame);
 			of_node_put(frame);
-			return;
+			goto out;
 		}
 
-		if (cnttidr & CNTTIDR_VIRT(n)) {
+		/* Try enabling everything, and see what sticks */
+		cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
+			 CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
+		writel_relaxed(cntacr, cntctlbase + CNTACR(n));
+		cntacr = readl_relaxed(cntctlbase + CNTACR(n));
+
+		if (~cntacr & CNTACR_RFRQ)
+			continue;
+
+		if ((cnttidr & CNTTIDR_VIRT(n)) &&
+		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT))) {
 			of_node_put(best_frame);
 			best_frame = frame;
 			arch_timer_mem_use_virtual = true;
 			break;
 		}
+
+		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
+			continue;
+
 		of_node_put(best_frame);
 		best_frame = of_node_get(frame);
 	}
@@ -786,24 +807,26 @@ static void __init arch_timer_mem_init(struct device_node *np)
 	base = arch_counter_base = of_iomap(best_frame, 0);
 	if (!base) {
 		pr_err("arch_timer: Can't map frame's registers\n");
-		of_node_put(best_frame);
-		return;
+		goto out;
 	}
 
 	if (arch_timer_mem_use_virtual)
 		irq = irq_of_parse_and_map(best_frame, 1);
 	else
 		irq = irq_of_parse_and_map(best_frame, 0);
-	of_node_put(best_frame);
+
 	if (!irq) {
 		pr_err("arch_timer: Frame missing %s irq",
 		       arch_timer_mem_use_virtual ? "virt" : "phys");
-		return;
+		goto out;
 	}
 
 	arch_timer_detect_rate(base, np);
 	arch_timer_mem_register(base, irq);
 	arch_timer_common_init();
+out:
+	iounmap(cntctlbase);
+	of_node_put(best_frame);
 }
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
 		       arch_timer_mem_init);
-- 
2.7.0.25.gfc10eb5.dirty
