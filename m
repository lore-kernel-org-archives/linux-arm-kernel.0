From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 26 Nov 2014 14:08:12 +0100
Subject: [PATCH 2/4] clocksource: armada-370-xp: Add missing clock enable
In-Reply-To: <1417007294-19869-1-git-send-email-daniel.lezcano@linaro.org>
References: <5475D044.5060607@linaro.org>
 <1417007294-19869-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1417007294-19869-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This commit makes sure the timer clock is prepared and enabled
before retrieving its rate.

Acked-by: Jason Cooper <jason@lakedaemon.net>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Wim Van Sebroeck <wim@iguana.be>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/time-armada-370-xp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index 0451e62..d8555f9 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -293,6 +293,7 @@ static void __init armada_xp_timer_init(struct device_node *np)
 
 	/* The 25Mhz fixed clock is mandatory, and must always be available */
 	BUG_ON(IS_ERR(clk));
+	clk_prepare_enable(clk);
 	timer_clk = clk_get_rate(clk);
 
 	armada_370_xp_timer_common_init(np);
@@ -305,6 +306,7 @@ static void __init armada_370_timer_init(struct device_node *np)
 	struct clk *clk = of_clk_get(np, 0);
 
 	BUG_ON(IS_ERR(clk));
+	clk_prepare_enable(clk);
 	timer_clk = clk_get_rate(clk) / TIMER_DIVIDER;
 	timer25Mhz = false;
 
-- 
1.9.1
