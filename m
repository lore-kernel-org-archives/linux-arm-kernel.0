From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Apr 2013 16:03:19 +0200
Subject: [PATCH 1/7] clk: exynos: prepare for multiplatform
In-Reply-To: <1365775405-115297-1-git-send-email-arnd@arndb.de>
References: <1365775405-115297-1-git-send-email-arnd@arndb.de>
Message-ID: <1365775405-115297-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new common clock drivers for exynos are using compile
time constants and soc_is_exynos* macros to provide backwards
compatibility for pre-DT systems, which is not possible with
multiplatform kernels. This moves all the necessary
information back into platform code and removes the mach/*
header inclusions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mike Turquette <mturquette@linaro.org>
---
 arch/arm/mach-exynos/common.c        |  2 +-
 arch/arm/mach-exynos/common.h        |  2 +-
 drivers/clk/samsung/clk-exynos4.c    | 93 ++++++++++++++++--------------------
 drivers/clk/samsung/clk-exynos5250.c |  1 -
 drivers/clk/samsung/clk-exynos5440.c |  1 -
 drivers/clk/samsung/clk.h            |  2 -
 6 files changed, 44 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 939bda7..42f399a 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -410,7 +410,7 @@ void __init exynos_init_time(void)
 	} else {
 		/* todo: remove after migrating legacy E4 platforms to dt */
 #ifdef CONFIG_ARCH_EXYNOS4
-		exynos4_clk_init(NULL);
+		exynos4_clk_init(NULL, !soc_is_exynos4210(), S5P_VA_CMU, readl(S5P_VA_CHIPID + 8) & 1);
 		exynos4_clk_register_fixed_ext(xxti_f, xusbxti_f);
 #endif
 		mct_init();
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index cb89ab8..4ed8eef 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -27,7 +27,7 @@ void exynos5_restart(char mode, const char *cmd);
 void exynos_init_late(void);
 
 /* ToDo: remove these after migrating legacy exynos4 platforms to dt */
-void exynos4_clk_init(struct device_node *np);
+void exynos4_clk_init(struct device_node *np, int is_exynos4210, void __iomem *reg_base, unsigned long xom);
 void exynos4_clk_register_fixed_ext(unsigned long, unsigned long);
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 7104669..d0940e6 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -16,7 +16,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
-#include <plat/cpu.h>
 #include "clk.h"
 #include "clk-pll.h"
 
@@ -910,16 +909,6 @@ struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
 			CLK_IGNORE_UNUSED, 0),
 };
 
-#ifdef CONFIG_OF
-static struct of_device_id exynos4_clk_ids[] __initdata = {
-	{ .compatible = "samsung,exynos4210-clock",
-			.data = (void *)EXYNOS4210, },
-	{ .compatible = "samsung,exynos4412-clock",
-			.data = (void *)EXYNOS4X12, },
-	{ },
-};
-#endif
-
 /*
  * The parent of the fin_pll clock is selected by the XOM[0] bit. This bit
  * resides in chipid register space, outside of the clock controller memory
@@ -927,33 +916,40 @@ static struct of_device_id exynos4_clk_ids[] __initdata = {
  * controller is first remapped and the value of XOM[0] bit is read to
  * determine the parent clock.
  */
-static void __init exynos4_clk_register_finpll(void)
+static unsigned long exynos4_get_xom(void)
 {
-	struct samsung_fixed_rate_clock fclk;
+	unsigned long xom = 0;
+	void __iomem *chipid_base;
 	struct device_node *np;
-	struct clk *clk;
-	void __iomem *chipid_base = S5P_VA_CHIPID;
-	unsigned long xom, finpll_f = 24000000;
-	char *parent_name;
 
 	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
-	if (np)
+	if (np) {
 		chipid_base = of_iomap(np, 0);
 
-	if (chipid_base) {
-		xom = readl(chipid_base + 8);
-		parent_name = xom & 1 ? "xusbxti" : "xxti";
-		clk = clk_get(NULL, parent_name);
-		if (IS_ERR(clk)) {
-			pr_err("%s: failed to lookup parent clock %s, assuming "
-				"fin_pll clock frequency is 24MHz\n", __func__,
-				parent_name);
-		} else {
-			finpll_f = clk_get_rate(clk);
-		}
+		if (chipid_base)
+			xom = readl(chipid_base + 8);
+
+		iounmap(chipid_base);
+	}
+
+	return xom;
+}
+
+static void __init exynos4_clk_register_finpll(unsigned long xom)
+{
+	struct samsung_fixed_rate_clock fclk;
+	struct clk *clk;
+	unsigned long finpll_f = 24000000;
+	char *parent_name;
+
+	parent_name = xom & 1 ? "xusbxti" : "xxti";
+	clk = clk_get(NULL, parent_name);
+	if (IS_ERR(clk)) {
+		pr_err("%s: failed to lookup parent clock %s, assuming "
+			"fin_pll clock frequency is 24MHz\n", __func__,
+			parent_name);
 	} else {
-		pr_err("%s: failed to map chipid registers, assuming "
-			"fin_pll clock frequency is 24MHz\n", __func__);
+		finpll_f = clk_get_rate(clk);
 	}
 
 	fclk.id = fin_pll;
@@ -963,8 +959,6 @@ static void __init exynos4_clk_register_finpll(void)
 	fclk.fixed_rate = finpll_f;
 	samsung_clk_register_fixed_rate(&fclk, 1);
 
-	if (np)
-		iounmap(chipid_base);
 }
 
 /*
@@ -988,28 +982,14 @@ static __initdata struct of_device_id ext_clk_match[] = {
 };
 
 /* register exynos4 clocks */
-void __init exynos4_clk_init(struct device_node *np)
+void __init exynos4_clk_init(struct device_node *np, enum exynos4_soc exynos4_soc, void __iomem *reg_base, unsigned long xom)
 {
-	void __iomem *reg_base;
 	struct clk *apll, *mpll, *epll, *vpll;
-	u32 exynos4_soc;
 
 	if (np) {
-		const struct of_device_id *match;
-		match = of_match_node(exynos4_clk_ids, np);
-		exynos4_soc = (u32)match->data;
-
 		reg_base = of_iomap(np, 0);
 		if (!reg_base)
 			panic("%s: failed to map registers\n", __func__);
-	} else {
-		reg_base = S5P_VA_CMU;
-		if (soc_is_exynos4210())
-			exynos4_soc = EXYNOS4210;
-		else if (soc_is_exynos4212() || soc_is_exynos4412())
-			exynos4_soc = EXYNOS4X12;
-		else
-			panic("%s: unable to determine soc\n", __func__);
 	}
 
 	if (exynos4_soc == EXYNOS4210)
@@ -1026,7 +1006,7 @@ void __init exynos4_clk_init(struct device_node *np)
 			ARRAY_SIZE(exynos4_fixed_rate_ext_clks),
 			ext_clk_match);
 
-	exynos4_clk_register_finpll();
+	exynos4_clk_register_finpll(xom);
 
 	if (exynos4_soc == EXYNOS4210) {
 		apll = samsung_clk_register_pll45xx("fout_apll", "fin_pll",
@@ -1087,5 +1067,16 @@ void __init exynos4_clk_init(struct device_node *np)
 		_get_rate("sclk_epll"), _get_rate("sclk_vpll"),
 		_get_rate("arm_clk"));
 }
-CLK_OF_DECLARE(exynos4210_clk, "samsung,exynos4210-clock", exynos4_clk_init);
-CLK_OF_DECLARE(exynos4412_clk, "samsung,exynos4412-clock", exynos4_clk_init);
+
+
+static void __init exynos4210_clk_init(struct device_node *np)
+{
+	exynos4_clk_init(np, EXYNOS4210, NULL, exynos4_get_xom());
+}
+CLK_OF_DECLARE(exynos4210_clk, "samsung,exynos4210-clock", exynos4210_clk_init);
+
+static void __init exynos4412_clk_init(struct device_node *np)
+{
+	exynos4_clk_init(np, EXYNOS4X12, NULL, exynos4_get_xom());
+}
+CLK_OF_DECLARE(exynos4412_clk, "samsung,exynos4412-clock", exynos4412_clk_init);
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 7290faa..61068cd 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -16,7 +16,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
-#include <plat/cpu.h>
 #include "clk.h"
 #include "clk-pll.h"
 
diff --git a/drivers/clk/samsung/clk-exynos5440.c b/drivers/clk/samsung/clk-exynos5440.c
index a0a094c..7d54341 100644
--- a/drivers/clk/samsung/clk-exynos5440.c
+++ b/drivers/clk/samsung/clk-exynos5440.c
@@ -15,7 +15,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
-#include <plat/cpu.h>
 #include "clk.h"
 #include "clk-pll.h"
 
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 10b2111..e4ad6ea 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -20,8 +20,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
-#include <mach/map.h>
-
 /**
  * struct samsung_clock_alias: information about mux clock
  * @id: platform specific id of the clock.
-- 
1.8.1.2
