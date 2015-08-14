From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 14 Aug 2015 00:58:59 -0700
Subject: [PATCH] ARM: smp: Collapse arch_cpu_idle_dead() into cpu_die()
Message-ID: <1439539139-8783-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only caller of cpu_die() on ARM is arch_cpu_idle_dead(), so
let's simplify the code by renaming cpu_die() to
arch_cpu_idle_dead(). While were here, drop the __ref annotation
because __cpuinit is gone nowadays.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/include/asm/smp.h | 1 -
 arch/arm/kernel/process.c  | 7 -------
 arch/arm/kernel/smp.c      | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 318ce89eeff7..ef356659b4f4 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -74,7 +74,6 @@ extern void secondary_startup_arm(void);
 extern int __cpu_disable(void);
 
 extern void __cpu_die(unsigned int cpu);
-extern void cpu_die(void);
 
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index f192a2a41719..358984b7f249 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -91,13 +91,6 @@ void arch_cpu_idle_exit(void)
 	ledtrig_cpu(CPU_LED_IDLE_END);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
-void arch_cpu_idle_dead(void)
-{
-	cpu_die();
-}
-#endif
-
 void __show_regs(struct pt_regs *regs)
 {
 	unsigned long flags;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 0496b481ad88..48185a773852 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -268,7 +268,7 @@ void __cpu_die(unsigned int cpu)
  * of the other hotplug-cpu capable cores, so presumably coming
  * out of idle fixes this.
  */
-void __ref cpu_die(void)
+void arch_cpu_idle_dead(void)
 {
 	unsigned int cpu = smp_processor_id();
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
