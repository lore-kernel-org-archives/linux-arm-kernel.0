From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 11 Jun 2012 11:54:03 -0400 (EDT)
Subject: [PATCH] ARM: formalize an IPI for CPU wake-ups
Message-ID: <alpine.LFD.2.02.1206111152190.23555@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Many CPUs are implementing power saving states via the WFI mode.
In some cases, WFI must be entered in order to suspend, or even reset,
a CPU.

Whether a CPU needs to be awaken, brought out of WFI during secondary
boot, or to cancel a reset state before it is effective, the CPU must
receive an interrupt to exit its WFI state.

Let's formalize an IPI number for this purpose, and move over existing
users over to a convenience function for it.

This also has the side effect of removing the spurious "Unknown IPI
message 1" each time a CPU is awaken.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index ae29293270..5b1ddd6ca5 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -90,6 +90,8 @@ extern void platform_cpu_die(unsigned int cpu);
 extern int platform_cpu_kill(unsigned int cpu);
 extern void platform_cpu_enable(unsigned int cpu);
 
+extern void arm_send_ping_ipi(int cpu);
+
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 2c7217d971..f0a060651d 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -51,7 +51,8 @@
 struct secondary_data secondary_data;
 
 enum ipi_msg_type {
-	IPI_TIMER = 2,
+	IPI_PING = 1,
+	IPI_TIMER,
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_CALL_FUNC_SINGLE,
@@ -336,6 +337,11 @@ void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
 	smp_cross_call = fn;
 }
 
+void arm_send_ping_ipi(int cpu)
+{
+	smp_cross_call(cpumask_of(cpu), IPI_PING);
+}
+
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 {
 	smp_cross_call(mask, IPI_CALL_FUNC);
@@ -504,6 +510,9 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		__inc_irq_stat(cpu, ipi_irqs[ipinr - IPI_TIMER]);
 
 	switch (ipinr) {
+	case IPI_PING:
+		break;
+
 	case IPI_TIMER:
 		irq_enter();
 		ipi_timer();
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 36c3984aaa..444001c9aa 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -139,7 +139,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 		__raw_writel(virt_to_phys(exynos4_secondary_startup),
 			CPU1_BOOT_REG);
-		gic_raise_softirq(cpumask_of(cpu), 1);
+		arm_send_ping_ipi(cpu);
 
 		if (pen_release == -1)
 			break;
diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index db0117ec55..9be8bed59f 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -127,7 +127,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the boot monitor to read the system wide flags register,
 	 * and branch to the address found there.
 	 */
-	gic_raise_softirq(cpumask_of(cpu), 1);
+	arm_send_ping_ipi(cpu);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index deffbf1c96..604051c169 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -111,7 +111,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 		booted = true;
 	}
 
-	gic_raise_softirq(cpumask_of(cpu), 1);
+	arm_send_ping_ipi(cpu);
 
 	/*
 	 * Now the secondary core is starting up let it run its
diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index 6a35c4a31e..9e55c54b90 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -82,7 +82,7 @@ int __cpuinit emev2_boot_secondary(unsigned int cpu)
 	/* Tell ROM loader about our vector (in headsmp.S) */
 	emev2_set_boot_vector(__pa(shmobile_secondary_vector));
 
-	gic_raise_softirq(cpumask_of(cpu), 1);
+	arm_send_ping_ipi(cpu);
 	return 0;
 }
 
diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index 49c7db48c7..53864bd0d0 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -85,7 +85,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the boot monitor to read the system wide flags register,
 	 * and branch to the address found there.
 	 */
-	gic_raise_softirq(cpumask_of(cpu), 1);
+	arm_send_ping_ipi(cpu);
 
 	timeout = jiffies + (1 * HZ);
 	while (time_before(jiffies, timeout)) {
