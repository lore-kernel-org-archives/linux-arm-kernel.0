From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Jul 2011 10:57:34 +0900
Subject: [PATCH V2 5/8] ARM: EXYNOS4: Support early wakeup entering sleep mode
In-Reply-To: <1309485457-13305-1-git-send-email-kgene.kim@samsung.com>
References: <1309485457-13305-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1309485457-13305-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaecheol Lee <jc.lee@samsung.com>

Since early wakeup can be handled in pm so we don't need masking
interrupts of external GIC. When the early wakeup interrupt happens,
PMU(Power Management Unit) ignores WFI instruction. This means that
PC(Program Counter) passed without any changes. This patch can handle
that case by early wakeup interrupt.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/pm.c |   43 +++++++++++++++++++------------------------
 1 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
index 9b5f3a5..17d43c2 100644
--- a/arch/arm/mach-exynos4/pm.c
+++ b/arch/arm/mach-exynos4/pm.c
@@ -241,7 +241,6 @@ static struct sleep_save exynos4_l2cc_save[] = {
 void exynos4_cpu_suspend(unsigned long arg)
 {
 	unsigned long tmp;
-	unsigned long mask = 0xFFFFFFFF;
 
 	/* Setting Central Sequence Register for power down mode */
 
@@ -249,33 +248,10 @@ void exynos4_cpu_suspend(unsigned long arg)
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
-- 
1.7.1
