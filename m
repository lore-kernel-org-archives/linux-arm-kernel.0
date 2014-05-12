From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 12 May 2014 09:30:34 +0800
Subject: [PATCH 3/5] ARM: hisi: Add hix5hd2 SoC support.
In-Reply-To: <1399858236-29027-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399858236-29027-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399858236-29027-4-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haifeng Yan <yanhaifeng@gmail.com>

Add SoC support for Hisilicon x5hd2 SoC.

Signed-off-by: Haifeng Yan <yanhaifeng@gmail.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-hisi/Makefile    |  1 +
 arch/arm/mach-hisi/core.h      |  3 ++
 arch/arm/mach-hisi/headsmp.S   | 39 +++++++++++++++++++++++
 arch/arm/mach-hisi/hisilicon.c | 31 +++++++++++++++++++
 arch/arm/mach-hisi/hotplug.c   | 36 ++++++++++++++++++++++
 arch/arm/mach-hisi/platsmp.c   | 70 ++++++++++++++++++++++++++++++++++++++++--
 6 files changed, 177 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-hisi/headsmp.S

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
index 1e60795..be15620 100644
--- a/arch/arm/mach-hisi/core.h
+++ b/arch/arm/mach-hisi/core.h
@@ -13,5 +13,8 @@ extern int hi3xxx_cpu_kill(unsigned int cpu);
 extern void hi3xxx_set_cpu(int cpu, bool enable);
 
 extern bool __init hip04_smp_init_ops(void);
+extern void hix5hd2_secondary_startup(void);
+extern struct smp_operations hix5hd2_smp_ops;
+extern void hix5hd2_set_cpu(int cpu, bool enable);
 
 #endif
diff --git a/arch/arm/mach-hisi/headsmp.S b/arch/arm/mach-hisi/headsmp.S
new file mode 100644
index 0000000..c4b2a95
--- /dev/null
+++ b/arch/arm/mach-hisi/headsmp.S
@@ -0,0 +1,39 @@
+/*
+ *
+ * arch/arm/mach-hisi/headsmp.S
+ *
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
index 6489e57..deaac5b 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -26,6 +26,8 @@
 
 #define HI3620_SYSCTRL_PHYS_BASE		0xfc802000
 #define HI3620_SYSCTRL_VIRT_BASE		0xfe802000
+#define HIX5HD2_SYSCTRL_PHYS_BASE		0xf8000000
+#define HIX5HD2_SYSCTRL_VIRT_BASE		0xfe802000
 
 /*
  * This table is only for optimization. Since ioremap() could always share
@@ -45,6 +47,16 @@ static struct map_desc hi3620_io_desc[] __initdata = {
 	},
 };
 
+static struct map_desc hix5hd2_io_desc[] __initdata = {
+	{
+		/* sysctrl */
+		.pfn		= __phys_to_pfn(HIX5HD2_SYSCTRL_PHYS_BASE),
+		.virtual	= HIX5HD2_SYSCTRL_VIRT_BASE,
+		.length		= 0x1000,
+		.type		= MT_DEVICE,
+	},
+};
+
 static void __init hi3620_map_io(void)
 {
 	debug_ll_io_init();
@@ -100,3 +112,22 @@ DT_MACHINE_START(HIP04, "Hisilicon HiP04 (Flattened Device Tree)")
 	.smp_init	= smp_init_ops(hip04_smp_init_ops),
 MACHINE_END
 #endif
+
+static void __init hix5hd2_map_io(void)
+{
+	debug_ll_io_init();
+	iotable_init(hix5hd2_io_desc, ARRAY_SIZE(hix5hd2_io_desc));
+}
+
+/* hix5hd2 series */
+static const char *hix5hd2_compat[] __initconst = {
+	"hisilicon,hix5hd2-dkb",
+	NULL,
+};
+
+DT_MACHINE_START(HIX5HD2_DT, "Hisilicon X5HD2 (Flattened Device Tree)")
+	.map_io		= hix5hd2_map_io,
+	.dt_compat	= hix5hd2_compat,
+	.smp		= smp_ops(hix5hd2_smp_ops),
+	.restart	= hi3xxx_restart,
+MACHINE_END
diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index abd441b..8599f57 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -57,6 +57,9 @@
 #define CPU0_NEON_SRST_REQ_EN		(1 << 4)
 #define CPU0_SRST_REQ_EN		(1 << 0)
 
+#define HIX5HD2_PERI_CRG20		0x50
+#define CRG20_CPU1_RESET		(1 << 17)
+
 enum {
 	HI3620_CTRL,
 	ERROR_CTRL,
@@ -157,6 +160,39 @@ void hi3xxx_set_cpu(int cpu, bool enable)
 		set_cpu_hi3620(cpu, enable);
 }
 
+void hix5hd2_set_cpu(int cpu, bool enable)
+{
+	u32 val = 0;
+
+	if (!ctrl_base)
+		BUG();
+
+	if (enable) {
+		/* power on cpu1 */
+		val = readl_relaxed(ctrl_base + 0x1000);
+		val &=  ~(0x1 << 8);
+		val |= (0x1 << 7);
+		val &= ~(0x1 << 3);
+		writel_relaxed(val, ctrl_base + 0x1000);
+		/* unreset */
+		val = readl_relaxed(ctrl_base + HIX5HD2_PERI_CRG20);
+		val &= ~CRG20_CPU1_RESET;
+		writel_relaxed(val, ctrl_base + HIX5HD2_PERI_CRG20);
+	} else {
+		/* power down cpu1 */
+		val = readl_relaxed(ctrl_base + 0x1000);
+		val &=  ~(0x1 << 8);
+		val |= (0x1 << 7);
+		val |= (0x1 << 3);
+		writel_relaxed(val, ctrl_base + 0x1000);
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
diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index 471f1ee..3f83921 100644
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
@@ -87,3 +95,59 @@ struct smp_operations hi3xxx_smp_ops __initdata = {
 	.cpu_kill		= hi3xxx_cpu_kill,
 #endif
 };
+
+static void __init hix5hd2_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *np = NULL;
+
+	hisi_enable_scu_a9();
+
+	if (ctrl_base)
+		return;
+	np = of_find_compatible_node(NULL, NULL, "hisilicon,cpuctrl");
+	if (np) {
+		ctrl_base = of_iomap(np, 0);
+		if (!ctrl_base) {
+			pr_err("failed to map address\n");
+			return;
+		}
+	}
+}
+
+
+/*
+ * copy startup code to sram, and flash cache.
+ * @start_addr: slave start phy address
+ * @jump_addr: slave jump phy address
+ */
+void hix5hd2_set_scu_boot_addr(unsigned int start_addr, unsigned int jump_addr)
+{
+	void __iomem *virt;
+
+	virt = ioremap(start_addr, PAGE_SIZE);
+
+	*(unsigned int *)virt++ = 0xe51ff004; /* ldr  pc, [pc, #-4] */
+	*(unsigned int *)virt++ = jump_addr;  /* pc jump phy address */
+	iounmap(virt);
+}
+
+static int hix5hd2_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned int jumpaddr;
+
+	jumpaddr = (unsigned int)virt_to_phys(hix5hd2_secondary_startup);
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
+	.cpu_die		= hi3xxx_cpu_die,
+	.cpu_kill		= hi3xxx_cpu_kill,
+#endif
+};
-- 
1.9.1
