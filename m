From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:56:36 +0530
Subject: [PATCH V6 03/11] ST SPEAr Clock: Updating for single image solution
In-Reply-To: <cover.1298977709.git.viresh.kumar@st.com>
References: <cover.1298977709.git.viresh.kumar@st.com>
Message-ID: <5dbf6225c190e9b4bd2aadb98c1baf0d1f762b22.1298977709.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch creates different clk_lookup arrays for individual machines.
These lookup arrays will be registered only if that specific machine is
current machine.

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/clock.c |   70 ++++++++++++++++++++++++---------------
 1 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 5707772..f67860c 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -13,6 +13,7 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <asm/mach-types.h>
 #include <plat/clock.h>
 #include <mach/misc_regs.h>
 
@@ -688,56 +689,71 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "adc",		.clk = &adc_clk},
 	{ .dev_id = "ssp-pl022.0",	.clk = &ssp0_clk},
 	{ .dev_id = "gpio",		.clk = &gpio_clk},
-#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
-	{ .dev_id = "physmap-flash",	.clk = &emi_clk},
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
 
 void __init spear3xx_clk_init(void)
 {
-	int i;
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
 
 	for (i = 0; i < ARRAY_SIZE(spear_clk_lookups); i++)
 		clk_register(&spear_clk_lookups[i]);
 
+	for (i = 0; i < cnt; i++)
+		clk_register(&lookups[i]);
+
 	clk_init();
 }
-- 
1.7.2.2
