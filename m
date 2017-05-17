From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 May 2017 16:05:35 +0200
Subject: [PATCH 1/8] clocksource/drivers/fttmr010: Fix the clock handling
In-Reply-To: <20170517140542.20016-1-linus.walleij@linaro.org>
References: <20170517140542.20016-1-linus.walleij@linaro.org>
Message-ID: <20170517140542.20016-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to also prepare and enable the clock we are using to get
the right reference count and avoid it being shut off.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/timer-fttmr010.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index b4a6f1e4bc54..58ce017e4a65 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -238,12 +238,18 @@ static int __init fttmr010_timer_of_init(struct device_node *np)
 	 * and using EXTCLK is not supported in the driver.
 	 */
 	struct clk *clk;
+	int ret;
 
 	clk = of_clk_get_by_name(np, "PCLK");
 	if (IS_ERR(clk)) {
-		pr_err("could not get PCLK");
+		pr_err("could not get PCLK\n");
 		return PTR_ERR(clk);
 	}
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("failed to enable PCLK\n");
+		return ret;
+	}
 	tick_rate = clk_get_rate(clk);
 
 	return fttmr010_timer_common_init(np);
-- 
2.9.3
