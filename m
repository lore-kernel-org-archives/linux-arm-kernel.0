From: jamie.iles@picochip.com (Jamie Iles)
Date: Mon,  4 Jan 2010 10:48:38 +0000
Subject: [PATCH 1/5] arm: provide a mechanism to reserve performance counters
In-Reply-To: <1262602122-10373-1-git-send-email-jamie.iles@picochip.com>
References: <1262602122-10373-1-git-send-email-jamie.iles@picochip.com>
Message-ID: <1262602122-10373-2-git-send-email-jamie.iles@picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To add support for perf events and to allow the hardware
counters to be shared with oprofile, we need a way to reserve
access to the pmu (performance monitor unit).

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
---
 arch/arm/Kconfig           |    5 ++
 arch/arm/include/asm/pmu.h |   74 ++++++++++++++++++++++++++++++
 arch/arm/kernel/Makefile   |    1 +
 arch/arm/kernel/pmu.c      |  107 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 187 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/pmu.h
 create mode 100644 arch/arm/kernel/pmu.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 233a222..9e08891 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -863,6 +863,11 @@ config XSCALE_PMU
 	depends on CPU_XSCALE && !XSCALE_PMU_TIMER
 	default y
 
+config CPU_HAS_PMU
+	depends on CPU_V6 || CPU_V7 || XSCALE_PMU
+	default y
+	bool
+
 if !MMU
 source "arch/arm/Kconfig-nommu"
 endif
diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
new file mode 100644
index 0000000..5840d2d
--- /dev/null
+++ b/arch/arm/include/asm/pmu.h
@@ -0,0 +1,74 @@
+/*
+ *  linux/arch/arm/include/asm/pmu.h
+ *
+ *  Copyright (C) 2009 picoChip Designs Ltd, Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ARM_PMU_H__
+#define __ARM_PMU_H__
+
+#ifdef CONFIG_CPU_HAS_PMU
+
+struct pmu_irqs {
+	const int   *irqs;
+	int	    num_irqs;
+};
+
+/**
+ * reserve_pmu() - reserve the hardware performance counters
+ *
+ * Reserve the hardware performance counters in the system for exclusive use.
+ * The 'struct pmu_irqs' for the system is returned on success, ERR_PTR()
+ * encoded error on failure.
+ */
+extern const struct pmu_irqs *
+reserve_pmu(void);
+
+/**
+ * release_pmu() - Relinquish control of the performance counters
+ *
+ * Release the performance counters and allow someone else to use them.
+ * Callers must have disabled the counters and released IRQs before calling
+ * this. The 'struct pmu_irqs' returned from reserve_pmu() must be passed as
+ * a cookie.
+ */
+extern int
+release_pmu(const struct pmu_irqs *irqs);
+
+/**
+ * init_pmu() - Initialise the PMU.
+ *
+ * Initialise the system ready for PMU enabling. This should typically set the
+ * IRQ affinity and nothing else. The users (oprofile/perf events etc) will do
+ * the actual hardware initialisation.
+ */
+extern int
+init_pmu(void);
+
+#else /* CONFIG_CPU_HAS_PMU */
+
+static inline const struct pmu_irqs *
+reserve_pmu(void)
+{
+	ERR_PTR(-ENODEV);
+}
+
+static inline int
+release_pmu(const struct pmu_irqs *irqs)
+{
+}
+
+static inline int
+init_pmu(void)
+{
+	return -ENODEV;
+}
+
+#endif /* CONFIG_CPU_HAS_PMU */
+
+#endif /* __ARM_PMU_H__ */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index dd00f74..216890d 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_CPU_XSCALE)	+= xscale-cp0.o
 obj-$(CONFIG_CPU_XSC3)		+= xscale-cp0.o
 obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
+obj-$(CONFIG_CPU_HAS_PMU)	+= pmu.o
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 
 ifneq ($(CONFIG_ARCH_EBSA110),y)
diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
new file mode 100644
index 0000000..a8c015d
--- /dev/null
+++ b/arch/arm/kernel/pmu.c
@@ -0,0 +1,107 @@
+/*
+ *  linux/arch/arm/kernel/pmu.c
+ *
+ *  Copyright (C) 2009 picoChip Designs Ltd, Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/cpumask.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/semaphore.h>
+
+#include <asm/pmu.h>
+
+/*
+ * Define the IRQs for the system. We could use something like a platform
+ * device but that seems fairly heavyweight for this. Also, the performance
+ * counters can't be removed or hotplugged.
+ *
+ * Ordering is important: init_pmu() will use the ordering to set the affinity
+ * to the corresponding core. e.g. the first interrupt will go to cpu 0, the
+ * second goes to cpu 1 etc.
+ */
+static const int irqs[] = {
+#ifdef CONFIG_ARCH_PC3XX
+	IRQ_NPMUIRQ,
+#elif defined(CONFIG_ARCH_OMAP2)
+	3,
+#elif defined(CONFIG_ARCH_BCMRING)
+	IRQ_PMUIRQ,
+#elif defined(CONFIG_MACH_REALVIEW_EB)
+	IRQ_EB11MP_PMU_CPU0,
+	IRQ_EB11MP_PMU_CPU1,
+	IRQ_EB11MP_PMU_CPU2,
+	IRQ_EB11MP_PMU_CPU3,
+#elif defined(CONFIG_ARCH_OMAP3)
+	INT_34XX_BENCH_MPU_EMUL,
+#elif defined(CONFIG_ARCH_IOP32X)
+	IRQ_IOP32X_CORE_PMU,
+#elif defined(CONFIG_ARCH_IOP33X)
+	IRQ_IOP33X_CORE_PMU,
+#elif defined(CONFIG_ARCH_PXA)
+	IRQ_PMU,
+#endif
+};
+
+static const struct pmu_irqs pmu_irqs = {
+	.irqs	    = irqs,
+	.num_irqs   = ARRAY_SIZE(irqs),
+};
+
+static DECLARE_MUTEX(pmu_mutex);
+
+const struct pmu_irqs *
+reserve_pmu(void)
+{
+	int ret = down_trylock(&pmu_mutex) ? -EBUSY : 0;
+
+	return ret ? ERR_PTR(ret) : &pmu_irqs;
+}
+EXPORT_SYMBOL_GPL(reserve_pmu);
+
+int
+release_pmu(const struct pmu_irqs *irqs)
+{
+	if (WARN_ON(irqs != &pmu_irqs))
+		return -EINVAL;
+	up(&pmu_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(release_pmu);
+
+static int
+set_irq_affinity(int irq,
+		 unsigned int cpu)
+{
+#ifdef CONFIG_SMP
+	int err = irq_set_affinity(irq, cpumask_of(cpu));
+	if (err)
+		pr_warning("unable to set irq affinity (irq=%d, cpu=%u)\n",
+			   irq, cpu);
+	return err;
+#else
+	return 0;
+#endif
+}
+
+int
+init_pmu(void)
+{
+	int i, err = 0;
+
+	for (i = 0; i < pmu_irqs.num_irqs; ++i) {
+		err = set_irq_affinity(pmu_irqs.irqs[i], i);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(init_pmu);
-- 
1.6.5.4
