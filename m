From: tom.leiming@gmail.com (tom.leiming at gmail.com)
Date: Tue,  8 Mar 2011 23:38:48 +0800
Subject: [patch v4 2/3] arm: pmu: allow platform specific irq enable/disable
	handling
In-Reply-To: <1299598729-27974-1-git-send-email-tom.leiming@gmail.com>
References: <1299598729-27974-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <1299598729-27974-3-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ming Lei <tom.leiming@gmail.com>

This patch introduces .enable_irq and .disable_irq into
struct arm_pmu_platdata, so platform specific irq enablement
can be handled after request_irq, and platform specific irq
disablement can be handled before free_irq.

This patch is for support of  pmu irq routed from CTI on omap4.

Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/include/asm/pmu.h   |   15 ++++++++++++---
 arch/arm/kernel/perf_event.c |   15 ++++++++++++---
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 7544ce6..7ca3d15 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -22,13 +22,22 @@ enum arm_pmu_type {
 /*
  * struct arm_pmu_platdata - ARM PMU platform data
  *
- * @handle_irq: an optional handler which will be called from the interrupt and
- * passed the address of the low level handler, and can be used to implement
- * any platform specific handling before or after calling it.
+ * @handle_irq: an optional handler which will be called from the
+ *	interrupt and passed the address of the low level handler,
+ *	and can be used to implement any platform specific handling
+ *	before or after calling it.
+ * @enable_irq: an optional handler which will be called after
+ *	request_irq and be used to handle some platform specific
+ *	irq enablement
+ * @disable_irq: an optional handler which will be called before
+ *	free_irq and be used to handle some platform specific
+ *	irq disablement
  */
 struct arm_pmu_platdata {
 	irqreturn_t (*handle_irq)(int irq, void *dev,
 				  irq_handler_t pmu_handler);
+	void (*enable_irq)(int irq);
+	void (*disable_irq)(int irq);
 };
 
 #ifdef CONFIG_CPU_HAS_PMU
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 22e194eb..61ff471 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -422,14 +422,18 @@ armpmu_reserve_hardware(void)
 			pr_warning("unable to request IRQ%d for ARM perf "
 				"counters\n", irq);
 			break;
-		}
+		} else if (plat->enable_irq)
+			plat->enable_irq(irq);
 	}
 
 	if (err) {
 		for (i = i - 1; i >= 0; --i) {
 			irq = platform_get_irq(pmu_device, i);
-			if (irq >= 0)
+			if (irq >= 0) {
+				if (plat->disable_irq)
+					plat->disable_irq(irq);
 				free_irq(irq, NULL);
+			}
 		}
 		release_pmu(pmu_device);
 		pmu_device = NULL;
@@ -442,11 +446,16 @@ static void
 armpmu_release_hardware(void)
 {
 	int i, irq;
+	struct arm_pmu_platdata *plat =
+		dev_get_platdata(&pmu_device->dev);
 
 	for (i = pmu_device->num_resources - 1; i >= 0; --i) {
 		irq = platform_get_irq(pmu_device, i);
-		if (irq >= 0)
+		if (irq >= 0) {
+			if (plat->disable_irq)
+				plat->disable_irq(irq);
 			free_irq(irq, NULL);
+		}
 	}
 	armpmu->stop();
 
-- 
1.7.3
