From: chenhui.zhao@freescale.com (Chenhui Zhao)
Date: Fri, 26 Sep 2014 19:25:01 +0800
Subject: [PATCH 1/3] arm: ls1: add CPU hotplug platform support
In-Reply-To: <1411730703-25836-1-git-send-email-chenhui.zhao@freescale.com>
References: <1411730703-25836-1-git-send-email-chenhui.zhao@freescale.com>
Message-ID: <1411730703-25836-2-git-send-email-chenhui.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhang Zhuoyu <Zhuoyu.Zhang@freescale.com>

This implements CPU hotplug for ls1. When cpu is down, it will be put
in WFI state. When cpu is up, it will be waked by a IPI interrupt and
reinitialized.

Signed-off-by: Zhang Zhuoyu <Zhuoyu.Zhang@freescale.com>
Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
---
 arch/arm/mach-imx/common.h  |    4 ++
 arch/arm/mach-imx/hotplug.c |   90 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/platsmp.c |   22 ++++++++--
 arch/arm/mach-imx/src.c     |   21 ++++++++++
 4 files changed, 132 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 203ee73..2ca32fe 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -115,6 +115,7 @@ void tzic_handle_irq(struct pt_regs *);
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
 extern u32 imx_get_cpu_arg(int cpu);
+extern u32 ls1_get_cpu_arg(int cpu);
 extern void imx_set_cpu_arg(int cpu, u32 arg);
 extern void v7_cpu_resume(void);
 #ifdef CONFIG_SMP
@@ -145,6 +146,9 @@ extern void imx6q_set_chicken_bit(void);
 extern void imx_cpu_die(unsigned int cpu);
 extern int imx_cpu_kill(unsigned int cpu);
 
+extern void ls1021a_cpu_die(unsigned int cpu);
+extern int ls1021a_cpu_kill(unsigned int cpu);
+
 #ifdef CONFIG_PM
 extern void imx6q_pm_init(void);
 extern void imx5_pm_init(void);
diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
index 3daf1ed..646034f 100644
--- a/arch/arm/mach-imx/hotplug.c
+++ b/arch/arm/mach-imx/hotplug.c
@@ -14,6 +14,9 @@
 #include <linux/jiffies.h>
 #include <asm/cp15.h>
 #include <asm/proc-fns.h>
+#include<asm/smp.h>
+#include<asm/smp_plat.h>
+#include<asm/cacheflush.h>
 
 #include "common.h"
 
@@ -38,6 +41,22 @@ static inline void cpu_enter_lowpower(void)
 	  : "cc");
 }
 
+static inline void cpu_leave_lowpower(void)
+{
+	unsigned int v;
+
+	asm volatile(
+	"	mrc     p15, 0, %0, c1, c0, 0\n"
+	"       orr     %0, %0, %1\n"
+	"       mcr     p15, 0, %0, c1, c0, 0\n"
+	"       mrc     p15, 0, %0, c1, c0, 1\n"
+	"       orr     %0, %0, %2\n"
+	"       mcr     p15, 0, %0, c1, c0, 1\n"
+	: "=&r" (v)
+	: "Ir" (CR_C), "Ir" (0x40)
+	: "cc");
+}
+
 /*
  * platform-specific code to shutdown a CPU
  *
@@ -66,3 +85,74 @@ int imx_cpu_kill(unsigned int cpu)
 	imx_set_cpu_arg(cpu, 0);
 	return 1;
 }
+
+static inline void ls1_do_lowpower(unsigned int cpu, int *spurious)
+{
+	/*
+	 * there is no power-control hardware on this platform, so all
+	 * we can do is put the core into WFI; this is safe as the calling
+	 * code will have already disabled interrupts
+	 */
+	for (;;) {
+		wfi();
+
+		if (pen_release == cpu_logical_map(cpu)) {
+			/*OK, proper wakeup, we're done*/
+			break;
+		}
+
+		/*
+		 * Getting here, means that we have come out of WFI without
+		 * having been woken up - this shouldn't happen
+		 *
+		 * Just note it happening - when we're woken, we can report
+		 * its occurrence.
+		 */
+		(*spurious)++;
+	}
+}
+
+/*
+ * platform-specific code to shutdown a CPU
+ *
+ * Called with IRQs disabled
+ */
+void __ref ls1021a_cpu_die(unsigned int cpu)
+{
+	int spurious = 0;
+
+	v7_exit_coherency_flush(louis);
+
+	/*we're ready for shutdown now, so do it*/
+	ls1_do_lowpower(cpu, &spurious);
+
+	/*
+	 * bring this CPU back into the world of cache
+	 * coherency, and then restore interrupts
+	 */
+	cpu_leave_lowpower();
+
+	if (spurious)
+		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
+
+	/*
+	 * Do not return to the idle loop - jump back to the secondary
+	 * cpu initialisation.  There's some initialisation which needs
+	 * to be repeated to undo the effects of taking the CPU offline.
+	 */
+	__asm__("mov    sp, %0\n"
+	"       mov     fp, #0\n"
+	"       b       ls1021a_secondary_startup"
+	:
+	: "r" (task_stack_page(current) + THREAD_SIZE - 8));
+}
+
+int ls1021a_cpu_kill(unsigned int cpu)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(50);
+
+	while (ls1_get_cpu_arg(cpu))
+		if (time_after(jiffies, timeout))
+			return 0;
+	return 1;
+}
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 5225b69..d262b32 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -29,6 +29,7 @@
 
 u32 g_diag_reg;
 static void __iomem *scu_base;
+void __iomem *dcfg_base;
 
 static struct map_desc scu_io_desc __initdata = {
 	/* .virtual and .pfn are run-time assigned */
@@ -196,19 +197,26 @@ static void __init ls1021a_smp_init_cpus(void)
 		set_cpu_possible(i, false);
 }
 
+void ls1021a_set_secondary_entry(void)
+{
+	unsigned long paddr;
+
+	if (dcfg_base) {
+		paddr = virt_to_phys(ls1021a_secondary_startup);
+		writel_relaxed(cpu_to_be32(paddr),
+				dcfg_base + DCFG_CCSR_SCRATCHRW1);
+	}
+}
+
 static void __init ls1021a_smp_prepare_cpus(unsigned int max_cpus)
 {
 	struct device_node *np;
-	void __iomem *dcfg_base;
-	unsigned long paddr;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,ls1021a-dcfg");
 	dcfg_base = of_iomap(np, 0);
 	WARN_ON(!dcfg_base);
 
-	paddr = virt_to_phys(ls1021a_secondary_startup);
-	writel_relaxed(cpu_to_be32(paddr), dcfg_base + DCFG_CCSR_SCRATCHRW1);
-
+	ls1021a_set_secondary_entry();
 }
 
 struct smp_operations  ls1021a_smp_ops __initdata = {
@@ -216,4 +224,8 @@ struct smp_operations  ls1021a_smp_ops __initdata = {
 	.smp_prepare_cpus	= ls1021a_smp_prepare_cpus,
 	.smp_boot_secondary	= ls1021a_boot_secondary,
 	.smp_secondary_init	= ls1021a_secondary_init,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die                = ls1021a_cpu_die,
+	.cpu_kill               = ls1021a_cpu_kill,
+#endif
 };
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 10a6b1a..49508d6 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -30,6 +30,8 @@
 #define BP_SRC_SCR_CORE1_RST		14
 #define BP_SRC_SCR_CORE1_ENABLE		22
 
+#define CCSR_TWAITSR0         0x04C
+
 static void __iomem *src_base;
 static DEFINE_SPINLOCK(scr_lock);
 
@@ -114,6 +116,25 @@ void imx_set_cpu_arg(int cpu, u32 arg)
 	writel_relaxed(arg, src_base + SRC_GPR1 + cpu * 8 + 4);
 }
 
+u32 ls1_get_cpu_arg(int cpu)
+{
+	struct device_node *np;
+	void __iomem *ls1_rcpm_base;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qoriq-rcpm-2.1");
+	if (!np) {
+		pr_err("%s(): Can not find the RCPM node.\n", __func__);
+		return -ENODEV;
+	}
+
+	ls1_rcpm_base = of_iomap(np, 0);
+	of_node_put(np);
+	WARN_ON(!ls1_rcpm_base);
+
+	cpu = cpu_logical_map(cpu);
+	return readl_relaxed(ls1_rcpm_base + CCSR_TWAITSR0) & (1 << cpu);
+}
+
 void imx_src_prepare_restart(void)
 {
 	u32 val;
-- 
1.7.3
