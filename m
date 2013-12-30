From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 11:19:28 +0100
Subject: [PATCH 09/20] clocksource: cadence_ttc_timer: Switch to
 sched_clock_register()
In-Reply-To: <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
References: <52C1479E.80808@linaro.org>
 <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1388398779-11222-9-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Michal Simek <monstr@monstr.eu>
Tested-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/cadence_ttc_timer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index b2bb3a4b..b865b4e 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -158,7 +158,7 @@ static cycle_t __ttc_clocksource_read(struct clocksource *cs)
 				TTC_COUNT_VAL_OFFSET);
 }
 
-static u32 notrace ttc_sched_clock_read(void)
+static u64 notrace ttc_sched_clock_read(void)
 {
 	return __raw_readl(ttc_sched_clock_val_reg);
 }
@@ -306,7 +306,7 @@ static void __init ttc_setup_clocksource(struct clk *clk, void __iomem *base)
 	}
 
 	ttc_sched_clock_val_reg = base + TTC_COUNT_VAL_OFFSET;
-	setup_sched_clock(ttc_sched_clock_read, 16,
+	sched_clock_register(ttc_sched_clock_read, 16,
 			clk_get_rate(ttccs->ttc.clk) / PRESCALE);
 }
 
-- 
1.7.9.5
