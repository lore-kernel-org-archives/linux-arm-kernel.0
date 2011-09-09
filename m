From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  9 Sep 2011 15:46:55 +0100
Subject: [RFC PATCH v2 2/3] ARM: SoC: Add per SoC SMP and CPU hotplug
	operations
In-Reply-To: <1315579616-27388-1-git-send-email-marc.zyngier@arm.com>
References: <1315579616-27388-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1315579616-27388-3-git-send-email-marc.zyngier@arm.com>
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
 arch/arm/include/asm/soc.h |   18 ++++++++++++++++
 arch/arm/kernel/setup.c    |   11 ++++++++++
 arch/arm/kernel/smp.c      |   47 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/soc.h b/arch/arm/include/asm/soc.h
index ce92784..2593f90 100644
--- a/arch/arm/include/asm/soc.h
+++ b/arch/arm/include/asm/soc.h
@@ -12,10 +12,28 @@
 #ifndef __ASM_ARM_SOC_H
 #define __ASM_ARM_SOC_H
 
+struct task_struct;
+
+struct arm_soc_smp_ops {
+	void (*smp_init_cpus)(void);
+	void (*smp_prepare_cpus)(unsigned int max_cpus);
+	void (*smp_secondary_init)(unsigned int cpu);
+	int  (*smp_boot_secondary)(unsigned int cpu, struct task_struct *idle);
+#ifdef CONFIG_HOTPLUG_CPU
+	int  (*cpu_kill)(unsigned int cpu);
+	void (*cpu_die)(unsigned int cpu);
+	int  (*cpu_disable)(unsigned int cpu);
+#endif
+};
+
 struct arm_soc_desc {
 	const char		*name;
+#ifdef CONFIG_SMP
+	struct arm_soc_smp_ops	*smp_ops;
+#endif
 };
 
 extern const struct arm_soc_desc	*soc_desc;
+extern const struct arm_soc_smp_ops	*soc_smp_ops;
 
 #endif	/* __ASM_ARM_SOC_H */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 6bfa5f6..972e43f 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -143,6 +143,10 @@ static char __initdata cmd_line[COMMAND_LINE_SIZE];
 struct machine_desc *machine_desc __initdata;
 const struct arm_soc_desc *soc_desc;
 static struct arm_soc_desc __soc_desc __read_mostly;
+#ifdef CONFIG_SMP
+const struct arm_soc_smp_ops *soc_smp_ops;
+static struct arm_soc_smp_ops __soc_smp_ops __read_mostly;
+#endif
 
 static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
 static union { char c[4]; unsigned long l; } endian_test __initdata = { { 'l', '?', '?', 'b' } };
@@ -918,6 +922,13 @@ void __init setup_arch(char **cmdline_p)
 		pr_info("SoC: %s\n", soc_desc->name);
 	} else
 		soc_desc = NULL;
+#ifdef CONFIG_SMP
+	if (soc_desc && soc_desc->smp_ops) {
+		__soc_smp_ops = *soc_desc->smp_ops;
+		soc_smp_ops = &__soc_smp_ops;
+	} else
+		soc_smp_ops = NULL;
+#endif
 
 	if (mdesc->soft_reboot)
 		reboot_setup("s");
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3f12ce9..8cb83ff 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -28,6 +28,7 @@
 #include <linux/completion.h>
 
 #include <linux/atomic.h>
+#include <asm/soc.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -155,9 +156,55 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	return ret;
 }
 
+/* SoC helpers */
+void __attribute__((weak)) smp_init_cpus(void)
+{
+	if (soc_smp_ops && soc_smp_ops->smp_init_cpus)
+		soc_smp_ops->smp_init_cpus();
+}
+
+void __attribute__((weak)) platform_smp_prepare_cpus(unsigned int max_cpus)
+{
+	if (soc_smp_ops && soc_smp_ops->smp_prepare_cpus)
+		soc_smp_ops->smp_prepare_cpus(max_cpus);
+}
+
+void __attribute__((weak)) platform_secondary_init(unsigned int cpu)
+{
+	if (soc_smp_ops && soc_smp_ops->smp_secondary_init)
+		soc_smp_ops->smp_secondary_init(cpu);
+}
+
+int __attribute__((weak)) boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	if (soc_smp_ops && soc_smp_ops->smp_boot_secondary)
+		return soc_smp_ops->smp_boot_secondary(cpu, idle);
+	return -ENOSYS;
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 static void percpu_timer_stop(void);
 
+int __attribute__((weak)) platform_cpu_kill(unsigned int cpu)
+{
+	if (soc_smp_ops && soc_smp_ops->cpu_kill)
+		return soc_smp_ops->cpu_kill(cpu);
+	return 0;
+}
+
+void __attribute__((weak)) platform_cpu_die(unsigned int cpu)
+{
+	if (soc_smp_ops && soc_smp_ops->cpu_die)
+		soc_smp_ops->cpu_die(cpu);
+}
+
+int __attribute__((weak)) platform_cpu_disable(unsigned int cpu)
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
1.7.0.4
