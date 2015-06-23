From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue, 23 Jun 2015 16:09:24 +0200
Subject: [PATCH 6/9] drivers: clk: st: Add CLK_GET_RATE_NOCACHE flag to clocks
In-Reply-To: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1435068567-30995-7-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pankaj Dev <pankaj.dev@st.com>

Add the CLK_GET_RATE_NOCACHE flag to all the clocks with recalc ops,
so that they reflect Hw rate after CPS wake-up when a clk_get_rate()
is called

Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 drivers/clk/st/clk-flexgen.c | 2 +-
 drivers/clk/st/clkgen-fsyn.c | 2 +-
 drivers/clk/st/clkgen-mux.c  | 8 +++++---
 drivers/clk/st/clkgen-pll.c  | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.c
index be06d2a..8dd8cce 100644
--- a/drivers/clk/st/clk-flexgen.c
+++ b/drivers/clk/st/clk-flexgen.c
@@ -190,7 +190,7 @@ static struct clk *clk_register_flexgen(const char *name,
 
 	init.name = name;
 	init.ops = &flexgen_ops;
-	init.flags = CLK_IS_BASIC | flexgen_flags;
+	init.flags = CLK_IS_BASIC | CLK_GET_RATE_NOCACHE | flexgen_flags;
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
 
diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index 9e26099..d9eb2e1 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -635,7 +635,7 @@ static struct clk * __init st_clk_register_quadfs_pll(
 
 	init.name = name;
 	init.ops = quadfs->pll_ops;
-	init.flags = CLK_IS_BASIC;
+	init.flags = CLK_IS_BASIC | CLK_GET_RATE_NOCACHE;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
index c94b56b..3919a67 100644
--- a/drivers/clk/st/clkgen-mux.c
+++ b/drivers/clk/st/clkgen-mux.c
@@ -239,7 +239,7 @@ static struct clk *clk_register_genamux(const char *name,
 
 	init.name = name;
 	init.ops = &clkgena_divmux_ops;
-	init.flags = CLK_IS_BASIC;
+	init.flags = CLK_IS_BASIC | CLK_GET_RATE_NOCACHE;
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
 
@@ -516,7 +516,8 @@ static void __init st_of_clkgena_prediv_setup(struct device_node *np)
 					  0, &clk_name))
 		return;
 
-	clk = clk_register_divider_table(NULL, clk_name, parent_name, 0,
+	clk = clk_register_divider_table(NULL, clk_name, parent_name,
+					 CLK_GET_RATE_NOCACHE,
 					 reg + data->offset, data->shift, 1,
 					 0, data->table, NULL);
 	if (IS_ERR(clk))
@@ -789,7 +790,8 @@ static void __init st_of_clkgen_vcc_setup(struct device_node *np)
 					     &mux->hw, &clk_mux_ops,
 					     &div->hw, &clk_divider_ops,
 					     &gate->hw, &clk_gate_ops,
-					     data->clk_flags);
+					     data->clk_flags |
+					     CLK_GET_RATE_NOCACHE);
 		if (IS_ERR(clk)) {
 			kfree(gate);
 			kfree(div);
diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index 1065322..72d1c27 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -406,7 +406,7 @@ static struct clk * __init clkgen_pll_register(const char *parent_name,
 	init.name = clk_name;
 	init.ops = pll_data->ops;
 
-	init.flags = CLK_IS_BASIC;
+	init.flags = CLK_IS_BASIC | CLK_GET_RATE_NOCACHE;
 	init.parent_names = &parent_name;
 	init.num_parents  = 1;
 
-- 
1.9.1
