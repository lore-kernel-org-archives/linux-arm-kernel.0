From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Apr 2014 09:47:52 +0200
Subject: [PATCH 06/17] ARM: exynos: cpuidle: Fix S5P_WAKEUP_STAT call
In-Reply-To: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1396597683-6969-7-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function should be called only when the powerdown sequence fails.

Even if the current code does not hurt, by moving this line, we have the same
code than the one in pm.c.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 9cd1ed9..a1e1882 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -135,11 +135,10 @@ static int exynos_enter_core0_aftr(struct cpuidle_device *dev,
 	if (!(tmp & S5P_CENTRAL_LOWPWR_CFG)) {
 		tmp |= S5P_CENTRAL_LOWPWR_CFG;
 		__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
+		/* Clear wakeup state register */
+		__raw_writel(0x0, S5P_WAKEUP_STAT);
 	}
 
-	/* Clear wakeup state register */
-	__raw_writel(0x0, S5P_WAKEUP_STAT);
-
 	return index;
 }
 
-- 
1.7.9.5
