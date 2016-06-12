From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 13 Jun 2016 00:04:43 +0300
Subject: [PATCH v5 05/12] ARM: shmobile: r8a7792: add SMP support
In-Reply-To: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
Message-ID: <8892035.WlgqvXCvaR@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add R8A7792 SMP support using the shared APMU code. This SoC has 2 ARM
Cortex-A15  CPU cores.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- new patch.

 arch/arm/mach-shmobile/Makefile        |    1 
 arch/arm/mach-shmobile/r8a7792.h       |    6 +++
 arch/arm/mach-shmobile/setup-r8a7792.c |    2 +
 arch/arm/mach-shmobile/smp-r8a7792.c   |   62 +++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)

Index: renesas/arch/arm/mach-shmobile/Makefile
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/Makefile
+++ renesas/arch/arm/mach-shmobile/Makefile
@@ -35,6 +35,7 @@ smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o
 smp-$(CONFIG_ARCH_R8A7791)	+= smp-r8a7791.o
+smp-$(CONFIG_ARCH_R8A7792)	+= smp-r8a7792.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
 # PM objects
Index: renesas/arch/arm/mach-shmobile/r8a7792.h
===================================================================
--- /dev/null
+++ renesas/arch/arm/mach-shmobile/r8a7792.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_R8A7792_H__
+#define __ASM_R8A7792_H__
+
+extern const struct smp_operations r8a7792_smp_ops;
+
+#endif /* __ASM_R8A7792_H__ */
Index: renesas/arch/arm/mach-shmobile/setup-r8a7792.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/setup-r8a7792.c
+++ renesas/arch/arm/mach-shmobile/setup-r8a7792.c
@@ -20,6 +20,7 @@
 
 #include "common.h"
 #include "rcar-gen2.h"
+#include "r8a7792.h"
 
 static const char * const r8a7792_boards_compat_dt[] __initconst = {
 	"renesas,r8a7792",
@@ -27,6 +28,7 @@ static const char * const r8a7792_boards
 };
 
 DT_MACHINE_START(R8A7792_DT, "Generic R8A7792 (Flattened Device Tree)")
+	.smp		= smp_ops(r8a7792_smp_ops),
 	.init_early	= shmobile_init_delay,
 	.init_late	= shmobile_init_late,
 	.init_time	= rcar_gen2_timer_init,
Index: renesas/arch/arm/mach-shmobile/smp-r8a7792.c
===================================================================
--- /dev/null
+++ renesas/arch/arm/mach-shmobile/smp-r8a7792.c
@@ -0,0 +1,62 @@
+/*
+ * SMP support for r8a7792
+ *
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ * Copyright (C) 2016 Cogent  Embedded, Inc.
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
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <linux/soc/renesas/rcar-sysc.h>
+
+#include <asm/smp_plat.h>
+
+#include "common.h"
+#include "platsmp-apmu.h"
+#include "rcar-gen2.h"
+#include "r8a7792.h"
+
+static struct rcar_sysc_ch r8a7792_ca15_scu = {
+	.chan_offs	= 0x180,	/* PWRSR5 .. PWRER5 */
+	.isr_bit	= 12,		/* CA15-SCU */
+};
+
+static struct rcar_apmu_config r8a7792_apmu_config[] = {
+	{
+		.iomem	= DEFINE_RES_MEM(0xe6152000, 0x188),
+		.cpus	= { 0, 1 },
+	},
+};
+
+static void __init r8a7792_smp_prepare_cpus(unsigned int max_cpus)
+{
+	/* let APMU code install data related to shmobile_boot_vector */
+	shmobile_smp_apmu_prepare_cpus(max_cpus,
+				       r8a7792_apmu_config,
+				       ARRAY_SIZE(r8a7792_apmu_config));
+
+	/* turn on power to SCU */
+	rcar_gen2_pm_init();
+	rcar_sysc_power_up(&r8a7792_ca15_scu);
+}
+
+const struct smp_operations r8a7792_smp_ops __initconst = {
+	.smp_prepare_cpus	= r8a7792_smp_prepare_cpus,
+	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_can_disable	= shmobile_smp_cpu_can_disable,
+	.cpu_die		= shmobile_smp_apmu_cpu_die,
+	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
+#endif
+};
