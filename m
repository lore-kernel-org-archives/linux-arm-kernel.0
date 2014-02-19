From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 19 Feb 2014 17:05:26 -0300
Subject: [PATCH 2/2] clocksource: armada-370-xp: Use atomic access for shared
 registers
In-Reply-To: <1392840326-29417-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392840326-29417-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1392840326-29417-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the driver-specific thread-safe shared register API
by the recently introduced atomic_io_clear_set().

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clocksource/time-armada-370-xp.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index ee8691b..0451e62 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -85,12 +85,6 @@ static u32 ticks_per_jiffy;
 
 static struct clock_event_device __percpu *armada_370_xp_evt;
 
-static void timer_ctrl_clrset(u32 clr, u32 set)
-{
-	writel((readl(timer_base + TIMER_CTRL_OFF) & ~clr) | set,
-		timer_base + TIMER_CTRL_OFF);
-}
-
 static void local_timer_ctrl_clrset(u32 clr, u32 set)
 {
 	writel((readl(local_base + TIMER_CTRL_OFF) & ~clr) | set,
@@ -245,7 +239,7 @@ static void __init armada_370_xp_timer_common_init(struct device_node *np)
 		clr = TIMER0_25MHZ;
 		enable_mask = TIMER0_EN | TIMER0_DIV(TIMER_DIVIDER_SHIFT);
 	}
-	timer_ctrl_clrset(clr, set);
+	atomic_io_modify(timer_base + TIMER_CTRL_OFF, clr | set, set);
 	local_timer_ctrl_clrset(clr, set);
 
 	/*
@@ -263,7 +257,9 @@ static void __init armada_370_xp_timer_common_init(struct device_node *np)
 	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
 	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
 
-	timer_ctrl_clrset(0, TIMER0_RELOAD_EN | enable_mask);
+	atomic_io_modify(timer_base + TIMER_CTRL_OFF,
+		TIMER0_RELOAD_EN | enable_mask,
+		TIMER0_RELOAD_EN | enable_mask);
 
 	/*
 	 * Set scale and timer for sched_clock.
-- 
1.8.1.5
