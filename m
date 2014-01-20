From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Jan 2014 21:55:24 +0100
Subject: [PATCH 4/5] clk: versatile: pass a parent to the ICST clock
Message-ID: <1390251324-6369-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we want to actually define the parent frequency in the device
tree for the ICST clocks, modify the clock registration function
to take a parent argument.

Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Mike, looking for an ACK to take this through the Integrator
and ARM SOC tree.
---
 drivers/clk/versatile/clk-icst.c       | 1 +
 drivers/clk/versatile/clk-icst.h       | 1 +
 drivers/clk/versatile/clk-impd1.c      | 6 ++++--
 drivers/clk/versatile/clk-integrator.c | 4 +++-
 drivers/clk/versatile/clk-realview.c   | 4 ++--
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
index 8cbfcf88fae3..c98adbe62733 100644
--- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -120,6 +120,7 @@ static const struct clk_ops icst_ops = {
 struct clk *icst_clk_register(struct device *dev,
 			const struct clk_icst_desc *desc,
 			const char *name,
+			const char *parent_name,
 			void __iomem *base)
 {
 	struct clk *clk;
diff --git a/drivers/clk/versatile/clk-icst.h b/drivers/clk/versatile/clk-icst.h
index be99dd0da785..04e6f0aef588 100644
--- a/drivers/clk/versatile/clk-icst.h
+++ b/drivers/clk/versatile/clk-icst.h
@@ -16,4 +16,5 @@ struct clk_icst_desc {
 struct clk *icst_clk_register(struct device *dev,
 			      const struct clk_icst_desc *desc,
 			      const char *name,
+			      const char *parent_name,
 			      void __iomem *base);
diff --git a/drivers/clk/versatile/clk-impd1.c b/drivers/clk/versatile/clk-impd1.c
index 844f8d711a12..6d8b8e1a080a 100644
--- a/drivers/clk/versatile/clk-impd1.c
+++ b/drivers/clk/versatile/clk-impd1.c
@@ -93,13 +93,15 @@ void integrator_impd1_clk_init(void __iomem *base, unsigned int id)
 	imc = &impd1_clks[id];
 
 	imc->vco1name = kasprintf(GFP_KERNEL, "lm%x-vco1", id);
-	clk = icst_clk_register(NULL, &impd1_icst1_desc, imc->vco1name, base);
+	clk = icst_clk_register(NULL, &impd1_icst1_desc, imc->vco1name, NULL,
+				base);
 	imc->vco1clk = clk;
 	imc->clks[0] = clkdev_alloc(clk, NULL, "lm%x:01000", id);
 
 	/* VCO2 is also called "CLK2" */
 	imc->vco2name = kasprintf(GFP_KERNEL, "lm%x-vco2", id);
-	clk = icst_clk_register(NULL, &impd1_icst2_desc, imc->vco2name, base);
+	clk = icst_clk_register(NULL, &impd1_icst2_desc, imc->vco2name, NULL,
+				base);
 	imc->vco2clk = clk;
 
 	/* MMCI uses CLK2 right off */
diff --git a/drivers/clk/versatile/clk-integrator.c b/drivers/clk/versatile/clk-integrator.c
index 19864b5690e9..5d36a719fefb 100644
--- a/drivers/clk/versatile/clk-integrator.c
+++ b/drivers/clk/versatile/clk-integrator.c
@@ -43,6 +43,7 @@ static void __init of_integrator_cm_osc_setup(struct device_node *np)
 	struct clk *clk = ERR_PTR(-EINVAL);
 	const char *clk_name = np->name;
 	const struct clk_icst_desc *desc = &cm_auxosc_desc;
+	const char *parent_name;
 
 	if (!cm_base) {
 		/* Remap the core module base if not done yet */
@@ -60,7 +61,8 @@ static void __init of_integrator_cm_osc_setup(struct device_node *np)
 		}
 	}
 
-	clk = icst_clk_register(NULL, desc, clk_name, cm_base);
+	parent_name = of_clk_get_parent_name(np, 0);
+	clk = icst_clk_register(NULL, desc, clk_name, parent_name, cm_base);
 	if (!IS_ERR(clk))
 		of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
diff --git a/drivers/clk/versatile/clk-realview.c b/drivers/clk/versatile/clk-realview.c
index 747e7b31117c..c8b523117fb7 100644
--- a/drivers/clk/versatile/clk-realview.c
+++ b/drivers/clk/versatile/clk-realview.c
@@ -85,10 +85,10 @@ void __init realview_clk_init(void __iomem *sysbase, bool is_pb1176)
 	/* ICST VCO clock */
 	if (is_pb1176)
 		clk = icst_clk_register(NULL, &realview_osc0_desc,
-					"osc0", sysbase);
+					"osc0", NULL, sysbase);
 	else
 		clk = icst_clk_register(NULL, &realview_osc4_desc,
-					"osc4", sysbase);
+					"osc4", NULL, sysbase);
 
 	clk_register_clkdev(clk, NULL, "dev:clcd");
 	clk_register_clkdev(clk, NULL, "issp:clcd");
-- 
1.8.4.2
