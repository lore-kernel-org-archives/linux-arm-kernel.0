From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Jul 2011 10:57:35 +0900
Subject: [PATCH V2 6/8] ARM: EXYNOS4: Move S5P_CENTRAL_SEQ_CONFIGURATION
	setting for PM
In-Reply-To: <1309485457-13305-1-git-send-email-kgene.kim@samsung.com>
References: <1309485457-13305-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1309485457-13305-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaecheol Lee <jc.lee@samsung.com>

We need to balance between set and check S5P_CENTRAL_SEQ_CONFIGURATION
register in syscore_ops suspend/resume function when failure in enter
suspend mode. Moved this register setting for PM for the purpose of balancing.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/pm.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
index 17d43c2..a658318 100644
--- a/arch/arm/mach-exynos4/pm.c
+++ b/arch/arm/mach-exynos4/pm.c
@@ -240,14 +240,6 @@ static struct sleep_save exynos4_l2cc_save[] = {
 
 void exynos4_cpu_suspend(unsigned long arg)
 {
-	unsigned long tmp;
-
-	/* Setting Central Sequence Register for power down mode */
-
-	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
-	tmp &= ~(S5P_CENTRAL_LOWPWR_CFG);
-	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
-
 	outer_flush_all();
 
 	/* issue the standby signal into the pm unit. */
@@ -327,6 +319,19 @@ static __init int exynos4_pm_drvinit(void)
 }
 arch_initcall(exynos4_pm_drvinit);
 
+static int exynos4_pm_suspend(void)
+{
+	unsigned long tmp;
+
+	/* Setting Central Sequence Register for power down mode */
+
+	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
+	tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
+	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
+
+	return 0;
+}
+
 static void exynos4_pm_resume(void)
 {
 	unsigned long tmp;
@@ -371,6 +376,7 @@ early_wakeup:
 }
 
 static struct syscore_ops exynos4_pm_syscore_ops = {
+	.suspend	= exynos4_pm_suspend,
 	.resume		= exynos4_pm_resume,
 };
 
-- 
1.7.1
