From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Apr 2013 16:22:44 +0200
Subject: [PATCH 02/14] clk: ux500: pass clock base adresses in init call
In-Reply-To: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
References: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1365171776-8463-3-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The ux500 clock driver was including <mach/db8500-regs.h>
which will not work when building for multiplatform support
since <mach/*> is going away.

Pass the base adresses in the init call instead.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu.c               |   4 +-
 drivers/clk/ux500/u8500_clk.c           | 142 ++++++++++++++++----------------
 include/linux/platform_data/clk-ux500.h |   3 +-
 3 files changed, 76 insertions(+), 73 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 537870d..741d06a 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -72,7 +72,9 @@ void __init ux500_init_irq(void)
 		db8500_prcmu_early_init();
 
 	if (cpu_is_u8500_family() || cpu_is_u9540())
-		u8500_clk_init();
+		u8500_clk_init(U8500_CLKRST1_BASE, U8500_CLKRST2_BASE,
+			       U8500_CLKRST3_BASE, U8500_CLKRST5_BASE,
+			       U8500_CLKRST6_BASE);
 	else if (cpu_is_u8540())
 		u8540_clk_init();
 }
diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index 6b889a0..0c9b83d 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -12,10 +12,10 @@
 #include <linux/clk-provider.h>
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/platform_data/clk-ux500.h>
-#include <mach/db8500-regs.h>
 #include "clk.h"
 
-void u8500_clk_init(void)
+void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
+		    u32 clkrst5_base, u32 clkrst6_base)
 {
 	struct prcmu_fw_version *fw_version;
 	const char *sgaclk_parent = NULL;
@@ -215,147 +215,147 @@ void u8500_clk_init(void)
 	 */
 
 	/* PRCC P-clocks */
-	clk = clk_reg_prcc_pclk("p1_pclk0", "per1clk", U8500_CLKRST1_BASE,
+	clk = clk_reg_prcc_pclk("p1_pclk0", "per1clk", clkrst1_base,
 				BIT(0), 0);
 	clk_register_clkdev(clk, "apb_pclk", "uart0");
 
-	clk = clk_reg_prcc_pclk("p1_pclk1", "per1clk", U8500_CLKRST1_BASE,
+	clk = clk_reg_prcc_pclk("p1_pclk1", "per1clk", clkrst1_base,
 				BIT(1), 0);
 	clk_register_clkdev(clk, "apb_pclk", "uart1");
 
-	clk = clk_reg_prcc_pclk("p1_pclk2", "per1clk", U8500_CLKRST1_BASE,
+	clk = clk_reg_prcc_pclk("p1_pclk2", "per1clk", clkrst1_base,
 				BIT(2), 0);
 	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.1");
 
-	clk = clk_reg_prcc_pclk("p1_pclk3", "per1clk", U8500_CLKRST1_BASE,
+	clk = clk_reg_prcc_pclk("p1_pclk3", "per1clk", clkrst1_base,
 				BIT(3), 0);
 	clk_register_clkdev(clk, "apb_pclk", "msp0");
 	clk_register_clkdev(clk, "apb_pclk", "ux500-msp-i2s.0");
 
-	clk = clk_reg_prcc_pclk("p1_pclk4", "per1clk", U8500_CLKRST1_BASE,
+	clk = clk_reg_prcc_pclk("p1_pclk4", "per1clk", clkrst1_base,
 				BIT(4), 0);
 	clk_register_clkdev(clk, "apb_pclk", "msp1");
 	clk_register_clkdev(clk, "apb_pclk", "ux500-msp-i2s.1");
 
-	clk = clk_reg_prcc_pclk("p1_pclk5", "per1clk", U8500_CLKRST1_BASE,
+	clk = clk_reg_prcc_pclk("p1_pclk5", "per1clk", clkrst1_base,
 				BIT(5), 0);
 	clk_register_clkdev(clk, "apb_pclk", "sdi0");
 
-	clk = clk_reg_prcc_pclk("p1_pclk6", "per1clk", U8500_CLKRST1_BASE,
+	clk = clk_reg_prcc_pclk("p1_pclk6", "per1clk", clkrst1_base,
 				BIT(6), 0);
 	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.2");
 
-	clk = clk_reg_prcc_pclk("p1_pclk7", "per1clk", U8500_CLKRST1_BASE,
+	clk = clk_reg_prcc_pclk("p1_pclk7", "per1clk", clkrst1_base,
 				BIT(7), 0);
 	clk_register_clkdev(clk, NULL, "spi3");
 
-	clk = clk_reg_prcc_pclk("p1_pclk8", "per1clk", U8500_CLKRST1_BASE,
+	clk = clk_reg_prcc_pclk("p1_pclk8", "per1clk", clkrst1_base,
 				BIT(8), 0);
 	clk_register_clkdev(clk, "apb_pclk", "slimbus0");
 
-	clk = clk_reg_prcc_pclk("p1_pclk9", "per1clk", U8500_CLKRST1_BASE,
+	clk = clk_reg_prcc_pclk("p1_pclk9", "per1clk", clkrst1_base,
 				BIT(9), 0);
 	clk_register_clkdev(clk, NULL, "gpio.0");
 	clk_register_clkdev(clk, NULL, "gpio.1");
 	clk_register_clkdev(clk, NULL, "gpioblock0");
 
-	clk = clk_reg_prcc_pclk("p1_pclk10", "per1clk", U8500_CLKRST1_BASE,
+	clk = clk_reg_prcc_pclk("p1_pclk10", "per1clk", clkrst1_base,
 				BIT(10), 0);
 	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.4");
 
-	clk = clk_reg_prcc_pclk("p1_pclk11", "per1clk", U8500_CLKRST1_BASE,
+	clk = clk_reg_prcc_pclk("p1_pclk11", "per1clk", clkrst1_base,
 				BIT(11), 0);
 	clk_register_clkdev(clk, "apb_pclk", "msp3");
 	clk_register_clkdev(clk, "apb_pclk", "ux500-msp-i2s.3");
 
-	clk = clk_reg_prcc_pclk("p2_pclk0", "per2clk", U8500_CLKRST2_BASE,
+	clk = clk_reg_prcc_pclk("p2_pclk0", "per2clk", clkrst2_base,
 				BIT(0), 0);
 	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.3");
 
-	clk = clk_reg_prcc_pclk("p2_pclk1", "per2clk", U8500_CLKRST2_BASE,
+	clk = clk_reg_prcc_pclk("p2_pclk1", "per2clk", clkrst2_base,
 				BIT(1), 0);
 	clk_register_clkdev(clk, NULL, "spi2");
 
-	clk = clk_reg_prcc_pclk("p2_pclk2", "per2clk", U8500_CLKRST2_BASE,
+	clk = clk_reg_prcc_pclk("p2_pclk2", "per2clk", clkrst2_base,
 				BIT(2), 0);
 	clk_register_clkdev(clk, NULL, "spi1");
 
-	clk = clk_reg_prcc_pclk("p2_pclk3", "per2clk", U8500_CLKRST2_BASE,
+	clk = clk_reg_prcc_pclk("p2_pclk3", "per2clk", clkrst2_base,
 				BIT(3), 0);
 	clk_register_clkdev(clk, NULL, "pwl");
 
-	clk = clk_reg_prcc_pclk("p2_pclk4", "per2clk", U8500_CLKRST2_BASE,
+	clk = clk_reg_prcc_pclk("p2_pclk4", "per2clk", clkrst2_base,
 				BIT(4), 0);
 	clk_register_clkdev(clk, "apb_pclk", "sdi4");
 
-	clk = clk_reg_prcc_pclk("p2_pclk5", "per2clk", U8500_CLKRST2_BASE,
+	clk = clk_reg_prcc_pclk("p2_pclk5", "per2clk", clkrst2_base,
 				BIT(5), 0);
 	clk_register_clkdev(clk, "apb_pclk", "msp2");
 	clk_register_clkdev(clk, "apb_pclk", "ux500-msp-i2s.2");
 
-	clk = clk_reg_prcc_pclk("p2_pclk6", "per2clk", U8500_CLKRST2_BASE,
+	clk = clk_reg_prcc_pclk("p2_pclk6", "per2clk", clkrst2_base,
 				BIT(6), 0);
 	clk_register_clkdev(clk, "apb_pclk", "sdi1");
 
-	clk = clk_reg_prcc_pclk("p2_pclk7", "per2clk", U8500_CLKRST2_BASE,
+	clk = clk_reg_prcc_pclk("p2_pclk7", "per2clk", clkrst2_base,
 				BIT(7), 0);
 	clk_register_clkdev(clk, "apb_pclk", "sdi3");
 
-	clk = clk_reg_prcc_pclk("p2_pclk8", "per2clk", U8500_CLKRST2_BASE,
+	clk = clk_reg_prcc_pclk("p2_pclk8", "per2clk", clkrst2_base,
 				BIT(8), 0);
 	clk_register_clkdev(clk, NULL, "spi0");
 
-	clk = clk_reg_prcc_pclk("p2_pclk9", "per2clk", U8500_CLKRST2_BASE,
+	clk = clk_reg_prcc_pclk("p2_pclk9", "per2clk", clkrst2_base,
 				BIT(9), 0);
 	clk_register_clkdev(clk, "hsir_hclk", "ste_hsi.0");
 
-	clk = clk_reg_prcc_pclk("p2_pclk10", "per2clk", U8500_CLKRST2_BASE,
+	clk = clk_reg_prcc_pclk("p2_pclk10", "per2clk", clkrst2_base,
 				BIT(10), 0);
 	clk_register_clkdev(clk, "hsit_hclk", "ste_hsi.0");
 
-	clk = clk_reg_prcc_pclk("p2_pclk11", "per2clk", U8500_CLKRST2_BASE,
+	clk = clk_reg_prcc_pclk("p2_pclk11", "per2clk", clkrst2_base,
 				BIT(11), 0);
 	clk_register_clkdev(clk, NULL, "gpio.6");
 	clk_register_clkdev(clk, NULL, "gpio.7");
 	clk_register_clkdev(clk, NULL, "gpioblock1");
 
-	clk = clk_reg_prcc_pclk("p2_pclk12", "per2clk", U8500_CLKRST2_BASE,
+	clk = clk_reg_prcc_pclk("p2_pclk12", "per2clk", clkrst2_base,
 				BIT(12), 0);
 
-	clk = clk_reg_prcc_pclk("p3_pclk0", "per3clk", U8500_CLKRST3_BASE,
+	clk = clk_reg_prcc_pclk("p3_pclk0", "per3clk", clkrst3_base,
 				BIT(0), 0);
 	clk_register_clkdev(clk, NULL, "fsmc");
 
-	clk = clk_reg_prcc_pclk("p3_pclk1", "per3clk", U8500_CLKRST3_BASE,
+	clk = clk_reg_prcc_pclk("p3_pclk1", "per3clk", clkrst3_base,
 				BIT(1), 0);
 	clk_register_clkdev(clk, "apb_pclk", "ssp0");
 
-	clk = clk_reg_prcc_pclk("p3_pclk2", "per3clk", U8500_CLKRST3_BASE,
+	clk = clk_reg_prcc_pclk("p3_pclk2", "per3clk", clkrst3_base,
 				BIT(2), 0);
 	clk_register_clkdev(clk, "apb_pclk", "ssp1");
 
-	clk = clk_reg_prcc_pclk("p3_pclk3", "per3clk", U8500_CLKRST3_BASE,
+	clk = clk_reg_prcc_pclk("p3_pclk3", "per3clk", clkrst3_base,
 				BIT(3), 0);
 	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.0");
 
-	clk = clk_reg_prcc_pclk("p3_pclk4", "per3clk", U8500_CLKRST3_BASE,
+	clk = clk_reg_prcc_pclk("p3_pclk4", "per3clk", clkrst3_base,
 				BIT(4), 0);
 	clk_register_clkdev(clk, "apb_pclk", "sdi2");
 
-	clk = clk_reg_prcc_pclk("p3_pclk5", "per3clk", U8500_CLKRST3_BASE,
+	clk = clk_reg_prcc_pclk("p3_pclk5", "per3clk", clkrst3_base,
 				BIT(5), 0);
 	clk_register_clkdev(clk, "apb_pclk", "ske");
 	clk_register_clkdev(clk, "apb_pclk", "nmk-ske-keypad");
 
-	clk = clk_reg_prcc_pclk("p3_pclk6", "per3clk", U8500_CLKRST3_BASE,
+	clk = clk_reg_prcc_pclk("p3_pclk6", "per3clk", clkrst3_base,
 				BIT(6), 0);
 	clk_register_clkdev(clk, "apb_pclk", "uart2");
 
-	clk = clk_reg_prcc_pclk("p3_pclk7", "per3clk", U8500_CLKRST3_BASE,
+	clk = clk_reg_prcc_pclk("p3_pclk7", "per3clk", clkrst3_base,
 				BIT(7), 0);
 	clk_register_clkdev(clk, "apb_pclk", "sdi5");
 
-	clk = clk_reg_prcc_pclk("p3_pclk8", "per3clk", U8500_CLKRST3_BASE,
+	clk = clk_reg_prcc_pclk("p3_pclk8", "per3clk", clkrst3_base,
 				BIT(8), 0);
 	clk_register_clkdev(clk, NULL, "gpio.2");
 	clk_register_clkdev(clk, NULL, "gpio.3");
@@ -363,45 +363,45 @@ void u8500_clk_init(void)
 	clk_register_clkdev(clk, NULL, "gpio.5");
 	clk_register_clkdev(clk, NULL, "gpioblock2");
 
-	clk = clk_reg_prcc_pclk("p5_pclk0", "per5clk", U8500_CLKRST5_BASE,
+	clk = clk_reg_prcc_pclk("p5_pclk0", "per5clk", clkrst5_base,
 				BIT(0), 0);
 	clk_register_clkdev(clk, "usb", "musb-ux500.0");
 
-	clk = clk_reg_prcc_pclk("p5_pclk1", "per5clk", U8500_CLKRST5_BASE,
+	clk = clk_reg_prcc_pclk("p5_pclk1", "per5clk", clkrst5_base,
 				BIT(1), 0);
 	clk_register_clkdev(clk, NULL, "gpio.8");
 	clk_register_clkdev(clk, NULL, "gpioblock3");
 
-	clk = clk_reg_prcc_pclk("p6_pclk0", "per6clk", U8500_CLKRST6_BASE,
+	clk = clk_reg_prcc_pclk("p6_pclk0", "per6clk", clkrst6_base,
 				BIT(0), 0);
 	clk_register_clkdev(clk, "apb_pclk", "rng");
 
-	clk = clk_reg_prcc_pclk("p6_pclk1", "per6clk", U8500_CLKRST6_BASE,
+	clk = clk_reg_prcc_pclk("p6_pclk1", "per6clk", clkrst6_base,
 				BIT(1), 0);
 	clk_register_clkdev(clk, NULL, "cryp0");
 	clk_register_clkdev(clk, NULL, "cryp1");
 
-	clk = clk_reg_prcc_pclk("p6_pclk2", "per6clk", U8500_CLKRST6_BASE,
+	clk = clk_reg_prcc_pclk("p6_pclk2", "per6clk", clkrst6_base,
 				BIT(2), 0);
 	clk_register_clkdev(clk, NULL, "hash0");
 
-	clk = clk_reg_prcc_pclk("p6_pclk3", "per6clk", U8500_CLKRST6_BASE,
+	clk = clk_reg_prcc_pclk("p6_pclk3", "per6clk", clkrst6_base,
 				BIT(3), 0);
 	clk_register_clkdev(clk, NULL, "pka");
 
-	clk = clk_reg_prcc_pclk("p6_pclk4", "per6clk", U8500_CLKRST6_BASE,
+	clk = clk_reg_prcc_pclk("p6_pclk4", "per6clk", clkrst6_base,
 				BIT(4), 0);
 	clk_register_clkdev(clk, NULL, "hash1");
 
-	clk = clk_reg_prcc_pclk("p6_pclk5", "per6clk", U8500_CLKRST6_BASE,
+	clk = clk_reg_prcc_pclk("p6_pclk5", "per6clk", clkrst6_base,
 				BIT(5), 0);
 	clk_register_clkdev(clk, NULL, "cfgreg");
 
-	clk = clk_reg_prcc_pclk("p6_pclk6", "per6clk", U8500_CLKRST6_BASE,
+	clk = clk_reg_prcc_pclk("p6_pclk6", "per6clk", clkrst6_base,
 				BIT(6), 0);
 	clk_register_clkdev(clk, "apb_pclk", "mtu0");
 
-	clk = clk_reg_prcc_pclk("p6_pclk7", "per6clk", U8500_CLKRST6_BASE,
+	clk = clk_reg_prcc_pclk("p6_pclk7", "per6clk", clkrst6_base,
 				BIT(7), 0);
 	clk_register_clkdev(clk, "apb_pclk", "mtu1");
 
@@ -415,110 +415,110 @@ void u8500_clk_init(void)
 
 	/* Periph1 */
 	clk = clk_reg_prcc_kclk("p1_uart0_kclk", "uartclk",
-			U8500_CLKRST1_BASE, BIT(0), CLK_SET_RATE_GATE);
+			clkrst1_base, BIT(0), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "uart0");
 
 	clk = clk_reg_prcc_kclk("p1_uart1_kclk", "uartclk",
-			U8500_CLKRST1_BASE, BIT(1), CLK_SET_RATE_GATE);
+			clkrst1_base, BIT(1), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "uart1");
 
 	clk = clk_reg_prcc_kclk("p1_i2c1_kclk", "i2cclk",
-			U8500_CLKRST1_BASE, BIT(2), CLK_SET_RATE_GATE);
+			clkrst1_base, BIT(2), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "nmk-i2c.1");
 
 	clk = clk_reg_prcc_kclk("p1_msp0_kclk", "msp02clk",
-			U8500_CLKRST1_BASE, BIT(3), CLK_SET_RATE_GATE);
+			clkrst1_base, BIT(3), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "msp0");
 	clk_register_clkdev(clk, NULL, "ux500-msp-i2s.0");
 
 	clk = clk_reg_prcc_kclk("p1_msp1_kclk", "msp1clk",
-			U8500_CLKRST1_BASE, BIT(4), CLK_SET_RATE_GATE);
+			clkrst1_base, BIT(4), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "msp1");
 	clk_register_clkdev(clk, NULL, "ux500-msp-i2s.1");
 
 	clk = clk_reg_prcc_kclk("p1_sdi0_kclk", "sdmmcclk",
-			U8500_CLKRST1_BASE, BIT(5), CLK_SET_RATE_GATE);
+			clkrst1_base, BIT(5), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "sdi0");
 
 	clk = clk_reg_prcc_kclk("p1_i2c2_kclk", "i2cclk",
-			U8500_CLKRST1_BASE, BIT(6), CLK_SET_RATE_GATE);
+			clkrst1_base, BIT(6), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "nmk-i2c.2");
 
 	clk = clk_reg_prcc_kclk("p1_slimbus0_kclk", "slimclk",
-			U8500_CLKRST1_BASE, BIT(8), CLK_SET_RATE_GATE);
+			clkrst1_base, BIT(8), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "slimbus0");
 
 	clk = clk_reg_prcc_kclk("p1_i2c4_kclk", "i2cclk",
-			U8500_CLKRST1_BASE, BIT(9), CLK_SET_RATE_GATE);
+			clkrst1_base, BIT(9), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "nmk-i2c.4");
 
 	clk = clk_reg_prcc_kclk("p1_msp3_kclk", "msp1clk",
-			U8500_CLKRST1_BASE, BIT(10), CLK_SET_RATE_GATE);
+			clkrst1_base, BIT(10), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "msp3");
 	clk_register_clkdev(clk, NULL, "ux500-msp-i2s.3");
 
 	/* Periph2 */
 	clk = clk_reg_prcc_kclk("p2_i2c3_kclk", "i2cclk",
-			U8500_CLKRST2_BASE, BIT(0), CLK_SET_RATE_GATE);
+			clkrst2_base, BIT(0), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "nmk-i2c.3");
 
 	clk = clk_reg_prcc_kclk("p2_sdi4_kclk", "sdmmcclk",
-			U8500_CLKRST2_BASE, BIT(2), CLK_SET_RATE_GATE);
+			clkrst2_base, BIT(2), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "sdi4");
 
 	clk = clk_reg_prcc_kclk("p2_msp2_kclk", "msp02clk",
-			U8500_CLKRST2_BASE, BIT(3), CLK_SET_RATE_GATE);
+			clkrst2_base, BIT(3), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "msp2");
 	clk_register_clkdev(clk, NULL, "ux500-msp-i2s.2");
 
 	clk = clk_reg_prcc_kclk("p2_sdi1_kclk", "sdmmcclk",
-			U8500_CLKRST2_BASE, BIT(4), CLK_SET_RATE_GATE);
+			clkrst2_base, BIT(4), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "sdi1");
 
 	clk = clk_reg_prcc_kclk("p2_sdi3_kclk", "sdmmcclk",
-			U8500_CLKRST2_BASE, BIT(5), CLK_SET_RATE_GATE);
+			clkrst2_base, BIT(5), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "sdi3");
 
 	/* Note that rate is received from parent. */
 	clk = clk_reg_prcc_kclk("p2_ssirx_kclk", "hsirxclk",
-			U8500_CLKRST2_BASE, BIT(6),
+			clkrst2_base, BIT(6),
 			CLK_SET_RATE_GATE|CLK_SET_RATE_PARENT);
 	clk = clk_reg_prcc_kclk("p2_ssitx_kclk", "hsitxclk",
-			U8500_CLKRST2_BASE, BIT(7),
+			clkrst2_base, BIT(7),
 			CLK_SET_RATE_GATE|CLK_SET_RATE_PARENT);
 
 	/* Periph3 */
 	clk = clk_reg_prcc_kclk("p3_ssp0_kclk", "sspclk",
-			U8500_CLKRST3_BASE, BIT(1), CLK_SET_RATE_GATE);
+			clkrst3_base, BIT(1), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "ssp0");
 
 	clk = clk_reg_prcc_kclk("p3_ssp1_kclk", "sspclk",
-			U8500_CLKRST3_BASE, BIT(2), CLK_SET_RATE_GATE);
+			clkrst3_base, BIT(2), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "ssp1");
 
 	clk = clk_reg_prcc_kclk("p3_i2c0_kclk", "i2cclk",
-			U8500_CLKRST3_BASE, BIT(3), CLK_SET_RATE_GATE);
+			clkrst3_base, BIT(3), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "nmk-i2c.0");
 
 	clk = clk_reg_prcc_kclk("p3_sdi2_kclk", "sdmmcclk",
-			U8500_CLKRST3_BASE, BIT(4), CLK_SET_RATE_GATE);
+			clkrst3_base, BIT(4), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "sdi2");
 
 	clk = clk_reg_prcc_kclk("p3_ske_kclk", "rtc32k",
-			U8500_CLKRST3_BASE, BIT(5), CLK_SET_RATE_GATE);
+			clkrst3_base, BIT(5), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "ske");
 	clk_register_clkdev(clk, NULL, "nmk-ske-keypad");
 
 	clk = clk_reg_prcc_kclk("p3_uart2_kclk", "uartclk",
-			U8500_CLKRST3_BASE, BIT(6), CLK_SET_RATE_GATE);
+			clkrst3_base, BIT(6), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "uart2");
 
 	clk = clk_reg_prcc_kclk("p3_sdi5_kclk", "sdmmcclk",
-			U8500_CLKRST3_BASE, BIT(7), CLK_SET_RATE_GATE);
+			clkrst3_base, BIT(7), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "sdi5");
 
 	/* Periph6 */
 	clk = clk_reg_prcc_kclk("p3_rng_kclk", "rngclk",
-			U8500_CLKRST6_BASE, BIT(0), CLK_SET_RATE_GATE);
+			clkrst6_base, BIT(0), CLK_SET_RATE_GATE);
 	clk_register_clkdev(clk, NULL, "rng");
 }
diff --git a/include/linux/platform_data/clk-ux500.h b/include/linux/platform_data/clk-ux500.h
index 3af0da1..320d9c3 100644
--- a/include/linux/platform_data/clk-ux500.h
+++ b/include/linux/platform_data/clk-ux500.h
@@ -10,7 +10,8 @@
 #ifndef __CLK_UX500_H
 #define __CLK_UX500_H
 
-void u8500_clk_init(void);
+void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
+		    u32 clkrst5_base, u32 clkrst6_base);
 void u9540_clk_init(void);
 void u8540_clk_init(void);
 
-- 
1.7.11.3
