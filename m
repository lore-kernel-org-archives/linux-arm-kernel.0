From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:20 +0100
Subject: [PATCH 07/69] clocksource/drivers/rockchip: Remove dsb() usage
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-7-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Caesar Wang <wxt@rock-chips.com>

The dsb() instruction is pointless in this code.

Remove it.

That also fixes the ARM64 compilation issue.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Caesar Wang <wxt@rock-chips.com>
---
 drivers/clocksource/rockchip_timer.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index b14716b6..8c77a52 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -49,14 +49,12 @@ static inline void __iomem *rk_base(struct clock_event_device *ce)
 static inline void rk_timer_disable(struct clock_event_device *ce)
 {
 	writel_relaxed(TIMER_DISABLE, rk_base(ce) + TIMER_CONTROL_REG);
-	dsb();
 }
 
 static inline void rk_timer_enable(struct clock_event_device *ce, u32 flags)
 {
 	writel_relaxed(TIMER_ENABLE | TIMER_INT_UNMASK | flags,
 		       rk_base(ce) + TIMER_CONTROL_REG);
-	dsb();
 }
 
 static void rk_timer_update_counter(unsigned long cycles,
@@ -64,13 +62,11 @@ static void rk_timer_update_counter(unsigned long cycles,
 {
 	writel_relaxed(cycles, rk_base(ce) + TIMER_LOAD_COUNT0);
 	writel_relaxed(0, rk_base(ce) + TIMER_LOAD_COUNT1);
-	dsb();
 }
 
 static void rk_timer_interrupt_clear(struct clock_event_device *ce)
 {
 	writel_relaxed(1, rk_base(ce) + TIMER_INT_STATUS);
-	dsb();
 }
 
 static inline int rk_timer_set_next_event(unsigned long cycles,
-- 
1.9.1
