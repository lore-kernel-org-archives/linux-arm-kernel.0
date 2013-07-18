From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Jul 2013 16:21:25 -0700
Subject: [PATCH v4 12/17] clocksource: samsung_pwm_timer: Switch to
 sched_clock_register()
In-Reply-To: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374189690-10810-13-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/samsung_pwm_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 584b547..09e8bc7 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -310,7 +310,7 @@ static void __iomem *samsung_timer_reg(void)
  * this wraps around for now, since it is just a relative time
  * stamp. (Inspired by U300 implementation.)
  */
-static u32 notrace samsung_read_sched_clock(void)
+static u64 notrace samsung_read_sched_clock(void)
 {
 	void __iomem *reg = samsung_timer_reg();
 
@@ -337,7 +337,7 @@ static void __init samsung_clocksource_init(void)
 	samsung_time_setup(pwm.source_id, pwm.tcnt_max);
 	samsung_time_start(pwm.source_id, true);
 
-	setup_sched_clock(samsung_read_sched_clock,
+	sched_clock_register(samsung_read_sched_clock,
 						pwm.variant.bits, clock_rate);
 
 	ret = clocksource_mmio_init(reg, "samsung_clocksource_timer",
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
