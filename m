From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 20 Jan 2011 12:56:28 +0530
Subject: [PATCH V5 50/63] ST SPEAr Clock Framework: Updating for single image
	solution
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <481eaeebe09c7cdf047b1df9c0bc249d15cfd43e.1295499395.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch creates different clk_lookup arrays for individual machines.
These lookup arrays will be registered only if that specific machine is
current machine.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/clock.c          |   29 ++++++++++--
 arch/arm/mach-spear3xx/clock.c           |   75 +++++++++++++++++++-----------
 arch/arm/mach-spear6xx/clock.c           |    8 +++-
 arch/arm/plat-spear/clock.c              |    8 +---
 arch/arm/plat-spear/include/plat/clock.h |    2 +-
 5 files changed, 82 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index 8105491..766e766 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -1117,13 +1117,17 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{.dev_id = "gpio1",		.clk = &gpio1_clk},
 	{.dev_id = "keyboard",		.clk = &kbd_clk},
 	{.dev_id = "wdt",		.clk = &wdt_clk},
+};
 
-	/* spear1300 machine specific clock structures */
+/* array of all spear 1300 clock lookups */
 #ifdef CONFIG_MACH_SPEAR1300
+static struct clk_lookup spear1300_clk_lookups[] = {
+};
 #endif
 
-	/* spear1310 machine specific clock structures */
+/* array of all spear 1310 clock lookups */
 #ifdef CONFIG_MACH_SPEAR1310
+static struct clk_lookup spear1310_clk_lookups[] = {
 	{.dev_id = "c_can_platform.0",	.clk = &can0_clk},
 	{.dev_id = "c_can_platform.1",	.clk = &can1_clk},
 	{.dev_id = "stmmaceth.1",	.clk = &gmac_ras1_clk},
@@ -1134,11 +1138,28 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{.dev_id = "stmmacphy.2",	.clk = &gmac_phy2_clk},
 	{.dev_id = "stmmacphy.3",	.clk = &gmac_phy3_clk},
 	{.dev_id = "stmmacphy.4",	.clk = &gmac_phy4_clk},
-#endif
 };
+#endif
 
 /* machine clk init */
 void __init spear13xx_clk_init(void)
 {
-	clk_init(spear_clk_lookups, ARRAY_SIZE(spear_clk_lookups), &ddr_clk);
+	int i, cnt;
+	struct clk_lookup *lookups;
+
+	if (machine_is_spear1300()) {
+		cnt = ARRAY_SIZE(spear1300_clk_lookups);
+		lookups = spear1300_clk_lookups;
+	} else {
+		cnt = ARRAY_SIZE(spear1310_clk_lookups);
+		lookups = spear1310_clk_lookups;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(spear_clk_lookups); i++)
+		clk_register(&spear_clk_lookups[i]);
+
+	for (i = 0; i < cnt; i++)
+		clk_register(&lookups[i]);
+
+	clk_init(&ddr_clk);
 }
diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 12d8c46..19603f6 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -13,6 +13,7 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <asm/mach-types.h>
 #include <mach/misc_regs.h>
 #include <plat/clock.h>
 
@@ -754,52 +755,72 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "adc",		.clk = &adc_clk},
 	{ .dev_id = "ssp-pl022.0",	.clk = &ssp0_clk},
 	{ .dev_id = "gpio",		.clk = &gpio_clk},
-#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
-	{ .con_id = "emi",		.clk = &emi_clk},
-#endif
-#if defined(CONFIG_MACH_SPEAR300) || defined(CONFIG_MACH_SPEAR310) || \
-	defined(CONFIG_MACH_SPEAR320)
-	{ .con_id = "fsmc",		.clk = &fsmc_clk},
-#endif
-
-/* common clocks to spear310 and spear320 */
-#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
-	{ .dev_id = "uart1",		.clk = &uart1_clk},
-	{ .dev_id = "uart2",		.clk = &uart2_clk},
-#endif
-
-	/* common clock to spear300 and spear320 */
-#if defined(CONFIG_MACH_SPEAR300) || defined(CONFIG_MACH_SPEAR320)
-	{ .dev_id = "clcd",		.clk = &clcd_clk},
-	{ .dev_id = "sdhci",		.clk = &sdhci_clk},
-#endif /* CONFIG_MACH_SPEAR300 || CONFIG_MACH_SPEAR320 */
+};
 
-	/* spear300 machine specific clock structures */
+/* array of all spear 300 clock lookups */
 #ifdef CONFIG_MACH_SPEAR300
+static struct clk_lookup spear300_clk_lookups[] = {
+	{ .dev_id = "clcd",		.clk = &clcd_clk},
+	{ .con_id = "fsmc",		.clk = &fsmc_clk},
 	{ .dev_id = "gpio1",		.clk = &gpio1_clk},
 	{ .dev_id = "keyboard",		.clk = &kbd_clk},
+	{ .dev_id = "sdhci",		.clk = &sdhci_clk},
+};
 #endif
 
-	/* spear310 machine specific clock structures */
+/* array of all spear 310 clock lookups */
 #ifdef CONFIG_MACH_SPEAR310
+static struct clk_lookup spear310_clk_lookups[] = {
+	{ .con_id = "fsmc",		.clk = &fsmc_clk},
+	{ .con_id = "emi",		.clk = &emi_clk},
+	{ .dev_id = "uart1",		.clk = &uart1_clk},
+	{ .dev_id = "uart2",		.clk = &uart2_clk},
 	{ .dev_id = "uart3",		.clk = &uart3_clk},
 	{ .dev_id = "uart4",		.clk = &uart4_clk},
 	{ .dev_id = "uart5",		.clk = &uart5_clk},
-
+};
 #endif
-	/* spear320 machine specific clock structures */
+
+/* array of all spear 320 clock lookups */
 #ifdef CONFIG_MACH_SPEAR320
+static struct clk_lookup spear320_clk_lookups[] = {
+	{ .dev_id = "clcd",		.clk = &clcd_clk},
+	{ .con_id = "fsmc",		.clk = &fsmc_clk},
+	{ .dev_id = "i2c_designware.1",	.clk = &i2c1_clk},
+	{ .con_id = "emi",		.clk = &emi_clk},
+	{ .dev_id = "pwm",		.clk = &pwm_clk},
+	{ .dev_id = "sdhci",		.clk = &sdhci_clk},
 	{ .dev_id = "c_can_platform.0",	.clk = &can0_clk},
 	{ .dev_id = "c_can_platform.1",	.clk = &can1_clk},
-	{ .dev_id = "i2c_designware.1",	.clk = &i2c1_clk},
 	{ .dev_id = "ssp-pl022.1",	.clk = &ssp1_clk},
 	{ .dev_id = "ssp-pl022.2",	.clk = &ssp2_clk},
-	{ .dev_id = "pwm",		.clk = &pwm_clk},
-#endif
+	{ .dev_id = "uart1",		.clk = &uart1_clk},
+	{ .dev_id = "uart2",		.clk = &uart2_clk},
 };
+#endif
 
 /* machine clk init */
 void __init spear3xx_clk_init(void)
 {
-	clk_init(spear_clk_lookups, ARRAY_SIZE(spear_clk_lookups), &ddr_clk);
+	int i, cnt;
+	struct clk_lookup *lookups;
+
+	if (machine_is_spear300()) {
+		cnt = ARRAY_SIZE(spear300_clk_lookups);
+		lookups = spear300_clk_lookups;
+	} else if (machine_is_spear310()) {
+		cnt = ARRAY_SIZE(spear310_clk_lookups);
+		lookups = spear310_clk_lookups;
+	} else {
+		cnt = ARRAY_SIZE(spear320_clk_lookups);
+		lookups = spear320_clk_lookups;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(spear_clk_lookups); i++)
+		clk_register(&spear_clk_lookups[i]);
+
+	for (i = 0; i < cnt; i++)
+		clk_register(&lookups[i]);
+
+	clk_init(&ddr_clk);
 }
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index f304102..4579e4a 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <mach/misc_regs.h>
+#include <asm/mach-types.h>
 #include <plat/clock.h>
 
 /* root clks */
@@ -740,5 +741,10 @@ static struct clk_lookup spear_clk_lookups[] = {
 /* machine clk init */
 void __init spear6xx_clk_init(void)
 {
-	clk_init(spear_clk_lookups, ARRAY_SIZE(spear_clk_lookups), &ddr_clk);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(spear_clk_lookups); i++)
+		clk_register(&spear_clk_lookups[i]);
+
+	clk_init(&ddr_clk);
 }
diff --git a/arch/arm/plat-spear/clock.c b/arch/arm/plat-spear/clock.c
index e911218..cbee914 100644
--- a/arch/arm/plat-spear/clock.c
+++ b/arch/arm/plat-spear/clock.c
@@ -966,14 +966,8 @@ void recalc_root_clocks(void)
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 
-void __init
-clk_init(struct clk_lookup *clk_lookups, u32 count, struct clk *dclk)
+void __init clk_init(struct clk *dclk)
 {
-	int i;
-
-	for (i = 0; i < count; i++)
-		clk_register(&clk_lookups[i]);
-
 	recalc_root_clocks();
 
 	/* Mark all ancestors of DDR with special flag */
diff --git a/arch/arm/plat-spear/include/plat/clock.h b/arch/arm/plat-spear/include/plat/clock.h
index 53162a9..8ba9cd2 100644
--- a/arch/arm/plat-spear/include/plat/clock.h
+++ b/arch/arm/plat-spear/include/plat/clock.h
@@ -241,7 +241,7 @@ struct ddr_rate_tbl {
  * Actually before changing rate of DDRs ancestor, we must put ddr in refresh
  * state and then change parent.
  */
-void clk_init(struct clk_lookup *clk_lookups, u32 count, struct clk *dclk);
+void clk_init(struct clk *dclk);
 void clk_register(struct clk_lookup *cl);
 void recalc_root_clocks(void);
 
-- 
1.7.3.4
