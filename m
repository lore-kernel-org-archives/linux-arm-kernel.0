From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  7 Jul 2011 16:50:19 +0100
Subject: [RFC PATCH 06/17] ARM: kernel: save/restore generic infrastructure
In-Reply-To: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1310053830-23779-7-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides the code infrastructure needed to maintain
a generic per-cpu architecture implementation of idle code.

sr_platform.c :
	- code manages patchset initialization and memory management

sr_context.c:
	- code initializes run-time context save/restore generic
	  support

sr_power.c:
	- provides the generic infrastructure to enter exit low
	  power modes and communicate with Power Control Unit (PCU)

v7 support hinges on the basic infrastructure to provide per-cpu
arch implementation basically through standard function pointers
signatures.

Preprocessor defines include size of data needed to save/restore
L2 state. This define value should be moved to the respective
subsystem (PL310) once the patchset IF to that subsystem is settled.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/kernel/sr.h          |  162 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/sr_context.c  |   23 ++++++
 arch/arm/kernel/sr_helpers.h  |   56 ++++++++++++++
 arch/arm/kernel/sr_platform.c |   48 ++++++++++++
 arch/arm/kernel/sr_power.c    |   26 +++++++
 5 files changed, 315 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/kernel/sr.h
 create mode 100644 arch/arm/kernel/sr_context.c
 create mode 100644 arch/arm/kernel/sr_helpers.h
 create mode 100644 arch/arm/kernel/sr_platform.c
 create mode 100644 arch/arm/kernel/sr_power.c

diff --git a/arch/arm/kernel/sr.h b/arch/arm/kernel/sr.h
new file mode 100644
index 0000000..6b24e53
--- /dev/null
+++ b/arch/arm/kernel/sr.h
@@ -0,0 +1,162 @@
+#define SR_NR_CLUSTERS 1
+
+#define STACK_SIZE 512
+
+#define CPU_A5			0x4100c050
+#define CPU_A8			0x4100c080
+#define CPU_A9			0x410fc090
+#define L2_DATA_SIZE		16
+#define CONTEXT_SPACE_UNCACHED	(2 * PAGE_SIZE)
+#define PA(f) ((typeof(f) *)virt_to_phys((void *)f))
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+#include <linux/threads.h>
+#include <linux/cpumask.h>
+#include <asm/page.h>
+
+/*
+ * Structures we hide from the OS API
+ */
+
+struct sr_cpu_context {
+	u32 flags;
+	u32 saved_items;
+	u32 *mmu_data;
+};
+
+struct sr_cluster_context {
+	u32 saved_items;
+	u32 *l2_data;
+};
+
+struct sr_main_table {
+	pgd_t *os_mmu_context[SR_NR_CLUSTERS][CONFIG_NR_CPUS];
+	cpumask_t cpu_idle_mask[SR_NR_CLUSTERS];
+	pgd_t *fw_mmu_context;
+	u32 num_clusters;
+	struct sr_cluster	*cluster_table;
+};
+
+
+/*
+ * A cluster is a container for CPUs, typically either a single CPU or a
+ * coherent cluster.
+ * We assume the CPUs in the cluster can be switched off independently.
+ */
+struct sr_cluster {
+	u32 cpu_type;       /* A9mpcore, A5mpcore, etc                  */
+	u32 num_cpus;
+	struct sr_cluster_context *context;
+	struct sr_cpu *cpu_table;
+	u32 power_state;
+	u32 cluster_down;
+	void __iomem *scu_address;
+	void *lock;
+};
+
+struct sr_cpu {
+	struct sr_cpu_context *context;
+	u32 power_state;
+};
+
+/*
+ * arch infrastructure
+ */
+struct sr_arch {
+	unsigned int		cpu_val;
+	unsigned int		cpu_mask;
+
+	int (*init)(void);
+
+	int  (*save_context)(struct sr_cluster *, struct sr_cpu *,
+					   unsigned);
+	int  (*restore_context)(struct sr_cluster *, struct sr_cpu *);
+	int  (*enter_cstate)(unsigned cpu_index,
+					struct sr_cpu *cpu,
+					struct sr_cluster *cluster);
+	int  (*leave_cstate)(unsigned, struct sr_cpu *,
+					struct sr_cluster *);
+	void (*reset)(void);
+
+};
+
+extern struct sr_arch *arch;
+extern int lookup_arch(void);
+
+/*
+ * Global variables
+ */
+extern struct sr_main_table main_table;
+extern unsigned long idle_save_context;
+extern unsigned long idle_restore_context;
+extern unsigned long idle_mt;
+extern void *context_memory_uncached;
+
+/*
+ * Context save/restore
+ */
+typedef u32 (sr_save_context_t)
+	(struct sr_cluster *,
+	struct sr_cpu*, u32);
+typedef u32 (sr_restore_context_t)
+	(struct sr_cluster *,
+	struct sr_cpu*);
+
+extern sr_save_context_t sr_save_context;
+extern sr_restore_context_t sr_restore_context;
+
+
+extern struct sr_arch *get_arch(void);
+
+
+/*
+ * 1:1 mappings
+ */
+
+extern int linux_sr_setup_translation_tables(void);
+
+/*
+ * dumb memory allocator
+ */
+
+extern void *get_memory(unsigned int size);
+
+/*
+ * Entering/Leaving C-states function entries
+ */
+
+extern int sr_platform_enter_cstate(unsigned cpu_index, struct sr_cpu *cpu,
+		struct sr_cluster *cluster);
+extern int sr_platform_leave_cstate(unsigned cpu_index, struct sr_cpu *cpu,
+		struct sr_cluster *cluster);
+
+/* save/restore main table */
+extern struct sr_main_table main_table;
+
+/*
+ * Init functions
+ */
+
+extern int sr_platform_runtime_init(void);
+extern int sr_platform_init(void);
+extern int sr_context_init(void);
+
+
+/*
+ * v7 specific
+ */
+
+extern char *cpu_v7_suspend_size;
+extern void scu_cpu_mode(void __iomem *base, int state);
+
+/*
+ * These arrays keep suitable stack pointers for CPUs.
+ *
+ * The memory must be 8-byte aligned.
+ */
+
+extern unsigned long platform_cpu_stacks[CONFIG_NR_CPUS];
+extern unsigned long platform_cpu_nc_stacks[CONFIG_NR_CPUS];
+#endif
diff --git a/arch/arm/kernel/sr_context.c b/arch/arm/kernel/sr_context.c
new file mode 100644
index 0000000..25eaa43
--- /dev/null
+++ b/arch/arm/kernel/sr_context.c
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2008-2011 ARM Limited
+ * Author(s): Jon Callan, Lorenzo Pieralisi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/cache.h>
+#include <asm/cacheflush.h>
+#include "sr.h"
+
+int  sr_context_init(void)
+{
+	idle_save_context = (unsigned long) arch->save_context;
+	idle_restore_context = __pa(arch->restore_context);
+	__cpuc_flush_dcache_area(&idle_restore_context, sizeof(unsigned long));
+	outer_clean_range(__pa(&idle_restore_context),
+			__pa(&idle_restore_context + 1));
+	return 0;
+}
diff --git a/arch/arm/kernel/sr_helpers.h b/arch/arm/kernel/sr_helpers.h
new file mode 100644
index 0000000..1ae3a9a
--- /dev/null
+++ b/arch/arm/kernel/sr_helpers.h
@@ -0,0 +1,56 @@
+/*
+ * Copyright (C) 2008-2011 ARM Limited
+ * Author(s): Jon Callan, Lorenzo Pieralisi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+static inline int sr_platform_get_cpu_index(void)
+{
+	unsigned int cpu;
+	__asm__ __volatile__(
+			"mrc	p15, 0, %0, c0, c0, 5\n\t"
+			: "=r" (cpu));
+	return cpu & 0xf;
+}
+
+/*
+ * Placeholder for further extensions
+ */
+static inline int sr_platform_get_cluster_index(void)
+{
+	return 0;
+}
+
+static inline void __iomem *sr_platform_cbar(void)
+{
+	void __iomem *base;
+	__asm__ __volatile__(
+			"mrc	p15, 4, %0, c15, c0, 0\n\t"
+			: "=r" (base));
+	return base;
+}
+
+#ifdef CONFIG_SMP
+static inline void exit_coherency(void)
+{
+	unsigned int v;
+	asm volatile (
+		"mrc	p15, 0, %0, c1, c0, 1\n"
+		"bic	%0, %0, %1\n"
+		"mcr	p15, 0, %0, c1, c0, 1\n"
+		 : "=&r" (v)
+		 : "Ir" (0x40)
+		 : );
+}
+#else
+static inline void exit_coherency(void) { }
+#endif
+
+extern void default_sleep(void);
+extern void sr_suspend(void *);
+extern void sr_resume(void *, int);
+extern void disable_clean_inv_dcache_v7_all(void);
diff --git a/arch/arm/kernel/sr_platform.c b/arch/arm/kernel/sr_platform.c
new file mode 100644
index 0000000..530aa1b
--- /dev/null
+++ b/arch/arm/kernel/sr_platform.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2008-2011 ARM Limited
+ *
+ * Author(s): Jon Callan, Lorenzo Pieralisi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <asm/memory.h>
+#include <asm/page.h>
+#include <asm/sr_platform_api.h>
+#include "sr.h"
+
+void *context_memory_uncached;
+
+/*
+ * Simple memory allocator function.
+ * Returns start address of allocated region
+ * Memory is zero-initialized.
+ */
+
+static unsigned int watermark;
+
+void *get_memory(unsigned int size)
+{
+	unsigned ret;
+	void *vmem = NULL;
+
+	ret = watermark;
+	watermark += size;
+	BUG_ON(watermark >= CONTEXT_SPACE_UNCACHED);
+	vmem = (context_memory_uncached + ret);
+	watermark = ALIGN(watermark, sizeof(long long));
+
+	return vmem;
+}
+
+int  sr_platform_init(void)
+{
+	memset(context_memory_uncached, 0, CONTEXT_SPACE_UNCACHED);
+	return arch->init();
+}
diff --git a/arch/arm/kernel/sr_power.c b/arch/arm/kernel/sr_power.c
new file mode 100644
index 0000000..2585559
--- /dev/null
+++ b/arch/arm/kernel/sr_power.c
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2008-2011 ARM Limited
+ *
+ * Author(s): Jon Callan, Lorenzo Pieralisi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include "sr.h"
+
+int sr_platform_enter_cstate(unsigned cpu_index,
+			       struct sr_cpu *cpu,
+			       struct sr_cluster *cluster)
+{
+	return arch->enter_cstate(cpu_index, cpu, cluster);
+}
+
+int sr_platform_leave_cstate(unsigned cpu_index,
+			       struct sr_cpu *cpu,
+			       struct sr_cluster *cluster)
+{
+	return arch->leave_cstate(cpu_index, cpu, cluster);
+}
-- 
1.7.4.4
