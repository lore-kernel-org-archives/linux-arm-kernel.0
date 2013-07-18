From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Jul 2013 16:21:28 -0700
Subject: [PATCH v4 15/17] clocksource: sirf: Switch to sched_clock_register()
 and use 64 bits
In-Reply-To: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374189690-10810-16-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface and use all 64 bits of this timer.

Cc: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/timer-prima2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index ef3cfb2..8a492d3 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -165,9 +165,9 @@ static struct irqaction sirfsoc_timer_irq = {
 };
 
 /* Overwrite weak default sched_clock with more precise one */
-static u32 notrace sirfsoc_read_sched_clock(void)
+static u64 notrace sirfsoc_read_sched_clock(void)
 {
-	return (u32)(sirfsoc_timer_read(NULL) & 0xffffffff);
+	return sirfsoc_timer_read(NULL);
 }
 
 static void __init sirfsoc_clockevent_init(void)
@@ -206,7 +206,7 @@ static void __init sirfsoc_prima2_timer_init(struct device_node *np)
 
 	BUG_ON(clocksource_register_hz(&sirfsoc_clocksource, CLOCK_TICK_RATE));
 
-	setup_sched_clock(sirfsoc_read_sched_clock, 32, CLOCK_TICK_RATE);
+	sched_clock_register(sirfsoc_read_sched_clock, 64, CLOCK_TICK_RATE);
 
 	BUG_ON(setup_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq));
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
