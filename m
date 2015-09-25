From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 25 Sep 2015 10:14:55 +0800
Subject: [PATCH v2 1/4] clocksource: rockchip: Make the driver more compatible
In-Reply-To: <1443147298-12603-1-git-send-email-wxt@rock-chips.com>
References: <1443147298-12603-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1443147298-12603-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Build the arm64 SoCs (e.g.: RK3368) on Rockchip platform,
There are some failure with build up on timer driver for rockchip.

Says:
/tmp/ccdAnNy5.s:47: Error: missing immediate expression at  operand 1 --
`dsb`
...

The problem was different semantics of dsb on btw arm32 and arm64,
Here we can convert the dsb with insteading of dsb(sy).The "sy" param
is the default which you are allow to omit, so on arm32 dsb()and dsb(sy)
are the same.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2:
- As Heiko/Daniel comments, let's split it into two patch.

Changes in v1:
- As Russell, Thomas, Daniel comments, let's replace NO_IRQ by '!irq'.

 drivers/clocksource/rockchip_timer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index bb2c2b0..3ace7ac 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -49,14 +49,14 @@ static inline void __iomem *rk_base(struct clock_event_device *ce)
 static inline void rk_timer_disable(struct clock_event_device *ce)
 {
 	writel_relaxed(TIMER_DISABLE, rk_base(ce) + TIMER_CONTROL_REG);
-	dsb();
+	dsb(sy);
 }
 
 static inline void rk_timer_enable(struct clock_event_device *ce, u32 flags)
 {
 	writel_relaxed(TIMER_ENABLE | TIMER_INT_UNMASK | flags,
 		       rk_base(ce) + TIMER_CONTROL_REG);
-	dsb();
+	dsb(sy);
 }
 
 static void rk_timer_update_counter(unsigned long cycles,
@@ -64,13 +64,13 @@ static void rk_timer_update_counter(unsigned long cycles,
 {
 	writel_relaxed(cycles, rk_base(ce) + TIMER_LOAD_COUNT0);
 	writel_relaxed(0, rk_base(ce) + TIMER_LOAD_COUNT1);
-	dsb();
+	dsb(sy);
 }
 
 static void rk_timer_interrupt_clear(struct clock_event_device *ce)
 {
 	writel_relaxed(1, rk_base(ce) + TIMER_INT_STATUS);
-	dsb();
+	dsb(sy);
 }
 
 static inline int rk_timer_set_next_event(unsigned long cycles,
-- 
1.9.1
