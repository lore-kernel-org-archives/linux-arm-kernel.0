From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 May 2017 16:05:37 +0200
Subject: [PATCH 3/8] clocksource/drivers/fttmr010: Drop Gemini specifics
In-Reply-To: <20170517140542.20016-1-linus.walleij@linaro.org>
References: <20170517140542.20016-1-linus.walleij@linaro.org>
Message-ID: <20170517140542.20016-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Gemini now has a proper clock driver and a proper PCLK
assigned in its device tree. Drop the Gemini-specific hacks
to look up the system speed and rely on the clock framework
like everyone else.

Cc: Joel Stanley <joel@jms.id.au>
Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/timer-fttmr010.c | 103 ++++++++---------------------------
 1 file changed, 22 insertions(+), 81 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index 58ce017e4a65..db097db346e3 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -11,8 +11,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
 #include <linux/sched_clock.h>
@@ -179,9 +177,28 @@ static struct irqaction fttmr010_timer_irq = {
 	.handler	= fttmr010_timer_interrupt,
 };
 
-static int __init fttmr010_timer_common_init(struct device_node *np)
+static int __init fttmr010_timer_init(struct device_node *np)
 {
 	int irq;
+	struct clk *clk;
+	int ret;
+
+	/*
+	 * These implementations require a clock reference.
+	 * FIXME: we currently only support clocking using PCLK
+	 * and using EXTCLK is not supported in the driver.
+	 */
+	clk = of_clk_get_by_name(np, "PCLK");
+	if (IS_ERR(clk)) {
+		pr_err("could not get PCLK\n");
+		return PTR_ERR(clk);
+	}
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("failed to enable PCLK\n");
+		return ret;
+	}
+	tick_rate = clk_get_rate(clk);
 
 	base = of_iomap(np, 0);
 	if (!base) {
@@ -229,81 +246,5 @@ static int __init fttmr010_timer_common_init(struct device_node *np)
 
 	return 0;
 }
-
-static int __init fttmr010_timer_of_init(struct device_node *np)
-{
-	/*
-	 * These implementations require a clock reference.
-	 * FIXME: we currently only support clocking using PCLK
-	 * and using EXTCLK is not supported in the driver.
-	 */
-	struct clk *clk;
-	int ret;
-
-	clk = of_clk_get_by_name(np, "PCLK");
-	if (IS_ERR(clk)) {
-		pr_err("could not get PCLK\n");
-		return PTR_ERR(clk);
-	}
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("failed to enable PCLK\n");
-		return ret;
-	}
-	tick_rate = clk_get_rate(clk);
-
-	return fttmr010_timer_common_init(np);
-}
-CLOCKSOURCE_OF_DECLARE(fttmr010, "faraday,fttmr010", fttmr010_timer_of_init);
-
-/*
- * Gemini-specific: relevant registers in the global syscon
- */
-#define GLOBAL_STATUS		0x04
-#define CPU_AHB_RATIO_MASK	(0x3 << 18)
-#define CPU_AHB_1_1		(0x0 << 18)
-#define CPU_AHB_3_2		(0x1 << 18)
-#define CPU_AHB_24_13		(0x2 << 18)
-#define CPU_AHB_2_1		(0x3 << 18)
-#define REG_TO_AHB_SPEED(reg)	((((reg) >> 15) & 0x7) * 10 + 130)
-
-static int __init gemini_timer_of_init(struct device_node *np)
-{
-	static struct regmap *map;
-	int ret;
-	u32 val;
-
-	map = syscon_regmap_lookup_by_phandle(np, "syscon");
-	if (IS_ERR(map)) {
-		pr_err("Can't get regmap for syscon handle\n");
-		return -ENODEV;
-	}
-	ret = regmap_read(map, GLOBAL_STATUS, &val);
-	if (ret) {
-		pr_err("Can't read syscon status register\n");
-		return -ENXIO;
-	}
-
-	tick_rate = REG_TO_AHB_SPEED(val) * 1000000;
-	pr_info("Bus: %dMHz ", tick_rate / 1000000);
-
-	tick_rate /= 6;		/* APB bus run AHB*(1/6) */
-
-	switch (val & CPU_AHB_RATIO_MASK) {
-	case CPU_AHB_1_1:
-		pr_cont("(1/1)\n");
-		break;
-	case CPU_AHB_3_2:
-		pr_cont("(3/2)\n");
-		break;
-	case CPU_AHB_24_13:
-		pr_cont("(24/13)\n");
-		break;
-	case CPU_AHB_2_1:
-		pr_cont("(2/1)\n");
-		break;
-	}
-
-	return fttmr010_timer_common_init(np);
-}
-CLOCKSOURCE_OF_DECLARE(gemini, "cortina,gemini-timer", gemini_timer_of_init);
+CLOCKSOURCE_OF_DECLARE(fttmr010, "faraday,fttmr010", fttmr010_timer_init);
+CLOCKSOURCE_OF_DECLARE(gemini, "cortina,gemini-timer", fttmr010_timer_init);
-- 
2.9.3
