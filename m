From: Zhuoyu.Zhang@freescale.com (Zhuoyu Zhang)
Date: Mon, 24 Nov 2014 13:28:09 +0800
Subject: [PATCH v2 1/2] arm: ls1: add CPU hotplug platform support
Message-ID: <1416806890-26920-1-git-send-email-Zhuoyu.Zhang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhang Zhuoyu <Zhuoyu.Zhang@freescale.com>

This implements CPU hotplug for ls1. When cpu is down, it will be put
in WFI state. When cpu is up, it will always soft reset and boots up
the same path as a cold boot.

Signed-off-by: Zhang Zhuoyu <Zhuoyu.Zhang@freescale.com>
---
 arch/arm/mach-imx/common.h  |   4 ++
 arch/arm/mach-imx/hotplug.c |  25 +++++++++
 arch/arm/mach-imx/platsmp.c | 132 +++++++++++++++++++++++++++++++++++++++-----
 arch/arm/mach-imx/src.c     |  21 +++++++
 4 files changed, 169 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 59ce8f3..f7d2be5 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -92,6 +92,7 @@ void imx_print_silicon_rev(const char *cpu, int srev);
 void imx_enable_cpu(int cpu, bool enable);
 void imx_set_cpu_jump(int cpu, void *jump_addr);
 u32 imx_get_cpu_arg(int cpu);
+u32 ls1_get_cpu_arg(int cpu);
 void imx_set_cpu_arg(int cpu, u32 arg);
 #ifdef CONFIG_SMP
 void v7_secondary_startup(void);
@@ -134,6 +135,9 @@ void imx6sl_pm_init(void);
 void imx6sx_pm_init(void);
 void imx6q_pm_set_ccm_base(void __iomem *base);
 
+extern void ls1021a_cpu_die(unsigned int cpu);
+extern int ls1021a_cpu_kill(unsigned int cpu);
+
 #ifdef CONFIG_PM
 void imx51_pm_init(void);
 void imx53_pm_init(void);
diff --git a/arch/arm/mach-imx/hotplug.c b/arch/arm/mach-imx/hotplug.c
index b35e99c..2ee5e46 100644
--- a/arch/arm/mach-imx/hotplug.c
+++ b/arch/arm/mach-imx/hotplug.c
@@ -14,6 +14,7 @@
 #include <linux/jiffies.h>
 #include <asm/cp15.h>
 #include <asm/proc-fns.h>
+#include <asm/cacheflush.h>
 
 #include "common.h"
 
@@ -68,3 +69,27 @@ int imx_cpu_kill(unsigned int cpu)
 	imx_set_cpu_arg(cpu, 0);
 	return 1;
 }
+
+/*
+ * For LS102x platforms, shutdowning a CPU is not supported by hardware.
+ * So we just put the offline CPU into lower-power state here.
+ */
+void __ref ls1021a_cpu_die(unsigned int cpu)
+{
+	v7_exit_coherency_flush(louis);
+
+	/* LS1021a platform can't really power down a CPU, so we
+	 * just put it into WFI state here.
+	 */
+	wfi();
+}
+
+int ls1021a_cpu_kill(unsigned int cpu)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(50);
+
+	while (!ls1_get_cpu_arg(cpu))
+		if (time_after(jiffies, timeout))
+			return 0;
+	return 1;
+}
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 7f27001..7735ebb 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -14,6 +14,7 @@
 #include <linux/of_address.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <linux/delay.h>
 
 #include <asm/cacheflush.h>
 #include <asm/page.h>
@@ -23,8 +24,24 @@
 #include "common.h"
 #include "hardware.h"
 
+#define	SCFG_CORE0_SFT_RST	0x130
+#define	SCFG_REVCR		0x200
+#define	SCFG_CORESRENCR		0x204
+#define	SCFG_SPARECR4		0x50C
+
+#define	DCFG_CCSR_BRR		0x0E4
+#define	DCFG_CCSR_SCRATCHRW1	0x200
+
+#define	DCSR_RCPM2_DEBUG1	0x400
+#define	DCSR_RCPM2_DEBUG2	0x414
+
+#define	STRIDE_4B		4
+
 u32 g_diag_reg;
 static void __iomem *scu_base;
+static void __iomem *dcfg_base;
+static void __iomem *scfg_base;
+static u32 secondary_pre_boot_entry;
 
 static struct map_desc scu_io_desc __initdata = {
 	/* .virtual and .pfn are run-time assigned */
@@ -98,32 +115,121 @@ struct smp_operations  imx_smp_ops __initdata = {
 #endif
 };
 
-#define DCFG_CCSR_SCRATCHRW1	0x200
-
-static int ls1021a_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int ls1021a_secondary_iomap(void)
 {
-	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+	struct device_node *np;
+	int ret;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,ls1021a-dcfg");
+	if (!np) {
+		pr_err("%s: failed to find dcfg node.\n", __func__);
+		ret = -EINVAL;
+		goto dcfg_err;
+	}
+
+	dcfg_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!dcfg_base) {
+		pr_err("%s: failed to map dcfg.\n", __func__);
+		ret = -ENOMEM;
+		goto dcfg_err;
+	}
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,ls1021a-scfg");
+	if (!np) {
+		pr_err("%s: failed to find scfg node.\n", __func__);
+		ret = -EINVAL;
+		goto scfg_err;
+	}
+
+	scfg_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!scfg_base) {
+		pr_err("%s: failed to map scfg.\n", __func__);
+		ret = -ENOMEM;
+		goto scfg_err;
+	}
 
 	return 0;
+
+scfg_err:
+	iounmap(dcfg_base);
+dcfg_err:
+	return ret;
 }
 
-static void __init ls1021a_smp_prepare_cpus(unsigned int max_cpus)
+void ls1021a_set_secondary_entry(void)
 {
-	struct device_node *np;
-	void __iomem *dcfg_base;
 	unsigned long paddr;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,ls1021a-dcfg");
-	dcfg_base = of_iomap(np, 0);
-	BUG_ON(!dcfg_base);
+	secondary_pre_boot_entry = readl_relaxed(dcfg_base +
+						DCFG_CCSR_SCRATCHRW1);
 
-	paddr = virt_to_phys(secondary_startup);
-	writel_relaxed(cpu_to_be32(paddr), dcfg_base + DCFG_CCSR_SCRATCHRW1);
+	if (dcfg_base) {
+		paddr = virt_to_phys(secondary_startup);
+		writel_relaxed(cpu_to_be32(paddr),
+				dcfg_base + DCFG_CCSR_SCRATCHRW1);
+	}
+}
 
-	iounmap(dcfg_base);
+static int ls1021a_reset_secondary(unsigned int cpu)
+{
+	u32 tmp;
+
+	if (!scfg_base || !dcfg_base)
+		return -ENOMEM;
+
+	writel_relaxed(secondary_pre_boot_entry,
+			dcfg_base + DCFG_CCSR_SCRATCHRW1);
+
+	/* Apply LS1021A specific to write to the BE SCFG space */
+	tmp = ioread32be(scfg_base + SCFG_REVCR);
+	iowrite32be(0xffffffff, scfg_base + SCFG_REVCR);
+
+	/* Soft reset secondary core */
+	iowrite32be(0x80000000, scfg_base + SCFG_CORESRENCR);
+	iowrite32be(0x80000000, scfg_base +
+				SCFG_CORE0_SFT_RST + STRIDE_4B * cpu);
+
+	/* Release secondary core */
+	iowrite32be(1 << cpu, dcfg_base + DCFG_CCSR_BRR);
+
+	ls1021a_set_secondary_entry();
+
+	/* Disable core soft reset register */
+	iowrite32be(0x0, scfg_base + SCFG_CORESRENCR);
+
+	/* Revert back to the default */
+	iowrite32be(tmp, scfg_base + SCFG_REVCR);
+
+	return 0;
+}
+
+static int ls1021a_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	int ret = 0;
+
+	if (system_state == SYSTEM_RUNNING)
+		ret = ls1021a_reset_secondary(cpu);
+
+	udelay(1);
+
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	return ret;
+}
+
+static void __init ls1021a_smp_prepare_cpus(unsigned int max_cpus)
+{
+	ls1021a_secondary_iomap();
+	ls1021a_set_secondary_entry();
 }
 
 struct smp_operations  ls1021a_smp_ops __initdata = {
 	.smp_prepare_cpus	= ls1021a_smp_prepare_cpus,
 	.smp_boot_secondary	= ls1021a_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die                = ls1021a_cpu_die,
+	.cpu_kill               = ls1021a_cpu_kill,
+#endif
 };
diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 45f7f4e..7bd403a 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -30,6 +30,8 @@
 #define BP_SRC_SCR_CORE1_RST		14
 #define BP_SRC_SCR_CORE1_ENABLE		22
 
+#define CCSR_TWAITSR0         0x04C
+
 static void __iomem *src_base;
 static DEFINE_SPINLOCK(scr_lock);
 
@@ -115,6 +117,25 @@ void imx_set_cpu_arg(int cpu, u32 arg)
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
+	return ioread32be(ls1_rcpm_base + CCSR_TWAITSR0) & (1 << cpu);
+}
+
 void __init imx_src_init(void)
 {
 	struct device_node *np;
-- 
2.1.0.27.g96db324
