From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 31 Jul 2013 15:31:15 -0700
Subject: [PATCH 16/18] ARM: orion: Switch to sched_clock_register()
In-Reply-To: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
References: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1375309877-16617-17-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/plat-orion/time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-orion/time.c b/arch/arm/plat-orion/time.c
index 9d2b2ac..dade292 100644
--- a/arch/arm/plat-orion/time.c
+++ b/arch/arm/plat-orion/time.c
@@ -60,7 +60,7 @@ static u32 ticks_per_jiffy;
  * at least 7.5ns (133MHz TCLK).
  */
 
-static u32 notrace orion_read_sched_clock(void)
+static u64 notrace orion_read_sched_clock(void)
 {
 	return ~readl(timer_base + TIMER0_VAL_OFF);
 }
@@ -201,7 +201,7 @@ orion_time_init(void __iomem *_bridge_base, u32 _bridge_timer1_clr_mask,
 	/*
 	 * Set scale and timer for sched_clock.
 	 */
-	setup_sched_clock(orion_read_sched_clock, 32, tclk);
+	sched_clock_register(orion_read_sched_clock, 32, tclk);
 
 	/*
 	 * Setup free-running clocksource timer (interrupts
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
