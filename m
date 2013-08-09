From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 09 Aug 2013 19:07:55 +0900
Subject: [PATCH 01/02] ARM: shmobile: Add r8a7790 SMP support using APMU code
In-Reply-To: <20130809100744.10827.62207.sendpatchset@w520>
References: <20130809100744.10827.62207.sendpatchset@w520>
Message-ID: <20130809100755.10827.10538.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add r8a7790 SMP support using the shared APMU code. To enable
SMP the r8a7790 specific DTS needs to be updated to include
CPU cores, and this is happening in a separate patch.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    1 
 arch/arm/mach-shmobile/setup-r8a7790.c        |    3 +
 arch/arm/mach-shmobile/smp-r8a7790.c          |   67 +++++++++++++++++++++++++
 4 files changed, 72 insertions(+)

--- 0011/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-08-07 20:10:54.000000000 +0900
@@ -35,6 +35,7 @@ smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A73A4)	+= smp-r8a73a4.o platsmp-apmu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
+smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o platsmp-apmu.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
 # IRQ objects
--- 0009/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7790.h	2013-08-07 20:10:54.000000000 +0900
@@ -7,6 +7,7 @@ void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
 void r8a7790_init_early(void);
 void r8a7790_timer_init(void);
+extern struct smp_operations r8a7790_smp_ops;
 
 #define MD(nr) BIT(nr)
 u32 r8a7790_read_mode_pins(void);
--- 0009/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-08-07 20:10:54.000000000 +0900
@@ -272,6 +272,9 @@ void __init r8a7790_init_early(void)
 #ifndef CONFIG_ARM_ARCH_TIMER
 	shmobile_setup_delay(1300, 2, 4); /* Cortex-A15 @ 1300MHz */
 #endif
+#ifdef CONFIG_SMP
+	smp_set_ops(&r8a7790_smp_ops);
+#endif
 }
 
 #ifdef CONFIG_USE_OF
--- /dev/null
+++ work/arch/arm/mach-shmobile/smp-r8a7790.c	2013-08-07 20:10:55.000000000 +0900
@@ -0,0 +1,67 @@
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
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <asm/smp_plat.h>
+#include <mach/common.h>
+
+#define RST		0xe6160000
+#define CA15BAR		0x0020
+#define CA7BAR		0x0030
+#define CA15RESCNT	0x0040
+#define CA7RESCNT	0x0044
+#define MERAM		0xe8080000
+
+static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
+{
+	void __iomem *p;
+	u32 bar;
+
+	/* let APMU code install data related to shmobile_boot_vector */
+	shmobile_smp_apmu_prepare_cpus(max_cpus);
+
+	/* MERAM for jump stub, because BAR requires 256KB aligned address */
+	p = ioremap_nocache(MERAM, shmobile_boot_size);
+	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
+	iounmap(p);
+
+	/* setup reset vectors */
+	p = ioremap_nocache(RST, 0x63);
+	bar = (MERAM >> 8) & 0xfffffc00;
+	writel_relaxed(bar, p + CA15BAR);
+	writel_relaxed(bar, p + CA7BAR);
+	writel_relaxed(bar | 0x10, p + CA15BAR);
+	writel_relaxed(bar | 0x10, p + CA7BAR);
+
+	/* enable clocks to all CPUs */
+	writel_relaxed((readl_relaxed(p + CA15RESCNT) & ~0x0f) | 0xa5a50000,
+		       p + CA15RESCNT);
+	writel_relaxed((readl_relaxed(p + CA7RESCNT) & ~0x0f) | 0x5a5a0000,
+		       p + CA7RESCNT);
+	iounmap(p);
+}
+
+struct smp_operations r8a7790_smp_ops __initdata = {
+	.smp_prepare_cpus	= r8a7790_smp_prepare_cpus,
+	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= shmobile_smp_cpu_disable,
+	.cpu_die		= shmobile_smp_apmu_cpu_die,
+	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
+#endif
+};
