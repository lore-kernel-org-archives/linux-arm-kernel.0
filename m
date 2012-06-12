From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Jun 2012 13:30:44 +0100
Subject: [PATCH v8 01/13] ARM: Add per-platform SMP/CPU-hotplug operations
In-Reply-To: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
References: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1339504256-11266-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow platforms to export their SMP and CPU hotplug operations
through a new smp_ops structure.

To allow the kernel to continue building, the platform hooks are
defined as weak symbols which are overridden by the platform code.
Once all platforms are converted, the "weak" attribute will be
removed and the functions made static.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/mach/arch.h |   10 +++++
 arch/arm/include/asm/smp_ops.h   |   87 ++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/setup.c          |    2 +
 arch/arm/kernel/smp.c            |   76 +++++++++++++++++++++++++++++++++
 4 files changed, 175 insertions(+)
 create mode 100644 arch/arm/include/asm/smp_ops.h

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 0b1c94b..13e1065 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -14,6 +14,7 @@ struct tag;
 struct meminfo;
 struct sys_timer;
 struct pt_regs;
+struct smp_ops;
 
 struct machine_desc {
 	unsigned int		nr;		/* architecture number	*/
@@ -35,6 +36,9 @@ struct machine_desc {
 	unsigned char		reserve_lp1 :1;	/* never has lp1	*/
 	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
 	char			restart_mode;	/* default restart mode	*/
+#ifdef CONFIG_SMP
+	struct smp_ops		*smp_ops;	/* SMP operations	*/
+#endif
 	void			(*fixup)(struct tag *, char **,
 					 struct meminfo *);
 	void			(*reserve)(void);/* reserve mem blocks	*/
@@ -50,6 +54,12 @@ struct machine_desc {
 	void			(*restart)(char, const char *);
 };
 
+#ifdef CONFIG_SMP
+#define smp_ops(s)		.smp_ops = (&s),
+#else
+#define smp_ops(s)		/* empty */
+#endif
+
 /*
  * Current machine - only accessible during boot.
  */
diff --git a/arch/arm/include/asm/smp_ops.h b/arch/arm/include/asm/smp_ops.h
new file mode 100644
index 0000000..47256bc
--- /dev/null
+++ b/arch/arm/include/asm/smp_ops.h
@@ -0,0 +1,87 @@
+/*
+ *  linux/arch/arm/include/asm/smp_ops.h
+ *
+ *  Copyright (C) 2011 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARM_SMP_OPS_H
+#define __ASM_ARM_SMP_OPS_H
+
+struct task_struct;
+
+struct smp_init_ops {
+#ifdef CONFIG_SMP
+	/*
+	 * Setup the set of possible CPUs (via set_cpu_possible)
+	 */
+	void (*smp_init_cpus)(void);
+	/*
+	 * Initialize cpu_possible map, and enable coherency
+	 */
+	void (*smp_prepare_cpus)(unsigned int max_cpus);
+#endif
+};
+
+struct smp_secondary_ops {
+#ifdef CONFIG_SMP
+	/*
+	 * Perform platform specific initialisation of the specified CPU.
+	 */
+	void (*smp_secondary_init)(unsigned int cpu);
+	/*
+	 * Boot a secondary CPU, and assign it the specified idle task.
+	 * This also gives us the initial stack to use for this CPU.
+	 */
+	int  (*smp_boot_secondary)(unsigned int cpu, struct task_struct *idle);
+#endif
+};
+
+struct smp_hotplug_ops {
+#ifdef CONFIG_HOTPLUG_CPU
+	int  (*cpu_kill)(unsigned int cpu);
+	void (*cpu_die)(unsigned int cpu);
+	int  (*cpu_disable)(unsigned int cpu);
+#endif
+};
+
+struct smp_ops {
+	struct smp_init_ops		init_ops;
+	struct smp_secondary_ops	secondary_ops;
+	struct smp_hotplug_ops		hotplug_ops;
+};
+
+#ifdef CONFIG_SMP
+#define smp_init_ops(prefix)		.init_ops = {			\
+		.smp_init_cpus		= prefix##_smp_init_cpus,	\
+		.smp_prepare_cpus	= prefix##_smp_prepare_cpus,	\
+	},
+
+#define smp_secondary_ops(prefix)	.secondary_ops = {		\
+		.smp_secondary_init	= prefix##_secondary_init,	\
+		.smp_boot_secondary	= prefix##_boot_secondary,	\
+	},
+
+extern void smp_ops_register(struct smp_ops *);
+
+#else
+#define smp_init_ops(prefix)		.init_ops = {},
+#define smp_secondary_ops(prefix)	.secondary_ops = {},
+#define smp_ops_register(a)		do {} while(0)
+#endif
+
+#ifdef CONFIG_HOTPLUG_CPU
+#define smp_hotplug_ops(prefix)		.hotplug_ops = {	\
+		.cpu_kill	= prefix##_cpu_kill,		\
+		.cpu_die	= prefix##_cpu_die,		\
+		.cpu_disable	= prefix##_cpu_disable,		\
+	},
+#else
+#define smp_hotplug_ops(prefix)		.hotplug_ops = {},
+#endif
+
+#endif	/* __ASM_ARM_SMP_OPS_H */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index e15d83b..f97bb1b 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -45,6 +45,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cachetype.h>
 #include <asm/tlbflush.h>
+#include <asm/smp_ops.h>
 
 #include <asm/prom.h>
 #include <asm/mach/arch.h>
@@ -947,6 +948,7 @@ void __init setup_arch(char **cmdline_p)
 		mdesc = setup_machine_tags(machine_arch_type);
 	machine_desc = mdesc;
 	machine_name = mdesc->name;
+	smp_ops_register(mdesc->smp_ops);
 
 	setup_dma_zone(mdesc);
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 2c7217d..6d69e1e 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -27,6 +27,7 @@
 #include <linux/completion.h>
 
 #include <linux/atomic.h>
+#include <asm/smp_ops.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -100,9 +101,84 @@ int __cpuinit __cpu_up(unsigned int cpu, struct task_struct *idle)
 	return ret;
 }
 
+/* SMP helpers */
+static const struct smp_init_ops *smp_init_ops __initdata;
+static const struct smp_secondary_ops *smp_secondary_ops  __cpuinitdata;
+static struct smp_secondary_ops __smp_secondary_ops __cpuinitdata;
+#ifdef CONFIG_HOTPLUG_CPU
+static const struct smp_hotplug_ops *smp_hotplug_ops;
+static struct smp_hotplug_ops __smp_hotplug_ops;
+#endif
+
+void __init smp_ops_register(struct smp_ops *smp_ops)
+{
+	if (!smp_ops)
+		return;
+
+	smp_init_ops = &smp_ops->init_ops;
+
+	/*
+	 * Warning: we're copying an __initdata structure into a
+	 * __cpuinitdata structure. We *know* it is valid because only
+	 * __cpuinit (or more persistant) functions should be pointed
+	 * to by soc_smp_ops. Still, this is borderline ugly.
+	 */
+	__smp_secondary_ops = smp_ops->secondary_ops;
+	smp_secondary_ops = &__smp_secondary_ops;
+#ifdef CONFIG_HOTPLUG_CPU
+	__smp_hotplug_ops = smp_ops->hotplug_ops;
+	smp_hotplug_ops = &__smp_hotplug_ops;
+#endif
+}
+
+void __attribute__((weak)) __init smp_init_cpus(void)
+{
+	if (smp_init_ops && smp_init_ops->smp_init_cpus)
+		smp_init_ops->smp_init_cpus();
+}
+
+void __attribute__((weak)) __init platform_smp_prepare_cpus(unsigned int max_cpus)
+{
+	if (smp_init_ops && smp_init_ops->smp_prepare_cpus)
+		smp_init_ops->smp_prepare_cpus(max_cpus);
+}
+
+void __attribute__((weak)) __cpuinit platform_secondary_init(unsigned int cpu)
+{
+	if (smp_secondary_ops && smp_secondary_ops->smp_secondary_init)
+		smp_secondary_ops->smp_secondary_init(cpu);
+}
+
+int __attribute__((weak)) __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	if (smp_secondary_ops && smp_secondary_ops->smp_boot_secondary)
+		return smp_secondary_ops->smp_boot_secondary(cpu, idle);
+	return -ENOSYS;
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 static void percpu_timer_stop(void);
 
+int __attribute__((weak)) platform_cpu_kill(unsigned int cpu)
+{
+	if (smp_hotplug_ops && smp_hotplug_ops->cpu_kill)
+		return smp_hotplug_ops->cpu_kill(cpu);
+	return 0;
+}
+
+void __attribute__((weak)) platform_cpu_die(unsigned int cpu)
+{
+	if (smp_hotplug_ops && smp_hotplug_ops->cpu_die)
+		smp_hotplug_ops->cpu_die(cpu);
+}
+
+int __attribute__((weak)) platform_cpu_disable(unsigned int cpu)
+{
+	if (smp_hotplug_ops && smp_hotplug_ops->cpu_disable)
+		return smp_hotplug_ops->cpu_disable(cpu);
+	return -EPERM;
+}
+
 /*
  * __cpu_disable runs on the processor to be shutdown.
  */
-- 
1.7.10.3
