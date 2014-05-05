From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 05 May 2014 12:57:18 +0200
Subject: [PATCH 6/7] ARM: EXYNOS: PM: fix register setup on EXYNOS4x12 for AFTR
 mode code
In-Reply-To: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
References: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1399287439-31376-7-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add S5P_CENTRAL_SEQ_OPTION register setup for EXYNOS4x12 to AFTR
mode code.  Without this setup AFTR mode doesn't show any benefit
over WFI one.  When this setup is applied AFTR mode reduces power
consumption by ~12% (as measured on Trats2 board).

This change is a preparation for adding secure firmware support to
EXYNOS cpuidle driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/pm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 18f6bf8..3922968 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -391,6 +391,10 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
 	case CPU_PM_ENTER:
 		if (cpu == 0) {
 			exynos_pm_central_suspend();
+			if (soc_is_exynos4212() || soc_is_exynos4412())
+				__raw_writel(S5P_USE_STANDBY_WFI0 |
+					     S5P_USE_STANDBY_WFE0,
+					     S5P_CENTRAL_SEQ_OPTION);
 			exynos_cpu_save_register();
 		}
 		break;
-- 
1.8.2.3
