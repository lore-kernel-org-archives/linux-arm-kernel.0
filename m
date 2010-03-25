From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Mar 2010 15:16:33 +0000
Subject: [PATCH 1/6] ARM: pmu: register IRQs at runtime
In-Reply-To: <1269530198-19572-1-git-send-email-will.deacon@arm.com>
References: <1269530198-19572-1-git-send-email-will.deacon@arm.com>
Message-ID: <1269530198-19572-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current PMU infrastructure for ARM requires that the IRQs for the PMU
device are fixed at compile time and are selected based on the ARCH_ or MACH_
flags. This has the disadvantage of tying the Kernel down to a particular board
as far as profiling is concerned.

This patch replaces the compile-time IRQ registration with a runtime mechanism
which allows the IRQs to be registered with the framework as a platform_device.

A further advantage of this change is that there is scope for registering
different types of performance counters in the future by changing the id of
the platform_device and attaching different resources to it.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jamie Iles <jamie.iles@picochip.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h   |   32 ++++++-----
 arch/arm/kernel/perf_event.c |   36 ++++++------
 arch/arm/kernel/pmu.c        |  127 +++++++++++++++++++++++++++--------------
 3 files changed, 119 insertions(+), 76 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 2829b9f..8ccea01 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -12,33 +12,33 @@
 #ifndef __ARM_PMU_H__
 #define __ARM_PMU_H__
 
-#ifdef CONFIG_CPU_HAS_PMU
-
-struct pmu_irqs {
-	const int   *irqs;
-	int	    num_irqs;
+enum arm_pmu_type {
+	ARM_PMU_DEVICE_CPU	= 0,
+	ARM_NUM_PMU_DEVICES,
 };
 
+#ifdef CONFIG_CPU_HAS_PMU
+
 /**
  * reserve_pmu() - reserve the hardware performance counters
  *
  * Reserve the hardware performance counters in the system for exclusive use.
- * The 'struct pmu_irqs' for the system is returned on success, ERR_PTR()
+ * The platform_device for the system is returned on success, ERR_PTR()
  * encoded error on failure.
  */
-extern const struct pmu_irqs *
-reserve_pmu(void);
+extern struct platform_device *
+reserve_pmu(enum arm_pmu_type device);
 
 /**
  * release_pmu() - Relinquish control of the performance counters
  *
  * Release the performance counters and allow someone else to use them.
  * Callers must have disabled the counters and released IRQs before calling
- * this. The 'struct pmu_irqs' returned from reserve_pmu() must be passed as
+ * this. The platform_device returned from reserve_pmu() must be passed as
  * a cookie.
  */
 extern int
-release_pmu(const struct pmu_irqs *irqs);
+release_pmu(struct platform_device *pdev);
 
 /**
  * init_pmu() - Initialise the PMU.
@@ -48,24 +48,26 @@ release_pmu(const struct pmu_irqs *irqs);
  * the actual hardware initialisation.
  */
 extern int
-init_pmu(void);
+init_pmu(enum arm_pmu_type device);
 
 #else /* CONFIG_CPU_HAS_PMU */
 
-static inline const struct pmu_irqs *
-reserve_pmu(void)
+#include <linux/err.h>
+
+static inline struct platform_device *
+reserve_pmu(enum arm_pmu_type device)
 {
 	return ERR_PTR(-ENODEV);
 }
 
 static inline int
-release_pmu(const struct pmu_irqs *irqs)
+release_pmu(struct platform_device *pdev)
 {
 	return -ENODEV;
 }
 
 static inline int
-init_pmu(void)
+init_pmu(enum arm_pmu_type device)
 {
 	return -ENODEV;
 }
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 9e70f20..0c1a447 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/perf_event.h>
+#include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
 
@@ -26,7 +27,7 @@
 #include <asm/pmu.h>
 #include <asm/stacktrace.h>
 
-static const struct pmu_irqs *pmu_irqs;
+static struct platform_device *pmu_device;
 
 /*
  * Hardware lock to serialize accesses to PMU registers. Needed for the
@@ -317,35 +318,36 @@ armpmu_reserve_hardware(void)
 	int i;
 	int err;
 
-	pmu_irqs = reserve_pmu();
-	if (IS_ERR(pmu_irqs)) {
+	pmu_device = reserve_pmu(ARM_PMU_DEVICE_CPU);
+	if (IS_ERR(pmu_device)) {
 		pr_warning("unable to reserve pmu\n");
-		return PTR_ERR(pmu_irqs);
+		return PTR_ERR(pmu_device);
 	}
 
-	init_pmu();
+	init_pmu(ARM_PMU_DEVICE_CPU);
 
-	if (pmu_irqs->num_irqs < 1) {
+	if (pmu_device->num_resources < 1) {
 		pr_err("no irqs for PMUs defined\n");
 		return -ENODEV;
 	}
 
-	for (i = 0; i < pmu_irqs->num_irqs; ++i) {
-		err = request_irq(pmu_irqs->irqs[i], armpmu->handle_irq,
+	for (i = 0; i < pmu_device->num_resources; ++i) {
+		err = request_irq(platform_get_irq(pmu_device, i),
+				  armpmu->handle_irq,
 				  IRQF_DISABLED | IRQF_NOBALANCING,
 				  "armpmu", NULL);
 		if (err) {
-			pr_warning("unable to request IRQ%d for ARM "
-				   "perf counters\n", pmu_irqs->irqs[i]);
+			pr_warning("unable to request IRQ%d for ARM perf "
+				"counters\n", platform_get_irq(pmu_device, i));
 			break;
 		}
 	}
 
 	if (err) {
 		for (i = i - 1; i >= 0; --i)
-			free_irq(pmu_irqs->irqs[i], NULL);
-		release_pmu(pmu_irqs);
-		pmu_irqs = NULL;
+			free_irq(platform_get_irq(pmu_device, i), NULL);
+		release_pmu(pmu_device);
+		pmu_device = NULL;
 	}
 
 	return err;
@@ -356,12 +358,12 @@ armpmu_release_hardware(void)
 {
 	int i;
 
-	for (i = pmu_irqs->num_irqs - 1; i >= 0; --i)
-		free_irq(pmu_irqs->irqs[i], NULL);
+	for (i = pmu_device->num_resources - 1; i >= 0; --i)
+		free_irq(platform_get_irq(pmu_device, i), NULL);
 	armpmu->stop();
 
-	release_pmu(pmu_irqs);
-	pmu_irqs = NULL;
+	release_pmu(pmu_device);
+	pmu_device = NULL;
 }
 
 static atomic_t active_events = ATOMIC_INIT(0);
diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
index a124312..b8af96e 100644
--- a/arch/arm/kernel/pmu.c
+++ b/arch/arm/kernel/pmu.c
@@ -2,6 +2,7 @@
  *  linux/arch/arm/kernel/pmu.c
  *
  *  Copyright (C) 2009 picoChip Designs Ltd, Jamie Iles
+ *  Copyright (C) 2010 ARM Ltd, Will Deacon
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -9,65 +10,78 @@
  *
  */
 
+#define pr_fmt(fmt) "PMU: " fmt
+
 #include <linux/cpumask.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include <asm/pmu.h>
 
-/*
- * Define the IRQs for the system. We could use something like a platform
- * device but that seems fairly heavyweight for this. Also, the performance
- * counters can't be removed or hotplugged.
- *
- * Ordering is important: init_pmu() will use the ordering to set the affinity
- * to the corresponding core. e.g. the first interrupt will go to cpu 0, the
- * second goes to cpu 1 etc.
- */
-static const int irqs[] = {
-#if defined(CONFIG_ARCH_OMAP2)
-	3,
-#elif defined(CONFIG_ARCH_BCMRING)
-	IRQ_PMUIRQ,
-#elif defined(CONFIG_MACH_REALVIEW_EB)
-	IRQ_EB11MP_PMU_CPU0,
-	IRQ_EB11MP_PMU_CPU1,
-	IRQ_EB11MP_PMU_CPU2,
-	IRQ_EB11MP_PMU_CPU3,
-#elif defined(CONFIG_ARCH_OMAP3)
-	INT_34XX_BENCH_MPU_EMUL,
-#elif defined(CONFIG_ARCH_IOP32X)
-	IRQ_IOP32X_CORE_PMU,
-#elif defined(CONFIG_ARCH_IOP33X)
-	IRQ_IOP33X_CORE_PMU,
-#elif defined(CONFIG_ARCH_PXA)
-	IRQ_PMU,
-#endif
-};
+static volatile long pmu_lock;
+
+static struct platform_device *pmu_devices[ARM_NUM_PMU_DEVICES];
+
+static int __devinit pmu_device_probe(struct platform_device *pdev)
+{
+
+	if (pdev->id < 0 || pdev->id >= ARM_NUM_PMU_DEVICES) {
+		pr_warning("received registration request for unknown "
+				"device %d\n", pdev->id);
+		return -EINVAL;
+	}
+
+	if (pmu_devices[pdev->id])
+		pr_warning("registering new PMU device type %d overwrites "
+				"previous registration!\n", pdev->id);
+	else
+		pr_info("registered new PMU device of type %d\n",
+				pdev->id);
 
-static const struct pmu_irqs pmu_irqs = {
-	.irqs	    = irqs,
-	.num_irqs   = ARRAY_SIZE(irqs),
+	pmu_devices[pdev->id] = pdev;
+	return 0;
+}
+
+static struct platform_driver pmu_driver = {
+	.driver		= {
+		.name	= "arm-pmu",
+	},
+	.probe		= pmu_device_probe,
 };
 
-static volatile long pmu_lock;
+static int __init register_pmu_driver(void)
+{
+	return platform_driver_register(&pmu_driver);
+}
+device_initcall(register_pmu_driver);
 
-const struct pmu_irqs *
-reserve_pmu(void)
+struct platform_device *
+reserve_pmu(enum arm_pmu_type device)
 {
-	return test_and_set_bit_lock(0, &pmu_lock) ? ERR_PTR(-EBUSY) :
-		&pmu_irqs;
+	struct platform_device *pdev;
+
+	if (test_and_set_bit_lock(device, &pmu_lock)) {
+		pdev = ERR_PTR(-EBUSY);
+	} else if (pmu_devices[device] == NULL) {
+		clear_bit_unlock(device, &pmu_lock);
+		pdev = ERR_PTR(-ENODEV);
+	} else {
+		pdev = pmu_devices[device];
+	}
+
+	return pdev;
 }
 EXPORT_SYMBOL_GPL(reserve_pmu);
 
 int
-release_pmu(const struct pmu_irqs *irqs)
+release_pmu(struct platform_device *pdev)
 {
-	if (WARN_ON(irqs != &pmu_irqs))
+	if (WARN_ON(pdev != pmu_devices[pdev->id]))
 		return -EINVAL;
-	clear_bit_unlock(0, &pmu_lock);
+	clear_bit_unlock(pdev->id, &pmu_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(release_pmu);
@@ -87,17 +101,42 @@ set_irq_affinity(int irq,
 #endif
 }
 
-int
-init_pmu(void)
+static int
+init_cpu_pmu(void)
 {
 	int i, err = 0;
+	struct platform_device *pdev = pmu_devices[ARM_PMU_DEVICE_CPU];
+
+	if (!pdev) {
+		err = -ENODEV;
+		goto out;
+	}
 
-	for (i = 0; i < pmu_irqs.num_irqs; ++i) {
-		err = set_irq_affinity(pmu_irqs.irqs[i], i);
+	for (i = 0; i < pdev->num_resources; ++i) {
+		err = set_irq_affinity(platform_get_irq(pdev, i), i);
 		if (err)
 			break;
 	}
 
+out:
+	return err;
+}
+
+int
+init_pmu(enum arm_pmu_type device)
+{
+	int err = 0;
+
+	switch (device) {
+	case ARM_PMU_DEVICE_CPU:
+		err = init_cpu_pmu();
+		break;
+	default:
+		pr_warning("attempt to initialise unknown device %d\n",
+				device);
+		err = -EINVAL;
+	}
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(init_pmu);
-- 
1.6.3.3
