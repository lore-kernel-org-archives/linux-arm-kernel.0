From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 31 Jul 2013 15:31:13 -0700
Subject: [PATCH 14/18] ARM: iop: Switch to sched_clock_register()
In-Reply-To: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
References: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1375309877-16617-15-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/plat-iop/time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 29606bd7..d70b733 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -54,7 +54,7 @@ static struct clocksource iop_clocksource = {
 /*
  * IOP sched_clock() implementation via its clocksource.
  */
-static u32 notrace iop_read_sched_clock(void)
+static u64 notrace iop_read_sched_clock(void)
 {
 	return 0xffffffffu - read_tcr1();
 }
@@ -142,7 +142,7 @@ void __init iop_init_time(unsigned long tick_rate)
 {
 	u32 timer_ctl;
 
-	setup_sched_clock(iop_read_sched_clock, 32, tick_rate);
+	sched_clock_register(iop_read_sched_clock, 32, tick_rate);
 
 	ticks_per_jiffy = DIV_ROUND_CLOSEST(tick_rate, HZ);
 	iop_tick_rate = tick_rate;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
