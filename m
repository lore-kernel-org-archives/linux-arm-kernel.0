From: v1ron@mail.ru (Roman Volkov)
Date: Mon, 21 Dec 2015 01:28:09 +0300
Subject: [PATCH 1/4] clocksource/vt8500: Use [read\write]l_relaxed()
In-Reply-To: <1450650492-18996-1-git-send-email-v1ron@mail.ru>
References: <1450650492-18996-1-git-send-email-v1ron@mail.ru>
Message-ID: <1450650492-18996-2-git-send-email-v1ron@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Volkov <rvolkov@v1ros.org>

It is more preferred way to use relaxed read\write without barriers on ARM.

http://permalink.gmane.org/gmane.linux.ports.arm.kernel/117658:
"For accesses to the same device we don't
actually need any barriers on ARM as this is guaranteed by the
architecture."

Also wrap these calls into macroses to save space.

Signed-off-by: Roman Volkov <rvolkov@v1ros.org>
---
 drivers/clocksource/vt8500_timer.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
index a92e94b..13ed892 100644
--- a/drivers/clocksource/vt8500_timer.c
+++ b/drivers/clocksource/vt8500_timer.c
@@ -50,16 +50,18 @@
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 
+#define timer_readl(addr)	readl_relaxed(regbase + addr)
+#define timer_writel(v, addr)	writel_relaxed(v, regbase + addr)
+
 static void __iomem *regbase;
 
 static cycle_t vt8500_timer_read(struct clocksource *cs)
 {
 	int loops = msecs_to_loops(10);
-	writel(3, regbase + TIMER_CTRL_VAL);
-	while ((readl((regbase + TIMER_AS_VAL)) & TIMER_COUNT_R_ACTIVE)
-						&& --loops)
+	timer_writel(3, TIMER_CTRL_VAL);
+	while ((timer_readl((TIMER_AS_VAL)) & TIMER_COUNT_R_ACTIVE) && --loops)
 		cpu_relax();
-	return readl(regbase + TIMER_COUNT_VAL);
+	return timer_readl(TIMER_COUNT_VAL);
 }
 
 static struct clocksource clocksource = {
@@ -75,23 +77,22 @@ static int vt8500_timer_set_next_event(unsigned long cycles,
 {
 	int loops = msecs_to_loops(10);
 	cycle_t alarm = clocksource.read(&clocksource) + cycles;
-	while ((readl(regbase + TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE)
-						&& --loops)
+	while ((timer_readl(TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE) && --loops)
 		cpu_relax();
-	writel((unsigned long)alarm, regbase + TIMER_MATCH_VAL);
+	timer_writel((unsigned long)alarm, TIMER_MATCH_VAL);
 
 	if ((signed)(alarm - clocksource.read(&clocksource)) <= 16)
 		return -ETIME;
 
-	writel(1, regbase + TIMER_IER_VAL);
+	timer_writel(1, TIMER_IER_VAL);
 
 	return 0;
 }
 
 static int vt8500_shutdown(struct clock_event_device *evt)
 {
-	writel(readl(regbase + TIMER_CTRL_VAL) | 1, regbase + TIMER_CTRL_VAL);
-	writel(0, regbase + TIMER_IER_VAL);
+	timer_writel(timer_readl(TIMER_CTRL_VAL) | 1, TIMER_CTRL_VAL);
+	timer_writel(0, TIMER_IER_VAL);
 	return 0;
 }
 
@@ -107,7 +108,7 @@ static struct clock_event_device clockevent = {
 static irqreturn_t vt8500_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
-	writel(0xf, regbase + TIMER_STATUS_VAL);
+	timer_writel(0xf, TIMER_STATUS_VAL);
 	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
@@ -137,9 +138,9 @@ static void __init vt8500_timer_init(struct device_node *np)
 		return;
 	}
 
-	writel(1, regbase + TIMER_CTRL_VAL);
-	writel(0xf, regbase + TIMER_STATUS_VAL);
-	writel(~0, regbase + TIMER_MATCH_VAL);
+	timer_writel(1, TIMER_CTRL_VAL);
+	timer_writel(0xf, TIMER_STATUS_VAL);
+	timer_writel(~0, TIMER_MATCH_VAL);
 
 	if (clocksource_register_hz(&clocksource, VT8500_TIMER_HZ))
 		pr_err("%s: vt8500_timer_init: clocksource_register failed for %s\n",
-- 
2.6.2
