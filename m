From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 22 Jun 2011 17:46:42 +0900
Subject: [PATCH 4/7] ARM: EXYNOS4: Support early wakeup while entering sleep
	mode
In-Reply-To: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
References: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1308732405-16664-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaecheol Lee <jc.lee@samsung.com>

We don't need to masking GIC with external GIC and changed in handling
early wakeup interrupt situation. In case of early wakeup situation,
PMU dosen't enter sleep mode by WFI wihch will be ignored.
This patch can handle this abnormal situation by early wakeup interrupt.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/pm.c    |   43 ++++++++++++++++++----------------------
 arch/arm/mach-exynos4/sleep.S |   15 +++++++++++--
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
index bf53588..f4d52b5 100644
--- a/arch/arm/mach-exynos4/pm.c
+++ b/arch/arm/mach-exynos4/pm.c
@@ -241,7 +241,6 @@ static struct sleep_save exynos4_l2cc_save[] = {
 void exynos4_cpu_suspend(void)
 {
 	unsigned long tmp;
-	unsigned long mask = 0xFFFFFFFF;
 
 	/* Setting Central Sequence Register for power down mode */
 
@@ -249,33 +248,10 @@ void exynos4_cpu_suspend(void)
 	tmp &= ~(S5P_CENTRAL_LOWPWR_CFG);
 	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
 
-	/* Setting Central Sequence option Register */
-
-	tmp = __raw_readl(S5P_CENTRAL_SEQ_OPTION);
-	tmp &= ~(S5P_USE_MASK);
-	tmp |= S5P_USE_STANDBY_WFI0;
-	__raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
-
-	/* Clear all interrupt pending to avoid early wakeup */
-
-	__raw_writel(mask, (S5P_VA_GIC_DIST + 0x280));
-	__raw_writel(mask, (S5P_VA_GIC_DIST + 0x284));
-	__raw_writel(mask, (S5P_VA_GIC_DIST + 0x288));
-
-	/* Disable all interrupt */
-
-	__raw_writel(0x0, (S5P_VA_GIC_CPU + 0x000));
-	__raw_writel(0x0, (S5P_VA_GIC_DIST + 0x000));
-	__raw_writel(mask, (S5P_VA_GIC_DIST + 0x184));
-	__raw_writel(mask, (S5P_VA_GIC_DIST + 0x188));
-
 	outer_flush_all();
 
 	/* issue the standby signal into the pm unit. */
 	cpu_do_idle();
-
-	/* we should never get past here */
-	panic("sleep resumed to originator?");
 }
 
 static void exynos4_pm_prepare(void)
@@ -353,6 +329,22 @@ arch_initcall(exynos4_pm_drvinit);
 
 static void exynos4_pm_resume(void)
 {
+	unsigned long tmp;
+
+	/*
+	 * If PMU failed while entering sleep mode, WFI will be
+	 * ignored by PMU and then exiting cpu_do_idle().
+	 * S5P_CENTRAL_LOWPWR_CFG bit will not be set automatically
+	 * in this situation.
+	 */
+	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
+	if (!(tmp & S5P_CENTRAL_LOWPWR_CFG)) {
+		tmp |= S5P_CENTRAL_LOWPWR_CFG;
+		__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
+		/* No need to perform below restore code */
+		goto early_wakeup;
+	}
+
 	/* For release retention */
 
 	__raw_writel((1 << 28), S5P_PAD_RET_MAUDIO_OPTION);
@@ -373,6 +365,9 @@ static void exynos4_pm_resume(void)
 	/* enable L2X0*/
 	writel_relaxed(1, S5P_VA_L2CC + L2X0_CTRL);
 #endif
+
+early_wakeup:
+	return;
 }
 
 static struct syscore_ops exynos4_pm_syscore_ops = {
diff --git a/arch/arm/mach-exynos4/sleep.S b/arch/arm/mach-exynos4/sleep.S
index 6b62425..d55d38c 100644
--- a/arch/arm/mach-exynos4/sleep.S
+++ b/arch/arm/mach-exynos4/sleep.S
@@ -45,11 +45,20 @@ ENTRY(s3c_cpu_save)
 	ldr	r3, =resume_with_mmu
 	bl	cpu_suspend
 
-	ldr	r0, =pm_cpu_sleep
-	ldr	r0, [ r0 ]
-	mov	pc, r0
+	bl	exynos4_cpu_suspend
+
+	/* Restore original sp */
+	mov	r0, sp
+	add	r0, r0, #4
+	ldr	sp, [r0]
+
+	mov	r0, #0
+	b	early_wakeup
 
 resume_with_mmu:
+	mov	r0, #1
+
+early_wakeup:
 	ldmfd	sp!, { r3 - r12, pc }
 
 	.ltorg
-- 
1.7.1
