From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 12 Sep 2013 09:50:07 +0900
Subject: [PATCH] ARM: shmobile: r8a7791 SMP support
Message-ID: <20130912005007.24692.14749.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add r8a7791 SMP support using the shared APMU code. This patch
also includes DTS modifications to enable the secondary CA15
CPU core to fully support the single cluster dual core r8a7791.

SMP boot and CPU Hotplug are known to be working.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-20130906, depends on
 [PATCH v2 01/03] ARM: shmobile: Shared APMU SMP support code without DT

 arch/arm/boot/dts/r8a7791.dtsi                |    7 ++
 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/board-koelsch.c        |    1 
 arch/arm/mach-shmobile/include/mach/r8a7791.h |    1 
 arch/arm/mach-shmobile/setup-r8a7791.c        |    1 
 arch/arm/mach-shmobile/smp-r8a7791.c          |   62 +++++++++++++++++++++++++
 6 files changed, 73 insertions(+)

--- 0004/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2013-09-12 09:17:37.000000000 +0900
@@ -25,6 +25,13 @@
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
 	};
 
 	gic: interrupt-controller at f1001000 {
--- 0004/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-09-12 09:18:18.000000000 +0900
@@ -37,6 +37,7 @@ smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o platsmp-apmu.o
+smp-$(CONFIG_ARCH_R8A7791)	+= smp-r8a7791.o platsmp-apmu.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
 # IRQ objects
--- 0004/arch/arm/mach-shmobile/board-koelsch.c
+++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-09-12 09:19:14.000000000 +0900
@@ -38,6 +38,7 @@ static const char * const koelsch_boards
 };
 
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
+	.smp		= smp_ops(r8a7791_smp_ops),
 	.init_early	= r8a7791_init_early,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= koelsch_add_standard_devices,
--- 0004/arch/arm/mach-shmobile/include/mach/r8a7791.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7791.h	2013-09-12 09:19:38.000000000 +0900
@@ -7,5 +7,6 @@ void r8a7791_add_standard_devices(void);
 void r8a7791_add_dt_devices(void);
 void r8a7791_clock_init(void);
 void r8a7791_init_early(void);
+extern struct smp_operations r8a7791_smp_ops;
 
 #endif /* __ASM_R8A7791_H__ */
--- 0004/arch/arm/mach-shmobile/setup-r8a7791.c
+++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2013-09-12 09:19:04.000000000 +0900
@@ -175,6 +175,7 @@ static const char *r8a7791_boards_compat
 };
 
 DT_MACHINE_START(R8A7791_DT, "Generic R8A7791 (Flattened Device Tree)")
+	.smp		= smp_ops(r8a7791_smp_ops),
 	.init_early	= r8a7791_init_early,
 	.init_time	= rcar_gen2_timer_init,
 	.dt_compat	= r8a7791_boards_compat_dt,
--- /dev/null
+++ work/arch/arm/mach-shmobile/smp-r8a7791.c	2013-09-12 09:22:43.000000000 +0900
@@ -0,0 +1,62 @@
+/*
+ * SMP support for r8a7791
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013 Magnus Damm
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
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <asm/smp_plat.h>
+#include <mach/common.h>
+#include <mach/r8a7791.h>
+
+#define RST		0xe6160000
+#define CA15BAR		0x0020
+#define CA15RESCNT	0x0040
+#define RAM		0xe6300000
+
+static void __init r8a7791_smp_prepare_cpus(unsigned int max_cpus)
+{
+	void __iomem *p;
+	u32 bar;
+
+	/* let APMU code install data related to shmobile_boot_vector */
+	shmobile_smp_apmu_prepare_cpus(max_cpus);
+
+	/* RAM for jump stub, because BAR requires 256KB aligned address */
+	p = ioremap_nocache(RAM, shmobile_boot_size);
+	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
+	iounmap(p);
+
+	/* setup reset vectors */
+	p = ioremap_nocache(RST, 0x63);
+	bar = (RAM >> 8) & 0xfffffc00;
+	writel_relaxed(bar, p + CA15BAR);
+	writel_relaxed(bar | 0x10, p + CA15BAR);
+
+	/* enable clocks to all CPUs */
+	writel_relaxed((readl_relaxed(p + CA15RESCNT) & ~0x0f) | 0xa5a50000,
+		       p + CA15RESCNT);
+	iounmap(p);
+}
+
+struct smp_operations r8a7791_smp_ops __initdata = {
+	.smp_prepare_cpus	= r8a7791_smp_prepare_cpus,
+	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= shmobile_smp_cpu_disable,
+	.cpu_die		= shmobile_smp_apmu_cpu_die,
+	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
+#endif
+};
