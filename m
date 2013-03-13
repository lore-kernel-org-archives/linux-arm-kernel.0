From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 13 Mar 2013 16:55:21 -0500
Subject: [PATCHv1 1/2] ARM: socfpga: Enable hotplug and soft reset
In-Reply-To: <1363211722-27237-1-git-send-email-dinguyen@altera.com>
References: <1363211722-27237-1-git-send-email-dinguyen@altera.com>
Message-ID: <1363211722-27237-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Put CPU1 into reset when it is hotplugged.
Enable a cold or warm reset to the HW from userspace.

Also fix a few sparse errors:

warning: symbol 'sys_manager_base_addr' was not declared. Should it be static?
warning: symbol 'rst_manager_base_addr' was not declared. Should it be static?

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 arch/arm/mach-socfpga/core.h    |   17 +++++++++++++++++
 arch/arm/mach-socfpga/platsmp.c |    9 ++++++---
 arch/arm/mach-socfpga/socfpga.c |   10 +++++++++-
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 315edff..d2a251f 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -20,12 +20,29 @@
 #ifndef __MACH_CORE_H
 #define __MACH_CORE_H
 
+#define SOCFPGA_RSTMGR_CTRL	0x04
+#define SOCFPGA_RSTMGR_MODPERRST	0x14
+#define SOCFPGA_RSTMGR_BRGMODRST	0x1c
+
+/* System Manager bits */
+#define RSTMGR_CTRL_SWCOLDRSTREQ	0x1	/* Cold Reset */
+#define RSTMGR_CTRL_SWWARMRSTREQ	0x2	/* Warm Reset */
+/*MPU Module Reset Register */
+#define RSTMGR_MPUMODRST_CPU0	0x1	/*CPU0 Reset*/
+#define RSTMGR_MPUMODRST_CPU1	0x2	/*CPU1 Reset*/
+#define RSTMGR_MPUMODRST_WDS		0x4	/*Watchdog Reset*/
+#define RSTMGR_MPUMODRST_SCUPER	0x8	/*SCU and periphs reset*/
+#define RSTMGR_MPUMODRST_L2		0x10	/*L2 Cache reset*/
+
 extern void socfpga_secondary_startup(void);
 extern void __iomem *socfpga_scu_base_addr;
 
 extern void socfpga_init_clocks(void);
 extern void socfpga_sysmgr_init(void);
 
+extern void __iomem *sys_manager_base_addr;
+extern void __iomem *rst_manager_base_addr;
+
 extern struct smp_operations socfpga_smp_ops;
 extern char secondary_trampoline, secondary_trampoline_end;
 
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 84c60fa..c75c33d 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -30,9 +30,6 @@
 
 #include "core.h"
 
-extern void __iomem *sys_manager_base_addr;
-extern void __iomem *rst_manager_base_addr;
-
 static void __cpuinit socfpga_secondary_init(unsigned int cpu)
 {
 	/*
@@ -100,6 +97,12 @@ static void __init socfpga_smp_prepare_cpus(unsigned int max_cpus)
  */
 static void socfpga_cpu_die(unsigned int cpu)
 {
+	/* Flush the L1 data cache. */
+	flush_cache_all();
+
+	/* This will put CPU1 into reset.*/
+	__raw_writel(RSTMGR_MPUMODRST_CPU1, rst_manager_base_addr + 0x10);
+
 	cpu_do_idle();
 
 	/* We should have never returned from idle */
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 1042c02..b41a945 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -87,7 +87,15 @@ static void __init socfpga_init_irq(void)
 
 static void socfpga_cyclone5_restart(char mode, const char *cmd)
 {
-	/* TODO: */
+	u32 temp;
+
+	temp = __raw_readl(rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
+
+	if (mode == 'h')
+		temp |= RSTMGR_CTRL_SWCOLDRSTREQ;
+	else
+		temp |= RSTMGR_CTRL_SWWARMRSTREQ;
+	__raw_writel(temp, rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
 }
 
 static void __init socfpga_cyclone5_init(void)
-- 
1.7.9.5
