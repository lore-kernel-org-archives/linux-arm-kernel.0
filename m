From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 28 Aug 2013 21:10:54 +0800
Subject: [PATCH v9 7/7] ARM: hi3xxx: add hotplug support
In-Reply-To: <1377695454-29109-1-git-send-email-haojian.zhuang@linaro.org>
References: <1377695454-29109-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1377695454-29109-8-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhangfei Gao <zhangfei.gao@linaro.org>

Enable hotplug support on hi3xxx platform

How to test:
cat proc/interrupts
echo 0 > /sys/devices/system/cpu/cpuX/online
cat proc/interrupts
echo 1 > /sys/devices/system/cpu/cpuX/online

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Zhang Mingjun <zhang.mingjun@linaro.org>
Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-hi3xxx/Makefile  |   1 +
 arch/arm/mach-hi3xxx/core.h    |   5 ++
 arch/arm/mach-hi3xxx/hi3xxx.c  |   1 +
 arch/arm/mach-hi3xxx/hotplug.c | 168 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-hi3xxx/platsmp.c |   5 ++
 5 files changed, 180 insertions(+)
 create mode 100644 arch/arm/mach-hi3xxx/hotplug.c

diff --git a/arch/arm/mach-hi3xxx/Makefile b/arch/arm/mach-hi3xxx/Makefile
index 0917f1c..c597cbf 100644
--- a/arch/arm/mach-hi3xxx/Makefile
+++ b/arch/arm/mach-hi3xxx/Makefile
@@ -4,3 +4,4 @@
 
 obj-y	+= hi3xxx.o system.o
 obj-$(CONFIG_SMP)		+= platsmp.o
+obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-hi3xxx/core.h b/arch/arm/mach-hi3xxx/core.h
index 3a9c50a..095d1d4 100644
--- a/arch/arm/mach-hi3xxx/core.h
+++ b/arch/arm/mach-hi3xxx/core.h
@@ -10,4 +10,9 @@ extern void hs_map_io(void);
 extern void hs_restart(enum reboot_mode, const char *cmd);
 extern struct smp_operations hs_smp_ops;
 
+extern void __init hs_hotplug_init(void);
+extern void hs_cpu_die(unsigned int cpu);
+extern int hs_cpu_kill(unsigned int cpu);
+extern void hs_set_cpu(int cpu, bool enable);
+
 #endif
diff --git a/arch/arm/mach-hi3xxx/hi3xxx.c b/arch/arm/mach-hi3xxx/hi3xxx.c
index 567a0d5..01ac68b 100644
--- a/arch/arm/mach-hi3xxx/hi3xxx.c
+++ b/arch/arm/mach-hi3xxx/hi3xxx.c
@@ -24,6 +24,7 @@
 static void __init hi3xxx_timer_init(void)
 {
 	hs_map_io();
+	hs_hotplug_init();
 	of_clk_init(NULL);
 	clocksource_of_init();
 }
diff --git a/arch/arm/mach-hi3xxx/hotplug.c b/arch/arm/mach-hi3xxx/hotplug.c
new file mode 100644
index 0000000..3262788
--- /dev/null
+++ b/arch/arm/mach-hi3xxx/hotplug.c
@@ -0,0 +1,168 @@
+/*
+ * Copyright (c) 2013 Linaro Ltd.
+ * Copyright (c) 2013 Hisilicon Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+#include <linux/cpu.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <asm/cacheflush.h>
+#include <asm/smp_plat.h>
+#include "core.h"
+
+enum {
+	HI3620_CTRL,
+	HI3716_CTRL,
+};
+
+static void __iomem *ctrl_base;
+static int id;
+
+static void hs_set_cpu_hi3620(int cpu, bool enable)
+{
+	u32 val = 0;
+
+	if (enable) {
+		/* MTCMOS set */
+		writel_relaxed(0x8 << cpu, ctrl_base + 0xd0);
+		/* unreset */
+		writel_relaxed(0x1011 << cpu, ctrl_base + 0x414);
+		/* reset */
+		writel_relaxed(0x401011 << cpu, ctrl_base + 0x410);
+
+		/* ISO disable */
+		writel(0x8 << cpu, ctrl_base + 0xc4);
+
+		/* WFI Mask */
+		val = readl(ctrl_base + 0x200);
+		val &= ~(0x10000000 << cpu);
+		writel(val, ctrl_base + 0x200);
+
+		/* Enable core */
+		writel_relaxed(0x01 << cpu, ctrl_base + 0xf4);
+		/* Unreset */
+		writel_relaxed(0x401011 << cpu, ctrl_base + 0x414);
+	} else {
+		/* iso enable */
+		writel_relaxed(0x8 << cpu, ctrl_base + 0xc0);
+
+		/* MTCMOS unset */
+		writel_relaxed(0x8 << cpu, ctrl_base + 0xd4);
+
+		/* wfi mask */
+		val = readl_relaxed(ctrl_base + 0x200);
+		val |= (0x10000000 << cpu);
+		writel_relaxed(val, ctrl_base + 0x200);
+
+		/* disable core*/
+		writel_relaxed(0x01 << cpu, ctrl_base + 0xf8);
+		/* reset */
+		writel_relaxed(0x401011 << cpu, ctrl_base + 0x410);
+	}
+}
+
+static void hs_set_cpu_hi3716(int cpu, bool enable)
+{
+	u32 val = 0;
+
+	if (enable) {
+		/* power on cpu1 */
+		val = readl_relaxed(ctrl_base + 0x1000);
+		val &=  ~(0x1 << 8);
+		val |= (0x1 << 7);
+		val &= ~(0x1 << 3);
+		writel_relaxed(val, ctrl_base + 0x1000);
+
+		/* unreset */
+		val = readl_relaxed(ctrl_base + 0x50);
+		val &= ~(0x1 << 17);
+		writel_relaxed(val, ctrl_base + 0x50);
+	} else {
+		/* power down cpu1 */
+		val = readl_relaxed(ctrl_base + 0x1000);
+		val &=  ~(0x1 << 8);
+		val |= (0x1 << 7);
+		val |= (0x1 << 3);
+		writel_relaxed(val, ctrl_base + 0x1000);
+
+		/* reset */
+		val = readl_relaxed(ctrl_base + 0x50);
+		val |= (0x1 << 17);
+		writel_relaxed(val, ctrl_base + 0x50);
+	}
+}
+
+void hs_set_cpu(int cpu, bool enable)
+{
+	if (!ctrl_base)
+		return;
+
+	if (id == HI3620_CTRL)
+		hs_set_cpu_hi3620(cpu, enable);
+	else if (id == HI3716_CTRL)
+		hs_set_cpu_hi3716(cpu, enable);
+}
+
+void __init hs_hotplug_init(void)
+{
+	struct device_node *node;
+
+	node = of_find_compatible_node(NULL, NULL, "hisilicon,hi3716-cpuctrl");
+	if (node) {
+		ctrl_base = of_iomap(node, 0);
+		id = HI3716_CTRL;
+		return;
+	}
+	node = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
+	if (node) {
+		ctrl_base = of_iomap(node, 0);
+		id = HI3620_CTRL;
+		return;
+	}
+}
+
+static inline void cpu_enter_lowpower(void)
+{
+	unsigned int v;
+
+	flush_cache_all();
+
+	/*
+	 * Turn off coherency and L1 D-cache
+	 */
+	asm volatile(
+	"	mrc	p15, 0, %0, c1, c0, 1\n"
+	"	bic	%0, %0, #0x40\n"
+	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	bic	%0, %0, #0x04\n"
+	"	mcr	p15, 0, %0, c1, c0, 0\n"
+	  : "=&r" (v)
+	  : "r" (0)
+	  : "cc");
+}
+
+void hs_cpu_die(unsigned int cpu)
+{
+	cpu_enter_lowpower();
+	hs_set_cpu_jump(cpu, phys_to_virt(0));
+	cpu_do_idle();
+
+	/* We should have never returned from idle */
+	panic("cpu %d unexpectedly exit from shutdown\n", cpu);
+}
+
+int hs_cpu_kill(unsigned int cpu)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(50);
+
+	while (hs_get_cpu_jump(cpu))
+		if (time_after(jiffies, timeout))
+			return 0;
+	hs_set_cpu(cpu, false);
+	return 1;
+}
diff --git a/arch/arm/mach-hi3xxx/platsmp.c b/arch/arm/mach-hi3xxx/platsmp.c
index a76a3cc..6a08630 100644
--- a/arch/arm/mach-hi3xxx/platsmp.c
+++ b/arch/arm/mach-hi3xxx/platsmp.c
@@ -32,6 +32,7 @@ static void __init hs_smp_prepare_cpus(unsigned int max_cpus)
 
 static int hs_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
+	hs_set_cpu(cpu, true);
 	hs_set_cpu_jump(cpu, secondary_startup);
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 	return 0;
@@ -40,4 +41,8 @@ static int hs_boot_secondary(unsigned int cpu, struct task_struct *idle)
 struct smp_operations hs_smp_ops __initdata = {
 	.smp_prepare_cpus	= hs_smp_prepare_cpus,
 	.smp_boot_secondary	= hs_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= hs_cpu_die,
+	.cpu_kill		= hs_cpu_kill,
+#endif
 };
-- 
1.8.1.2
