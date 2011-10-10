From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 10 Oct 2011 15:02:22 +0100
Subject: [PATCH v5 10/10] ARM: smp: Make SoC descriptor mandatory for SMP
	platforms
In-Reply-To: <1318255342-17451-1-git-send-email-marc.zyngier@arm.com>
References: <1318255342-17451-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1318255342-17451-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all SMP platforms have been converted to the SOC descriptor
and its SMP operations, remove the "weak" attribute from the hooks
in smp.c, and make the functions static wherever possible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/smp.h |   15 ---------------
 arch/arm/kernel/smp.c      |   18 +++++++++---------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 674ebcd..bf25484 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -56,16 +56,6 @@ extern int boot_secondary(unsigned int cpu, struct task_struct *);
 asmlinkage void secondary_start_kernel(void);
 
 /*
- * Perform platform specific initialisation of the specified CPU.
- */
-extern void platform_secondary_init(unsigned int cpu);
-
-/*
- * Initialize cpu_possible map, and enable coherency
- */
-extern void platform_smp_prepare_cpus(unsigned int);
-
-/*
  * Logical CPU mapping.
  */
 extern int __cpu_logical_map[NR_CPUS];
@@ -82,15 +72,10 @@ struct secondary_data {
 extern struct secondary_data secondary_data;
 
 extern int __cpu_disable(void);
-extern int platform_cpu_disable(unsigned int cpu);
 
 extern void __cpu_die(unsigned int cpu);
 extern void cpu_die(void);
 
-extern void platform_cpu_die(unsigned int cpu);
-extern int platform_cpu_kill(unsigned int cpu);
-extern void platform_cpu_enable(unsigned int cpu);
-
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index f7a9add..c256dd9 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -179,25 +179,25 @@ void __init soc_smp_ops_register(struct arm_soc_smp_init_ops *smp_init_ops,
 	}
 }
 
-void __attribute__((weak)) __init smp_init_cpus(void)
+void __init smp_init_cpus(void)
 {
 	if (soc_smp_init_ops && soc_smp_init_ops->smp_init_cpus)
 		soc_smp_init_ops->smp_init_cpus();
 }
 
-void __attribute__((weak)) __init platform_smp_prepare_cpus(unsigned int max_cpus)
+static void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 {
 	if (soc_smp_ops && soc_smp_init_ops->smp_prepare_cpus)
 		soc_smp_init_ops->smp_prepare_cpus(max_cpus);
 }
 
-void __attribute__((weak)) __cpuinit platform_secondary_init(unsigned int cpu)
+static void __cpuinit platform_secondary_init(unsigned int cpu)
 {
 	if (soc_smp_ops && soc_smp_ops->smp_secondary_init)
 		soc_smp_ops->smp_secondary_init(cpu);
 }
 
-int __attribute__((weak)) __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	if (soc_smp_ops && soc_smp_ops->smp_boot_secondary)
 		return soc_smp_ops->smp_boot_secondary(cpu, idle);
@@ -207,20 +207,20 @@ int __attribute__((weak)) __cpuinit boot_secondary(unsigned int cpu, struct task
 #ifdef CONFIG_HOTPLUG_CPU
 static void percpu_timer_stop(void);
 
-int __attribute__((weak)) __cpuinit platform_cpu_kill(unsigned int cpu)
+static int __cpuinit platform_cpu_kill(unsigned int cpu)
 {
 	if (soc_smp_ops && soc_smp_ops->cpu_kill)
 		return soc_smp_ops->cpu_kill(cpu);
 	return 0;
 }
 
-void __attribute__((weak)) __cpuinit platform_cpu_die(unsigned int cpu)
+static void __cpuinit platform_cpu_die(unsigned int cpu)
 {
 	if (soc_smp_ops && soc_smp_ops->cpu_die)
 		soc_smp_ops->cpu_die(cpu);
 }
 
-int __attribute__((weak)) __cpuinit platform_cpu_disable(unsigned int cpu)
+static int __cpuinit platform_cpu_disable(unsigned int cpu)
 {
 	if (soc_smp_ops && soc_smp_ops->cpu_disable)
 		return soc_smp_ops->cpu_disable(cpu);
@@ -230,7 +230,7 @@ int __attribute__((weak)) __cpuinit platform_cpu_disable(unsigned int cpu)
 /*
  * __cpu_disable runs on the processor to be shutdown.
  */
-int __cpu_disable(void)
+int __cpuinit __cpu_disable(void)
 {
 	unsigned int cpu = smp_processor_id();
 	struct task_struct *p;
@@ -279,7 +279,7 @@ static DECLARE_COMPLETION(cpu_died);
  * called on the thread which is asking for a CPU to be shutdown -
  * waits until shutdown has completed, or it is timed out.
  */
-void __cpu_die(unsigned int cpu)
+void __cpuinit __cpu_die(unsigned int cpu)
 {
 	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
 		pr_err("CPU%u: cpu didn't die\n", cpu);
-- 
1.7.0.4
