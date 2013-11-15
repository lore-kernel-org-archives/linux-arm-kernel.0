From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Nov 2013 15:26:18 -0800
Subject: [PATCH 10/17] ARM: OMAP2+: Switch to sched_clock_register()
In-Reply-To: <1384557985-9414-1-git-send-email-sboyd@codeaurora.org>
References: <1384557985-9414-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1384557985-9414-11-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 3ca81e0..ec084d1 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -379,7 +379,7 @@ static struct clocksource clocksource_gpt = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static u32 notrace dmtimer_read_sched_clock(void)
+static u64 notrace dmtimer_read_sched_clock(void)
 {
 	if (clksrc.reserved)
 		return __omap_dm_timer_read_counter(&clksrc,
@@ -471,7 +471,7 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 	__omap_dm_timer_load_start(&clksrc,
 				   OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0,
 				   OMAP_TIMER_NONPOSTED);
-	setup_sched_clock(dmtimer_read_sched_clock, 32, clksrc.rate);
+	sched_clock_register(dmtimer_read_sched_clock, 32, clksrc.rate);
 
 	if (clocksource_register_hz(&clocksource_gpt, clksrc.rate))
 		pr_err("Could not register clocksource %s\n",
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
