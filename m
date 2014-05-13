From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 13 May 2014 17:44:38 +0800
Subject: [PATCH v2 3/6] ARM: hisi: enable hix5hd2 SoC
In-Reply-To: <1399974281-9737-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399974281-9737-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399974281-9737-4-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haifeng Yan <yanhaifeng@gmail.com>

Enable Hisilicon HiX5HD2 SoC. This HiX5HD2 SoC series support both
one core or dual cores. The core is Cortex A9.

Signed-off-by: Haifeng Yan <yanhaifeng@gmail.com>
Signed-off-by: Jiancheng Xue <jchxue@gmail.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-hisi/Kconfig     | 13 ++++++++--
 arch/arm/mach-hisi/Makefile    |  1 +
 arch/arm/mach-hisi/core.h      |  5 ++++
 arch/arm/mach-hisi/headsmp.S   | 36 ++++++++++++++++++++++++++
 arch/arm/mach-hisi/hisilicon.c | 14 ++++++++++
 arch/arm/mach-hisi/hotplug.c   | 58 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-hisi/platsmp.c   | 50 +++++++++++++++++++++++++++++++++---
 7 files changed, 172 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-hisi/headsmp.S

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 0a5a49d..94b7ff1 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -10,14 +10,14 @@ if ARCH_HISI
 menu "Hisilicon platform type"
 
 config ARCH_HI3xxx
-	bool "Hisilicon Hi36xx/Hi37xx family" if ARCH_MULTI_V7
+	bool "Hisilicon Hi36xx family" if ARCH_MULTI_V7
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
 	select PINCTRL_SINGLE
 	help
-	  Support for Hisilicon Hi36xx/Hi37xx SoC family
+	  Support for Hisilicon Hi36xx SoC family
 
 config ARCH_HIP04
 	bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7
@@ -28,6 +28,15 @@ config ARCH_HIP04
 	help
 	  Support for Hisilicon HiP04 SoC family
 
+config ARCH_HIX5HD2
+	bool "Hisilicon X5HD2 family" if ARCH_MULTI_V7
+	select CACHE_L2X0
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select PINCTRL
+	select PINCTRL_SINGLE
+	help
+	  Support for Hisilicon X5HD2 SoC family
 endmenu
 
 endif
diff --git a/arch/arm/mach-hisi/Makefile b/arch/arm/mach-hisi/Makefile
index e7a8640..428daf6 100644
--- a/arch/arm/mach-hisi/Makefile
+++ b/arch/arm/mach-hisi/Makefile
@@ -3,5 +3,6 @@
 #
 
 obj-y	+= hisilicon.o
+obj-$(CONFIG_ARCH_HIX5HD2)	+= headsmp.o
 obj-$(CONFIG_MCPM)		+= platmcpm.o
 obj-$(CONFIG_SMP)		+= platsmp.o hotplug.o
diff --git a/arch/arm/mach-hisi/core.h b/arch/arm/mach-hisi/core.h
index 1e60795..5d19ebe 100644
--- a/arch/arm/mach-hisi/core.h
+++ b/arch/arm/mach-hisi/core.h
@@ -14,4 +14,9 @@ extern void hi3xxx_set_cpu(int cpu, bool enable);
 
 extern bool __init hip04_smp_init_ops(void);
 
+extern void hix5hd2_secondary_startup(void);
+extern struct smp_operations hix5hd2_smp_ops;
+extern void hix5hd2_set_cpu(int cpu, bool enable);
+extern void hix5hd2_cpu_die(unsigned int cpu);
+
 #endif
diff --git a/arch/arm/mach-hisi/headsmp.S b/arch/arm/mach-hisi/headsmp.S
new file mode 100644
index 0000000..7947e91
--- /dev/null
+++ b/arch/arm/mach-hisi/headsmp.S
@@ -0,0 +1,36 @@
+/*
+ *  Copyright (c) 2014 Hisilicon Limited.
+ *  Copyright (c) 2014 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+	__CPUINIT
+
+ENTRY(hix5hd2_secondary_startup)
+
+	/* set the cpu to SVC32 mode */
+	mrs	r0, cpsr
+	bic	r0, r0, #0x1f  /* r0 = ((~0x1F) & r0) */
+	orr	r0, r0, #0xd3  /* r0 = (0xd3 | r0)    */
+	msr	cpsr, r0
+
+	/* disable MMU stuff and caches */
+	mrc	p15, 0, r0, c1, c0, 0
+	orr	r0, r0, #0x00002000      /* clear bits 13 (--V-)   */
+	bic	r0, r0, #0x00000007      /* clear bits 2:0 (-CAM)  */
+	orr	r0, r0, #0x00000002      /* set bit 1 (--A-) Align */
+	orr	r0, r0, #0x00000800      /* set bit 12 (Z---) BTB  */
+	mcr	p15, 0, r0, c1, c0, 0
+
+	/*
+	 * Invalidate L1 I/D
+	 */
+	mcr	p15, 0, r0, c8, c7, 0    /* invalidate TLBs */
+	mcr	p15, 0, r0, c7, c5, 0    /* invalidate icache */
+	bl	v7_invalidate_l1
+	b	secondary_startup
diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index a476388..8255ce6 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -26,6 +26,8 @@
 
 #define HI3620_SYSCTRL_PHYS_BASE		0xfc802000
 #define HI3620_SYSCTRL_VIRT_BASE		0xfe802000
+#define HIX5HD2_SYSCTRL_PHYS_BASE		0xf8000000
+#define HIX5HD2_SYSCTRL_VIRT_BASE		0xfe802000
 
 /*
  * This table is only for optimization. Since ioremap() could always share
@@ -106,3 +108,15 @@ DT_MACHINE_START(HIP04, "Hisilicon HiP04 (Flattened Device Tree)")
 	.smp_init	= smp_init_ops(hip04_smp_init_ops),
 MACHINE_END
 #endif
+
+static const char *hix5hd2_compat[] __initconst = {
+	"hisilicon,hix5hd2",
+	NULL,
+};
+
+DT_MACHINE_START(HIX5HD2_DT, "Hisilicon X5HD2 (Flattened Device Tree)")
+	.dt_compat	= hix5hd2_compat,
+	.init_late	= hi3xxx_init_late,
+	.smp		= smp_ops(hix5hd2_smp_ops),
+	.restart	= hi3xxx_restart,
+MACHINE_END
diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index abd441b..84e6919 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -57,6 +57,14 @@
 #define CPU0_NEON_SRST_REQ_EN		(1 << 4)
 #define CPU0_SRST_REQ_EN		(1 << 0)
 
+#define HIX5HD2_PERI_CRG20		0x50
+#define CRG20_CPU1_RESET		(1 << 17)
+
+#define HIX5HD2_PERI_PMC0		0x1000
+#define PMC0_CPU1_WAIT_MTCOMS_ACK	(1 << 8)
+#define PMC0_CPU1_PMC_ENABLE		(1 << 7)
+#define PMC0_CPU1_POWERDOWN		(1 << 3)
+
 enum {
 	HI3620_CTRL,
 	ERROR_CTRL,
@@ -157,6 +165,50 @@ void hi3xxx_set_cpu(int cpu, bool enable)
 		set_cpu_hi3620(cpu, enable);
 }
 
+static bool hix5hd2_hotplug_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "hisilicon,cpuctrl");
+	if (np) {
+		ctrl_base = of_iomap(np, 0);
+		return true;
+	}
+	return false;
+}
+
+void hix5hd2_set_cpu(int cpu, bool enable)
+{
+	u32 val = 0;
+
+	if (!ctrl_base)
+		if (!hix5hd2_hotplug_init())
+			BUG();
+
+	if (enable) {
+		/* power on cpu1 */
+		val = readl_relaxed(ctrl_base + HIX5HD2_PERI_PMC0);
+		val &= ~(PMC0_CPU1_WAIT_MTCOMS_ACK | PMC0_CPU1_POWERDOWN);
+		val |= PMC0_CPU1_PMC_ENABLE;
+		writel_relaxed(val, ctrl_base + HIX5HD2_PERI_PMC0);
+		/* unreset */
+		val = readl_relaxed(ctrl_base + HIX5HD2_PERI_CRG20);
+		val &= ~CRG20_CPU1_RESET;
+		writel_relaxed(val, ctrl_base + HIX5HD2_PERI_CRG20);
+	} else {
+		/* power down cpu1 */
+		val = readl_relaxed(ctrl_base + HIX5HD2_PERI_PMC0);
+		val |= PMC0_CPU1_PMC_ENABLE | PMC0_CPU1_POWERDOWN;
+		val &= ~PMC0_CPU1_WAIT_MTCOMS_ACK;
+		writel_relaxed(val, ctrl_base + HIX5HD2_PERI_PMC0);
+
+		/* reset */
+		val = readl_relaxed(ctrl_base + HIX5HD2_PERI_CRG20);
+		val |= CRG20_CPU1_RESET;
+		writel_relaxed(val, ctrl_base + HIX5HD2_PERI_CRG20);
+	}
+}
+
 static inline void cpu_enter_lowpower(void)
 {
 	unsigned int v;
@@ -199,4 +251,10 @@ int hi3xxx_cpu_kill(unsigned int cpu)
 	hi3xxx_set_cpu(cpu, false);
 	return 1;
 }
+
+void hix5hd2_cpu_die(unsigned int cpu)
+{
+	flush_cache_all();
+	hix5hd2_set_cpu(cpu, false);
+}
 #endif
diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index 471f1ee..ecf7058 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -17,6 +17,8 @@
 
 #include "core.h"
 
+#define HIX5HD2_BOOT_ADDRESS		0xffff0000
+
 static void __iomem *ctrl_base;
 
 void hi3xxx_set_cpu_jump(int cpu, void *jump_addr)
@@ -35,11 +37,9 @@ int hi3xxx_get_cpu_jump(int cpu)
 	return readl_relaxed(ctrl_base + ((cpu - 1) << 2));
 }
 
-static void __init hi3xxx_smp_prepare_cpus(unsigned int max_cpus)
+static void __init hisi_enable_scu_a9(void)
 {
-	struct device_node *np = NULL;
 	unsigned long base = 0;
-	u32 offset = 0;
 	void __iomem *scu_base = NULL;
 
 	if (scu_a9_has_base()) {
@@ -52,6 +52,14 @@ static void __init hi3xxx_smp_prepare_cpus(unsigned int max_cpus)
 		scu_enable(scu_base);
 		iounmap(scu_base);
 	}
+}
+
+static void __init hi3xxx_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *np = NULL;
+	u32 offset = 0;
+
+	hisi_enable_scu_a9();
 	if (!ctrl_base) {
 		np = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
 		if (!np) {
@@ -87,3 +95,39 @@ struct smp_operations hi3xxx_smp_ops __initdata = {
 	.cpu_kill		= hi3xxx_cpu_kill,
 #endif
 };
+
+static void __init hix5hd2_smp_prepare_cpus(unsigned int max_cpus)
+{
+	hisi_enable_scu_a9();
+}
+
+void hix5hd2_set_scu_boot_addr(phys_addr_t start_addr, phys_addr_t jump_addr)
+{
+	void __iomem *virt;
+
+	virt = ioremap(start_addr, PAGE_SIZE);
+
+	writel_relaxed(0xe51ff004, virt);	/* ldr pc, [rc, #-4] */
+	writel_relaxed(jump_addr, virt + 4);	/* pc jump phy address */
+	iounmap(virt);
+}
+
+static int hix5hd2_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	phys_addr_t jumpaddr;
+
+	jumpaddr = virt_to_phys(hix5hd2_secondary_startup);
+	hix5hd2_set_scu_boot_addr(HIX5HD2_BOOT_ADDRESS, jumpaddr);
+	hix5hd2_set_cpu(cpu, true);
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+	return 0;
+}
+
+
+struct smp_operations hix5hd2_smp_ops __initdata = {
+	.smp_prepare_cpus	= hix5hd2_smp_prepare_cpus,
+	.smp_boot_secondary	= hix5hd2_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= hix5hd2_cpu_die,
+#endif
+};
-- 
1.9.1
