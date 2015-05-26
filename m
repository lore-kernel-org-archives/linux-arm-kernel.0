From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 May 2015 17:23:34 +0100
Subject: [PATCH 1/7] arm: perf: kill off unused pm callbacks
In-Reply-To: <1432657420-887-1-git-send-email-mark.rutland@arm.com>
References: <1432657420-887-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1432657420-887-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the arm perf code has platdata callbacks for runtime PM and
irq handling, but no platform implements the hooks for the former. Kill
these off.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h       | 14 --------------
 arch/arm/kernel/perf_event.c     | 38 +-------------------------------------
 arch/arm/kernel/perf_event_cpu.c |  1 -
 3 files changed, 1 insertion(+), 52 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index ecad26e..62464a4 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -24,22 +24,10 @@
  *	interrupt and passed the address of the low level handler,
  *	and can be used to implement any platform specific handling
  *	before or after calling it.
- * @runtime_resume: an optional handler which will be called by the
- *	runtime PM framework following a call to pm_runtime_get().
- *	Note that if pm_runtime_get() is called more than once in
- *	succession this handler will only be called once.
- * @runtime_suspend: an optional handler which will be called by the
- *	runtime PM framework following a call to pm_runtime_put().
- *	Note that if pm_runtime_get() is called more than once in
- *	succession this handler will only be called following the
- *	final call to pm_runtime_put() that actually disables the
- *	hardware.
  */
 struct arm_pmu_platdata {
 	irqreturn_t (*handle_irq)(int irq, void *dev,
 				  irq_handler_t pmu_handler);
-	int (*runtime_resume)(struct device *dev);
-	int (*runtime_suspend)(struct device *dev);
 };
 
 #ifdef CONFIG_HW_PERF_EVENTS
@@ -123,8 +111,6 @@ struct arm_pmu {
 
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
 
-extern const struct dev_pm_ops armpmu_dev_pm_ops;
-
 int armpmu_register(struct arm_pmu *armpmu, int type);
 
 u64 armpmu_event_update(struct perf_event *event);
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index df02807..0072e8b 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -14,7 +14,6 @@
 #include <linux/cpumask.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/irq.h>
 #include <linux/irqdesc.h>
 
@@ -349,20 +348,12 @@ static void
 armpmu_release_hardware(struct arm_pmu *armpmu)
 {
 	armpmu->free_irq(armpmu);
-	pm_runtime_put_sync(&armpmu->plat_device->dev);
 }
 
 static int
 armpmu_reserve_hardware(struct arm_pmu *armpmu)
 {
-	int err;
-	struct platform_device *pmu_device = armpmu->plat_device;
-
-	if (!pmu_device)
-		return -ENODEV;
-
-	pm_runtime_get_sync(&pmu_device->dev);
-	err = armpmu->request_irq(armpmu, armpmu_dispatch_irq);
+	int err = armpmu->request_irq(armpmu, armpmu_dispatch_irq);
 	if (err) {
 		armpmu_release_hardware(armpmu);
 		return err;
@@ -536,32 +527,6 @@ static int armpmu_filter_match(struct perf_event *event)
 	return cpumask_test_cpu(cpu, &armpmu->supported_cpus);
 }
 
-#ifdef CONFIG_PM
-static int armpmu_runtime_resume(struct device *dev)
-{
-	struct arm_pmu_platdata *plat = dev_get_platdata(dev);
-
-	if (plat && plat->runtime_resume)
-		return plat->runtime_resume(dev);
-
-	return 0;
-}
-
-static int armpmu_runtime_suspend(struct device *dev)
-{
-	struct arm_pmu_platdata *plat = dev_get_platdata(dev);
-
-	if (plat && plat->runtime_suspend)
-		return plat->runtime_suspend(dev);
-
-	return 0;
-}
-#endif
-
-const struct dev_pm_ops armpmu_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(armpmu_runtime_suspend, armpmu_runtime_resume, NULL)
-};
-
 static void armpmu_init(struct arm_pmu *armpmu)
 {
 	atomic_set(&armpmu->active_events, 0);
@@ -583,7 +548,6 @@ static void armpmu_init(struct arm_pmu *armpmu)
 int armpmu_register(struct arm_pmu *armpmu, int type)
 {
 	armpmu_init(armpmu);
-	pm_runtime_enable(&armpmu->plat_device->dev);
 	pr_info("enabled with %s PMU driver, %d counters available\n",
 			armpmu->name, armpmu->num_events);
 	return perf_pmu_register(&armpmu->pmu, armpmu->name, type);
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 50f245b..14a5a0a 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -408,7 +408,6 @@ out_free:
 static struct platform_driver cpu_pmu_driver = {
 	.driver		= {
 		.name	= "arm-pmu",
-		.pm	= &armpmu_dev_pm_ops,
 		.of_match_table = cpu_pmu_of_device_ids,
 	},
 	.probe		= cpu_pmu_device_probe,
-- 
1.9.1
