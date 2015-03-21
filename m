From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 21 Mar 2015 15:45:57 +0100
Subject: [PATCH] sun4i-timer: Only register a sched_clock on sun4i and sun5i
Message-ID: <1426949157-24033-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun6i and newer have an arm arch timer which is a better sched_clock source
then the sun4i-timer, and sched_clock does not have priorities, so do not
register the sun4i-timer sched_clock at all on sun6i and newer.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/clocksource/sun4i_timer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index f4a9c00..1928a89 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -170,7 +170,15 @@ static void __init sun4i_timer_init(struct device_node *node)
 	       TIMER_CTL_CLK_SRC(TIMER_CTL_CLK_SRC_OSC24M),
 	       timer_base + TIMER_CTL_REG(1));
 
-	sched_clock_register(sun4i_timer_sched_read, 32, rate);
+	/*
+	 * sched_clock_register does not have priorities, and on sun6i and
+	 * later there is a better sched_clock registered by arm_arch_timer.c
+	 */
+	if (of_machine_is_compatible("allwinner,sun4i-a10") ||
+	    of_machine_is_compatible("allwinner,sun5i-a13") ||
+	    of_machine_is_compatible("allwinner,sun5i-a10s"))
+		sched_clock_register(sun4i_timer_sched_read, 32, rate);
+
 	clocksource_mmio_init(timer_base + TIMER_CNTVAL_REG(1), node->name,
 			      rate, 350, 32, clocksource_mmio_readl_down);
 
-- 
2.3.3
