From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 19 Jul 2017 17:25:16 +0200
Subject: [PATCH 012/102] clocksource/drivers/sun5i: explicitly request
 exclusive reset control
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Message-ID: <20170719152646.25903-13-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/clocksource/timer-sun5i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 2a3fe83ec3377..a75be5bfb8b20 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -349,7 +349,7 @@ static int __init sun5i_timer_init(struct device_node *node)
 		return PTR_ERR(clk);
 	}
 
-	rstc = of_reset_control_get(node, NULL);
+	rstc = of_reset_control_get_exclusive(node, NULL);
 	if (!IS_ERR(rstc))
 		reset_control_deassert(rstc);
 
-- 
2.11.0
