From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 31 Jul 2013 15:31:02 -0700
Subject: [PATCH 03/18] ARM: davinci: Switch to sched_clock_register()
In-Reply-To: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
References: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1375309877-16617-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-davinci/time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 7a55b5c..6d5440a 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -285,7 +285,7 @@ static struct clocksource clocksource_davinci = {
 /*
  * Overwrite weak default sched_clock with something more precise
  */
-static u32 notrace davinci_read_sched_clock(void)
+static u64 notrace davinci_read_sched_clock(void)
 {
 	return timer32_read(&timers[TID_CLOCKSOURCE]);
 }
@@ -392,7 +392,7 @@ void __init davinci_timer_init(void)
 				    davinci_clock_tick_rate))
 		printk(err, clocksource_davinci.name);
 
-	setup_sched_clock(davinci_read_sched_clock, 32,
+	sched_clock_register(davinci_read_sched_clock, 32,
 			  davinci_clock_tick_rate);
 
 	/* setup clockevent */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
