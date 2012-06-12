From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Jun 2012 13:30:54 +0100
Subject: [PATCH v8 11/13] ARM: convert spear13xx to smp_ops
In-Reply-To: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
References: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1339504256-11266-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the spear13xx platforms to use the smp_ops to provide
their SMP and CPU hotplug operations.

Cc: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-spear13xx/hotplug.c              |    6 +++---
 arch/arm/mach-spear13xx/include/mach/generic.h |    7 +++++++
 arch/arm/mach-spear13xx/platsmp.c              |   16 ++++++++++++----
 arch/arm/mach-spear13xx/spear1310.c            |    1 +
 arch/arm/mach-spear13xx/spear1340.c            |    1 +
 5 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-spear13xx/hotplug.c b/arch/arm/mach-spear13xx/hotplug.c
index 5c6867b..e8fa26d 100644
--- a/arch/arm/mach-spear13xx/hotplug.c
+++ b/arch/arm/mach-spear13xx/hotplug.c
@@ -79,7 +79,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 	}
 }
 
-int platform_cpu_kill(unsigned int cpu)
+int spear13xx_cpu_kill(unsigned int cpu)
 {
 	return 1;
 }
@@ -89,7 +89,7 @@ int platform_cpu_kill(unsigned int cpu)
  *
  * Called with IRQs disabled
  */
-void __cpuinit platform_cpu_die(unsigned int cpu)
+void __cpuinit spear13xx_cpu_die(unsigned int cpu)
 {
 	int spurious = 0;
 
@@ -109,7 +109,7 @@ void __cpuinit platform_cpu_die(unsigned int cpu)
 		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
 }
 
-int platform_cpu_disable(unsigned int cpu)
+int spear13xx_cpu_disable(unsigned int cpu)
 {
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 6d8c45b..1fea357 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -16,6 +16,7 @@
 
 #include <linux/dmaengine.h>
 #include <asm/mach/time.h>
+#include <asm/smp_ops.h>
 
 /* Add spear13xx structure declarations here */
 extern struct sys_timer spear13xx_timer;
@@ -46,4 +47,10 @@ void __init spear1340_clk_init(void);
 static inline void spear1340_clk_init(void) {}
 #endif
 
+extern int spear13xx_cpu_disable(unsigned int cpu);
+extern void spear13xx_cpu_die(unsigned int cpu);
+extern int spear13xx_cpu_kill(unsigned int cpu);
+
+extern struct smp_ops spear13xx_smp_ops;
+
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear13xx/platsmp.c b/arch/arm/mach-spear13xx/platsmp.c
index f5d07f2..742653c 100644
--- a/arch/arm/mach-spear13xx/platsmp.c
+++ b/arch/arm/mach-spear13xx/platsmp.c
@@ -18,7 +18,9 @@
 #include <asm/cacheflush.h>
 #include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
+#include <asm/smp_ops.h>
 #include <mach/spear.h>
+#include <mach/generic.h>
 
 /*
  * control for which core is the next to come out of the secondary
@@ -30,7 +32,7 @@ static DEFINE_SPINLOCK(boot_lock);
 static void __iomem *scu_base = IOMEM(VA_SCU_BASE);
 extern void spear13xx_secondary_startup(void);
 
-void __cpuinit platform_secondary_init(unsigned int cpu)
+void __cpuinit spear13xx_secondary_init(unsigned int cpu)
 {
 	/*
 	 * if any interrupts are already enabled for the primary
@@ -53,7 +55,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+int __cpuinit spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 
@@ -97,7 +99,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
  * Initialise the CPU possible map early - this describes the CPUs
  * which may be present or become present in the system.
  */
-void __init smp_init_cpus(void)
+void __init spear13xx_smp_init_cpus(void)
 {
 	unsigned int i, ncores = scu_get_core_count(scu_base);
 
@@ -113,7 +115,7 @@ void __init smp_init_cpus(void)
 	set_smp_cross_call(gic_raise_softirq);
 }
 
-void __init platform_smp_prepare_cpus(unsigned int max_cpus)
+void __init spear13xx_smp_prepare_cpus(unsigned int max_cpus)
 {
 
 	scu_enable(scu_base);
@@ -125,3 +127,9 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 */
 	__raw_writel(virt_to_phys(spear13xx_secondary_startup), SYS_LOCATION);
 }
+
+struct smp_ops spear13xx_smp_ops __initdata = {
+	smp_init_ops(spear13xx)
+	smp_secondary_ops(spear13xx)
+	smp_hotplug_ops(spear13xx)
+};
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
index fefd15b..d72f695 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -78,6 +78,7 @@ static void __init spear1310_map_io(void)
 }
 
 DT_MACHINE_START(SPEAR1310_DT, "ST SPEAr1310 SoC with Flattened Device Tree")
+	smp_ops(spear13xx_smp_ops)
 	.map_io		=	spear1310_map_io,
 	.init_irq	=	spear13xx_dt_init_irq,
 	.handle_irq	=	gic_handle_irq,
diff --git a/arch/arm/mach-spear13xx/spear1340.c b/arch/arm/mach-spear13xx/spear1340.c
index ee38cbc..7e2e709 100644
--- a/arch/arm/mach-spear13xx/spear1340.c
+++ b/arch/arm/mach-spear13xx/spear1340.c
@@ -182,6 +182,7 @@ static const char * const spear1340_dt_board_compat[] = {
 };
 
 DT_MACHINE_START(SPEAR1340_DT, "ST SPEAr1340 SoC with Flattened Device Tree")
+	smp_ops(spear13xx_smp_ops)
 	.map_io		=	spear13xx_map_io,
 	.init_irq	=	spear13xx_dt_init_irq,
 	.handle_irq	=	gic_handle_irq,
-- 
1.7.10.3
