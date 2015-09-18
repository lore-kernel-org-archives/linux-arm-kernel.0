From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 18 Sep 2015 16:51:09 +0800
Subject: [PATCH v1 1/3] clocksource: rockchip: Make the driver more
 readability and compatible
In-Reply-To: <1442566271-10695-1-git-send-email-wxt@rock-chips.com>
References: <1442566271-10695-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1442566271-10695-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Build the arm64 SoCs (e.g.: RK3368) on Rockchip platform,
There are some failure with build up on timer driver for rockchip.

logs:
...
drivers/clocksource/rockchip_timer.c:156:13: error: 'NO_IRQ' undeclared
/tmp/ccdAnNy5.s:47: Error: missing immediate expression at  operand 1 --
`dsb`
...

The problem was different semantics of dsb on btw arm32 and arm64,
Here we can convert the dsb with insteading of dsb(sy).

NO_IRQ definition is missing for ARM64, since NO_IRQ being -1 is a
legacy thing for ARM - all ARM drivers are supposed to be converted to
use <= 0 or == 0 to detect invalid IRQs, and _eventually_ once all users
are gone, NO_IRQ deleted. Modern drivers should _all_ be using !irq to
detect invalid IRQs, and not using NO_IRQ.

Meanwhile, I change a bit to make the code more readability for driver
when I check the code style.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v1:
- As Russell, Thomas, Daniel comments, let's replace NO_IRQ by '!irq'.

 drivers/clocksource/rockchip_timer.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index bb2c2b0..e1af449 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -17,16 +17,16 @@
 
 #define TIMER_NAME "rk_timer"
 
-#define TIMER_LOAD_COUNT0 0x00
-#define TIMER_LOAD_COUNT1 0x04
-#define TIMER_CONTROL_REG 0x10
-#define TIMER_INT_STATUS 0x18
+#define TIMER_LOAD_COUNT0	0x00
+#define TIMER_LOAD_COUNT1	0x04
+#define TIMER_CONTROL_REG	0x10
+#define TIMER_INT_STATUS	0x18
 
-#define TIMER_DISABLE 0x0
-#define TIMER_ENABLE 0x1
-#define TIMER_MODE_FREE_RUNNING (0 << 1)
-#define TIMER_MODE_USER_DEFINED_COUNT (1 << 1)
-#define TIMER_INT_UNMASK (1 << 2)
+#define TIMER_DISABLE			(0 << 0)
+#define TIMER_ENABLE			(1 << 0)
+#define TIMER_MODE_FREE_RUNNING		(0 << 1)
+#define TIMER_MODE_USER_DEFINED_COUNT	(1 << 1)
+#define TIMER_INT_UNMASK		(1 << 2)
 
 struct bc_timer {
 	struct clock_event_device ce;
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
@@ -148,7 +148,7 @@ static void __init rk_timer_init(struct device_node *np)
 	bc_timer.freq = clk_get_rate(timer_clk);
 
 	irq = irq_of_parse_and_map(np, 0);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		pr_err("Failed to map interrupts for '%s'\n", TIMER_NAME);
 		return;
 	}
@@ -173,4 +173,5 @@ static void __init rk_timer_init(struct device_node *np)
 
 	clockevents_config_and_register(ce, bc_timer.freq, 1, UINT_MAX);
 }
+
 CLOCKSOURCE_OF_DECLARE(rk_timer, "rockchip,rk3288-timer", rk_timer_init);
-- 
1.9.1
