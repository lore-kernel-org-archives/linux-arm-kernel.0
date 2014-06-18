From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Wed, 18 Jun 2014 17:01:00 +0530
Subject: [PATCH] clocksource: exynos-mct: Register the timer for stable udelay
Message-ID: <1403091060-5054-1-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch register the exynos mct clocksource as the current timer
as it has constant clock rate. This will generate correct udelay for the
exynos platform and avoid using unnecessary calibrated jiffies. This change
have been tested on exynos5420 based board.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---

Patches from David Riley confirmed that udelay is broken in exynos5420.
Link to those patches are,
1) https://patchwork.kernel.org/patch/4344911/
2) https://patchwork.kernel.org/patch/4344881/

 drivers/clocksource/exynos_mct.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 8d64200..57cb3dc 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -198,10 +198,21 @@ static u64 notrace exynos4_read_sched_clock(void)
 	return exynos4_frc_read(&mct_frc);
 }
 
+static struct delay_timer exynos4_delay_timer;
+
+static unsigned long exynos4_read_current_timer(void)
+{
+	return exynos4_frc_read(&mct_frc);
+}
+
 static void __init exynos4_clocksource_init(void)
 {
 	exynos4_mct_frc_start(0, 0);
 
+	exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;
+	exynos4_delay_timer.freq = clk_rate;
+	register_current_timer_delay(&exynos4_delay_timer);
+
 	if (clocksource_register_hz(&mct_frc, clk_rate))
 		panic("%s: can't register clocksource\n", mct_frc.name);
 
-- 
1.9.1
