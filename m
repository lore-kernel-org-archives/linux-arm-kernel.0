From: avictor.za@gmail.com (Andrew Victor)
Date: Mon, 02 May 2011 18:43:11 +0200
Subject: AT91: Not all processors have 4 programmable clocks
Message-ID: <1304354591.17141.16.camel@redbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In clocks.c at91_clocks_valid_for_suspend() [originally from pm.c
at91_pm_verify_clocks()], the code assumes there are always 4
programmable clocks.  That's not always the case.
Modify the code to rather loop through the number of registered
programmable clocks.

Signed-off-by: Andrew Victor <linux@maxim.org.za>


diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index a624a23..f046f54 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -511,7 +511,7 @@ postcore_initcall(at91_clk_debugfs_init);
 int at91_clocks_valid_for_suspend(void)
 {
 	unsigned long scsr;
-	int i;
+	struct clk *clk;
 
 	scsr = pmc_readl(AT91_PMC_SCSR);
 
@@ -535,16 +535,18 @@ int at91_clocks_valid_for_suspend(void)
 	}
 
 #ifdef CONFIG_AT91_PROGRAMMABLE_CLOCKS
-	/* PCK0..PCK3 must be disabled, or configured to use clk32k */
-	for (i = 0; i < 4; i++) {
+	/* PCK0..PCKn must be disabled, or configured to use clk32k */
+	list_for_each_entry(clk, &clocks, node) {
 		u32 css;
 
-		if ((scsr & (AT91_PMC_PCK0 << i)) == 0)
+		if (!clk_is_programmable(clk))
+			continue;
+		if ((scsr & clk->pmc_mask) == 0)	/* not enabled */
 			continue;
 
-		css = pmc_readl(AT91_PMC_PCKR(i)) & AT91_PMC_CSS;
+		css = pmc_readl(AT91_PMC_PCKR(clk->id)) & AT91_PMC_CSS;
 		if (css != AT91_PMC_CSS_SLOW) {
-			pr_err("AT91: PM - Suspend-to-RAM with PCK%d src %d\n", i, css);
+			pr_err("AT91: PM - Suspend-to-RAM with PCK%d src %d\n", clk->id, css);
 			return 0;
 		}
 	}
