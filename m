From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Sep 2013 19:53:36 +0200
Subject: [PATCH 03/26] clk: nomadik: declare OF clock provider
In-Reply-To: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1379526839-14798-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Common clock framework allows to register clock providers to get called
on of_clk_init() by using CLK_OF_DECLARE. This converts nomadik clock
provider to make use of it and get rid of the mach specific clk init
call. As clocks require system reset controller base address to be
initialized each clock driver checks src_base and calls new
nomadik_src_init if required.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-nomadik/cpu-8815.c          |    5 ++--
 drivers/clk/clk-nomadik.c                 |   46 ++++++++++-------------------
 include/linux/platform_data/clk-nomadik.h |    2 --
 3 files changed, 17 insertions(+), 36 deletions(-)
 delete mode 100644 include/linux/platform_data/clk-nomadik.h

diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 0fcb149..2be38a0 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -25,7 +25,7 @@
 #include <linux/slab.h>
 #include <linux/irq.h>
 #include <linux/dma-mapping.h>
-#include <linux/platform_data/clk-nomadik.h>
+#include <linux/clk-provider.h>
 #include <linux/clocksource.h>
 #include <linux/of_irq.h>
 #include <linux/of_gpio.h>
@@ -115,8 +115,7 @@ static void cpu8815_restart(enum reboot_mode mode, const char *cmd)
 
 static void __init cpu8815_timer_init_of(void)
 {
-	/* We need this to be up now */
-	nomadik_clk_init();
+	of_clk_init(NULL);
 	clocksource_of_init();
 }
 
diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index 7849086..74978f0 100644
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -491,6 +491,9 @@ static void __init of_nomadik_pll_setup(struct device_node *np)
 	const char *parent_name;
 	u32 pll_id;
 
+	if (!src_base)
+		nomadik_src_init();
+
 	if (of_property_read_u32(np, "pll-id", &pll_id)) {
 		pr_err("%s: PLL \"%s\" missing pll-id property\n",
 			__func__, clk_name);
@@ -501,6 +504,8 @@ static void __init of_nomadik_pll_setup(struct device_node *np)
 	if (!IS_ERR(clk))
 		of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
+CLK_OF_DECLARE(nomadik_pll_clk,
+	"st,nomadik-pll-clock", of_nomadik_pll_setup);
 
 static void __init of_nomadik_hclk_setup(struct device_node *np)
 {
@@ -508,6 +513,9 @@ static void __init of_nomadik_hclk_setup(struct device_node *np)
 	const char *clk_name = np->name;
 	const char *parent_name;
 
+	if (!src_base)
+		nomadik_src_init();
+
 	parent_name = of_clk_get_parent_name(np, 0);
 	/*
 	 * The HCLK divides PLL1 with 1 (passthru), 2, 3 or 4.
@@ -520,6 +528,8 @@ static void __init of_nomadik_hclk_setup(struct device_node *np)
 	if (!IS_ERR(clk))
 		of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
+CLK_OF_DECLARE(nomadik_hclk_clk,
+	"st,nomadik-hclk-clock", of_nomadik_hclk_setup);
 
 static void __init of_nomadik_src_clk_setup(struct device_node *np)
 {
@@ -528,6 +538,9 @@ static void __init of_nomadik_src_clk_setup(struct device_node *np)
 	const char *parent_name;
 	u32 clk_id;
 
+	if (!src_base)
+		nomadik_src_init();
+
 	if (of_property_read_u32(np, "clock-id", &clk_id)) {
 		pr_err("%s: SRC clock \"%s\" missing clock-id property\n",
 			__func__, clk_name);
@@ -538,34 +551,5 @@ static void __init of_nomadik_src_clk_setup(struct device_node *np)
 	if (!IS_ERR(clk))
 		of_clk_add_provider(np, of_clk_src_simple_get, clk);
 }
-
-static const struct of_device_id nomadik_src_clk_match[] __initconst = {
-	{
-		.compatible = "fixed-clock",
-		.data = of_fixed_clk_setup,
-	},
-	{
-		.compatible = "fixed-factor-clock",
-		.data = of_fixed_factor_clk_setup,
-	},
-	{
-		.compatible = "st,nomadik-pll-clock",
-		.data = of_nomadik_pll_setup,
-	},
-	{
-		.compatible = "st,nomadik-hclk-clock",
-		.data = of_nomadik_hclk_setup,
-	},
-	{
-		.compatible = "st,nomadik-src-clock",
-		.data = of_nomadik_src_clk_setup,
-	},
-	{ /* sentinel */ }
-};
-
-
-void __init nomadik_clk_init(void)
-{
-	nomadik_src_init();
-	of_clk_init(nomadik_src_clk_match);
-}
+CLK_OF_DECLARE(nomadik_src_clk,
+	"st,nomadik-src-clock", of_nomadik_src_clk_setup);
diff --git a/include/linux/platform_data/clk-nomadik.h b/include/linux/platform_data/clk-nomadik.h
deleted file mode 100644
index 5713c87..0000000
--- a/include/linux/platform_data/clk-nomadik.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* Minimal platform data header */
-void nomadik_clk_init(void);
-- 
1.7.10.4
