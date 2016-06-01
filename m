From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:29 -0700
Subject: [PATCH 30/34] clk: stm32f3: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-31-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-stm32f4.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index fd89e771107e..b6ca33f0c935 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -136,7 +136,7 @@ static const u64 stm32f42xx_gate_map[] = { 0x000000f17ef417ffull,
 					   0x0000000000000001ull,
 					   0x04777f33f6fec9ffull };
 
-static struct clk *clks[MAX_CLKS];
+static struct clk_hw *clks[MAX_CLKS];
 static DEFINE_SPINLOCK(stm32f4_clk_lock);
 static void __iomem *base;
 
@@ -281,7 +281,7 @@ static int stm32f4_rcc_lookup_clk_idx(u8 primary, u8 secondary)
 	       (BIT_ULL_WORD(secondary) >= 2 ? hweight64(table[2]) : 0);
 }
 
-static struct clk *
+static struct clk_hw *
 stm32f4_rcc_lookup_clk(struct of_phandle_args *clkspec, void *data)
 {
 	int i = stm32f4_rcc_lookup_clk_idx(clkspec->args[0], clkspec->args[1]);
@@ -346,9 +346,9 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 	clk_register_apb_mul(NULL, "apb2_mul", "apb2_div",
 			     CLK_SET_RATE_PARENT, 15);
 
-	clks[SYSTICK] = clk_register_fixed_factor(NULL, "systick", "ahb_div",
+	clks[SYSTICK] = clk_hw_register_fixed_factor(NULL, "systick", "ahb_div",
 						  0, 1, 8);
-	clks[FCLK] = clk_register_fixed_factor(NULL, "fclk", "ahb_div",
+	clks[FCLK] = clk_hw_register_fixed_factor(NULL, "fclk", "ahb_div",
 					       0, 1, 1);
 
 	for (n = 0; n < ARRAY_SIZE(stm32f4_gates); n++) {
@@ -360,7 +360,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 		if (idx < 0)
 			goto fail;
 
-		clks[idx] = clk_register_gate(
+		clks[idx] = clk_hw_register_gate(
 		    NULL, gd->name, gd->parent_name, gd->flags,
 		    base + gd->offset, gd->bit_idx, 0, &stm32f4_clk_lock);
 
@@ -371,7 +371,7 @@ static void __init stm32f4_rcc_init(struct device_node *np)
 		}
 	}
 
-	of_clk_add_provider(np, stm32f4_rcc_lookup_clk, NULL);
+	of_clk_add_hw_provider(np, stm32f4_rcc_lookup_clk, NULL);
 	return;
 fail:
 	iounmap(base);
-- 
2.7.4
