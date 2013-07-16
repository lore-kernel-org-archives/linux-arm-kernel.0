From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 16 Jul 2013 12:27:51 +0900
Subject: [PATCH] ARM: EXYNOS: skip pm support on exynos5440
Message-ID: <027501ce81d4$73a0a200$5ae1e600$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


EXYNOS5440 doesn't support PM and current single image for EXYNOS
will be break without this patch. Actually, SSDK5440 cannot boot
without this so this should be merged during -rc.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/pm.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 41c2069..c679db5 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -217,6 +217,9 @@ static __init int exynos_pm_drvinit(void)
 	struct clk *pll_base;
 	unsigned int tmp;
 
+	if (soc_is_exynos5440())
+		return 0;
+
 	s3c_pm_init();
 
 	/* All wakeup disable */
@@ -340,6 +343,9 @@ static struct syscore_ops exynos_pm_syscore_ops = {
 
 static __init int exynos_pm_syscore_init(void)
 {
+	if (soc_is_exynos5440())
+		return 0;
+
 	register_syscore_ops(&exynos_pm_syscore_ops);
 	return 0;
 }
-- 
1.7.10.4
