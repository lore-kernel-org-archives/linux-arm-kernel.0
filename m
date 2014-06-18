From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 18 Jun 2014 17:46:52 +0200
Subject: [PATCH] clk: samsung: Register clk provider only after registering its
 all clocks
Message-ID: <1403106412-24526-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure the clock provider is not registered until after all its related
clocks were created and are ready to use. Currently there are races
possible and any (of_)clk_get() call right after a clock provider's
clk_init_cb callback call may fail.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---

NOTE: Tested only on Exynos4412.

 drivers/clk/samsung/clk-exynos3250.c |    2 ++
 drivers/clk/samsung/clk-exynos4.c    |    2 ++
 drivers/clk/samsung/clk-exynos5250.c |    2 ++
 drivers/clk/samsung/clk-exynos5260.c |    2 ++
 drivers/clk/samsung/clk-exynos5410.c |    2 ++
 drivers/clk/samsung/clk-exynos5420.c |    2 ++
 drivers/clk/samsung/clk-exynos5440.c |    2 ++
 drivers/clk/samsung/clk-s3c2410.c    |    2 ++
 drivers/clk/samsung/clk-s3c2412.c    |    2 ++
 drivers/clk/samsung/clk-s3c2443.c    |    2 ++
 drivers/clk/samsung/clk-s3c64xx.c    |    2 ++
 drivers/clk/samsung/clk.c            |   19 ++++++++++---------
 drivers/clk/samsung/clk.h            |    2 ++
 13 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index 7a17bd4..9a43cc3 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -776,5 +776,7 @@ static void __init exynos3250_cmu_init(struct device_node *np)
 	samsung_clk_register_gate(ctx, gate_clks, ARRAY_SIZE(gate_clks));

 	exynos3250_clk_sleep_init();
+
+	samsung_clk_of_add_provider(np, ctx);
 }
 CLK_OF_DECLARE(exynos3250_cmu, "samsung,exynos3250-cmu", exynos3250_cmu_init);
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 4f150c9..fc73bb4 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1260,6 +1260,8 @@ static void __init exynos4_clk_init(struct device_node *np,

 	exynos4_clk_sleep_init();

+	samsung_clk_of_add_provider(np, ctx);
+
 	pr_info("%s clocks: sclk_apll = %ld, sclk_mpll = %ld\n"
 		"\tsclk_epll = %ld, sclk_vpll = %ld, arm_clk = %ld\n",
 		exynos4_soc == EXYNOS4210 ? "Exynos4210" : "Exynos4x12",
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 1fad4c5..3a544a8 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -820,6 +820,8 @@ static void __init exynos5250_clk_init(struct device_node *np)

 	exynos5250_clk_sleep_init();

+	samsung_clk_of_add_provider(np, ctx);
+
 	pr_info("Exynos5250: clock setup completed, armclk=%ld\n",
 			_get_rate("div_arm2"));
 }
diff --git a/drivers/clk/samsung/clk-exynos5260.c b/drivers/clk/samsung/clk-exynos5260.c
index 64596ba..ce3de97 100644
--- a/drivers/clk/samsung/clk-exynos5260.c
+++ b/drivers/clk/samsung/clk-exynos5260.c
@@ -206,6 +206,8 @@ void __init exynos5260_cmu_register_one(struct device_node *np,
 	if (cmu->clk_regs)
 		exynos5260_clk_sleep_init(reg_base, cmu->clk_regs,
 			cmu->nr_clk_regs);
+
+	samsung_clk_of_add_provider(np, ctx);
 }


diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
index c9505ab..231475b 100644
--- a/drivers/clk/samsung/clk-exynos5410.c
+++ b/drivers/clk/samsung/clk-exynos5410.c
@@ -204,6 +204,8 @@ static void __init exynos5410_clk_init(struct device_node *np)
 	samsung_clk_register_gate(ctx, exynos5410_gate_clks,
 			ARRAY_SIZE(exynos5410_gate_clks));

+	samsung_clk_of_add_provider(np, ctx);
+
 	pr_debug("Exynos5410: clock setup completed.\n");
 }
 CLK_OF_DECLARE(exynos5410_clk, "samsung,exynos5410-clock", exynos5410_clk_init);
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 9d7d7ee..ef48f34 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1226,6 +1226,8 @@ static void __init exynos5x_clk_init(struct device_node *np,
 	}

 	exynos5420_clk_sleep_init();
+
+	samsung_clk_of_add_provider(np, ctx);
 }

 static void __init exynos5420_clk_init(struct device_node *np)
diff --git a/drivers/clk/samsung/clk-exynos5440.c b/drivers/clk/samsung/clk-exynos5440.c
index 647f144..2f182f2 100644
--- a/drivers/clk/samsung/clk-exynos5440.c
+++ b/drivers/clk/samsung/clk-exynos5440.c
@@ -123,6 +123,8 @@ static void __init exynos5440_clk_init(struct device_node *np)
 	samsung_clk_register_gate(ctx, exynos5440_gate_clks,
 			ARRAY_SIZE(exynos5440_gate_clks));

+	samsung_clk_of_add_provider(np, ctx);
+
 	pr_info("Exynos5440: arm_clk = %ldHz\n", _get_rate("arm_clk"));
 	pr_info("exynos5440 clock initialization complete\n");
 }
diff --git a/drivers/clk/samsung/clk-s3c2410.c b/drivers/clk/samsung/clk-s3c2410.c
index ba07168..2e688c3 100644
--- a/drivers/clk/samsung/clk-s3c2410.c
+++ b/drivers/clk/samsung/clk-s3c2410.c
@@ -461,6 +461,8 @@ void __init s3c2410_common_clk_init(struct device_node *np, unsigned long xti_f,
 	}

 	s3c2410_clk_sleep_init();
+
+	samsung_clk_of_add_provider(np, ctx);
 }

 static void __init s3c2410_clk_init(struct device_node *np)
diff --git a/drivers/clk/samsung/clk-s3c2412.c b/drivers/clk/samsung/clk-s3c2412.c
index 23e4313..34af09f 100644
--- a/drivers/clk/samsung/clk-s3c2412.c
+++ b/drivers/clk/samsung/clk-s3c2412.c
@@ -265,6 +265,8 @@ void __init s3c2412_common_clk_init(struct device_node *np, unsigned long xti_f,
 				   ARRAY_SIZE(s3c2412_aliases));

 	s3c2412_clk_sleep_init();
+
+	samsung_clk_of_add_provider(np, ctx);
 }

 static void __init s3c2412_clk_init(struct device_node *np)
diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
index c4bbdab..c92f853 100644
--- a/drivers/clk/samsung/clk-s3c2443.c
+++ b/drivers/clk/samsung/clk-s3c2443.c
@@ -445,6 +445,8 @@ void __init s3c2443_common_clk_init(struct device_node *np, unsigned long xti_f,
 	}

 	s3c2443_clk_sleep_init();
+
+	samsung_clk_of_add_provider(np, ctx);
 }

 static void __init s3c2416_clk_init(struct device_node *np)
diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
index efa16ee..3fb997fe 100644
--- a/drivers/clk/samsung/clk-s3c64xx.c
+++ b/drivers/clk/samsung/clk-s3c64xx.c
@@ -516,6 +516,8 @@ void __init s3c64xx_clk_init(struct device_node *np, unsigned long xtal_f,
 					ARRAY_SIZE(s3c64xx_clock_aliases));
 	s3c64xx_clk_sleep_init();

+	samsung_clk_of_add_provider(np, ctx);
+
 	pr_info("%s clocks: apll = %lu, mpll = %lu\n"
 		"\tepll = %lu, arm_clk = %lu\n",
 		is_s3c6400 ? "S3C6400" : "S3C6410",
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 49629c7..98fb31b 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -53,7 +53,6 @@ struct samsung_clk_provider *__init samsung_clk_init(struct device_node *np,
 {
 	struct samsung_clk_provider *ctx;
 	struct clk **clk_table;
-	int ret;
 	int i;

 	ctx = kzalloc(sizeof(struct samsung_clk_provider), GFP_KERNEL);
@@ -72,17 +71,19 @@ struct samsung_clk_provider *__init samsung_clk_init(struct device_node *np,
 	ctx->clk_data.clk_num = nr_clks;
 	spin_lock_init(&ctx->lock);

-	if (!np)
-		return ctx;
-
-	ret = of_clk_add_provider(np, of_clk_src_onecell_get,
-			&ctx->clk_data);
-	if (ret)
-		panic("could not register clock provide\n");
-
 	return ctx;
 }

+void __init samsung_clk_of_add_provider(struct device_node *np,
+				struct samsung_clk_provider *ctx)
+{
+	if (np) {
+		if (of_clk_add_provider(np, of_clk_src_onecell_get,
+					&ctx->clk_data))
+			panic("could not register clk provider\n");
+	}
+}
+
 /* add a clock instance to the clock lookup table used for dt based lookup */
 void samsung_clk_add_lookup(struct samsung_clk_provider *ctx, struct clk *clk,
 				unsigned int id)
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 9693b80..92131f9 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -327,6 +327,8 @@ struct samsung_pll_clock {
 extern struct samsung_clk_provider *__init samsung_clk_init(
 			struct device_node *np, void __iomem *base,
 			unsigned long nr_clks);
+extern void __init samsung_clk_of_add_provider(struct device_node *np,
+			struct samsung_clk_provider *ctx);
 extern void __init samsung_clk_of_register_fixed_ext(
 			struct samsung_clk_provider *ctx,
 			struct samsung_fixed_rate_clock *fixed_rate_clk,
--
1.7.9.5
