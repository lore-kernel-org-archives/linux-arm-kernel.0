From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 11 Apr 2013 10:55:24 -0500
Subject: [PATCHv3 1/3] ARM: socfpga: Enable soft reset
Message-ID: <1365695726-26849-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Enable a cold or warm reset to the HW from userspace.

Also fix a few sparse errors:

warning: symbol 'sys_manager_base_addr' was not declared. Should it be static?
warning: symbol 'rst_manager_base_addr' was not declared. Should it be static?

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

v3:
- Use regular readl/writel

v2:
- Remove hotplug support while investigating on how implement PSCI
---
 arch/arm/mach-socfpga/core.h    |   11 +++++++++++
 arch/arm/mach-socfpga/platsmp.c |    3 ---
 arch/arm/mach-socfpga/socfpga.c |   10 +++++++++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 315edff..572b8f7 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -20,12 +20,23 @@
 #ifndef __MACH_CORE_H
 #define __MACH_CORE_H
 
+#define SOCFPGA_RSTMGR_CTRL	0x04
+#define SOCFPGA_RSTMGR_MODPERRST	0x14
+#define SOCFPGA_RSTMGR_BRGMODRST	0x1c
+
+/* System Manager bits */
+#define RSTMGR_CTRL_SWCOLDRSTREQ	0x1	/* Cold Reset */
+#define RSTMGR_CTRL_SWWARMRSTREQ	0x2	/* Warm Reset */
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
index 84c60fa..b907fb9 100644
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
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 1042c02..2cae16c 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -87,7 +87,15 @@ static void __init socfpga_init_irq(void)
 
 static void socfpga_cyclone5_restart(char mode, const char *cmd)
 {
-	/* TODO: */
+	u32 temp;
+
+	temp = readl(rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
+
+	if (mode == 'h')
+		temp |= RSTMGR_CTRL_SWCOLDRSTREQ;
+	else
+		temp |= RSTMGR_CTRL_SWWARMRSTREQ;
+	writel(temp, rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
 }
 
 static void __init socfpga_cyclone5_init(void)
-- 
1.7.9.5
