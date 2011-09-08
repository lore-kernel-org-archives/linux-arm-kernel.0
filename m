From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  8 Sep 2011 18:00:11 +0100
Subject: [RFC PATCH 2/3] ARM: SoC: Add per SoC SMP and CPU hotplug operations
In-Reply-To: <1315501212-1820-1-git-send-email-marc.zyngier@arm.com>
References: <1315501212-1820-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1315501212-1820-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate the SoC descriptor structure with the SMP and CPU hotplug
operations. To allow the kernel to continue building, the platform
hooks are defined as weak symbols which are overrided by the
platform code. Once all platforms are converted, the "weak" attribute
will be removed and the function made static.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/soc.h |   17 +++++++++++++++
 arch/arm/kernel/smp.c      |   48 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/soc.h b/arch/arm/include/asm/soc.h
index d9a6671..caaedf9 100644
--- a/arch/arm/include/asm/soc.h
+++ b/arch/arm/include/asm/soc.h
@@ -12,8 +12,25 @@
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
+	struct arm_soc_smp_ops	smp_ops;
+#endif
 };
 
 extern struct arm_soc_desc	*soc_desc;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index faa524b..3f17a93 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -28,6 +28,7 @@
 #include <linux/completion.h>
 
 #include <linux/atomic.h>
+#include <asm/soc.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -154,7 +155,54 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	return ret;
 }
 
+/* SoC helpers */
+void __attribute__((weak)) smp_init_cpus(void)
+{
+	if (soc_desc->smp_ops.smp_init_cpus)
+		soc_desc->smp_ops.smp_init_cpus();
+}
+
+void __attribute__((weak)) platform_smp_prepare_cpus(unsigned int max_cpus)
+{
+	if (soc_desc->smp_ops.smp_prepare_cpus)
+		soc_desc->smp_ops.smp_prepare_cpus(max_cpus);
+}
+
+void __attribute__((weak)) platform_secondary_init(unsigned int cpu)
+{
+	if (soc_desc->smp_ops.smp_secondary_init)
+		soc_desc->smp_ops.smp_secondary_init(cpu);
+}
+
+int __attribute__((weak)) boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	if (soc_desc->smp_ops.smp_boot_secondary)
+		return soc_desc->smp_ops.smp_boot_secondary(cpu, idle);
+	return -ENOSYS;
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
+
+int __attribute__((weak)) platform_cpu_kill(unsigned int cpu)
+{
+	if (soc_desc->smp_ops.cpu_kill)
+		return soc_desc->smp_ops.cpu_kill(cpu);
+	return 0;
+}
+
+void __attribute__((weak)) platform_cpu_die(unsigned int cpu)
+{
+	if (soc_desc->smp_ops.cpu_die)
+		soc_desc->smp_ops.cpu_die(cpu);
+}
+
+int __attribute__((weak)) platform_cpu_disable(unsigned int cpu)
+{
+	if (soc_desc->smp_ops.cpu_disable)
+		return soc_desc->smp_ops.cpu_disable(cpu);
+	return -EPERM;
+}
+
 /*
  * __cpu_disable runs on the processor to be shutdown.
  */
-- 
1.7.0.4
