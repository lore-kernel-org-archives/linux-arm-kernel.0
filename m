From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 25 Apr 2011 13:40:57 +0900
Subject: [PATCH] arm: exynos4: PM Bugfix for not waking up from suspend-to-RAM
Message-ID: <1303706457-20936-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos4210 EVT1 (s5pc210-evt1) has an issue of not waking up from
suspend-to-RAM WAKEUP_MASK register's 31'b is not cleared before
entering a suspend. This patch clears every undocumented bits of
WAKEUP_MASK before entering a suspend and enabled sleep/wake in the
specified chip.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/pm.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
index 10d917d..1cef195 100644
--- a/arch/arm/mach-exynos4/pm.c
+++ b/arch/arm/mach-exynos4/pm.c
@@ -326,6 +326,10 @@ static void exynos4_pm_prepare(void)
 	s3c_pm_do_save(exynos4_core_save, ARRAY_SIZE(exynos4_core_save));
 	s3c_pm_do_save(exynos4_l2cc_save, ARRAY_SIZE(exynos4_l2cc_save));
 
+	/* EVT1 issues with undocumented S5P_WAKEUP_MASK bits. */
+	tmp = __raw_readl(S5P_WAKEUP_MASK);
+	__raw_writel(0x000fffff & tmp, S5P_WAKEUP_MASK);
+
 	tmp = __raw_readl(S5P_INFORM1);
 
 	/* Set value of power down register for sleep mode */
-- 
1.7.1
