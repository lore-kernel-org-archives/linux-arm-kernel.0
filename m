From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 May 2011 09:23:15 +0100
Subject: [RFC PATCH 06/15] ARM: perf: move platform device to struct arm_pmu
Message-ID: <mailman.76.1313415783.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the ARM perf code supports having a single struct
platform_device to supply IRQ numbers, limiting it to supporting a
single PMU.

This patch makes a platform_device instance variable on struct arm_pmu.
This should allow for multiple PMUs to be supported in future.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 9874395..1d648d1 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -26,8 +26,6 @@
 #include <asm/pmu.h>
 #include <asm/stacktrace.h>
 
-static struct platform_device *pmu_device;
-
 /*
  * Hardware lock to serialize accesses to PMU registers. Needed for the
  * read/modify/write sequences.
@@ -85,6 +83,7 @@ struct arm_pmu {
 	atomic_t	active_events;
 	struct mutex	reserve_mutex;
 	u64		max_period;
+	struct platform_device	*plat_device;
 };
 
 /* Set at runtime when we know what CPU type we are. */
@@ -374,7 +373,8 @@ validate_group(struct perf_event *event)
 
 static irqreturn_t armpmu_platform_irq(int irq, void *dev)
 {
-	struct arm_pmu_platdata *plat = dev_get_platdata(&pmu_device->dev);
+	struct platform_device *plat_device = armpmu->plat_device;
+	struct arm_pmu_platdata *plat = dev_get_platdata(&plat_device->dev);
 
 	return plat->handle_irq(irq, dev, armpmu->handle_irq);
 }
@@ -383,6 +383,7 @@ static void
 armpmu_release_hardware(void)
 {
 	int i, irq, irqs;
+	struct platform_device *pmu_device = armpmu->plat_device;
 
 	irqs = min(pmu_device->num_resources, num_possible_cpus());
 
@@ -404,6 +405,7 @@ armpmu_reserve_hardware(void)
 	struct arm_pmu_platdata *plat;
 	irq_handler_t handle_irq;
 	int i, err, irq, irqs;
+	struct platform_device *pmu_device = armpmu->plat_device;
 
 	err = reserve_pmu(ARM_PMU_DEVICE_CPU);
 	if (err) {
@@ -657,7 +659,7 @@ static struct platform_device_id armpmu_plat_device_ids[] = {
 
 static int __devinit armpmu_device_probe(struct platform_device *pdev)
 {
-	pmu_device = pdev;
+	armpmu->plat_device = pdev;
 	return 0;
 }
 
-- 
1.7.0.4
