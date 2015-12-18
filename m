From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:17 +0100
Subject: [PATCH 64/69] clocksource/drivers/lpc32: Correct pr_err() output
 format
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-64-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Zapolskiy <vz@mleia.com>

If by some reason timerclk is not available, both clockevent and
clocksource initializations correctly exit, but output of errno to
kernel log buffer may be confusing:

  lpc32xx_clk_init: failed to map system control block registers
  lpc32xx_clocksource_init: clock get failed (4294966779)
  lpc32xx_clockevent_init: clock get failed (4294966779)

Use signed integer output in the correspondent pr_err() string formats:

  lpc32xx_clocksource_init: clock get failed (-517)
  lpc32xx_clockevent_init: clock get failed (-517)

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/time-lpc32xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
index a1c06a2..1316876 100644
--- a/drivers/clocksource/time-lpc32xx.c
+++ b/drivers/clocksource/time-lpc32xx.c
@@ -125,7 +125,7 @@ static int __init lpc32xx_clocksource_init(struct device_node *np)
 
 	clk = of_clk_get_by_name(np, "timerclk");
 	if (IS_ERR(clk)) {
-		pr_err("clock get failed (%lu)\n", PTR_ERR(clk));
+		pr_err("clock get failed (%ld)\n", PTR_ERR(clk));
 		return PTR_ERR(clk);
 	}
 
@@ -184,7 +184,7 @@ static int __init lpc32xx_clockevent_init(struct device_node *np)
 
 	clk = of_clk_get_by_name(np, "timerclk");
 	if (IS_ERR(clk)) {
-		pr_err("clock get failed (%lu)\n", PTR_ERR(clk));
+		pr_err("clock get failed (%ld)\n", PTR_ERR(clk));
 		return PTR_ERR(clk);
 	}
 
-- 
1.9.1
