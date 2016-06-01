From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:17 -0700
Subject: [PATCH 18/34] clk: mb86s7x: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-19-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-mb86s7x.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-mb86s7x.c b/drivers/clk/clk-mb86s7x.c
index e0817754ca3e..2a83a3ff1d09 100644
--- a/drivers/clk/clk-mb86s7x.c
+++ b/drivers/clk/clk-mb86s7x.c
@@ -327,10 +327,11 @@ static struct clk_ops clk_clc_ops = {
 	.set_rate = clc_set_rate,
 };
 
-struct clk *mb86s7x_clclk_register(struct device *cpu_dev)
+static struct clk_hw *mb86s7x_clclk_register(struct device *cpu_dev)
 {
 	struct clk_init_data init;
 	struct cl_clk *clc;
+	int ret;
 
 	clc = kzalloc(sizeof(*clc), GFP_KERNEL);
 	if (!clc)
@@ -344,14 +345,17 @@ struct clk *mb86s7x_clclk_register(struct device *cpu_dev)
 	init.flags = CLK_GET_RATE_NOCACHE;
 	init.num_parents = 0;
 
-	return devm_clk_register(cpu_dev, &clc->hw);
+	ret = devm_clk_hw_register(cpu_dev, &clc->hw);
+	if (ret)
+		return ERR_PTR(ret);
+	return &clc->hw;
 }
 
 static int mb86s7x_clclk_of_init(void)
 {
 	int cpu, ret = -ENODEV;
 	struct device_node *np;
-	struct clk *clk;
+	struct clk_hw *hw;
 
 	np = of_find_compatible_node(NULL, NULL, "fujitsu,mb86s70-scb-1.0");
 	if (!np || !of_device_is_available(np))
@@ -365,12 +369,12 @@ static int mb86s7x_clclk_of_init(void)
 			continue;
 		}
 
-		clk = mb86s7x_clclk_register(cpu_dev);
-		if (IS_ERR(clk)) {
+		hw = mb86s7x_clclk_register(cpu_dev);
+		if (IS_ERR(hw)) {
 			pr_err("failed to register cpu%d clock\n", cpu);
 			continue;
 		}
-		if (clk_register_clkdev(clk, NULL, dev_name(cpu_dev))) {
+		if (clk_hw_register_clkdev(hw, NULL, dev_name(cpu_dev))) {
 			pr_err("failed to register cpu%d clock lookup\n", cpu);
 			continue;
 		}
-- 
2.7.4
