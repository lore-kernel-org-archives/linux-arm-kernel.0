From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed,  2 Dec 2015 08:02:08 +0200
Subject: [PATCH] clocksource: correct pr_err() output format
Message-ID: <1449036128-19968-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
2.1.4
