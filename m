From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Feb 2013 23:17:37 +0000
Subject: [PATCH 07/17] ARM: twd: data endian fix
In-Reply-To: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360365467-25056-8-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure the twd driver uses the correct calls to access the hardware
to ensure that we do not end up with data in the wrong endian format.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/kernel/smp_twd.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 49f335d..3756f42 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -46,7 +46,7 @@ static void twd_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_PERIODIC:
 		ctrl = TWD_TIMER_CONTROL_ENABLE | TWD_TIMER_CONTROL_IT_ENABLE
 			| TWD_TIMER_CONTROL_PERIODIC;
-		__raw_writel(DIV_ROUND_CLOSEST(twd_timer_rate, HZ),
+		writel_relaxed(DIV_ROUND_CLOSEST(twd_timer_rate, HZ),
 			twd_base + TWD_TIMER_LOAD);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
@@ -59,18 +59,18 @@ static void twd_set_mode(enum clock_event_mode mode,
 		ctrl = 0;
 	}
 
-	__raw_writel(ctrl, twd_base + TWD_TIMER_CONTROL);
+	writel_relaxed(ctrl, twd_base + TWD_TIMER_CONTROL);
 }
 
 static int twd_set_next_event(unsigned long evt,
 			struct clock_event_device *unused)
 {
-	unsigned long ctrl = __raw_readl(twd_base + TWD_TIMER_CONTROL);
+	unsigned long ctrl = readl_relaxed(twd_base + TWD_TIMER_CONTROL);
 
 	ctrl |= TWD_TIMER_CONTROL_ENABLE;
 
-	__raw_writel(evt, twd_base + TWD_TIMER_COUNTER);
-	__raw_writel(ctrl, twd_base + TWD_TIMER_CONTROL);
+	writel_relaxed(evt, twd_base + TWD_TIMER_COUNTER);
+	writel_relaxed(ctrl, twd_base + TWD_TIMER_CONTROL);
 
 	return 0;
 }
@@ -83,8 +83,8 @@ static int twd_set_next_event(unsigned long evt,
  */
 static int twd_timer_ack(void)
 {
-	if (__raw_readl(twd_base + TWD_TIMER_INTSTAT)) {
-		__raw_writel(1, twd_base + TWD_TIMER_INTSTAT);
+	if (readl_relaxed(twd_base + TWD_TIMER_INTSTAT)) {
+		writel_relaxed(1, twd_base + TWD_TIMER_INTSTAT);
 		return 1;
 	}
 
@@ -210,15 +210,15 @@ static void __cpuinit twd_calibrate_rate(void)
 		waitjiffies += 5;
 
 				 /* enable, no interrupt or reload */
-		__raw_writel(0x1, twd_base + TWD_TIMER_CONTROL);
+		writel_relaxed(0x1, twd_base + TWD_TIMER_CONTROL);
 
 				 /* maximum value */
-		__raw_writel(0xFFFFFFFFU, twd_base + TWD_TIMER_COUNTER);
+		writel_relaxed(0xFFFFFFFFU, twd_base + TWD_TIMER_COUNTER);
 
 		while (get_jiffies_64() < waitjiffies)
 			udelay(10);
 
-		count = __raw_readl(twd_base + TWD_TIMER_COUNTER);
+		count = readl_relaxed(twd_base + TWD_TIMER_COUNTER);
 
 		twd_timer_rate = (0xFFFFFFFFU - count) * (HZ / 5);
 
@@ -273,7 +273,7 @@ static int __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	 * bother with the below.
 	 */
 	if (per_cpu(percpu_setup_called, cpu)) {
-		__raw_writel(0, twd_base + TWD_TIMER_CONTROL);
+		writel_relaxed(0, twd_base + TWD_TIMER_CONTROL);
 		clockevents_register_device(*__this_cpu_ptr(twd_evt));
 		enable_percpu_irq(clk->irq, 0);
 		return 0;
@@ -305,7 +305,7 @@ static int __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	 * The following is done once per CPU the first time .setup() is
 	 * called.
 	 */
-	__raw_writel(0, twd_base + TWD_TIMER_CONTROL);
+	writel_relaxed(0, twd_base + TWD_TIMER_CONTROL);
 
 	clk->name = "local_timer";
 	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
-- 
1.7.10.4
