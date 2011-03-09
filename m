From: jc.lee@samsung.com (Jaecheol Lee)
Date: Wed,  9 Mar 2011 11:08:41 +0900
Subject: [PATCH 3/3] ARM: EXYNOS4: Update HRT for supporting PM
In-Reply-To: <1299636521-4831-1-git-send-email-jc.lee@samsung.com>
References: <1299636521-4831-1-git-send-email-jc.lee@samsung.com>
Message-ID: <1299636521-4831-4-git-send-email-jc.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates HRT driver for supporting PM.
The resume function of PWM4 timer which is used clocksource is needed
when kernel is resuming for restarting.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
---
 arch/arm/mach-exynos4/time.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/time.c b/arch/arm/mach-exynos4/time.c
index e30ac70..86b9fa0 100644
--- a/arch/arm/mach-exynos4/time.c
+++ b/arch/arm/mach-exynos4/time.c
@@ -206,12 +206,28 @@ static cycle_t exynos4_pwm4_read(struct clocksource *cs)
 	return (cycle_t) ~__raw_readl(S3C_TIMERREG(0x40));
 }
 
+static void exynos4_pwm4_resume(struct clocksource *cs)
+{
+	unsigned long pclk;
+
+	pclk = clk_get_rate(timerclk);
+
+	clk_set_rate(tdiv4, pclk / 2);
+	clk_set_parent(tin4, tdiv4);
+
+	exynos4_pwm_init(4, ~0);
+	exynos4_pwm_start(4, 1);
+}
+
 struct clocksource pwm_clocksource = {
 	.name		= "pwm_timer4",
 	.rating		= 250,
 	.read		= exynos4_pwm4_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS ,
+#ifdef CONFIG_PM
+	.resume		= exynos4_pwm4_resume,
+#endif
 };
 
 static void __init exynos4_clocksource_init(void)
-- 
1.7.1
