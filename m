From: joel@jms.id.au (Joel Stanley)
Date: Mon,  9 May 2016 22:02:47 +0930
Subject: [PATCH 2/4] drivers/clocksource/moxart: Refactor enable/disable
In-Reply-To: <1462797169-14512-1-git-send-email-joel@jms.id.au>
References: <1462797169-14512-1-git-send-email-joel@jms.id.au>
Message-ID: <1462797169-14512-3-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clocksource/moxart_timer.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/moxart_timer.c b/drivers/clocksource/moxart_timer.c
index 19857af651c1..b00b2b21e8b3 100644
--- a/drivers/clocksource/moxart_timer.c
+++ b/drivers/clocksource/moxart_timer.c
@@ -58,15 +58,25 @@
 static void __iomem *base;
 static unsigned int clock_count_per_tick;
 
-static int moxart_shutdown(struct clock_event_device *evt)
+static inline void moxart_disable(struct clock_event_device *evt)
 {
 	writel(TIMER1_DISABLE, base + TIMER_CR);
+}
+
+static inline void moxart_enable(struct clock_event_device *evt)
+{
+	writel(TIMER1_ENABLE, base + TIMER_CR);
+}
+
+static int moxart_shutdown(struct clock_event_device *evt)
+{
+	moxart_disable(evt);
 	return 0;
 }
 
 static int moxart_set_oneshot(struct clock_event_device *evt)
 {
-	writel(TIMER1_DISABLE, base + TIMER_CR);
+	moxart_disable(evt);
 	writel(~0, base + TIMER1_BASE + REG_LOAD);
 	return 0;
 }
@@ -74,21 +84,21 @@ static int moxart_set_oneshot(struct clock_event_device *evt)
 static int moxart_set_periodic(struct clock_event_device *evt)
 {
 	writel(clock_count_per_tick, base + TIMER1_BASE + REG_LOAD);
-	writel(TIMER1_ENABLE, base + TIMER_CR);
+	moxart_enable(evt);
 	return 0;
 }
 
 static int moxart_clkevt_next_event(unsigned long cycles,
-				    struct clock_event_device *unused)
+				    struct clock_event_device *evt)
 {
 	u32 u;
 
-	writel(TIMER1_DISABLE, base + TIMER_CR);
+	moxart_disable(evt);
 
 	u = readl(base + TIMER1_BASE + REG_COUNT) - cycles;
 	writel(u, base + TIMER1_BASE + REG_MATCH1);
 
-	writel(TIMER1_ENABLE, base + TIMER_CR);
+	moxart_enable(evt);
 
 	return 0;
 }
-- 
2.8.1
