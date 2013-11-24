From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 24 Nov 2013 21:58:52 +0100
Subject: [PATCH 1/2] clk: versatile: pass a name to ICST clock provider
Message-ID: <1385326732-16406-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we have more than one of these clocks in a system (such as
on the IM-PD1) we need a mechanism to pass a name for the clock.
Refactor to add this as an argument.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi Mike, I'd like an ACK for this if you're OK with it, so I
can take it through the ARM SoC tree with the rest of the
Integrator patches.
---
 drivers/clk/versatile/clk-icst.c       | 3 ++-
 drivers/clk/versatile/clk-icst.h       | 1 +
 drivers/clk/versatile/clk-impd1.c      | 4 ++--
 drivers/clk/versatile/clk-integrator.c | 2 +-
 drivers/clk/versatile/clk-realview.c   | 6 ++++--
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
index f5e4c21b301f..8cbfcf88fae3 100644
--- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -119,6 +119,7 @@ static const struct clk_ops icst_ops = {
 
 struct clk *icst_clk_register(struct device *dev,
 			const struct clk_icst_desc *desc,
+			const char *name,
 			void __iomem *base)
 {
 	struct clk *clk;
@@ -130,7 +131,7 @@ struct clk *icst_clk_register(struct device *dev,
 		pr_err("could not allocate ICST clock!\n");
 		return ERR_PTR(-ENOMEM);
 	}
-	init.name = "icst";
+	init.name = name;
 	init.ops = &icst_ops;
 	init.flags = CLK_IS_ROOT;
 	init.parent_names = NULL;
diff --git a/drivers/clk/versatile/clk-icst.h b/drivers/clk/versatile/clk-icst.h
index dad51b6ffd00..be99dd0da785 100644
--- a/drivers/clk/versatile/clk-icst.h
+++ b/drivers/clk/versatile/clk-icst.h
@@ -15,4 +15,5 @@ struct clk_icst_desc {
 
 struct clk *icst_clk_register(struct device *dev,
 			      const struct clk_icst_desc *desc,
+			      const char *name,
 			      void __iomem *base);
diff --git a/drivers/clk/versatile/clk-impd1.c b/drivers/clk/versatile/clk-impd1.c
index 369139af2a3b..b693a2bbf25a 100644
--- a/drivers/clk/versatile/clk-impd1.c
+++ b/drivers/clk/versatile/clk-impd1.c
@@ -66,8 +66,8 @@ void integrator_impd1_clk_init(void __iomem *base, unsigned int id)
 	}
 	imc = &impd1_clks[id];
 
-	clk = icst_clk_register(NULL, &impd1_icst1_desc, base);
-	imc->vcoclk = clk;
+	clk = icst_clk_register(NULL, &impd1_icst1_desc, "icst1", base);
+	imc->vco1clk = clk;
 	imc->clks[0] = clkdev_alloc(clk, NULL, "lm%x:01000", id);
 
 	/* UART reference clock */
diff --git a/drivers/clk/versatile/clk-integrator.c b/drivers/clk/versatile/clk-integrator.c
index 08593b4ee2c9..bda8967e09c2 100644
--- a/drivers/clk/versatile/clk-integrator.c
+++ b/drivers/clk/versatile/clk-integrator.c
@@ -78,7 +78,7 @@ void __init integrator_clk_init(bool is_cp)
 	clk_register_clkdev(clk, NULL, "sp804");
 
 	/* ICST VCO clock used on the Integrator/CP CLCD */
-	clk = icst_clk_register(NULL, &cp_icst_desc,
+	clk = icst_clk_register(NULL, &cp_icst_desc, "icst",
 				__io_address(INTEGRATOR_HDR_BASE));
 	clk_register_clkdev(clk, NULL, "clcd");
 }
diff --git a/drivers/clk/versatile/clk-realview.c b/drivers/clk/versatile/clk-realview.c
index cda07e70a408..747e7b31117c 100644
--- a/drivers/clk/versatile/clk-realview.c
+++ b/drivers/clk/versatile/clk-realview.c
@@ -84,9 +84,11 @@ void __init realview_clk_init(void __iomem *sysbase, bool is_pb1176)
 
 	/* ICST VCO clock */
 	if (is_pb1176)
-		clk = icst_clk_register(NULL, &realview_osc0_desc, sysbase);
+		clk = icst_clk_register(NULL, &realview_osc0_desc,
+					"osc0", sysbase);
 	else
-		clk = icst_clk_register(NULL, &realview_osc4_desc, sysbase);
+		clk = icst_clk_register(NULL, &realview_osc4_desc,
+					"osc4", sysbase);
 
 	clk_register_clkdev(clk, NULL, "dev:clcd");
 	clk_register_clkdev(clk, NULL, "issp:clcd");
-- 
1.8.3.1
