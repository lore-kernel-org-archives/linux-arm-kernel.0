From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 24 Jan 2017 15:16:40 +0300
Subject: [PATCH v5 5/8] clocksource/drivers/rockchip_timer: split bc_timer
 into rk_timer and rk_clock_event_device
In-Reply-To: <1485260203-14216-1-git-send-email-al.kochet@gmail.com>
References: <1485260203-14216-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1485260203-14216-6-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch move ce field out of struct bc_timer into struct
rk_clock_event_device and rename struct bc_timer to struct rk_timer.

The main idea for the commit is to exctact low level timer
routines from current implementation so they could be
reused in the following clocksource implementation commit.

This is refactoring step without functional changes.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Reviwed-by: Heiko St?bner <heiko@sntech.de>
---
 drivers/clocksource/rockchip_timer.c |   33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index 23e267a..6d68d4c 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -29,18 +29,28 @@
 #define TIMER_MODE_USER_DEFINED_COUNT		(1 << 1)
 #define TIMER_INT_UNMASK			(1 << 2)
 
-struct bc_timer {
-	struct clock_event_device ce;
+struct rk_timer {
 	void __iomem *base;
 	void __iomem *ctrl;
 	u32 freq;
 };
 
-static struct bc_timer bc_timer;
+struct rk_clock_event_device {
+	struct clock_event_device ce;
+	struct rk_timer timer;
+};
+
+static struct rk_clock_event_device bc_timer;
+
+static inline struct rk_clock_event_device*
+rk_clock_event_device(struct clock_event_device *ce)
+{
+	return container_of(ce, struct rk_clock_event_device, ce);
+}
 
-static inline struct bc_timer *rk_timer(struct clock_event_device *ce)
+static inline struct rk_timer *rk_timer(struct clock_event_device *ce)
 {
-	return container_of(ce, struct bc_timer, ce);
+	return &rk_clock_event_device(ce)->timer;
 }
 
 static inline void __iomem *rk_base(struct clock_event_device *ce)
@@ -116,16 +126,17 @@ static irqreturn_t rk_timer_interrupt(int irq, void *dev_id)
 static int __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
 {
 	struct clock_event_device *ce = &bc_timer.ce;
+	struct rk_timer *timer = &bc_timer.timer;
 	struct clk *timer_clk;
 	struct clk *pclk;
 	int ret = -EINVAL, irq;
 
-	bc_timer.base = of_iomap(np, 0);
-	if (!bc_timer.base) {
+	timer->base = of_iomap(np, 0);
+	if (!timer->base) {
 		pr_err("Failed to get base address for '%s'\n", TIMER_NAME);
 		return -ENXIO;
 	}
-	bc_timer.ctrl = bc_timer.base + ctrl_reg;
+	timer->ctrl = timer->base + ctrl_reg;
 
 	pclk = of_clk_get_by_name(np, "pclk");
 	if (IS_ERR(pclk)) {
@@ -153,7 +164,7 @@ static int __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
 		goto out_timer_clk;
 	}
 
-	bc_timer.freq = clk_get_rate(timer_clk);
+	timer->freq = clk_get_rate(timer_clk);
 
 	irq = irq_of_parse_and_map(np, 0);
 	if (!irq) {
@@ -181,7 +192,7 @@ static int __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
 		goto out_irq;
 	}
 
-	clockevents_config_and_register(ce, bc_timer.freq, 1, UINT_MAX);
+	clockevents_config_and_register(ce, timer->freq, 1, UINT_MAX);
 
 	return 0;
 
@@ -190,7 +201,7 @@ static int __init rk_timer_init(struct device_node *np, u32 ctrl_reg)
 out_timer_clk:
 	clk_disable_unprepare(pclk);
 out_unmap:
-	iounmap(bc_timer.base);
+	iounmap(timer->base);
 
 	return ret;
 }
-- 
1.7.9.5
