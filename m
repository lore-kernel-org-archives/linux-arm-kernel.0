From: digetx@gmail.com (Dmitry Osipenko)
Date: Thu, 30 Aug 2018 21:04:20 +0300
Subject: [PATCH v3 7/8] ARM: tegra: Support L2 cache maintenance done via
 firmware
In-Reply-To: <20180830180421.6415-1-digetx@gmail.com>
References: <20180830180421.6415-1-digetx@gmail.com>
Message-ID: <20180830180421.6415-8-digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trusted Foundations firmware require MMU to be enabled for L2 cache
maintenance on Tegra30, hence perform the maintenance early-late on
suspend-resume respectively.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c            | 36 +++++++++++++++++++++++++++++
 arch/arm/mach-tegra/reset-handler.S |  8 ++-----
 arch/arm/mach-tegra/sleep.S         |  4 ++++
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 1ad5719779b0..66c8cd63dd86 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -38,6 +38,7 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
+#include <asm/trusted_foundations.h>
 
 #include "iomap.h"
 #include "pm.h"
@@ -195,8 +196,27 @@ void tegra_idle_lp2_last(void)
 	cpu_cluster_pm_enter();
 	suspend_cpu_complex();
 
+	/*
+	 * L2 cache disabling using kernel API only allowed when all
+	 * secondary CPU's are offline. Cache have to be disabled early
+	 * if cache maintenance is done via Trusted Foundations firmware.
+	 * Note that CPUIDLE won't ever enter powergate on Tegra30 if any
+	 * of secondary CPU's is online and this is the LP2 codepath only
+	 * for Tegra20/30.
+	 */
+	if (trusted_foundations_registered())
+		outer_disable();
+
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
 
+	/*
+	 * Resume L2 cache if it wasn't re-enabled early during resume,
+	 * which is the case for Tegra30 that has to re-enable the cache
+	 * via firmware call. In other cases cache is already enabled and
+	 * hence re-enabling is a no-op.
+	 */
+	outer_resume();
+
 	restore_cpu_complex();
 	cpu_cluster_pm_exit();
 }
@@ -340,8 +360,24 @@ static int tegra_suspend_enter(suspend_state_t state)
 		break;
 	}
 
+	/*
+	 * Cache have to be disabled early if cache maintenance is done
+	 * via Trusted Foundations firmware. Otherwise this is a no-op,
+	 * like on Tegra114+.
+	 */
+	if (trusted_foundations_registered())
+		outer_disable();
+
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, tegra_sleep_func);
 
+	/*
+	 * Resume L2 cache if it wasn't re-enabled early during resume,
+	 * which is the case for Tegra30 that has to re-enable the cache
+	 * via firmware call. In other cases cache is already enabled and
+	 * hence re-enabling is a no-op.
+	 */
+	outer_resume();
+
 	switch (mode) {
 	case TEGRA_SUSPEND_LP1:
 		tegra_suspend_exit_lp1();
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 555c652f5a07..4973ea053bd7 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -69,7 +69,7 @@ ENTRY(tegra_resume)
 
 	mov32	r9, 0xc09
 	cmp	r8, r9
-	bne	end_ca9_scu_l2_resume
+	bne	end_ca9_scu_resume
 #ifdef CONFIG_HAVE_ARM_SCU
 	/* enable SCU */
 	mov32	r0, TEGRA_ARM_PERIF_BASE
@@ -78,11 +78,7 @@ ENTRY(tegra_resume)
 	str	r1, [r0]
 #endif
 
-#ifdef CONFIG_CACHE_L2X0
-	/* L2 cache resume & re-enable */
-	bl	l2c310_early_resume
-#endif
-end_ca9_scu_l2_resume:
+end_ca9_scu_resume:
 	mov32	r9, 0xc0f
 	cmp	r8, r9
 	bleq	tegra_init_l2_for_a15
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 5e3496753df1..b96126fe5dc5 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -132,8 +132,12 @@ ENTRY(tegra_shut_off_mmu)
 #ifdef CONFIG_CACHE_L2X0
 	/* Disable L2 cache */
 	check_cpu_part_num 0xc09, r9, r10
+	retne	r0
+
 	movweq	r2, #:lower16:(TEGRA_ARM_PERIF_BASE + 0x3000)
 	movteq	r2, #:upper16:(TEGRA_ARM_PERIF_BASE + 0x3000)
+	ldr	r3, [r2, #L2X0_CTRL]
+	cmp	r3, #1
 	moveq	r3, #0
 	streq	r3, [r2, #L2X0_CTRL]
 #endif
-- 
2.18.0
