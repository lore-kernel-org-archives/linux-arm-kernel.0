From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Mar 2013 12:02:58 +0100
Subject: [PATCH 21/21] clk: samsung: exynos4: Add support for SoC-specific
 register save list
In-Reply-To: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
References: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
Message-ID: <1364382178-25248-22-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends suspend/resume support for SoC-specific registers to
handle differences in register sets on particular SoCs.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c    | 30 ++++++++++++++++++++++++++++--
 drivers/clk/samsung/clk-exynos5250.c |  3 ++-
 drivers/clk/samsung/clk-exynos5440.c |  2 +-
 drivers/clk/samsung/clk.c            |  9 ++++++---
 drivers/clk/samsung/clk.h            |  3 ++-
 5 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 279c435..607ff3a 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -183,6 +183,26 @@ enum exynos4_clks {
  * list of controller registers to be saved and restored during a
  * suspend/resume cycle.
  */
+static __initdata unsigned long exynos4210_clk_save[] = {
+	E4210_SRC_IMAGE,
+	E4210_SRC_LCD1,
+	E4210_SRC_MASK_LCD1,
+	E4210_DIV_LCD1,
+	E4210_GATE_IP_IMAGE,
+	E4210_GATE_IP_LCD1,
+	E4210_GATE_IP_PERIR,
+	E4210_MPLL_CON0,
+};
+
+static __initdata unsigned long exynos4x12_clk_save[] = {
+	E4X12_GATE_IP_IMAGE,
+	E4X12_GATE_IP_PERIR,
+	E4X12_SRC_CAM1,
+	E4X12_DIV_ISP,
+	E4X12_DIV_CAM1,
+	E4X12_MPLL_CON0,
+};
+
 static __initdata unsigned long exynos4_clk_regs[] = {
 	SRC_LEFTBUS,
 	DIV_LEFTBUS,
@@ -985,8 +1005,14 @@ void __init exynos4_clk_init(struct device_node *np)
 			panic("%s: unable to determine soc\n", __func__);
 	}
 
-	samsung_clk_init(np, reg_base, nr_clks,
-		exynos4_clk_regs, ARRAY_SIZE(exynos4_clk_regs));
+	if (exynos4_soc == EXYNOS4210)
+		samsung_clk_init(np, reg_base, nr_clks,
+			exynos4_clk_regs, ARRAY_SIZE(exynos4_clk_regs),
+			exynos4210_clk_save, ARRAY_SIZE(exynos4210_clk_save));
+	else
+		samsung_clk_init(np, reg_base, nr_clks,
+			exynos4_clk_regs, ARRAY_SIZE(exynos4_clk_regs),
+			exynos4x12_clk_save, ARRAY_SIZE(exynos4x12_clk_save));
 
 	if (np)
 		samsung_clk_of_register_fixed_ext(exynos4_fixed_rate_ext_clks,
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 1152125..5cd9a0c 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -477,7 +477,8 @@ void __init exynos5250_clk_init(struct device_node *np)
 	}
 
 	samsung_clk_init(np, reg_base, nr_clks,
-			exynos5250_clk_regs, ARRAY_SIZE(exynos5250_clk_regs));
+			exynos5250_clk_regs, ARRAY_SIZE(exynos5250_clk_regs),
+			NULL, 0);
 	samsung_clk_of_register_fixed_ext(exynos5250_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos5250_fixed_rate_ext_clks),
 			ext_clk_match);
diff --git a/drivers/clk/samsung/clk-exynos5440.c b/drivers/clk/samsung/clk-exynos5440.c
index d588e93..a0a094c 100644
--- a/drivers/clk/samsung/clk-exynos5440.c
+++ b/drivers/clk/samsung/clk-exynos5440.c
@@ -115,7 +115,7 @@ void __init exynos5440_clk_init(struct device_node *np)
 		return;
 	}
 
-	samsung_clk_init(np, reg_base, nr_clks, NULL, 0);
+	samsung_clk_init(np, reg_base, nr_clks, NULL, 0, NULL, 0);
 	samsung_clk_of_register_fixed_ext(exynos5440_fixed_rate_ext_clks,
 		ARRAY_SIZE(exynos5440_fixed_rate_ext_clks), ext_clk_match);
 
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 82f27f6..3a50d4f 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -54,7 +54,8 @@ static struct syscore_ops samsung_clk_syscore_ops = {
 /* setup the essentials required to support clock lookup using ccf */
 void __init samsung_clk_init(struct device_node *np, void __iomem *base,
 		unsigned long nr_clks, unsigned long *rdump,
-		unsigned long nr_rdump)
+		unsigned long nr_rdump, unsigned long *soc_rdump,
+		unsigned long nr_soc_rdump)
 {
 	reg_base = base;
 
@@ -62,7 +63,7 @@ void __init samsung_clk_init(struct device_node *np, void __iomem *base,
 	if (rdump && nr_rdump) {
 		unsigned int idx;
 		reg_dump = kzalloc(sizeof(struct samsung_clk_reg_dump)
-					* nr_rdump, GFP_KERNEL);
+				* (nr_rdump + nr_soc_rdump), GFP_KERNEL);
 		if (!reg_dump) {
 			pr_err("%s: memory alloc for register dump failed\n",
 					__func__);
@@ -71,7 +72,9 @@ void __init samsung_clk_init(struct device_node *np, void __iomem *base,
 
 		for (idx = 0; idx < nr_rdump; idx++)
 			reg_dump[idx].offset = rdump[idx];
-		nr_reg_dump = nr_rdump;
+		for (idx = 0; idx < nr_soc_rdump; idx++)
+			reg_dump[nr_rdump + idx].offset = soc_rdump[idx];
+		nr_reg_dump = nr_rdump + nr_soc_rdump;
 		register_syscore_ops(&samsung_clk_syscore_ops);
 	}
 #endif
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 6bacd6f..10b2111 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -262,7 +262,8 @@ struct samsung_clk_reg_dump {
 
 extern void __init samsung_clk_init(struct device_node *np, void __iomem *base,
 		unsigned long nr_clks, unsigned long *rdump,
-		unsigned long nr_rdump);
+		unsigned long nr_rdump, unsigned long *soc_rdump,
+		unsigned long nr_soc_rdump);
 extern void __init samsung_clk_of_register_fixed_ext(
 		struct samsung_fixed_rate_clock *fixed_rate_clk,
 		unsigned int nr_fixed_rate_clk,
-- 
1.8.1.5
