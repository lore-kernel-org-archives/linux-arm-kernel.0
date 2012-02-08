From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Feb 2012 00:30:46 +0000
Subject: [PATCH v6 02/15] ARM: SoC: Add per SoC SMP and CPU hotplug operations
In-Reply-To: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1328661059-24584-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate the SoC descriptor structure with the SMP and CPU hotplug
operations. To allow the kernel to continue building, the platform
hooks are defined as weak symbols which are overrided by the
platform code. Once all platforms are converted, the "weak" attribute
will be removed and the function made static.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/soc.h |   45 ++++++++++++++++++++++++++++
 arch/arm/kernel/setup.c    |    1 +
 arch/arm/kernel/smp.c      |   69 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/soc.h b/arch/arm/include/asm/soc.h
index 2d73e35..1bcc58c 100644
--- a/arch/arm/include/asm/soc.h
+++ b/arch/arm/include/asm/soc.h
@@ -12,8 +12,53 @@
 #ifndef __ASM_ARM_SOC_H
 #define __ASM_ARM_SOC_H
 
+struct task_struct;
+
+struct arm_soc_smp_init_ops {
+	/*
+	 * Setup the set of possible CPUs (via set_cpu_possible)
+	 */
+	void (*smp_init_cpus)(void);
+	/*
+	 * Initialize cpu_possible map, and enable coherency
+	 */
+	void (*smp_prepare_cpus)(unsigned int max_cpus);
+};
+
+struct arm_soc_smp_ops {
+	/*
+	 * Perform platform specific initialisation of the specified CPU.
+	 */
+	void (*smp_secondary_init)(unsigned int cpu);
+	/*
+	 * Boot a secondary CPU, and assign it the specified idle task.
+	 * This also gives us the initial stack to use for this CPU.
+	 */
+	int  (*smp_boot_secondary)(unsigned int cpu, struct task_struct *idle);
+#ifdef CONFIG_HOTPLUG_CPU
+	int  (*cpu_kill)(unsigned int cpu);
+	void (*cpu_die)(unsigned int cpu);
+	int  (*cpu_disable)(unsigned int cpu);
+#endif
+};
+
 struct arm_soc_desc {
 	const char			*name;
+#ifdef CONFIG_SMP
+	struct arm_soc_smp_init_ops	*smp_init_ops;
+	struct arm_soc_smp_ops		*smp_ops;
+#endif
 };
 
+#ifdef CONFIG_SMP
+#define soc_smp_init_ops(ops)		.smp_init_ops = &(ops),
+#define soc_smp_ops(ops)		.smp_ops = &(ops),
+extern void soc_smp_ops_register(struct arm_soc_smp_init_ops *,
+				 struct arm_soc_smp_ops *);
+#else
+#define soc_smp_init_ops(ops)		/* empty */
+#define soc_smp_ops(ops)		/* empty */
+#define soc_smp_ops_register(a,b)	do {} while(0)
+#endif
+
 #endif	/* __ASM_ARM_SOC_H */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 69ac002..bf30274 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -927,6 +927,7 @@ void __init setup_arch(char **cmdline_p)
 	if (mdesc->soc) {
 		soc_desc = mdesc->soc;
 		pr_info("SoC: %s\n", soc_desc->name);
+		soc_smp_ops_register(soc_desc->smp_init_ops, soc_desc->smp_ops);
 	} else
 		soc_desc = NULL;
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index cdeb727..49a904d 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -27,6 +27,7 @@
 #include <linux/completion.h>
 
 #include <linux/atomic.h>
+#include <asm/soc.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -127,9 +128,77 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	return ret;
 }
 
+/* SoC helpers */
+static const struct arm_soc_smp_init_ops *soc_smp_init_ops  __initdata;
+static const struct arm_soc_smp_ops *soc_smp_ops  __cpuinitdata;
+static struct arm_soc_smp_ops __soc_smp_ops __cpuinitdata;
+
+void __init soc_smp_ops_register(struct arm_soc_smp_init_ops *smp_init_ops,
+				 struct arm_soc_smp_ops *smp_ops)
+{
+	if (smp_init_ops)
+		soc_smp_init_ops = smp_init_ops;
+
+	/*
+	 * Warning: we're copying an __initdata structure into a
+	 * __cpuinitdata structure. We *know* it is valid because only
+	 * __cpuinit (or more persistant) functions should be pointed
+	 * to by soc_smp_ops. Still, this is borderline ugly.
+	 */
+	if (smp_ops) {
+		__soc_smp_ops = *smp_ops;
+		soc_smp_ops = &__soc_smp_ops;
+	}
+}
+
+void __attribute__((weak)) __init smp_init_cpus(void)
+{
+	if (soc_smp_init_ops && soc_smp_init_ops->smp_init_cpus)
+		soc_smp_init_ops->smp_init_cpus();
+}
+
+void __attribute__((weak)) __init platform_smp_prepare_cpus(unsigned int max_cpus)
+{
+	if (soc_smp_ops && soc_smp_init_ops->smp_prepare_cpus)
+		soc_smp_init_ops->smp_prepare_cpus(max_cpus);
+}
+
+void __attribute__((weak)) __cpuinit platform_secondary_init(unsigned int cpu)
+{
+	if (soc_smp_ops && soc_smp_ops->smp_secondary_init)
+		soc_smp_ops->smp_secondary_init(cpu);
+}
+
+int __attribute__((weak)) __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	if (soc_smp_ops && soc_smp_ops->smp_boot_secondary)
+		return soc_smp_ops->smp_boot_secondary(cpu, idle);
+	return -ENOSYS;
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 static void percpu_timer_stop(void);
 
+int __attribute__((weak)) __cpuinit platform_cpu_kill(unsigned int cpu)
+{
+	if (soc_smp_ops && soc_smp_ops->cpu_kill)
+		return soc_smp_ops->cpu_kill(cpu);
+	return 0;
+}
+
+void __attribute__((weak)) __cpuinit platform_cpu_die(unsigned int cpu)
+{
+	if (soc_smp_ops && soc_smp_ops->cpu_die)
+		soc_smp_ops->cpu_die(cpu);
+}
+
+int __attribute__((weak)) __cpuinit platform_cpu_disable(unsigned int cpu)
+{
+	if (soc_smp_ops && soc_smp_ops->cpu_disable)
+		return soc_smp_ops->cpu_disable(cpu);
+	return -EPERM;
+}
+
 /*
  * __cpu_disable runs on the processor to be shutdown.
  */
-- 
1.7.3.4
