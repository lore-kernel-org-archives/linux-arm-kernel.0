From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 30 May 2013 17:52:01 +0900
Subject: [PATCH 01/05] ARM: shmobile: r8a73a4 SMP prototype v1 (CA15 x 4)
In-Reply-To: <20130530085152.24374.64208.sendpatchset@w520>
References: <20130530085152.24374.64208.sendpatchset@w520>
Message-ID: <20130530085201.24374.97084.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add SMP prototype support for r8a73a4 by enabling
4 x Cortex-A15. This patch only adds support for
booting, see the incremental patch for CPU Hotplug.

Needs a rewrite to support more generic handling of
CPU core power domains. Not ready for merge.

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Developed and tested on top of v3.10-rc2

 arch/arm/boot/dts/r8a73a4.dtsi                |   21 +++++
 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/board-ape6evm.c        |    1 
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    1 
 arch/arm/mach-shmobile/setup-r8a73a4.c        |    1 
 arch/arm/mach-shmobile/smp-r8a73a4.c          |   89 +++++++++++++++++++++++++
 6 files changed, 114 insertions(+)

--- 0003/arch/arm/boot/dts/r8a73a4.dtsi
+++ work/arch/arm/boot/dts/r8a73a4.dtsi	2013-05-22 13:21:21.000000000 +0900
@@ -25,6 +25,27 @@
 			reg = <0>;
 			clock-frequency = <1500000000>;
 		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1500000000>;
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <2>;
+			clock-frequency = <1500000000>;
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <3>;
+			clock-frequency = <1500000000>;
+		};
 	};
 
 	gic: interrupt-controller at f1001000 {
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-05-22 13:21:21.000000000 +0900
@@ -18,6 +18,7 @@ obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o
+smp-$(CONFIG_ARCH_R8A73A4)	+= smp-r8a73a4.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o
 
--- 0001/arch/arm/mach-shmobile/board-ape6evm.c
+++ work/arch/arm/mach-shmobile/board-ape6evm.c	2013-05-22 13:21:51.000000000 +0900
@@ -87,6 +87,7 @@ static const char *ape6evm_boards_compat
 };
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
+	.smp		= smp_ops(r8a73a4_smp_ops),
 	.init_irq	= irqchip_init,
 	.init_time	= shmobile_timer_init,
 	.init_machine	= ape6evm_add_standard_devices,
--- 0001/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a73a4.h	2013-05-22 13:21:21.000000000 +0900
@@ -4,5 +4,6 @@
 void r8a73a4_add_standard_devices(void);
 void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
+extern struct smp_operations r8a73a4_smp_ops;
 
 #endif /* __ASM_R8A73A4_H__ */
--- 0001/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ work/arch/arm/mach-shmobile/setup-r8a73a4.c	2013-05-22 13:21:44.000000000 +0900
@@ -194,6 +194,7 @@ static const char *r8a73a4_boards_compat
 };
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
+	.smp		= smp_ops(r8a73a4_smp_ops),
 	.init_irq	= irqchip_init,
 	.init_machine	= r8a73a4_add_standard_devices_dt,
 	.init_time	= shmobile_timer_init,
--- /dev/null
+++ work/arch/arm/mach-shmobile/smp-r8a73a4.c	2013-05-22 13:21:21.000000000 +0900
@@ -0,0 +1,89 @@
+/*
+ * SMP support for r8a73a4
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
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
+#define CA15BAR	0x6020
+#define RESCNT	0x801c
+
+#define APMU	0xe6150000
+#define CA15WUPCR 0x2010
+
+#define MERAM	0xe8080000
+#define CCI_BASE	0xf0190000
+#define CCI_SLAVE3	0x4000
+#define CCI_SNOOP	0x0000
+#define CCI_STATUS	0x000c
+
+static void __init r8a73a4_smp_prepare_cpus(unsigned int max_cpus)
+{
+	u32 bar;
+	void __iomem *p;
+
+	/* MERAM for jump stub, because BAR requires 256KB aligned address */
+	p = ioremap_nocache(MERAM, 16);
+	memcpy(p, shmobile_secondary_vector, 16);
+	iounmap(p);
+
+	flush_cache_louis();
+
+	/* setup reset vector and disable reset */
+	p = ioremap_nocache(SYSC, 0x9000);
+	bar = (MERAM >> 8) & 0xfffffc00;
+	__raw_writel(bar, p + CA15BAR);
+	__raw_writel(bar | 0x10, p + CA15BAR);
+	__raw_writel(__raw_readl(p + RESCNT) & ~(1 << 10), p + RESCNT);
+	iounmap(p);
+
+	/* enable snoop and DVM */
+	p = ioremap_nocache(CCI_BASE, 0x8000);
+	__raw_writel(3, p + CCI_SLAVE3 + CCI_SNOOP);	/* ca15 */
+	while (__raw_readl(p + CCI_STATUS))
+		/* wait for pending bit low */;
+	iounmap(p);
+}
+
+static int __cpuinit r8a73a4_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	void __iomem *p;
+
+	/* wake up CPU core */
+	p = ioremap_nocache(APMU, 0x3000);
+	__raw_writel(1 << (cpu_logical_map(cpu) & 3), p + CA15WUPCR);
+	iounmap(p);
+
+	return 0;
+}
+
+struct smp_operations r8a73a4_smp_ops __initdata = {
+	.smp_prepare_cpus	= r8a73a4_smp_prepare_cpus,
+	.smp_boot_secondary	= r8a73a4_boot_secondary,
+};
