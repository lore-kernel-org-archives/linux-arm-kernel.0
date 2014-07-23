From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 23 Jul 2014 22:03:17 +0800
Subject: [PATCH] clocksource: sirf: disable counter before re-setting it
Message-ID: <1406124197-25083-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hao Liu <Hao.Liu@csr.com>

according to HW spec, we have to disable counter before setting
it, if we don't this, in pressure test, sometimes the timer might
not generate interrupt any more.

and this patch also fixes a typo for register set by changing 0x7
to 0x3. 0x7 is loop mode in HW, but here we are using oneshot 0x3.

Signed-off-by: Hao Liu <Hao.Liu@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/clocksource/timer-marco.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-marco.c b/drivers/clocksource/timer-marco.c
index 330e930..caf7a20 100644
--- a/drivers/clocksource/timer-marco.c
+++ b/drivers/clocksource/timer-marco.c
@@ -63,7 +63,7 @@ static inline void sirfsoc_timer_count_disable(int idx)
 /* enable count and interrupt */
 static inline void sirfsoc_timer_count_enable(int idx)
 {
-	writel_relaxed(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL + 4 * idx) | 0x7,
+	writel_relaxed(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL + 4 * idx) | 0x3,
 		sirfsoc_timer_base + SIRFSOC_TIMER_32COUNTER_0_CTRL + 4 * idx);
 }
 
@@ -103,6 +103,9 @@ static int sirfsoc_timer_set_next_event(unsigned long delta,
 {
 	int cpu = smp_processor_id();
 
+	/* disable timer first, then modify the related registers */
+	sirfsoc_timer_count_disable(cpu);
+
 	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_0 +
 		4 * cpu);
 	writel_relaxed(delta, sirfsoc_timer_base + SIRFSOC_TIMER_MATCH_0 +
-- 
1.7.9.5
