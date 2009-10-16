From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:24 -0700
Subject: [PATCH 20/46] davinci: Correct the GPIO number for LCD panel power
In-Reply-To: <1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-22-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

On the latest DA850/OMAP-L138 EVM (Beta) the GPIO pin
number of LCD panel power has changed. This patch takes
care of this change. Software will support only Beta
versions of DA850/OMAP-L138 EVM.

In the process, add the missing entry for data pin 0
and remove the GPIO specific pins from da850_lcdcntl_pins
structure. EVM specific muxing for LCD is being done in the
board file now.

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da850-evm.c  |   14 +++++++++++++-
 arch/arm/mach-davinci/da850.c            |   13 ++++++-------
 arch/arm/mach-davinci/include/mach/mux.h |    2 +-
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 47619a9..25ae007 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -32,12 +32,13 @@
 #include <mach/cp_intc.h>
 #include <mach/da8xx.h>
 #include <mach/nand.h>
+#include <mach/mux.h>
 
 #define DA850_EVM_PHY_MASK		0x1
 #define DA850_EVM_MDIO_FREQUENCY	2200000 /* PHY bus frequency */
 
+#define DA850_LCD_PWR_PIN		GPIO_TO_PIN(2, 8)
 #define DA850_LCD_BL_PIN		GPIO_TO_PIN(2, 15)
-#define DA850_LCD_PWR_PIN		GPIO_TO_PIN(8, 10)
 
 #define DA850_MMCSD_CD_PIN		GPIO_TO_PIN(4, 0)
 #define DA850_MMCSD_WP_PIN		GPIO_TO_PIN(4, 1)
@@ -264,6 +265,11 @@ static void __init da850_evm_init_nor(void)
 #define HAS_MMC 0
 #endif
 
+static const short da850_evm_lcdc_pins[] = {
+	DA850_GPIO2_8, DA850_GPIO2_15,
+	-1
+};
+
 static __init void da850_evm_init(void)
 {
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
@@ -372,6 +378,12 @@ static __init void da850_evm_init(void)
 		pr_warning("da850_evm_init: lcdcntl mux setup failed: %d\n",
 				ret);
 
+	/* Handle board specific muxing for LCD here */
+	ret = da8xx_pinmux_setup(da850_evm_lcdc_pins);
+	if (ret)
+		pr_warning("da850_evm_init: evm specific lcd mux setup "
+				"failed: %d\n",	ret);
+
 	ret = da850_lcd_hw_init();
 	if (ret)
 		pr_warning("da850_evm_init: lcd initialization failed: %d\n",
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 575e9cc..a62863c 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -513,8 +513,8 @@ static const struct mux_config da850_pins[] = {
 	MUX_CFG(DA850, EMA_WAIT_1,	6,	24,	15,	1,	false)
 	MUX_CFG(DA850, NEMA_CS_2,	7,	0,	15,	1,	false)
 	/* GPIO function */
+	MUX_CFG(DA850, GPIO2_8,		5,	28,	15,	8,	false)
 	MUX_CFG(DA850, GPIO2_15,	5,	0,	15,	8,	false)
-	MUX_CFG(DA850, GPIO8_10,	18,	28,	15,	8,	false)
 	MUX_CFG(DA850, GPIO4_0,		10,	28,	15,	8,	false)
 	MUX_CFG(DA850, GPIO4_1,		10,	24,	15,	8,	false)
 #endif
@@ -562,12 +562,11 @@ const short da850_mcasp_pins[] __initdata = {
 };
 
 const short da850_lcdcntl_pins[] __initdata = {
-	DA850_LCD_D_1, DA850_LCD_D_2, DA850_LCD_D_3, DA850_LCD_D_4,
-	DA850_LCD_D_5, DA850_LCD_D_6, DA850_LCD_D_7, DA850_LCD_D_8,
-	DA850_LCD_D_9, DA850_LCD_D_10, DA850_LCD_D_11, DA850_LCD_D_12,
-	DA850_LCD_D_13, DA850_LCD_D_14, DA850_LCD_D_15, DA850_LCD_PCLK,
-	DA850_LCD_HSYNC, DA850_LCD_VSYNC, DA850_NLCD_AC_ENB_CS, DA850_GPIO2_15,
-	DA850_GPIO8_10,
+	DA850_LCD_D_0, DA850_LCD_D_1, DA850_LCD_D_2, DA850_LCD_D_3,
+	DA850_LCD_D_4, DA850_LCD_D_5, DA850_LCD_D_6, DA850_LCD_D_7,
+	DA850_LCD_D_8, DA850_LCD_D_9, DA850_LCD_D_10, DA850_LCD_D_11,
+	DA850_LCD_D_12, DA850_LCD_D_13, DA850_LCD_D_14, DA850_LCD_D_15,
+	DA850_LCD_PCLK, DA850_LCD_HSYNC, DA850_LCD_VSYNC, DA850_NLCD_AC_ENB_CS,
 	-1
 };
 
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index bb84893..b2c1ad0 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -881,8 +881,8 @@ enum davinci_da850_index {
 	DA850_NEMA_CS_2,
 
 	/* GPIO function */
+	DA850_GPIO2_8,
 	DA850_GPIO2_15,
-	DA850_GPIO8_10,
 	DA850_GPIO4_0,
 	DA850_GPIO4_1,
 };
-- 
1.6.4.3
