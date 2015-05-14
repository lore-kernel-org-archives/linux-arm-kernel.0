From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 May 2015 18:12:38 +0200
Subject: [PATCH 02/10] ARM: ux500: remove static maps from platsmp
Message-ID: <1431619958-14890-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the reliance on static maps for SCU and backupram
for the SMP startup of the Ux500 SoC.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/platsmp.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index a44967f3168c..1e13d0a8ad77 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -26,6 +26,9 @@
 #include "db8500-regs.h"
 #include "id.h"
 
+static void __iomem *scu_base;
+static void __iomem *backupram;
+
 /* This is called from headsmp.S to wakeup the secondary core */
 extern void u8500_secondary_startup(void);
 
@@ -41,16 +44,6 @@ static void write_pen_release(int val)
 	sync_cache_w(&pen_release);
 }
 
-static void __iomem *scu_base_addr(void)
-{
-	if (cpu_is_u8500_family() || cpu_is_ux540_family())
-		return __io_address(U8500_SCU_BASE);
-	else
-		ux500_unknown_soc();
-
-	return NULL;
-}
-
 static DEFINE_SPINLOCK(boot_lock);
 
 static void ux500_secondary_init(unsigned int cpu)
@@ -104,13 +97,6 @@ static int ux500_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static void __init wakeup_secondary(void)
 {
-	void __iomem *backupram;
-
-	if (cpu_is_u8500_family() || cpu_is_ux540_family())
-		backupram = __io_address(U8500_BACKUPRAM0_BASE);
-	else
-		ux500_unknown_soc();
-
 	/*
 	 * write the address of secondary startup into the backup ram register
 	 * at offset 0x1FF4, then write the magic number 0xA1FEED01 to the
@@ -135,10 +121,11 @@ static void __init wakeup_secondary(void)
  */
 static void __init ux500_smp_init_cpus(void)
 {
-	void __iomem *scu_base = scu_base_addr();
 	unsigned int i, ncores;
 
-	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
+	scu_base = ioremap(U8500_SCU_BASE, 0x100);
+	backupram = ioremap(U8500_BACKUPRAM0_BASE, SZ_8K);
+	ncores = scu_get_core_count(scu_base);
 
 	/* sanity check */
 	if (ncores > nr_cpu_ids) {
@@ -153,8 +140,7 @@ static void __init ux500_smp_init_cpus(void)
 
 static void __init ux500_smp_prepare_cpus(unsigned int max_cpus)
 {
-
-	scu_enable(scu_base_addr());
+	scu_enable(scu_base);
 	wakeup_secondary();
 }
 
-- 
1.9.3
