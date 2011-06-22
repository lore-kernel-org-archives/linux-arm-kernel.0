From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jun 2011 16:13:35 +0100
Subject: [PATCH 15/25] ARM: pm: sa1100: move cpu_suspend into C code
In-Reply-To: <20110622150816.GT23234@n2100.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Message-ID: <E1QZP7X-0002Wj-Pl@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need a veneer for cpu_suspend, it can be called directly from
C code now.  Move it into sa11x0_pm_enter() along with the re-enabling
of clock switching.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/pm.c    |    7 +++++--
 arch/arm/mach-sa1100/sleep.S |   12 ++----------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-sa1100/pm.c b/arch/arm/mach-sa1100/pm.c
index c4661aa..7d8f80e 100644
--- a/arch/arm/mach-sa1100/pm.c
+++ b/arch/arm/mach-sa1100/pm.c
@@ -32,7 +32,7 @@
 #include <asm/system.h>
 #include <asm/mach/time.h>
 
-extern void sa1100_cpu_suspend(long);
+extern void sa1100_finish_suspend(unsigned long);
 
 #define SAVE(x)		sleep_save[SLEEP_SAVE_##x] = x
 #define RESTORE(x)	x = sleep_save[SLEEP_SAVE_##x]
@@ -75,7 +75,10 @@ static int sa11x0_pm_enter(suspend_state_t state)
 	PSPR = virt_to_phys(cpu_resume);
 
 	/* go zzz */
-	sa1100_cpu_suspend(PLAT_PHYS_OFFSET - PAGE_OFFSET);
+	cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, 0, sa1100_finish_suspend);
+
+	/* Re-enable clock switching */
+	asm volatile("mcr p15, 0, %0, c15, c1, 2" : : "r" (0));
 
 	cpu_init();
 
diff --git a/arch/arm/mach-sa1100/sleep.S b/arch/arm/mach-sa1100/sleep.S
index e814b60..e822331 100644
--- a/arch/arm/mach-sa1100/sleep.S
+++ b/arch/arm/mach-sa1100/sleep.S
@@ -22,21 +22,13 @@
 
 		.text
 /*
- * sa1100_cpu_suspend()
+ * sa1100_finish_suspend()
  *
  * Causes sa11x0 to enter sleep state
  *
  */
 
-ENTRY(sa1100_cpu_suspend)
-	mov	r9, lr
-	mov	r1, r0
-	adr	r3, BSYM(sa1100_finish_suspend)
-	bl	cpu_suspend
-	mcr	p15, 0, r1, c15, c1, 2		@ enable clock switching
-	mov	pc, r9				@ return to caller
-
-sa1100_finish_suspend:
+ENTRY(sa1100_finish_suspend)
 	@ disable clock switching
 	mcr	p15, 0, r1, c15, c2, 2
 
-- 
1.7.4.4
