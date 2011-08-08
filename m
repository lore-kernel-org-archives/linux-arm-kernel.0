From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:16:03 +0100
Subject: [PATCH 02/10] ARM: PMU: move CPU PMU platform device handling and
	init into perf
In-Reply-To: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
References: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823771-9952-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once upon a time, OProfile and Perf fought hard over who could play with
the PMU. To stop all hell from breaking loose, pmu.c offered an internal
reserve/release API and took care of parsing PMU platform data passed in
from board support code.

Now that Perf has ingested OProfile, let's move the platform device
handling into the Perf driver and out of the PMU locking code.
Unfortunately, the lock has to remain to prevent Perf being bitten by
out-of-tree modules such as LTTng, which still claim a right to the PMU
when Perf isn't looking.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h   |   39 +++-------
 arch/arm/kernel/perf_event.c |   74 ++++++++++++++---
 arch/arm/kernel/pmu.c        |  181 ++----------------------------------------
 3 files changed, 80 insertions(+), 214 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 67c70a3..f210708 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -14,6 +14,10 @@
 
 #include <linux/interrupt.h>
 
+/*
+ * Types of PMUs that can be accessed directly and require mutual
+ * exclusion between profiling tools.
+ */
 enum arm_pmu_type {
 	ARM_PMU_DEVICE_CPU	= 0,
 	ARM_NUM_PMU_DEVICES,
@@ -37,54 +41,31 @@ struct arm_pmu_platdata {
  * reserve_pmu() - reserve the hardware performance counters
  *
  * Reserve the hardware performance counters in the system for exclusive use.
- * The platform_device for the system is returned on success, ERR_PTR()
- * encoded error on failure.
+ * Returns 0 on success or -EBUSY if the lock is already held.
  */
-extern struct platform_device *
+extern int
 reserve_pmu(enum arm_pmu_type device);
 
 /**
  * release_pmu() - Relinquish control of the performance counters
  *
  * Release the performance counters and allow someone else to use them.
- * Callers must have disabled the counters and released IRQs before calling
- * this. The platform_device returned from reserve_pmu() must be passed as
- * a cookie.
  */
-extern int
+extern void
 release_pmu(enum arm_pmu_type type);
 
-/**
- * init_pmu() - Initialise the PMU.
- *
- * Initialise the system ready for PMU enabling. This should typically set the
- * IRQ affinity and nothing else. The users (oprofile/perf events etc) will do
- * the actual hardware initialisation.
- */
-extern int
-init_pmu(enum arm_pmu_type device);
-
 #else /* CONFIG_CPU_HAS_PMU */
 
 #include <linux/err.h>
 
-static inline struct platform_device *
-reserve_pmu(enum arm_pmu_type device)
-{
-	return ERR_PTR(-ENODEV);
-}
-
 static inline int
-release_pmu(struct platform_device *pdev)
+reserve_pmu(enum arm_pmu_type device)
 {
 	return -ENODEV;
 }
 
-static inline int
-init_pmu(enum arm_pmu_type device)
-{
-	return -ENODEV;
-}
+static inline void
+release_pmu(struct platform_device *pdev)	{ }
 
 #endif /* CONFIG_CPU_HAS_PMU */
 
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 7304996..8514855 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -393,15 +393,15 @@ armpmu_reserve_hardware(void)
 {
 	struct arm_pmu_platdata *plat;
 	irq_handler_t handle_irq;
-	int i, err = -ENODEV, irq;
+	int i, err, irq, irqs;
 
-	pmu_device = reserve_pmu(ARM_PMU_DEVICE_CPU);
-	if (IS_ERR(pmu_device)) {
+	err = reserve_pmu(ARM_PMU_DEVICE_CPU);
+	if (err) {
 		pr_warning("unable to reserve pmu\n");
-		return PTR_ERR(pmu_device);
+		return err;
 	}
 
-	init_pmu(ARM_PMU_DEVICE_CPU);
+	irqs = pmu_device->num_resources;
 
 	plat = dev_get_platdata(&pmu_device->dev);
 	if (plat && plat->handle_irq)
@@ -409,22 +409,34 @@ armpmu_reserve_hardware(void)
 	else
 		handle_irq = armpmu->handle_irq;
 
-	if (pmu_device->num_resources < 1) {
+	if (irqs < 1) {
 		pr_err("no irqs for PMUs defined\n");
 		return -ENODEV;
 	}
 
-	for (i = 0; i < pmu_device->num_resources; ++i) {
+	for (i = 0; i < irqs; ++i) {
 		irq = platform_get_irq(pmu_device, i);
 		if (irq < 0)
 			continue;
 
+		/*
+		 * If we have a single PMU interrupt that we can't shift,
+		 * assume that we're running on a uniprocessor machine and
+		 * continue.
+		 */
+		err = irq_set_affinity(irq, cpumask_of(i));
+		if (err && irqs > 1) {
+			pr_err("unable to set irq affinity (irq=%d, cpu=%u)\n",
+				irq, i);
+			break;
+		}
+
 		err = request_irq(irq, handle_irq,
 				  IRQF_DISABLED | IRQF_NOBALANCING,
-				  "armpmu", NULL);
+				  "arm-pmu", NULL);
 		if (err) {
-			pr_warning("unable to request IRQ%d for ARM perf "
-				"counters\n", irq);
+			pr_err("unable to request IRQ%d for ARM PMU counters\n",
+				irq);
 			break;
 		}
 	}
@@ -436,7 +448,6 @@ armpmu_reserve_hardware(void)
 				free_irq(irq, NULL);
 		}
 		release_pmu(ARM_PMU_DEVICE_CPU);
-		pmu_device = NULL;
 	}
 
 	return err;
@@ -455,7 +466,6 @@ armpmu_release_hardware(void)
 	armpmu->stop();
 
 	release_pmu(ARM_PMU_DEVICE_CPU);
-	pmu_device = NULL;
 }
 
 static atomic_t active_events = ATOMIC_INIT(0);
@@ -638,6 +648,46 @@ armpmu_reset(void)
 }
 arch_initcall(armpmu_reset);
 
+/*
+ * PMU platform driver and devicetree bindings.
+ */
+static struct of_device_id armpmu_of_device_ids[] = {
+	{.compatible = "arm,cortex-a9-pmu"},
+	{.compatible = "arm,cortex-a8-pmu"},
+	{.compatible = "arm,arm1136-pmu"},
+	{.compatible = "arm,arm1176-pmu"},
+	{},
+};
+
+static struct platform_device_id armpmu_plat_device_ids[] = {
+	{.name = "arm-pmu"},
+	{},
+};
+
+static int __devinit armpmu_device_probe(struct platform_device *pdev)
+{
+	pmu_device = pdev;
+	return 0;
+}
+
+static struct platform_driver armpmu_driver = {
+	.driver		= {
+		.name	= "arm-pmu",
+		.of_match_table = armpmu_of_device_ids,
+	},
+	.probe		= armpmu_device_probe,
+	.id_table	= armpmu_plat_device_ids,
+};
+
+static int __init register_pmu_driver(void)
+{
+	return platform_driver_register(&armpmu_driver);
+}
+device_initcall(register_pmu_driver);
+
+/*
+ * CPU PMU identification and registration.
+ */
 static int __init
 init_hw_perf_events(void)
 {
diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
index 2b70709..98d0736 100644
--- a/arch/arm/kernel/pmu.c
+++ b/arch/arm/kernel/pmu.c
@@ -10,192 +10,27 @@
  *
  */
 
-#define pr_fmt(fmt) "PMU: " fmt
-
-#include <linux/cpumask.h>
 #include <linux/err.h>
-#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/platform_device.h>
 
 #include <asm/pmu.h>
 
-static volatile long pmu_lock;
-
-static struct platform_device *pmu_devices[ARM_NUM_PMU_DEVICES];
-
-static int __devinit pmu_register(struct platform_device *pdev,
-					enum arm_pmu_type type)
-{
-	if (type < 0 || type >= ARM_NUM_PMU_DEVICES) {
-		pr_warning("received registration request for unknown "
-				"device %d\n", type);
-		return -EINVAL;
-	}
-
-	if (pmu_devices[type]) {
-		pr_warning("rejecting duplicate registration of PMU device "
-			"type %d.", type);
-		return -ENOSPC;
-	}
-
-	pr_info("registered new PMU device of type %d\n", type);
-	pmu_devices[type] = pdev;
-	return 0;
-}
-
-#define OF_MATCH_PMU(_name, _type) {	\
-	.compatible = _name,		\
-	.data = (void *)_type,		\
-}
-
-#define OF_MATCH_CPU(name)	OF_MATCH_PMU(name, ARM_PMU_DEVICE_CPU)
-
-static struct of_device_id armpmu_of_device_ids[] = {
-	OF_MATCH_CPU("arm,cortex-a9-pmu"),
-	OF_MATCH_CPU("arm,cortex-a8-pmu"),
-	OF_MATCH_CPU("arm,arm1136-pmu"),
-	OF_MATCH_CPU("arm,arm1176-pmu"),
-	{},
-};
-
-#define PLAT_MATCH_PMU(_name, _type) {	\
-	.name		= _name,	\
-	.driver_data	= _type,	\
-}
-
-#define PLAT_MATCH_CPU(_name)	PLAT_MATCH_PMU(_name, ARM_PMU_DEVICE_CPU)
-
-static struct platform_device_id armpmu_plat_device_ids[] = {
-	PLAT_MATCH_CPU("arm-pmu"),
-	{},
-};
-
-enum arm_pmu_type armpmu_device_type(struct platform_device *pdev)
-{
-	const struct of_device_id	*of_id;
-	const struct platform_device_id *pdev_id;
-
-	/* provided by of_device_id table */
-	if (pdev->dev.of_node) {
-		of_id = of_match_device(armpmu_of_device_ids, &pdev->dev);
-		BUG_ON(!of_id);
-		return (enum arm_pmu_type)of_id->data;
-	}
-
-	/* Provided by platform_device_id table */
-	pdev_id = platform_get_device_id(pdev);
-	BUG_ON(!pdev_id);
-	return pdev_id->driver_data;
-}
-
-static int __devinit armpmu_device_probe(struct platform_device *pdev)
-{
-	return pmu_register(pdev, armpmu_device_type(pdev));
-}
-
-static struct platform_driver armpmu_driver = {
-	.driver		= {
-		.name	= "arm-pmu",
-		.of_match_table = armpmu_of_device_ids,
-	},
-	.probe		= armpmu_device_probe,
-	.id_table	= armpmu_plat_device_ids,
-};
-
-static int __init register_pmu_driver(void)
-{
-	return platform_driver_register(&armpmu_driver);
-}
-device_initcall(register_pmu_driver);
+/*
+ * PMU locking to ensure mutual exclusion between different subsystems.
+ */
+static unsigned long pmu_lock[BITS_TO_LONGS(ARM_NUM_PMU_DEVICES)];
 
-struct platform_device *
+int
 reserve_pmu(enum arm_pmu_type device)
 {
-	struct platform_device *pdev;
-
-	if (test_and_set_bit_lock(device, &pmu_lock)) {
-		pdev = ERR_PTR(-EBUSY);
-	} else if (pmu_devices[device] == NULL) {
-		clear_bit_unlock(device, &pmu_lock);
-		pdev = ERR_PTR(-ENODEV);
-	} else {
-		pdev = pmu_devices[device];
-	}
-
-	return pdev;
+	return test_and_set_bit_lock(device, pmu_lock) ? -EBUSY : 0;
 }
 EXPORT_SYMBOL_GPL(reserve_pmu);
 
-int
+void
 release_pmu(enum arm_pmu_type device)
 {
-	if (WARN_ON(!pmu_devices[device]))
-		return -EINVAL;
-	clear_bit_unlock(device, &pmu_lock);
-	return 0;
+	clear_bit_unlock(device, pmu_lock);
 }
 EXPORT_SYMBOL_GPL(release_pmu);
-
-static int
-set_irq_affinity(int irq,
-		 unsigned int cpu)
-{
-#ifdef CONFIG_SMP
-	int err = irq_set_affinity(irq, cpumask_of(cpu));
-	if (err)
-		pr_warning("unable to set irq affinity (irq=%d, cpu=%u)\n",
-			   irq, cpu);
-	return err;
-#else
-	return -EINVAL;
-#endif
-}
-
-static int
-init_cpu_pmu(void)
-{
-	int i, irqs, err = 0;
-	struct platform_device *pdev = pmu_devices[ARM_PMU_DEVICE_CPU];
-
-	if (!pdev)
-		return -ENODEV;
-
-	irqs = pdev->num_resources;
-
-	/*
-	 * If we have a single PMU interrupt that we can't shift, assume that
-	 * we're running on a uniprocessor machine and continue.
-	 */
-	if (irqs == 1 && !irq_can_set_affinity(platform_get_irq(pdev, 0)))
-		return 0;
-
-	for (i = 0; i < irqs; ++i) {
-		err = set_irq_affinity(platform_get_irq(pdev, i), i);
-		if (err)
-			break;
-	}
-
-	return err;
-}
-
-int
-init_pmu(enum arm_pmu_type device)
-{
-	int err = 0;
-
-	switch (device) {
-	case ARM_PMU_DEVICE_CPU:
-		err = init_cpu_pmu();
-		break;
-	default:
-		pr_warning("attempt to initialise unknown device %d\n",
-				device);
-		err = -EINVAL;
-	}
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(init_pmu);
-- 
1.7.0.4
