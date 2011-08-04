From: dsaxena@linaro.org (Deepak Saxena)
Date: Thu, 4 Aug 2011 06:53:00 -0700
Subject: [PATCH 09/12] ARM: netx:  Remove LATCH and CLOCK_TICK_RATE dependency
In-Reply-To: <cover.1312455035.git.dsaxena@linaro.org>
References: <cover.1312455035.git.dsaxena@linaro.org>
Message-ID: <20110804135300.GG1019@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of work to remove the global CLOCK_TICK_RATE symbol,
this patch defines a sub-arch local value for use by the
netx code.  Once all LATCH and CLOCK_TICK_RATE references
are removed, we will remove all the definitions across
sub-arches.

Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
---
 arch/arm/mach-netx/time.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-netx/time.c b/arch/arm/mach-netx/time.c
index e24c141..36429fb 100644
--- a/arch/arm/mach-netx/time.c
+++ b/arch/arm/mach-netx/time.c
@@ -31,6 +31,9 @@
 #define TIMER_CLOCKEVENT 0
 #define TIMER_CLOCKSOURCE 1
 
+#define NETX_TICK_RATE		100000000
+#define NETX_TIMER_LATCH 	((NETX_TICK_RATE + HZ/2) / HZ)
+
 static void netx_set_mode(enum clock_event_mode mode,
 		struct clock_event_device *clk)
 {
@@ -41,7 +44,7 @@ static void netx_set_mode(enum clock_event_mode mode,
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		writel(LATCH, NETX_GPIO_COUNTER_MAX(TIMER_CLOCKEVENT));
+		writel(NETX_TIMER_LATCH, NETX_GPIO_COUNTER_MAX(TIMER_CLOCKEVENT));
 		tmode = NETX_GPIO_COUNTER_CTRL_RST_EN |
 			NETX_GPIO_COUNTER_CTRL_IRQ_EN |
 			NETX_GPIO_COUNTER_CTRL_RUN;
@@ -115,7 +118,7 @@ static void __init netx_timer_init(void)
 	/* Reset the timer value to zero */
 	writel(0, NETX_GPIO_COUNTER_CURRENT(0));
 
-	writel(LATCH, NETX_GPIO_COUNTER_MAX(0));
+	writel(NETX_TIMER_LATCH, NETX_GPIO_COUNTER_MAX(0));
 
 	/* acknowledge interrupt */
 	writel(COUNTER_BIT(0), NETX_GPIO_IRQ);
-- 
1.7.4.1
