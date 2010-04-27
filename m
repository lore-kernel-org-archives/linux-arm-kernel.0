From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 27 Apr 2010 09:46:50 +0530
Subject: [PATCH 12/14] ux500: use UX500_* macros instead of U8500_*
In-Reply-To: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272341812-4622-13-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So that the correct addresses get used on U5500.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/include/mach/entry-macro.S |    2 +-
 arch/arm/mach-ux500/platsmp.c                  |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ux500/include/mach/entry-macro.S b/arch/arm/mach-ux500/include/mach/entry-macro.S
index eece330..60ea88d 100644
--- a/arch/arm/mach-ux500/include/mach/entry-macro.S
+++ b/arch/arm/mach-ux500/include/mach/entry-macro.S
@@ -17,7 +17,7 @@
 		.endm
 
 		.macro  get_irqnr_preamble, base, tmp
-		ldr     \base, =IO_ADDRESS(U8500_GIC_CPU_BASE)
+		ldr     \base, =IO_ADDRESS(UX500_GIC_CPU_BASE)
 		.endm
 
 		.macro  arch_ret_to_user, tmp1, tmp2
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 76dd935..438ef16 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -30,7 +30,7 @@ volatile int __cpuinitdata pen_release = -1;
 
 static unsigned int __init get_core_count(void)
 {
-	return scu_get_core_count(__io_address(U8500_SCU_BASE));
+	return scu_get_core_count(__io_address(UX500_SCU_BASE));
 }
 
 static DEFINE_SPINLOCK(boot_lock);
@@ -44,7 +44,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * core (e.g. timer irq), then they will not have been enabled
 	 * for us: do so
 	 */
-	gic_cpu_init(0, __io_address(U8500_GIC_CPU_BASE));
+	gic_cpu_init(0, __io_address(UX500_GIC_CPU_BASE));
 
 	/*
 	 * let the primary processor know we're out of the
@@ -106,12 +106,12 @@ static void __init wakeup_secondary(void)
 	 */
 #define U8500_CPU1_JUMPADDR_OFFSET 0x1FF4
 	__raw_writel(virt_to_phys(u8500_secondary_startup),
-		(void __iomem *)IO_ADDRESS(U8500_BACKUPRAM0_BASE) +
+		__io_address(UX500_BACKUPRAM0_BASE) +
 		U8500_CPU1_JUMPADDR_OFFSET);
 
 #define U8500_CPU1_WAKEMAGIC_OFFSET 0x1FF0
 	__raw_writel(0xA1FEED01,
-		(void __iomem *)IO_ADDRESS(U8500_BACKUPRAM0_BASE) +
+		__io_address(UX500_BACKUPRAM0_BASE) +
 		U8500_CPU1_WAKEMAGIC_OFFSET);
 
 	/* make sure write buffer is drained */
@@ -172,7 +172,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		 * boot CPU, but only if we have more than one CPU.
 		 */
 		percpu_timer_setup();
-		scu_enable(__io_address(U8500_SCU_BASE));
+		scu_enable(__io_address(UX500_SCU_BASE));
 		wakeup_secondary();
 	}
 }
-- 
1.7.0
