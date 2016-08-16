From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 16 Aug 2016 15:27:17 +0900
Subject: [PATCH 1/7] clocksource: exynos_mct: Add the support for Exynos 64bit
 SoC
In-Reply-To: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1471328843-26653-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the support for Exynos 64bit SoC. The delay_timer is only used
for 32bit SoC.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clocksource/Kconfig      | 2 +-
 drivers/clocksource/exynos_mct.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 567788664723..ec443c318c77 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -351,7 +351,7 @@ config CLKSRC_METAG_GENERIC
 
 config CLKSRC_EXYNOS_MCT
 	bool "Exynos multi core timer driver" if COMPILE_TEST
-	depends on ARM
+	depends on ARM || ARM64
 	help
 	  Support for Multi Core Timer controller on Exynos SoCs.
 
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 41840d02c331..8f3488b80896 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -223,6 +223,7 @@ static u64 notrace exynos4_read_sched_clock(void)
 	return exynos4_read_count_32();
 }
 
+#if defined(CONFIG_ARM)
 static struct delay_timer exynos4_delay_timer;
 
 static cycles_t exynos4_read_current_timer(void)
@@ -231,14 +232,17 @@ static cycles_t exynos4_read_current_timer(void)
 			 "cycles_t needs to move to 32-bit for ARM64 usage");
 	return exynos4_read_count_32();
 }
+#endif
 
 static int __init exynos4_clocksource_init(void)
 {
 	exynos4_mct_frc_start();
 
+#if defined(CONFIG_ARM)
 	exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;
 	exynos4_delay_timer.freq = clk_rate;
 	register_current_timer_delay(&exynos4_delay_timer);
+#endif
 
 	if (clocksource_register_hz(&mct_frc, clk_rate))
 		panic("%s: can't register clocksource\n", mct_frc.name);
-- 
1.9.1
