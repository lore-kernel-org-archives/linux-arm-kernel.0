From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 17:19:40 +0200
Subject: [PATCH] clk: efm32: fix build warning
Message-ID: <3456522.oqa7pbstSD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The normal prototype for of clk init functions is to return void,
while efm32gg_cmu_init return an int, resulting in this harmless
build warning:

drivers/clk/clk-efm32gg.c:81:189: warning: comparison of distinct pointer types lacks a cast [enabled by default]
 CLK_OF_DECLARE(efm32ggcmu, "efm32gg,cmu", efm32gg_cmu_init);

This changes the return type to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/clk/clk-efm32gg.c b/drivers/clk/clk-efm32gg.c
index bac2ddf49d02..73a8d0ff530c 100644
--- a/drivers/clk/clk-efm32gg.c
+++ b/drivers/clk/clk-efm32gg.c
@@ -22,7 +22,7 @@ static struct clk_onecell_data clk_data = {
 	.clk_num = ARRAY_SIZE(clk),
 };
 
-static int __init efm32gg_cmu_init(struct device_node *np)
+static void __init efm32gg_cmu_init(struct device_node *np)
 {
 	int i;
 	void __iomem *base;
@@ -33,7 +33,7 @@ static int __init efm32gg_cmu_init(struct device_node *np)
 	base = of_iomap(np, 0);
 	if (!base) {
 		pr_warn("Failed to map address range for efm32gg,cmu node\n");
-		return -EADDRNOTAVAIL;
+		return;
 	}
 
 	clk[clk_HFXO] = clk_register_fixed_rate(NULL, "HFXO", NULL,
@@ -76,6 +76,6 @@ static int __init efm32gg_cmu_init(struct device_node *np)
 	clk[clk_HFPERCLKDAC0] = clk_register_gate(NULL, "HFPERCLK.DAC0",
 			"HFXO", 0, base + CMU_HFPERCLKEN0, 17, 0, NULL);
 
-	return of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 }
 CLK_OF_DECLARE(efm32ggcmu, "efm32gg,cmu", efm32gg_cmu_init);
