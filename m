From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 10 Mar 2011 13:51:14 +0900
Subject: [PATCH V2 3/3] ARM: EXYNOS4: Update HRT for supporting PM
In-Reply-To: <1299732674-6752-1-git-send-email-kgene.kim@samsung.com>
References: <1299732674-6752-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1299732674-6752-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaecheol Lee <jc.lee@samsung.com>

This patch updates HRT driver for supporting PM.
The resume function of PWM4 timer which is used clocksource is needed
when kernel is resuming for restarting.

Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
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
