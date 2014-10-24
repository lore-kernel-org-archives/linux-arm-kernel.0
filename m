From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Oct 2014 17:33:08 +0900
Subject: [PATCH 1/2] ARM: shmobile: Separate APMU resource data into CPU
 dependant part
In-Reply-To: <1414139589-13605-1-git-send-email-horms+renesas@verge.net.au>
References: <1414139589-13605-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1414139589-13605-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

APMU resources are not common to all R-Car SoCs so don't share this data.
A subsequent patch will correct the CPU cores for the r8a7791.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/common.h       |  5 -----
 arch/arm/mach-shmobile/platsmp-apmu.c | 27 +++++++++------------------
 arch/arm/mach-shmobile/platsmp-apmu.h | 32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/smp-r8a7790.c  | 16 +++++++++++++++-
 arch/arm/mach-shmobile/smp-r8a7791.c  | 16 +++++++++++++++-
 5 files changed, 71 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/platsmp-apmu.h

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 72087c7..309025e 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -19,11 +19,6 @@ extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern void shmobile_smp_scu_cpu_die(unsigned int cpu);
 extern int shmobile_smp_scu_cpu_kill(unsigned int cpu);
-extern void shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus);
-extern int shmobile_smp_apmu_boot_secondary(unsigned int cpu,
-					    struct task_struct *idle);
-extern void shmobile_smp_apmu_cpu_die(unsigned int cpu);
-extern int shmobile_smp_apmu_cpu_kill(unsigned int cpu);
 struct clk;
 extern int shmobile_clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 2c06810..f483b56 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -1,6 +1,7 @@
 /*
  * SMP support for SoCs with APMU
  *
+ * Copyright (C) 2014  Renesas Electronics Corporation
  * Copyright (C) 2013  Magnus Damm
  *
  * This program is free software; you can redistribute it and/or modify
@@ -22,6 +23,7 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include "common.h"
+#include "platsmp-apmu.h"
 
 static struct {
 	void __iomem *iomem;
@@ -83,28 +85,15 @@ static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 	pr_debug("apmu ioremap %d %d %pr\n", cpu, bit, res);
 }
 
-static struct {
-	struct resource iomem;
-	int cpus[4];
-} apmu_config[] = {
-	{
-		.iomem = DEFINE_RES_MEM(0xe6152000, 0x88),
-		.cpus = { 0, 1, 2, 3 },
-	},
-	{
-		.iomem = DEFINE_RES_MEM(0xe6151000, 0x88),
-		.cpus = { 0x100, 0x101, 0x102, 0x103 },
-	}
-};
-
-static void apmu_parse_cfg(void (*fn)(struct resource *res, int cpu, int bit))
+static void apmu_parse_cfg(void (*fn)(struct resource *res, int cpu, int bit),
+			   struct rcar_apmu_config *apmu_config, int num)
 {
 	u32 id;
 	int k;
 	int bit, index;
 	bool is_allowed;
 
-	for (k = 0; k < ARRAY_SIZE(apmu_config); k++) {
+	for (k = 0; k < num; k++) {
 		/* only enable the cluster that includes the boot CPU */
 		is_allowed = false;
 		for (bit = 0; bit < ARRAY_SIZE(apmu_config[k].cpus); bit++) {
@@ -128,14 +117,16 @@ static void apmu_parse_cfg(void (*fn)(struct resource *res, int cpu, int bit))
 	}
 }
 
-void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus)
+void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
+					   struct rcar_apmu_config *apmu_config,
+					   int num)
 {
 	/* install boot code shared by all CPUs */
 	shmobile_boot_fn = virt_to_phys(shmobile_smp_boot);
 	shmobile_boot_arg = MPIDR_HWID_BITMASK;
 
 	/* perform per-cpu setup */
-	apmu_parse_cfg(apmu_init_cpu);
+	apmu_parse_cfg(apmu_init_cpu, apmu_config, num);
 }
 
 #ifdef CONFIG_SMP
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.h b/arch/arm/mach-shmobile/platsmp-apmu.h
new file mode 100644
index 0000000..76512c9
--- /dev/null
+++ b/arch/arm/mach-shmobile/platsmp-apmu.h
@@ -0,0 +1,32 @@
+/*
+ * rmobile apmu definition
+ *
+ * Copyright (C) 2014  Renesas Electronics Corporation
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
+#ifndef PLATSMP_APMU_H
+#define PLATSMP_APMU_H
+
+struct rcar_apmu_config {
+	struct resource iomem;
+	int cpus[4];
+};
+
+extern void shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
+					   struct rcar_apmu_config *apmu_config,
+					   int num);
+extern int shmobile_smp_apmu_boot_secondary(unsigned int cpu,
+					    struct task_struct *idle);
+extern void shmobile_smp_apmu_cpu_die(unsigned int cpu);
+extern int shmobile_smp_apmu_cpu_kill(unsigned int cpu);
+
+#endif /* PLATSMP_APMU_H */
diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index 2311694..9c3da13 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -21,6 +21,7 @@
 #include <asm/smp_plat.h>
 
 #include "common.h"
+#include "platsmp-apmu.h"
 #include "pm-rcar.h"
 #include "r8a7790.h"
 
@@ -34,10 +35,23 @@ static struct rcar_sysc_ch r8a7790_ca7_scu = {
 	.isr_bit = 21, /* CA7-SCU */
 };
 
+static struct rcar_apmu_config r8a7790_apmu_config[] = {
+	{
+		.iomem = DEFINE_RES_MEM(0xe6152000, 0x88),
+		.cpus = { 0, 1, 2, 3 },
+	},
+	{
+		.iomem = DEFINE_RES_MEM(0xe6151000, 0x88),
+		.cpus = { 0x100, 0x0101, 0x102, 0x103 },
+	}
+};
+
 static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
 {
 	/* let APMU code install data related to shmobile_boot_vector */
-	shmobile_smp_apmu_prepare_cpus(max_cpus);
+	shmobile_smp_apmu_prepare_cpus(max_cpus,
+				       r8a7790_apmu_config,
+				       ARRAY_SIZE(r8a7790_apmu_config));
 
 	/* turn on power to SCU */
 	r8a7790_pm_init();
diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
index f743386..96e392c 100644
--- a/arch/arm/mach-shmobile/smp-r8a7791.c
+++ b/arch/arm/mach-shmobile/smp-r8a7791.c
@@ -21,13 +21,27 @@
 #include <asm/smp_plat.h>
 
 #include "common.h"
+#include "platsmp-apmu.h"
 #include "r8a7791.h"
 #include "rcar-gen2.h"
 
+static struct rcar_apmu_config r8a7791_apmu_config[] = {
+	{
+		.iomem = DEFINE_RES_MEM(0xe6152000, 0x88),
+		.cpus = { 0, 1, 2, 3 },
+	},
+	{
+		.iomem = DEFINE_RES_MEM(0xe6151000, 0x88),
+		.cpus = { 0x100, 0x0101, 0x102, 0x103 },
+	}
+};
+
 static void __init r8a7791_smp_prepare_cpus(unsigned int max_cpus)
 {
 	/* let APMU code install data related to shmobile_boot_vector */
-	shmobile_smp_apmu_prepare_cpus(max_cpus);
+	shmobile_smp_apmu_prepare_cpus(max_cpus,
+				       r8a7791_apmu_config,
+				       ARRAY_SIZE(r8a7791_apmu_config));
 
 	r8a7791_pm_init();
 }
-- 
2.1.1
