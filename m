From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Mar 2010 14:58:18 +0000
Subject: [RFC PATCH 1/2] ARM: pmu: register IRQs at runtime
In-Reply-To: <1268233099-28965-1-git-send-email-will.deacon@arm.com>
References: <1268233099-28965-1-git-send-email-will.deacon@arm.com>
Message-ID: <1268233099-28965-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current PMU infrastructure for ARM requires that the IRQs for the PMU
device are fixed at compile time and are selected based on the ARCH_ or MACH_
flags. This has the disadvantage of tying the Kernel down to a particular board
as far as profiling is concerned.

This patch replaces the compile-time IRQ registration with a runtime mechanism
which allows the IRQs to be passed in from the board initialisation files using
the pmu_device_register() function.

A further advantage of this change is that there is scope for registering
different types of performance counters in the future by adding a new field
to the arm_pmu_type enumeration.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h   |   36 +++++++++++----
 arch/arm/kernel/perf_event.c |    6 +-
 arch/arm/kernel/pmu.c        |  103 +++++++++++++++++++++++-------------------
 3 files changed, 86 insertions(+), 59 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 2829b9f..2ded693 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -12,22 +12,38 @@
 #ifndef __ARM_PMU_H__
 #define __ARM_PMU_H__
 
+enum arm_pmu_type {
+	ARM_PMU_DEVICE_CPU = 0,
+	ARM_NUM_PMU_DEVICES,
+};
+
 #ifdef CONFIG_CPU_HAS_PMU
 
 struct pmu_irqs {
-	const int   *irqs;
-	int	    num_irqs;
+	enum arm_pmu_type	device_type;
+	const int		*irqs;
+	int			num_irqs;
 };
 
 /**
+ * pmu_device_register() - register a new counter source with the kernel
+ *
+ * Register a new PMU device and its corresponding IRQs. Only one instance
+ * of each device type may be registered at once, but multiple IRQs can be
+ * specified in the corresponding struct pmu_irqs.
+ */
+void
+pmu_device_register(struct pmu_irqs *device);
+
+/**
  * reserve_pmu() - reserve the hardware performance counters
  *
  * Reserve the hardware performance counters in the system for exclusive use.
  * The 'struct pmu_irqs' for the system is returned on success, ERR_PTR()
  * encoded error on failure.
  */
-extern const struct pmu_irqs *
-reserve_pmu(void);
+extern struct pmu_irqs *
+reserve_pmu(enum arm_pmu_type device);
 
 /**
  * release_pmu() - Relinquish control of the performance counters
@@ -38,7 +54,7 @@ reserve_pmu(void);
  * a cookie.
  */
 extern int
-release_pmu(const struct pmu_irqs *irqs);
+release_pmu(struct pmu_irqs *irqs);
 
 /**
  * init_pmu() - Initialise the PMU.
@@ -48,24 +64,24 @@ release_pmu(const struct pmu_irqs *irqs);
  * the actual hardware initialisation.
  */
 extern int
-init_pmu(void);
+init_pmu(enum arm_pmu_type device);
 
 #else /* CONFIG_CPU_HAS_PMU */
 
-static inline const struct pmu_irqs *
-reserve_pmu(void)
+static inline struct pmu_irqs *
+reserve_pmu(enum arm_pmu_type device)
 {
 	return ERR_PTR(-ENODEV);
 }
 
 static inline int
-release_pmu(const struct pmu_irqs *irqs)
+release_pmu(struct pmu_irqs *irqs)
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
index c45a155..752ada2 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -26,7 +26,7 @@
 #include <asm/pmu.h>
 #include <asm/stacktrace.h>
 
-static const struct pmu_irqs *pmu_irqs;
+static struct pmu_irqs *pmu_irqs;
 
 /*
  * Hardware lock to serialize accesses to PMU registers. Needed for the
@@ -317,13 +317,13 @@ armpmu_reserve_hardware(void)
 	int i;
 	int err;
 
-	pmu_irqs = reserve_pmu();
+	pmu_irqs = reserve_pmu(ARM_PMU_DEVICE_CPU);
 	if (IS_ERR(pmu_irqs)) {
 		pr_warning("unable to reserve pmu\n");
 		return PTR_ERR(pmu_irqs);
 	}
 
-	init_pmu();
+	init_pmu(ARM_PMU_DEVICE_CPU);
 
 	if (pmu_irqs->num_irqs < 1) {
 		pr_err("no irqs for PMUs defined\n");
diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
index a124312..e58412f 100644
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
@@ -17,57 +18,48 @@
 
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
-
-static const struct pmu_irqs pmu_irqs = {
-	.irqs	    = irqs,
-	.num_irqs   = ARRAY_SIZE(irqs),
-};
+static struct pmu_irqs *pmu_irqs[ARM_NUM_PMU_DEVICES];
 
 static volatile long pmu_lock;
 
-const struct pmu_irqs *
-reserve_pmu(void)
+void pmu_device_register(struct pmu_irqs *device)
 {
-	return test_and_set_bit_lock(0, &pmu_lock) ? ERR_PTR(-EBUSY) :
-		&pmu_irqs;
+	int device_type = device->device_type;
+
+	if (pmu_irqs[device_type])
+		pr_warning("pmu: registering new device of type %d overwrites "
+				"previous definition!", device_type);
+	else
+		pr_info("pmu: registered new PMU device of type %d\n",
+				device_type);
+
+	pmu_irqs[device_type] = device;
+}
+
+struct pmu_irqs *
+reserve_pmu(enum arm_pmu_type device)
+{
+	struct pmu_irqs *irqs;
+
+	if (test_and_set_bit_lock(device, &pmu_lock)) {
+		irqs = ERR_PTR(-EBUSY);
+	} else if (pmu_irqs[device] == NULL) {
+		clear_bit_unlock(device, &pmu_lock);
+		irqs = ERR_PTR(-ENODEV);
+	} else {
+		irqs = pmu_irqs[device];
+	}
+
+	return irqs;
 }
 EXPORT_SYMBOL_GPL(reserve_pmu);
 
 int
-release_pmu(const struct pmu_irqs *irqs)
+release_pmu(struct pmu_irqs *irqs)
 {
-	if (WARN_ON(irqs != &pmu_irqs))
+	if (WARN_ON(irqs != pmu_irqs[irqs->device_type]))
 		return -EINVAL;
-	clear_bit_unlock(0, &pmu_lock);
+	clear_bit_unlock(irqs->device_type, &pmu_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(release_pmu);
@@ -87,17 +79,36 @@ set_irq_affinity(int irq,
 #endif
 }
 
-int
-init_pmu(void)
+static int
+init_cpu_pmu(void)
 {
-	int i, err = 0;
+	int i, err = 0, num_irqs = pmu_irqs[ARM_PMU_DEVICE_CPU]->num_irqs;
+	const int *irqs = pmu_irqs[ARM_PMU_DEVICE_CPU]->irqs;
 
-	for (i = 0; i < pmu_irqs.num_irqs; ++i) {
-		err = set_irq_affinity(pmu_irqs.irqs[i], i);
+	for (i = 0; i < num_irqs; ++i) {
+		err = set_irq_affinity(irqs[i], i);
 		if (err)
 			break;
 	}
 
 	return err;
 }
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
+		pr_warning("pmu: attempt to initialise unknown device %d\n",
+				device);
+		err = -EINVAL;
+	}
+
+	return err;
+}
 EXPORT_SYMBOL_GPL(init_pmu);
-- 
1.6.3.3
