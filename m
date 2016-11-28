From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Mon, 28 Nov 2016 17:31:24 +0300
Subject: [PATCHv2 09/11] clocksource/drivers/rockchip_timer: implement loading
 64bit value into timer
In-Reply-To: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
References: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1480343486-25539-10-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/clocksource/rockchip_timer.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index 61c3bb1..c2b0454 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -63,11 +63,13 @@ static inline void rk_timer_enable(struct rk_timer *timer, u32 flags)
 	writel_relaxed(TIMER_ENABLE | flags, timer->ctrl);
 }
 
-static void rk_timer_update_counter(unsigned long cycles,
-				    struct rk_timer *timer)
+static void rk_timer_update_counter(u64 cycles, struct rk_timer *timer)
 {
-	writel_relaxed(cycles, timer->base + TIMER_LOAD_COUNT0);
-	writel_relaxed(0, timer->base + TIMER_LOAD_COUNT1);
+	u32 lower = cycles & 0xFFFFFFFF;
+	u32 upper = (cycles >> 32) & 0xFFFFFFFF;
+
+	writel_relaxed(lower, timer->base + TIMER_LOAD_COUNT0);
+	writel_relaxed(upper, timer->base + TIMER_LOAD_COUNT1);
 }
 
 static void rk_timer_interrupt_clear(struct rk_timer *timer)
-- 
1.7.9.5
