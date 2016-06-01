From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:12 -0700
Subject: [PATCH 13/34] clk: clps711x: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-14-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-clps711x.c | 78 +++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/clk/clk-clps711x.c b/drivers/clk/clk-clps711x.c
index 1f60b02416a7..9b57050b8f19 100644
--- a/drivers/clk/clk-clps711x.c
+++ b/drivers/clk/clk-clps711x.c
@@ -40,9 +40,8 @@ static const struct clk_div_table timer_div_table[] = {
 };
 
 struct clps711x_clk {
-	struct clk_onecell_data	clk_data;
-	spinlock_t		lock;
-	struct clk		*clks[CLPS711X_CLK_MAX];
+	spinlock_t			lock;
+	struct clk_hw_onecell_data	clk_data;
 };
 
 static struct clps711x_clk * __init _clps711x_clk_init(void __iomem *base,
@@ -55,7 +54,9 @@ static struct clps711x_clk * __init _clps711x_clk_init(void __iomem *base,
 	if (!base)
 		return ERR_PTR(-ENOMEM);
 
-	clps711x_clk = kzalloc(sizeof(*clps711x_clk), GFP_KERNEL);
+	clps711x_clk = kzalloc(sizeof(*clps711x_clk) +
+			sizeof(*clps711x_clk->clk_data.hws) * CLPS711X_CLK_MAX,
+			GFP_KERNEL);
 	if (!clps711x_clk)
 		return ERR_PTR(-ENOMEM);
 
@@ -106,40 +107,40 @@ static struct clps711x_clk * __init _clps711x_clk_init(void __iomem *base,
 	tmp |= SYSCON1_TC2M | SYSCON1_TC2S;
 	writel(tmp, base + CLPS711X_SYSCON1);
 
-	clps711x_clk->clks[CLPS711X_CLK_DUMMY] =
-		clk_register_fixed_rate(NULL, "dummy", NULL, 0, 0);
-	clps711x_clk->clks[CLPS711X_CLK_CPU] =
-		clk_register_fixed_rate(NULL, "cpu", NULL, 0, f_cpu);
-	clps711x_clk->clks[CLPS711X_CLK_BUS] =
-		clk_register_fixed_rate(NULL, "bus", NULL, 0, f_bus);
-	clps711x_clk->clks[CLPS711X_CLK_PLL] =
-		clk_register_fixed_rate(NULL, "pll", NULL, 0, f_pll);
-	clps711x_clk->clks[CLPS711X_CLK_TIMERREF] =
-		clk_register_fixed_rate(NULL, "timer_ref", NULL, 0, f_tim);
-	clps711x_clk->clks[CLPS711X_CLK_TIMER1] =
-		clk_register_divider_table(NULL, "timer1", "timer_ref", 0,
+	clps711x_clk->clk_data.hws[CLPS711X_CLK_DUMMY] =
+		clk_hw_register_fixed_rate(NULL, "dummy", NULL, 0, 0);
+	clps711x_clk->clk_data.hws[CLPS711X_CLK_CPU] =
+		clk_hw_register_fixed_rate(NULL, "cpu", NULL, 0, f_cpu);
+	clps711x_clk->clk_data.hws[CLPS711X_CLK_BUS] =
+		clk_hw_register_fixed_rate(NULL, "bus", NULL, 0, f_bus);
+	clps711x_clk->clk_data.hws[CLPS711X_CLK_PLL] =
+		clk_hw_register_fixed_rate(NULL, "pll", NULL, 0, f_pll);
+	clps711x_clk->clk_data.hws[CLPS711X_CLK_TIMERREF] =
+		clk_hw_register_fixed_rate(NULL, "timer_ref", NULL, 0, f_tim);
+	clps711x_clk->clk_data.hws[CLPS711X_CLK_TIMER1] =
+		clk_hw_register_divider_table(NULL, "timer1", "timer_ref", 0,
 					   base + CLPS711X_SYSCON1, 5, 1, 0,
 					   timer_div_table, &clps711x_clk->lock);
-	clps711x_clk->clks[CLPS711X_CLK_TIMER2] =
-		clk_register_divider_table(NULL, "timer2", "timer_ref", 0,
+	clps711x_clk->clk_data.hws[CLPS711X_CLK_TIMER2] =
+		clk_hw_register_divider_table(NULL, "timer2", "timer_ref", 0,
 					   base + CLPS711X_SYSCON1, 7, 1, 0,
 					   timer_div_table, &clps711x_clk->lock);
-	clps711x_clk->clks[CLPS711X_CLK_PWM] =
-		clk_register_fixed_rate(NULL, "pwm", NULL, 0, f_pwm);
-	clps711x_clk->clks[CLPS711X_CLK_SPIREF] =
-		clk_register_fixed_rate(NULL, "spi_ref", NULL, 0, f_spi);
-	clps711x_clk->clks[CLPS711X_CLK_SPI] =
-		clk_register_divider_table(NULL, "spi", "spi_ref", 0,
+	clps711x_clk->clk_data.hws[CLPS711X_CLK_PWM] =
+		clk_hw_register_fixed_rate(NULL, "pwm", NULL, 0, f_pwm);
+	clps711x_clk->clk_data.hws[CLPS711X_CLK_SPIREF] =
+		clk_hw_register_fixed_rate(NULL, "spi_ref", NULL, 0, f_spi);
+	clps711x_clk->clk_data.hws[CLPS711X_CLK_SPI] =
+		clk_hw_register_divider_table(NULL, "spi", "spi_ref", 0,
 					   base + CLPS711X_SYSCON1, 16, 2, 0,
 					   spi_div_table, &clps711x_clk->lock);
-	clps711x_clk->clks[CLPS711X_CLK_UART] =
-		clk_register_fixed_factor(NULL, "uart", "bus", 0, 1, 10);
-	clps711x_clk->clks[CLPS711X_CLK_TICK] =
-		clk_register_fixed_rate(NULL, "tick", NULL, 0, 64);
+	clps711x_clk->clk_data.hws[CLPS711X_CLK_UART] =
+		clk_hw_register_fixed_factor(NULL, "uart", "bus", 0, 1, 10);
+	clps711x_clk->clk_data.hws[CLPS711X_CLK_TICK] =
+		clk_hw_register_fixed_rate(NULL, "tick", NULL, 0, 64);
 	for (i = 0; i < CLPS711X_CLK_MAX; i++)
-		if (IS_ERR(clps711x_clk->clks[i]))
+		if (IS_ERR(clps711x_clk->clk_data.hws[i]))
 			pr_err("clk %i: register failed with %ld\n",
-			       i, PTR_ERR(clps711x_clk->clks[i]));
+			       i, PTR_ERR(clps711x_clk->clk_data.hws[i]));
 
 	return clps711x_clk;
 }
@@ -153,17 +154,17 @@ void __init clps711x_clk_init(void __iomem *base)
 	BUG_ON(IS_ERR(clps711x_clk));
 
 	/* Clocksource */
-	clk_register_clkdev(clps711x_clk->clks[CLPS711X_CLK_TIMER1],
+	clk_hw_register_clkdev(clps711x_clk->clk_data.hws[CLPS711X_CLK_TIMER1],
 			    NULL, "clps711x-timer.0");
-	clk_register_clkdev(clps711x_clk->clks[CLPS711X_CLK_TIMER2],
+	clk_hw_register_clkdev(clps711x_clk->clk_data.hws[CLPS711X_CLK_TIMER2],
 			    NULL, "clps711x-timer.1");
 
 	/* Drivers */
-	clk_register_clkdev(clps711x_clk->clks[CLPS711X_CLK_PWM],
+	clk_hw_register_clkdev(clps711x_clk->clk_data.hws[CLPS711X_CLK_PWM],
 			    NULL, "clps711x-pwm");
-	clk_register_clkdev(clps711x_clk->clks[CLPS711X_CLK_UART],
+	clk_hw_register_clkdev(clps711x_clk->clk_data.hws[CLPS711X_CLK_UART],
 			    NULL, "clps711x-uart.0");
-	clk_register_clkdev(clps711x_clk->clks[CLPS711X_CLK_UART],
+	clk_hw_register_clkdev(clps711x_clk->clk_data.hws[CLPS711X_CLK_UART],
 			    NULL, "clps711x-uart.1");
 }
 
@@ -179,10 +180,9 @@ static void __init clps711x_clk_init_dt(struct device_node *np)
 	clps711x_clk = _clps711x_clk_init(base, fref);
 	BUG_ON(IS_ERR(clps711x_clk));
 
-	clps711x_clk->clk_data.clks = clps711x_clk->clks;
-	clps711x_clk->clk_data.clk_num = CLPS711X_CLK_MAX;
-	of_clk_add_provider(np, of_clk_src_onecell_get,
-			    &clps711x_clk->clk_data);
+	clps711x_clk->clk_data.num = CLPS711X_CLK_MAX;
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
+			       &clps711x_clk->clk_data);
 }
 CLK_OF_DECLARE(clps711x, "cirrus,clps711x-clk", clps711x_clk_init_dt);
 #endif
-- 
2.7.4
