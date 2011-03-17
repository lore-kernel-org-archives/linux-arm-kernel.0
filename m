From: j.weitzel@phytec.de (Jan Weitzel)
Date: Thu, 17 Mar 2011 13:44:29 +0100
Subject: [PATCH 1/2] ARM: mxc: Add dummy_get_cycles to avoid access before
	init is done
Message-ID: <1300365870-26193-1-git-send-email-j.weitzel@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this is needed to use get_cycles with sched_clock. Accessing timer
without enabled clk will result in crash

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 arch/arm/plat-mxc/time.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 9f0c261..0142e4b 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -105,6 +105,11 @@ static void gpt_irq_acknowledge(void)
 		__raw_writel(V2_TSTAT_OF1, timer_base + V2_TSTAT);
 }
 
+static cycle_t dummy_get_cycles(struct clocksource *cs)
+{
+	return 0;
+}
+
 static cycle_t mx1_2_get_cycles(struct clocksource *cs)
 {
 	return __raw_readl(timer_base + MX1_2_TCN);
@@ -118,7 +123,7 @@ static cycle_t v2_get_cycles(struct clocksource *cs)
 static struct clocksource clocksource_mxc = {
 	.name 		= "mxc_timer1",
 	.rating		= 200,
-	.read		= mx1_2_get_cycles,
+	.read		= dummy_get_cycles,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
@@ -129,6 +134,8 @@ static int __init mxc_clocksource_init(struct clk *timer_clk)
 
 	if (timer_is_v2())
 		clocksource_mxc.read = v2_get_cycles;
+	else
+		clocksource_mxc.read = mx1_2_get_cycles;
 
 	clocksource_register_hz(&clocksource_mxc, c);
 
-- 
1.7.0.4
