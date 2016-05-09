From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon,  9 May 2016 19:32:31 +0200
Subject: [PATCH v2] clk: samsung: Remove useless check for return value of
 samsung_clk_init
Message-ID: <1462815151-14396-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The samsung_clk_init() cannot return NULL. Either it returns allocated
memory or it panics.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v1:
1. Remove the check from most of other Samsung clock drivers (suggested
   by Javier).
---
 drivers/clk/samsung/clk-exynos4.c    | 2 --
 drivers/clk/samsung/clk-exynos5250.c | 3 +--
 drivers/clk/samsung/clk-exynos5420.c | 2 --
 drivers/clk/samsung/clk-exynos5440.c | 2 --
 drivers/clk/samsung/clk-s3c2410.c    | 2 --
 drivers/clk/samsung/clk-s3c2412.c    | 2 --
 drivers/clk/samsung/clk-s3c2443.c    | 2 --
 drivers/clk/samsung/clk-s3c64xx.c    | 2 --
 drivers/clk/samsung/clk-s5pv210.c    | 2 --
 9 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 7b3d0f975987..2f458233908b 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1450,8 +1450,6 @@ static void __init exynos4_clk_init(struct device_node *np,
 		panic("%s: failed to map registers\n", __func__);
 
 	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
-	if (!ctx)
-		panic("%s: unable to allocate context.\n", __func__);
 
 	samsung_clk_of_register_fixed_ext(ctx, exynos4_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos4_fixed_rate_ext_clks),
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 837197db4ffb..d8621cf31786 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -805,8 +805,7 @@ static void __init exynos5250_clk_init(struct device_node *np)
 	}
 
 	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
-	if (!ctx)
-		panic("%s: unable to allocate context.\n", __func__);
+
 	samsung_clk_of_register_fixed_ext(ctx, exynos5250_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos5250_fixed_rate_ext_clks),
 			ext_clk_match);
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 92382cef9f90..770c0f007c6b 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1356,8 +1356,6 @@ static void __init exynos5x_clk_init(struct device_node *np,
 	exynos5x_soc = soc;
 
 	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
-	if (!ctx)
-		panic("%s: unable to allocate context.\n", __func__);
 
 	samsung_clk_of_register_fixed_ext(ctx, exynos5x_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos5x_fixed_rate_ext_clks),
diff --git a/drivers/clk/samsung/clk-exynos5440.c b/drivers/clk/samsung/clk-exynos5440.c
index c57cff1e1798..22c73d4a5ee3 100644
--- a/drivers/clk/samsung/clk-exynos5440.c
+++ b/drivers/clk/samsung/clk-exynos5440.c
@@ -125,8 +125,6 @@ static void __init exynos5440_clk_init(struct device_node *np)
 	}
 
 	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
-	if (!ctx)
-		panic("%s: unable to allocate context.\n", __func__);
 
 	samsung_clk_of_register_fixed_ext(ctx, exynos5440_fixed_rate_ext_clks,
 		ARRAY_SIZE(exynos5440_fixed_rate_ext_clks), ext_clk_match);
diff --git a/drivers/clk/samsung/clk-s3c2410.c b/drivers/clk/samsung/clk-s3c2410.c
index d7b011c1fcf8..d7a1e772d95a 100644
--- a/drivers/clk/samsung/clk-s3c2410.c
+++ b/drivers/clk/samsung/clk-s3c2410.c
@@ -374,8 +374,6 @@ void __init s3c2410_common_clk_init(struct device_node *np, unsigned long xti_f,
 	}
 
 	ctx = samsung_clk_init(np, reg_base, NR_CLKS);
-	if (!ctx)
-		panic("%s: unable to allocate context.\n", __func__);
 
 	/* Register external clocks only in non-dt cases */
 	if (!np)
diff --git a/drivers/clk/samsung/clk-s3c2412.c b/drivers/clk/samsung/clk-s3c2412.c
index effe3736ec6b..ec873ee15d37 100644
--- a/drivers/clk/samsung/clk-s3c2412.c
+++ b/drivers/clk/samsung/clk-s3c2412.c
@@ -265,8 +265,6 @@ void __init s3c2412_common_clk_init(struct device_node *np, unsigned long xti_f,
 	}
 
 	ctx = samsung_clk_init(np, reg_base, NR_CLKS);
-	if (!ctx)
-		panic("%s: unable to allocate context.\n", __func__);
 
 	/* Register external clocks only in non-dt cases */
 	if (!np)
diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
index 37562783b25e..5e24a17e10e6 100644
--- a/drivers/clk/samsung/clk-s3c2443.c
+++ b/drivers/clk/samsung/clk-s3c2443.c
@@ -400,8 +400,6 @@ void __init s3c2443_common_clk_init(struct device_node *np, unsigned long xti_f,
 	}
 
 	ctx = samsung_clk_init(np, reg_base, NR_CLKS);
-	if (!ctx)
-		panic("%s: unable to allocate context.\n", __func__);
 
 	/* Register external clocks only in non-dt cases */
 	if (!np)
diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
index 60aa775bd374..a48bd5f17330 100644
--- a/drivers/clk/samsung/clk-s3c64xx.c
+++ b/drivers/clk/samsung/clk-s3c64xx.c
@@ -471,8 +471,6 @@ void __init s3c64xx_clk_init(struct device_node *np, unsigned long xtal_f,
 	}
 
 	ctx = samsung_clk_init(np, reg_base, NR_CLKS);
-	if (!ctx)
-		panic("%s: unable to allocate context.\n", __func__);
 
 	/* Register external clocks. */
 	if (!np)
diff --git a/drivers/clk/samsung/clk-s5pv210.c b/drivers/clk/samsung/clk-s5pv210.c
index 52302262045d..fd2725710a6f 100644
--- a/drivers/clk/samsung/clk-s5pv210.c
+++ b/drivers/clk/samsung/clk-s5pv210.c
@@ -784,8 +784,6 @@ static void __init __s5pv210_clk_init(struct device_node *np,
 	struct samsung_clk_provider *ctx;
 
 	ctx = samsung_clk_init(np, reg_base, NR_CLKS);
-	if (!ctx)
-		panic("%s: unable to allocate context.\n", __func__);
 
 	samsung_clk_register_mux(ctx, early_mux_clks,
 					ARRAY_SIZE(early_mux_clks));
-- 
2.5.0
