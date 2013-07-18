From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Jul 2013 16:21:26 -0700
Subject: [PATCH v4 13/17] clocksource: tegra: Switch to sched_clock_register()
In-Reply-To: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374189690-10810-14-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/tegra20_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index 9396170..5cff616 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -98,7 +98,7 @@ static struct clock_event_device tegra_clockevent = {
 	.set_mode	= tegra_timer_set_mode,
 };
 
-static u32 notrace tegra_read_sched_clock(void)
+static u64 notrace tegra_read_sched_clock(void)
 {
 	return timer_readl(TIMERUS_CNTR_1US);
 }
@@ -200,7 +200,7 @@ static void __init tegra20_init_timer(struct device_node *np)
 		WARN(1, "Unknown clock rate");
 	}
 
-	setup_sched_clock(tegra_read_sched_clock, 32, 1000000);
+	sched_clock_register(tegra_read_sched_clock, 32, 1000000);
 
 	if (clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
 		"timer_us", 1000000, 300, 32, clocksource_mmio_readl_up)) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
