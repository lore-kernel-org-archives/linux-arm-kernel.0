From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Oct 2012 23:22:56 +0800
Subject: [PATCH 07/10] ARM: imx6q: get v7_cpu_resume ready for cpuidle
In-Reply-To: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1351005779-30347-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To get v7_cpu_resume ready for cpuidle power gating case, we need the
following changes.

* L2X0_POWER_CTRL register needs to be restored.

* Enable SCU inside v7_cpu_resume.  As the result, function
  imx_smp_prepare gets eliminated.

* Remove v7_invalidate_l1 invoking from v7_cpu_resume.  It turns out
  that v7_invalidate_l1 only needs to be called for secondary cores
  startup.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/common.h   |    2 --
 arch/arm/mach-imx/headsmp.S  |   25 ++++++++++++++++++++++---
 arch/arm/mach-imx/platsmp.c  |    7 +------
 arch/arm/mach-imx/pm-imx6q.c |    1 -
 4 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 9ff0776..ea11bbc 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -125,11 +125,9 @@ extern u32 *pl310_get_save_ptr(void);
 #ifdef CONFIG_SMP
 extern void v7_secondary_startup(void);
 extern void imx_scu_map_io(void);
-extern void imx_smp_prepare(void);
 extern void imx_scu_standby_enable(bool enable);
 #else
 static inline void imx_scu_map_io(void) {}
-static inline void imx_smp_prepare(void) {}
 static inline void imx_scu_standby_enable(bool enable) {}
 #endif
 extern void imx_enable_cpu(int cpu, bool enable);
diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
index 7e49deb..ac8a967 100644
--- a/arch/arm/mach-imx/headsmp.S
+++ b/arch/arm/mach-imx/headsmp.S
@@ -27,8 +27,7 @@
  * clean + invalidate, before jumping into the kernel.
  *
  * This funciton is cloned from arch/arm/mach-tegra/headsmp.S, and needs
- * to be called for both secondary cores startup and primary core resume
- * procedures.  Ideally, it should be moved into arch/arm/mm/cache-v7.S.
+ * to be called for secondary cores startup.
  */
 ENTRY(v7_invalidate_l1)
 	mov	r0, #0
@@ -84,10 +83,16 @@ ENDPROC(v7_secondary_startup)
 	.macro	pl310_resume
 	ldr	r2, phys_l2x0_saved_regs
 	ldr	r0, [r2, #L2X0_R_PHY_BASE]	@ get physical base of l2x0
+	ldr	r1, [r0, #L2X0_CTRL]		@ check if already enabled
+	tst	r1, #1
+	bne	1f
 	ldr	r1, [r2, #L2X0_R_AUX_CTRL]	@ get aux_ctrl value
 	str	r1, [r0, #L2X0_AUX_CTRL]	@ restore aux_ctrl
+	ldr	r1, [r2, #L2X0_R_PWR_CTRL]
+	str	r1, [r0, #L2X0_POWER_CTRL]
 	mov	r1, #0x1
 	str	r1, [r0, #L2X0_CTRL]		@ re-enable L2
+1:
 	.endm
 
 	.globl	phys_l2x0_saved_regs
@@ -98,9 +103,23 @@ phys_l2x0_saved_regs:
 	.endm
 #endif
 
+#ifdef CONFIG_SMP
+	.macro	_scu_enable
+	/* Enable SCU */
+	mrc	p15, 4, r0, c15, c0, 0		@ r0 = scu physical base
+	ldr	r1, [r0]			@ r1 = scu control register
+	tst	r1, #0x1			@ check if already enabled
+	orreq	r1, r1, #0x1
+	streq	r1, [r0]
+	.endm
+#else
+	.macro	_scu_enable
+	.endm
+#endif
+
 ENTRY(v7_cpu_resume)
-	bl	v7_invalidate_l1
 	pl310_resume
+	_scu_enable
 	b	cpu_resume
 ENDPROC(v7_cpu_resume)
 #endif
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index c739a8a..fc25062 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -89,14 +89,9 @@ static void __init imx_smp_init_cpus(void)
 	set_smp_cross_call(gic_raise_softirq);
 }
 
-void imx_smp_prepare(void)
-{
-	scu_enable(scu_base);
-}
-
 static void __init imx_smp_prepare_cpus(unsigned int max_cpus)
 {
-	imx_smp_prepare();
+	scu_enable(scu_base);
 }
 
 struct smp_operations  imx_smp_ops __initdata = {
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
index a17543d..7c4347b 100644
--- a/arch/arm/mach-imx/pm-imx6q.c
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -39,7 +39,6 @@ static int imx6q_pm_enter(suspend_state_t state)
 		imx_set_cpu_jump(0, v7_cpu_resume);
 		/* Zzz ... */
 		cpu_suspend(0, imx6q_suspend_finish);
-		imx_smp_prepare();
 		imx_gpc_post_resume();
 		break;
 	default:
-- 
1.7.9.5
