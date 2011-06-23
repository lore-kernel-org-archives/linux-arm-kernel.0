From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Jun 2011 20:13:26 +0100
Subject: [PATCH 13/25] ARM: pm: sa1100: move cpu_suspend into C code
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Message-ID: <E1QZpLC-0005mj-0s@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need a veneer for cpu_suspend, it can be called directly from
C code now.  Move it into sa11x0_pm_enter() along with the re-enabling
of clock switching.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/pm.c    |    4 ++--
 arch/arm/mach-sa1100/sleep.S |   11 ++---------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-sa1100/pm.c b/arch/arm/mach-sa1100/pm.c
index d35885c..259ed3b 100644
--- a/arch/arm/mach-sa1100/pm.c
+++ b/arch/arm/mach-sa1100/pm.c
@@ -32,7 +32,7 @@
 #include <asm/system.h>
 #include <asm/mach/time.h>
 
-extern void sa1100_cpu_suspend(long);
+extern void sa1100_finish_suspend(unsigned long);
 
 #define SAVE(x)		sleep_save[SLEEP_SAVE_##x] = x
 #define RESTORE(x)	x = sleep_save[SLEEP_SAVE_##x]
@@ -75,7 +75,7 @@ static int sa11x0_pm_enter(suspend_state_t state)
 	PSPR = virt_to_phys(cpu_resume);
 
 	/* go zzz */
-	sa1100_cpu_suspend(PLAT_PHYS_OFFSET - PAGE_OFFSET);
+	cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, 0, sa1100_finish_suspend);
 
 	/*
 	 * Ensure not to come back here if it wasn't intended
diff --git a/arch/arm/mach-sa1100/sleep.S b/arch/arm/mach-sa1100/sleep.S
index f3fe397..e822331 100644
--- a/arch/arm/mach-sa1100/sleep.S
+++ b/arch/arm/mach-sa1100/sleep.S
@@ -22,20 +22,13 @@
 
 		.text
 /*
- * sa1100_cpu_suspend()
+ * sa1100_finish_suspend()
  *
  * Causes sa11x0 to enter sleep state
  *
  */
 
-ENTRY(sa1100_cpu_suspend)
-	stmfd	sp!, {r4 - r12, lr}		@ save registers on stack
-	mov	r1, r0
-	adr	r3, BSYM(sa1100_finish_suspend)
-	bl	cpu_suspend
-	ldmfd	sp!, {r4 - r12, pc}		@ return to caller
-
-sa1100_finish_suspend:
+ENTRY(sa1100_finish_suspend)
 	@ disable clock switching
 	mcr	p15, 0, r1, c15, c2, 2
 
-- 
1.7.4.4
