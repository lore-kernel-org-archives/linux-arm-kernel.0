From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  7 Jul 2016 10:00:53 +0200
Subject: [PATCH 20/93] clocksource/drivers/clps711x: Convert init function to
 return error
In-Reply-To: <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
References: <577E0BED.3020608@linaro.org>
 <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467878526-1238-20-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init functions do not return any error. They behave as the following:

  - panic, thus leading to a kernel crash while another timer may work and
       make the system boot up correctly

  or

  - print an error and let the caller unaware if the state of the system

Change that by converting the init functions to return an error conforming
to the CLOCKSOURCE_OF_RET prototype.

Proper error handling (rollback, errno value) will be changed later case
by case, thus this change just return back an error or success in the init
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/clps711x-timer.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
index cdd86e3..3b66198 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -104,7 +104,7 @@ void __init clps711x_clksrc_init(void __iomem *tc1_base, void __iomem *tc2_base,
 }
 
 #ifdef CONFIG_CLKSRC_OF
-static void __init clps711x_timer_init(struct device_node *np)
+static int __init clps711x_timer_init(struct device_node *np)
 {
 	unsigned int irq = irq_of_parse_and_map(np, 0);
 	struct clk *clock = of_clk_get(np, 0);
@@ -112,14 +112,12 @@ static void __init clps711x_timer_init(struct device_node *np)
 
 	switch (of_alias_get_id(np, "timer")) {
 	case CLPS711X_CLKSRC_CLOCKSOURCE:
-		BUG_ON(_clps711x_clksrc_init(clock, base));
-		break;
+		return _clps711x_clksrc_init(clock, base);
 	case CLPS711X_CLKSRC_CLOCKEVENT:
-		BUG_ON(_clps711x_clkevt_init(clock, base, irq));
-		break;
+		return _clps711x_clkevt_init(clock, base, irq);
 	default:
-		break;
+		return -EINVAL;
 	}
 }
-CLOCKSOURCE_OF_DECLARE(clps711x, "cirrus,clps711x-timer", clps711x_timer_init);
+CLOCKSOURCE_OF_DECLARE_RET(clps711x, "cirrus,clps711x-timer", clps711x_timer_init);
 #endif
-- 
1.9.1
