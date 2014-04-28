From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:32:09 +0100
Subject: [PATCH 70/97] ARM: l2c: tegra: convert to common l2c310 early resume
 functionality
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerHd-0001YS-LA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-tegra/pm.h            |  2 --
 arch/arm/mach-tegra/reset-handler.S | 11 +++--------
 arch/arm/mach-tegra/sleep.h         | 31 -------------------------------
 arch/arm/mach-tegra/tegra.c         |  6 +-----
 4 files changed, 4 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 6e92a7c2ecbd..f4a89698e5b0 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -35,8 +35,6 @@ void tegra20_sleep_core_init(void);
 void tegra30_lp1_iram_hook(void);
 void tegra30_sleep_core_init(void);
 
-extern unsigned long l2x0_saved_regs_addr;
-
 void tegra_clear_cpu_in_lp2(void);
 bool tegra_set_cpu_in_lp2(void);
 
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 8c1ba4fea384..578d4d1ad648 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -19,7 +19,6 @@
 
 #include <asm/cache.h>
 #include <asm/asm-offsets.h>
-#include <asm/hardware/cache-l2x0.h>
 
 #include "flowctrl.h"
 #include "fuse.h"
@@ -78,8 +77,10 @@ ENTRY(tegra_resume)
 	str	r1, [r0]
 #endif
 
+#ifdef CONFIG_CACHE_L2X0
 	/* L2 cache resume & re-enable */
-	l2_cache_resume r0, r1, r2, l2x0_saved_regs_addr
+	bl	l2c310_early_resume
+#endif
 end_ca9_scu_l2_resume:
 	mov32	r9, 0xc0f
 	cmp	r8, r9
@@ -89,12 +90,6 @@ end_ca9_scu_l2_resume:
 ENDPROC(tegra_resume)
 #endif
 
-#ifdef CONFIG_CACHE_L2X0
-	.globl	l2x0_saved_regs_addr
-l2x0_saved_regs_addr:
-	.long	0
-#endif
-
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler_start)
 
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index a032820d2fac..339fe42cd6fb 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -120,37 +120,6 @@
 	mov	\tmp1, \tmp1, lsr #8
 .endm
 
-/* Macro to resume & re-enable L2 cache */
-#ifndef L2X0_CTRL_EN
-#define L2X0_CTRL_EN	1
-#endif
-
-#ifdef CONFIG_CACHE_L2X0
-.macro l2_cache_resume, tmp1, tmp2, tmp3, phys_l2x0_saved_regs
-	W(adr)	\tmp1, \phys_l2x0_saved_regs
-	ldr	\tmp1, [\tmp1]
-	ldr	\tmp2, [\tmp1, #L2X0_R_PHY_BASE]
-	ldr	\tmp3, [\tmp2, #L2X0_CTRL]
-	tst	\tmp3, #L2X0_CTRL_EN
-	bne	exit_l2_resume
-	ldr	\tmp3, [\tmp1, #L2X0_R_TAG_LATENCY]
-	str	\tmp3, [\tmp2, #L310_TAG_LATENCY_CTRL]
-	ldr	\tmp3, [\tmp1, #L2X0_R_DATA_LATENCY]
-	str	\tmp3, [\tmp2, #L310_DATA_LATENCY_CTRL]
-	ldr	\tmp3, [\tmp1, #L2X0_R_PREFETCH_CTRL]
-	str	\tmp3, [\tmp2, #L310_PREFETCH_CTRL]
-	ldr	\tmp3, [\tmp1, #L2X0_R_PWR_CTRL]
-	str	\tmp3, [\tmp2, #L310_POWER_CTRL]
-	ldr	\tmp3, [\tmp1, #L2X0_R_AUX_CTRL]
-	str	\tmp3, [\tmp2, #L2X0_AUX_CTRL]
-	mov	\tmp3, #L2X0_CTRL_EN
-	str	\tmp3, [\tmp2, #L2X0_CTRL]
-exit_l2_resume:
-.endm
-#else /* CONFIG_CACHE_L2X0 */
-.macro l2_cache_resume, tmp1, tmp2, tmp3, phys_l2x0_saved_regs
-.endm
-#endif /* CONFIG_CACHE_L2X0 */
 #else
 void tegra_pen_lock(void);
 void tegra_pen_unlock(void);
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index fb802e24b647..1bc49f9db015 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -73,11 +73,7 @@ u32 tegra_uart_config[3] = {
 static void __init tegra_init_cache(void)
 {
 #ifdef CONFIG_CACHE_L2X0
-	int ret;
-
-	ret = l2x0_of_init(0x3c400001, 0xc20fc3fe);
-	if (!ret)
-		l2x0_saved_regs_addr = virt_to_phys(&l2x0_saved_regs);
+	l2x0_of_init(0x3c400001, 0xc20fc3fe);
 #endif
 }
 
-- 
1.8.3.1
