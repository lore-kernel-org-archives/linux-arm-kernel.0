From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 8 Feb 2011 09:24:36 +0530
Subject: [PATCHv2 1/2] ARM: perf_event: allow platform-specific interrupt
	handler
Message-ID: <1297137277-26889-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow a platform-specific IRQ handler to be specified via platform data.  This
will be used to implement the single-irq workaround for the DB8500.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/include/asm/pmu.h   |   14 ++++++++++++++
 arch/arm/kernel/perf_event.c |   17 ++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 8ccea01..7544ce6 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -12,11 +12,25 @@
 #ifndef __ARM_PMU_H__
 #define __ARM_PMU_H__
 
+#include <linux/interrupt.h>
+
 enum arm_pmu_type {
 	ARM_PMU_DEVICE_CPU	= 0,
 	ARM_NUM_PMU_DEVICES,
 };
 
+/*
+ * struct arm_pmu_platdata - ARM PMU platform data
+ *
+ * @handle_irq: an optional handler which will be called from the interrupt and
+ * passed the address of the low level handler, and can be used to implement
+ * any platform specific handling before or after calling it.
+ */
+struct arm_pmu_platdata {
+	irqreturn_t (*handle_irq)(int irq, void *dev,
+				  irq_handler_t pmu_handler);
+};
+
 #ifdef CONFIG_CPU_HAS_PMU
 
 /**
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 5efa264..3239511 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -377,9 +377,18 @@ validate_group(struct perf_event *event)
 	return 0;
 }
 
+static irqreturn_t armpmu_platform_irq(int irq, void *dev)
+{
+	struct arm_pmu_platdata *plat = dev_get_platdata(&pmu_device->dev);
+
+	return plat->handle_irq(irq, dev, armpmu->handle_irq);
+}
+
 static int
 armpmu_reserve_hardware(void)
 {
+	struct arm_pmu_platdata *plat;
+	irq_handler_t handle_irq;
 	int i, err = -ENODEV, irq;
 
 	pmu_device = reserve_pmu(ARM_PMU_DEVICE_CPU);
@@ -390,6 +399,12 @@ armpmu_reserve_hardware(void)
 
 	init_pmu(ARM_PMU_DEVICE_CPU);
 
+	plat = dev_get_platdata(&pmu_device->dev);
+	if (plat && plat->handle_irq)
+		handle_irq = armpmu_platform_irq;
+	else
+		handle_irq = armpmu->handle_irq;
+
 	if (pmu_device->num_resources < 1) {
 		pr_err("no irqs for PMUs defined\n");
 		return -ENODEV;
@@ -400,7 +415,7 @@ armpmu_reserve_hardware(void)
 		if (irq < 0)
 			continue;
 
-		err = request_irq(irq, armpmu->handle_irq,
+		err = request_irq(irq, handle_irq,
 				  IRQF_DISABLED | IRQF_NOBALANCING,
 				  "armpmu", NULL);
 		if (err) {
-- 
1.7.2.dirty
