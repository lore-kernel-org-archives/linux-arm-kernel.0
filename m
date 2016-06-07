From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  7 Jun 2016 12:54:32 +0800
Subject: [PATCH v2 3/4] clocksource: rockchip: add support for rk3399 SoC
In-Reply-To: <1465275273-22076-1-git-send-email-wxt@rock-chips.com>
References: <1465275273-22076-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1465275273-22076-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Huang, Tao" <huangtao@rock-chips.com>

The CONTROL register offset is different from old SoCs.
For Linux driver, there are not functional changes at all.
So add dedicated mapping for the CONTROL register.

Signed-off-by: Huang Tao <huangtao@rock-chips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Tested-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v2:
- As the Daniel suggests on https://patchwork.kernel.org/patch/9135061/,
  That will be better for the rockchip timer driver.

 drivers/clocksource/rockchip_timer.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index b510863..a3f22b0 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -19,7 +19,8 @@
 
 #define TIMER_LOAD_COUNT0	0x00
 #define TIMER_LOAD_COUNT1	0x04
-#define TIMER_CONTROL_REG	0x10
+#define TIMER_CONTROL_REG3288	0x10
+#define TIMER_CONTROL_REG3399	0x1c
 #define TIMER_INT_STATUS	0x18
 
 #define TIMER_DISABLE		0x0
@@ -31,6 +32,7 @@
 struct bc_timer {
 	struct clock_event_device ce;
 	void __iomem *base;
+	void __iomem *ctrl;
 	u32 freq;
 };
 
@@ -46,15 +48,20 @@ static inline void __iomem *rk_base(struct clock_event_device *ce)
 	return rk_timer(ce)->base;
 }
 
+static inline void __iomem *rk_ctrl(struct clock_event_device *ce)
+{
+	return rk_timer(ce)->ctrl;
+}
+
 static inline void rk_timer_disable(struct clock_event_device *ce)
 {
-	writel_relaxed(TIMER_DISABLE, rk_base(ce) + TIMER_CONTROL_REG);
+	writel_relaxed(TIMER_DISABLE, rk_ctrl(ce));
 }
 
 static inline void rk_timer_enable(struct clock_event_device *ce, u32 flags)
 {
 	writel_relaxed(TIMER_ENABLE | TIMER_INT_UNMASK | flags,
-		       rk_base(ce) + TIMER_CONTROL_REG);
+		       rk_ctrl(ce));
 }
 
 static void rk_timer_update_counter(unsigned long cycles,
@@ -106,7 +113,7 @@ static irqreturn_t rk_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void __init rk_timer_init(struct device_node *np)
+static void __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
 {
 	struct clock_event_device *ce = &bc_timer.ce;
 	struct clk *timer_clk;
@@ -118,6 +125,7 @@ static void __init rk_timer_init(struct device_node *np)
 		pr_err("Failed to get base address for '%s'\n", TIMER_NAME);
 		return;
 	}
+	bc_timer.ctrl = bc_timer.base + ctrl_reg;
 
 	pclk = of_clk_get_by_name(np, "pclk");
 	if (IS_ERR(pclk)) {
@@ -180,4 +188,17 @@ out_unmap:
 	iounmap(bc_timer.base);
 }
 
-CLOCKSOURCE_OF_DECLARE(rk_timer, "rockchip,rk3288-timer", rk_timer_init);
+static void __init rk3288_timer_init(struct device_node *np)
+{
+	rk_timer_init(np, TIMER_CONTROL_REG3288);
+}
+
+static void __init rk3399_timer_init(struct device_node *np)
+{
+	rk_timer_init(np, TIMER_CONTROL_REG3399);
+}
+
+CLOCKSOURCE_OF_DECLARE(rk3288_timer, "rockchip,rk3288-timer",
+		       rk3288_timer_init);
+CLOCKSOURCE_OF_DECLARE(rk3399_timer, "rockchip,rk3399-timer",
+		       rk3399_timer_init);
-- 
1.9.1
