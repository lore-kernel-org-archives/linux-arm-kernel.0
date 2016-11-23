From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Wed, 23 Nov 2016 20:29:34 +0300
Subject: [PATCH 6/9] clocksource/drivers/rockchip_timer: implement reading
 64bit value from timer
In-Reply-To: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
References: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1479922177-20136-6-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/clocksource/rockchip_timer.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index f4c26be..61787c5 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -19,6 +19,8 @@
 
 #define TIMER_LOAD_COUNT0	0x00
 #define TIMER_LOAD_COUNT1	0x04
+#define TIMER_CURRENT_VALUE0	0x08
+#define TIMER_CURRENT_VALUE1	0x0C
 #define TIMER_CONTROL_REG3288	0x10
 #define TIMER_CONTROL_REG3399	0x1c
 #define TIMER_INT_STATUS	0x18
@@ -72,6 +74,25 @@ static void rk_timer_update_counter(u64 cycles, struct rk_timer *timer)
 	writel_relaxed(upper, timer->base + TIMER_LOAD_COUNT1);
 }
 
+static u64 rk_timer_counter_read(struct rk_timer *timer)
+{
+	u64 counter;
+	u32 lower;
+	u32 upper, old_upper;
+
+	upper = readl_relaxed(timer->base + TIMER_CURRENT_VALUE1);
+	do {
+		old_upper = upper;
+		lower = readl_relaxed(timer->base + TIMER_CURRENT_VALUE0);
+		upper = readl_relaxed(timer->base + TIMER_CURRENT_VALUE1);
+	} while (upper != old_upper);
+
+	counter = upper;
+	counter <<= 32;
+	counter |= lower;
+	return counter;
+}
+
 static void rk_timer_interrupt_clear(struct rk_timer *timer)
 {
 	writel_relaxed(1, timer->base + TIMER_INT_STATUS);
-- 
1.7.9.5
