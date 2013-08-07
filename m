From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 Aug 2013 07:55:40 +0900
Subject: [PATCH 01/02] ARM: shmobile: Add r8a73a4 SMP support using APMU code
In-Reply-To: <20130807225531.9856.18974.sendpatchset@w520>
References: <20130807225531.9856.18974.sendpatchset@w520>
Message-ID: <20130807225540.9856.67383.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add r8a73a4 SMP support using the shared APMU code. To enable
SMP the r8a73a4 specific DTS needs to be updated to include
CPU cores, and this is happening in a separate patch.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    1 
 arch/arm/mach-shmobile/setup-r8a73a4.c        |    3 +
 arch/arm/mach-shmobile/smp-r8a73a4.c          |   75 +++++++++++++++++++++++++
 4 files changed, 80 insertions(+)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-08-07 20:07:31.000000000 +0900
@@ -33,6 +33,7 @@ endif
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
+smp-$(CONFIG_ARCH_R8A73A4)	+= smp-r8a73a4.o platsmp-apmu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
--- 0008/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a73a4.h	2013-08-07 20:08:02.000000000 +0900
@@ -6,5 +6,6 @@ void r8a73a4_add_dt_devices(void);
 void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
 void r8a73a4_init_early(void);
+extern struct smp_operations r8a73a4_smp_ops;
 
 #endif /* __ASM_R8A73A4_H__ */
--- 0008/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ work/arch/arm/mach-shmobile/setup-r8a73a4.c	2013-08-07 20:07:48.000000000 +0900
@@ -212,6 +212,9 @@ void __init r8a73a4_init_early(void)
 #ifndef CONFIG_ARM_ARCH_TIMER
 	shmobile_setup_delay(1500, 2, 4); /* Cortex-A15 @ 1500MHz */
 #endif
+#ifdef CONFIG_SMP
+	smp_set_ops(&r8a73a4_smp_ops);
+#endif
 }
 
 #ifdef CONFIG_USE_OF
--- /dev/null
+++ work/arch/arm/mach-shmobile/smp-r8a73a4.c	2013-08-07 20:09:10.000000000 +0900
@@ -0,0 +1,75 @@
+/*
+ * SMP support for r8a73a4
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
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <asm/smp_plat.h>
+#include <mach/common.h>
+
+#define SYSC		0xe6180000
+#define CA7BAR		0x4020
+#define CA15BAR		0x6020
+#define RESCNT		0x801c
+#define MERAM		0xe8080000
+#define CCI_BASE	0xf0190000
+#define CCI_SLAVE3	0x4000
+#define CCI_SLAVE4	0x5000
+#define CCI_SNOOP	0x0000
+#define CCI_STATUS	0x000c
+
+static void __init r8a73a4_smp_prepare_cpus(unsigned int max_cpus)
+{
+	u32 bar;
+	void __iomem *p;
+
+	/* let APMU code install data related to shmobile_boot_vector */
+	shmobile_smp_apmu_prepare_cpus(max_cpus);
+
+	/* MERAM for jump stub, because BAR requires 256KB aligned address */
+	p = ioremap_nocache(MERAM, shmobile_boot_size);
+	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
+	iounmap(p);
+
+	/* setup reset vector and disable reset */
+	p = ioremap_nocache(SYSC, 0x9000);
+	bar = (MERAM >> 8) & 0xfffffc00;
+	writel_relaxed(bar, p + CA15BAR);
+	writel_relaxed(bar, p + CA7BAR);
+	writel_relaxed(bar | 0x10, p + CA15BAR);
+	writel_relaxed(bar | 0x10, p + CA7BAR);
+	writel_relaxed(readl_relaxed(p + RESCNT) & ~(1 << 10), p + RESCNT);
+	writel_relaxed(readl_relaxed(p + RESCNT) & ~(1 << 9), p + RESCNT);
+	iounmap(p);
+
+	/* enable snoop and DVM */
+	p = ioremap_nocache(CCI_BASE, 0x8000);
+	writel_relaxed(3, p + CCI_SLAVE3 + CCI_SNOOP);	/* CA15 */
+	writel_relaxed(3, p + CCI_SLAVE4 + CCI_SNOOP);	/* CA7 */
+	while (readl_relaxed(p + CCI_STATUS))
+		/* wait for pending bit low */;
+	iounmap(p);
+}
+
+struct smp_operations r8a73a4_smp_ops __initdata = {
+	.smp_prepare_cpus	= r8a73a4_smp_prepare_cpus,
+	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= shmobile_smp_cpu_disable,
+	.cpu_die		= shmobile_smp_apmu_cpu_die,
+	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
+#endif
+};
