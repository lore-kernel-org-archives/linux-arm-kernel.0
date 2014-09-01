From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 1 Sep 2014 09:02:18 +0800
Subject: [PATCH] ARM: imx: remove imx_scu_standby_enable()
Message-ID: <1409533338-4111-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit c716483c3db1 ("ARM: 8122/1: smp_scu: enable SCU standby
support"), the STANDBY bit of SCU is handled by core function
scu_enable().  So imx_scu_standby_enable() can be removed now.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/common.h        | 2 --
 arch/arm/mach-imx/cpuidle-imx6q.c | 4 ----
 arch/arm/mach-imx/platsmp.c       | 8 --------
 3 files changed, 14 deletions(-)

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
index 5b57c17c06bd..31edbcd70c27 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -45,14 +45,6 @@ void __init imx_scu_map_io(void)
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
