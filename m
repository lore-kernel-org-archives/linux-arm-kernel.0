From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 21 Jul 2014 15:45:55 +0800
Subject: [PATCH 3/3] ARM: imx: remove SCU standby enable code
In-Reply-To: <1405928755-19413-1-git-send-email-shawn.guo@freescale.com>
References: <1405928755-19413-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1405928755-19413-4-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have scu_enable() enables SCU standby support at SCU core
level, the code enabling SCU standby at i.MX platform level can be
removed now.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/common.h        |  2 --
 arch/arm/mach-imx/cpuidle-imx6q.c |  4 ----
 arch/arm/mach-imx/platsmp.c       | 10 ----------
 3 files changed, 16 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 22ba8973bcb9..1dabf435c592 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -98,11 +98,9 @@ void imx_set_cpu_arg(int cpu, u32 arg);
 void v7_secondary_startup(void);
 void imx_scu_map_io(void);
 void imx_smp_prepare(void);
-void imx_scu_standby_enable(void);
 #else
 static inline void imx_scu_map_io(void) {}
 static inline void imx_smp_prepare(void) {}
-static inline void imx_scu_standby_enable(void) {}
 #endif
 void imx_src_init(void);
 void imx_gpc_init(void);
diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index 10844d3bb926..aa935787b743 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -66,10 +66,6 @@ static struct cpuidle_driver imx6q_cpuidle_driver = {
 
 int __init imx6q_cpuidle_init(void)
 {
-	/* Need to enable SCU standby for entering WAIT modes */
-	if (!cpu_is_imx6sx())
-		imx_scu_standby_enable();
-
 	/* Set INT_MEM_CLK_LPM bit to get a reliable WAIT mode support */
 	imx6q_set_int_mem_clk_lpm(true);
 
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 5b57c17c06bd..771bd25c1025 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -20,8 +20,6 @@
 #include "common.h"
 #include "hardware.h"
 
-#define SCU_STANDBY_ENABLE	(1 << 5)
-
 u32 g_diag_reg;
 static void __iomem *scu_base;
 
@@ -45,14 +43,6 @@ void __init imx_scu_map_io(void)
 	scu_base = IMX_IO_ADDRESS(base);
 }
 
-void imx_scu_standby_enable(void)
-{
-	u32 val = readl_relaxed(scu_base);
-
-	val |= SCU_STANDBY_ENABLE;
-	writel_relaxed(val, scu_base);
-}
-
 static int imx_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	imx_set_cpu_jump(cpu, v7_secondary_startup);
-- 
1.9.1
