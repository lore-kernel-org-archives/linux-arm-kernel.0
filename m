From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 27 Jun 2013 08:58:37 +0900
Subject: [PATCH] ARM: shmobile: r8a7790 SMP prototype v2
Message-ID: <20130626235837.11576.86389.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add SMP prototype support for r8a7790 by enabling
one cluster of either 4 x Cortex-A7 or 4 x Cortex-A15.

This patch only adds support for booting, at this point
no CPU Hotplug is included. The big cluster is known
to work well, support for LITTLE needs more work.

On r8a7790 the MD6 pin control boot processor, and on the
Lager board SW8.7 can be used to select big or LITTLE.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written on top of renesas-next-20130620

 arch/arm/boot/dts/r8a7790.dtsi                |   49 ++++++
 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/board-lager.c          |    1 
 arch/arm/mach-shmobile/include/mach/common.h  |    1 
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    1 
 arch/arm/mach-shmobile/setup-r8a7790.c        |    1 
 arch/arm/mach-shmobile/smp-r8a7790.c          |  187 +++++++++++++++++++++++++
 7 files changed, 241 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-06-27 08:34:41.000000000 +0900
@@ -24,6 +24,55 @@
 			reg = <0>;
 			clock-frequency = <1300000000>;
 		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1300000000>;
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <2>;
+			clock-frequency = <1300000000>;
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <3>;
+			clock-frequency = <1300000000>;
+		};
+
+		cpu4: cpu at 4 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			clock-frequency = <780000000>;
+		};
+
+		cpu5: cpu at 5 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			clock-frequency = <780000000>;
+		};
+
+		cpu6: cpu at 6 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x102>;
+			clock-frequency = <780000000>;
+		};
+
+		cpu7: cpu at 7 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x103>;
+			clock-frequency = <780000000>;
+		};
 	};
 
 	gic: interrupt-controller at f1001000 {
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-06-26 22:40:38.000000000 +0900
@@ -19,6 +19,7 @@ obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.
 smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o
+smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o
 
 # IRQ objects
--- 0001/arch/arm/mach-shmobile/board-lager.c
+++ work/arch/arm/mach-shmobile/board-lager.c	2013-06-26 22:40:38.000000000 +0900
@@ -103,6 +103,7 @@ static const char *lager_boards_compat_d
 };
 
 DT_MACHINE_START(LAGER_DT, "lager")
+	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_irq	= irqchip_init,
 	.init_time	= r8a7790_timer_init,
 	.init_machine	= lager_add_standard_devices,
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-06-26 22:40:38.000000000 +0900
@@ -11,6 +11,7 @@ extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
 extern unsigned long shmobile_boot_arg;
 extern void shmobile_boot_scu(void);
+extern void shmobile_invalidate_start(void);
 struct clk;
 extern int shmobile_clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
--- 0001/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7790.h	2013-06-26 22:40:38.000000000 +0900
@@ -5,5 +5,6 @@ void r8a7790_add_standard_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
 void r8a7790_timer_init(void);
+extern struct smp_operations r8a7790_smp_ops;
 
 #endif /* __ASM_R8A7790_H__ */
--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-06-26 22:40:38.000000000 +0900
@@ -188,6 +188,7 @@ static const char *r8a7790_boards_compat
 };
 
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
+	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_irq	= irqchip_init,
 	.init_machine	= r8a7790_add_standard_devices_dt,
 	.init_time	= r8a7790_timer_init,
--- /dev/null
+++ work/arch/arm/mach-shmobile/smp-r8a7790.c	2013-06-26 22:40:40.000000000 +0900
@@ -0,0 +1,187 @@
+/*
+ * SMP support for r8a7790
+ *
+ * Copyright (C) 2012-2013 Renesas Solutions Corp.
+ * Copyright (C) 2012 Takashi Yoshii <takashi.yoshii.ze@renesas.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/smp.h>
+#include <linux/irqchip/arm-gic.h>
+#include <asm/cacheflush.h>
+#include <asm/io.h>
+#include <asm/smp_plat.h>
+#include <asm/suspend.h>
+#include <mach/common.h>
+#include <mach/hardware.h>
+
+#include <asm/cacheflush.h>
+#include <asm/cp15.h>
+#include <asm/smp_plat.h>
+
+#define SYSC	0xe6180000
+#define SYSCSR  0x0000
+
+#define RST	0xe6160000
+#define CA15BAR	0x6020
+#define CA15RESCNT 0x0040
+#define CA7BAR	0x4030
+#define CA7RESCNT 0x0044
+#define RESCNT	0x0050
+
+#define APMU	0xe6150000
+#define CA15WUPCR 0x2010
+#define CA7WUPCR 0x1010
+
+#define MERAM	0xe8080000
+
+enum { R8A7790_CLST_CA15, R8A7790_CLST_CA7, R8A7790_CLST_NR };
+
+static struct {
+	unsigned int cabar;
+	unsigned int carescnt;
+	unsigned int carescnt_magic;
+	unsigned int rescnt_bit;
+	unsigned int use_count;
+} r8a7790_clst[R8A7790_CLST_NR] = {
+	[R8A7790_CLST_CA15] = {
+		.cabar = CA15BAR,
+		.carescnt = CA15RESCNT,
+		.carescnt_magic = 0xa5a50000,
+		.rescnt_bit = 1,
+	},
+	[R8A7790_CLST_CA7] = {
+		.cabar = CA7BAR,
+		.carescnt = CA7RESCNT,
+		.carescnt_magic = 0x5a5a0000,
+		.rescnt_bit = 0,
+	},
+};
+
+#define r8a7790_clst_id(cpu) (cpu_logical_map((cpu)) >> 8)
+#define r8a7790_cpu_id(cpu) (cpu_logical_map((cpu)) & 0xff)
+
+static void r8a7790_deassert_reset(unsigned int cpu)
+{
+	void __iomem *p, *carescnt;
+	u32 bar, mask, magic;
+	unsigned int clst_id = r8a7790_clst_id(cpu);
+
+	/* setup reset vectors */
+	p = ioremap_nocache(RST, 0x7000);
+	bar = (MERAM >> 8) & 0xfffffc00;
+	__raw_writel(bar, p + r8a7790_clst[clst_id].cabar);
+	__raw_writel(bar | 0x10, p + r8a7790_clst[clst_id].cabar);
+
+	/* enable clocks for cluster */
+	if (r8a7790_clst[clst_id].use_count++ == 0) {
+		mask = 1 << r8a7790_clst[clst_id].rescnt_bit;
+		__raw_writel(__raw_readl(p + RESCNT) & ~mask, p + RESCNT);
+	}
+
+	/* enable per-core clocks */
+	mask = BIT(3 - r8a7790_cpu_id(cpu));
+	magic = r8a7790_clst[clst_id].carescnt_magic;
+	carescnt = p + r8a7790_clst[clst_id].carescnt;
+	__raw_writel((__raw_readl(carescnt) & ~mask) | magic, carescnt);
+
+	iounmap(p);
+}
+
+static void r8a7790_assert_reset(unsigned int cpu)
+{
+	void __iomem *p, *carescnt;
+	u32 mask, magic;
+	unsigned int clst_id = r8a7790_clst_id(cpu);
+
+	p = ioremap_nocache(RST, 0x7000);
+
+	/* disable per-core clocks */
+	mask = BIT(3 - r8a7790_cpu_id(cpu));
+	magic = r8a7790_clst[clst_id].carescnt_magic;
+	carescnt = p + r8a7790_clst[clst_id].carescnt;
+	__raw_writel((__raw_readl(carescnt) | mask) | magic, carescnt);
+
+	/* disable clocks for cluster */
+	if (r8a7790_clst[clst_id].use_count == 1) {
+		mask = 1 << r8a7790_clst[clst_id].rescnt_bit;
+		__raw_writel(__raw_readl(p + RESCNT) | mask, p + RESCNT);
+	}
+
+	if (r8a7790_clst[clst_id].use_count > 0)
+		r8a7790_clst[clst_id].use_count--;
+
+	iounmap(p);
+}
+
+static void r8a7790_power_on(unsigned int cpu)
+{
+	void __iomem *p, *p2, *cawupcr;
+
+	/* wake up CPU core via APMU */
+	p = ioremap_nocache(APMU, 0x3000);
+	cawupcr = p + (r8a7790_clst_id(cpu) ? CA7WUPCR : CA15WUPCR);
+	__raw_writel(BIT(r8a7790_cpu_id(cpu)), cawupcr);
+
+	/* wait for SYSC to finish wake up sequence */
+	p2 = ioremap_nocache(SYSC, 0x1000);
+	while ((__raw_readl(p2 + SYSCSR) & 0x3) != 0x3)
+		;
+
+	/* wait for APMU to finish */
+	while (__raw_readl(cawupcr) != 0)
+		;
+
+	iounmap(p2);
+	iounmap(p);
+}
+
+static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
+{
+	void __iomem *p;
+	unsigned int k;
+
+	shmobile_boot_fn = virt_to_phys(shmobile_invalidate_start);
+
+	/* MERAM for jump stub, because BAR requires 256KB aligned address */
+	p = ioremap_nocache(MERAM, 16);
+	memcpy(p, shmobile_boot_vector, 16);
+	iounmap(p);
+
+	flush_cache_louis();
+
+	/* keep secondary CPU cores in reset, but powered on */
+	for (k = 1; k < 8; k++) {
+		r8a7790_assert_reset(k);
+		r8a7790_power_on(k);
+	}
+
+	r8a7790_deassert_reset(0);
+}
+
+static int __cpuinit r8a7790_boot_secondary(unsigned int cpu,
+					    struct task_struct *idle)
+{
+	/* only allow a single cluster for now */
+	if (r8a7790_clst_id(cpu) != r8a7790_clst_id(0))
+		return -ENOTSUPP;
+
+	r8a7790_deassert_reset(cpu);
+	return 0;
+}
+
+struct smp_operations r8a7790_smp_ops __initdata = {
+	.smp_prepare_cpus	= r8a7790_smp_prepare_cpus,
+	.smp_boot_secondary	= r8a7790_boot_secondary,
+};
