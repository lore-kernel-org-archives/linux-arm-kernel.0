From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 13 Aug 2012 13:57:40 +0200
Subject: [PATCH 1/7] ARM: u300: retire ancient platforms
Message-ID: <1344859061-29296-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This retires the B26/S26, B330/S330 and B365/S365 boards from
the U300 platform. The only board really used anywhere today
is the S335 so let's concentrate any efforts on that one board.
Also the board variants are selected at compile-time, which is
strictly a no-no these days, if multi-board support is to be
brought back it need to happen using run-time and device tree.

My work on ARM Linux started on the B26/S26 so it's a bit sad
to see it go, but there is a time to move on with all things
in life.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/Kconfig                     | 43 +---------------
 arch/arm/mach-u300/core.c                      | 70 +-------------------------
 arch/arm/mach-u300/i2c.c                       |  6 +--
 arch/arm/mach-u300/include/mach/dma_channels.h | 11 +---
 arch/arm/mach-u300/include/mach/irqs.h         | 34 +------------
 arch/arm/mach-u300/include/mach/syscon.h       | 32 ++----------
 arch/arm/mach-u300/include/mach/u300-regs.h    | 19 +------
 arch/arm/mach-u300/u300-gpio.h                 | 46 +----------------
 arch/arm/mach-u300/u300.c                      | 18 +------
 9 files changed, 14 insertions(+), 265 deletions(-)

diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index 54d8f34..f7e12ed 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -1,6 +1,6 @@
 if ARCH_U300
 
-menu "ST-Ericsson AB U300/U330/U335/U365 Platform"
+menu "ST-Ericsson AB U300/U335 Platform"
 
 comment "ST-Ericsson Mobile Platform Products"
 
@@ -10,46 +10,7 @@ config MACH_U300
 	select PINCTRL_U300
 	select PINCTRL_COH901
 
-comment "ST-Ericsson U300/U330/U335/U365 Feature Selections"
-
-choice
-	prompt "U300/U330/U335/U365 system type"
-	default MACH_U300_BS2X
-	---help---
-	You need to select the target system, i.e. the
-	U300/U330/U335/U365 board that you want to compile your kernel
-	for.
-
-config MACH_U300_BS2X
-	bool "S26/S26/B25/B26 Test Products"
-	depends on MACH_U300
-	help
-		Select this if you're developing on the
-		S26/S25 test products. (Also works on
-		B26/B25 big boards.)
-
-config MACH_U300_BS330
-	bool "S330/B330 Test Products"
-	depends on MACH_U300
-	help
-		Select this if you're developing on the
-		S330/B330 test products.
-
-config MACH_U300_BS335
-	bool "S335/B335 Test Products"
-	depends on MACH_U300
-	help
-		Select this if you're developing on the
-		S335/B335 test products.
-
-config MACH_U300_BS365
-	bool "S365/B365 Test Products"
-	depends on MACH_U300
-	help
-		Select this if you're developing on the
-		S365/B365 test products.
-
-endchoice
+comment "ST-Ericsson U300/U335 Feature Selections"
 
 config U300_DEBUG
 	bool "Debug support for U300"
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 03acf18..1794075 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -3,7 +3,7 @@
  * arch/arm/mach-u300/core.c
  *
  *
- * Copyright (C) 2007-2010 ST-Ericsson SA
+ * Copyright (C) 2007-2012 ST-Ericsson SA
  * License terms: GNU General Public License (GPL) version 2
  * Core platform support, IRQ handling and device definitions.
  * Author: Linus Walleij <linus.walleij@stericsson.com>
@@ -101,7 +101,6 @@ static AMBA_APB_DEVICE(uart0, "uart0", 0, U300_UART0_BASE,
 	{ IRQ_U300_UART0 }, &uart0_plat_data);
 
 /* The U335 have an additional UART1 on the APP CPU */
-#ifdef CONFIG_MACH_U300_BS335
 static struct amba_pl011_data uart1_plat_data = {
 #ifdef CONFIG_COH901318
 	.dma_filter = coh901318_filter_id,
@@ -113,7 +112,6 @@ static struct amba_pl011_data uart1_plat_data = {
 /* Fast device at 0x7000 offset */
 static AMBA_APB_DEVICE(uart1, "uart1", 0, U300_UART1_BASE,
 	{ IRQ_U300_UART1 }, &uart1_plat_data);
-#endif
 
 /* AHB device at 0x4000 offset */
 static AMBA_APB_DEVICE(pl172, "pl172", 0, U300_EMIF_CFG_BASE, { }, NULL);
@@ -152,9 +150,7 @@ static AMBA_APB_DEVICE(mmcsd, "mmci", 0, U300_MMCSD_BASE,
  */
 static struct amba_device *amba_devs[] __initdata = {
 	&uart0_device,
-#ifdef CONFIG_MACH_U300_BS335
 	&uart1_device,
-#endif
 	&pl022_device,
 	&pl172_device,
 	&mmcsd_device,
@@ -188,7 +184,6 @@ static struct resource gpio_resources[] = {
 		.end   = IRQ_U300_GPIO_PORT2,
 		.flags = IORESOURCE_IRQ,
 	},
-#if defined(CONFIG_MACH_U300_BS365) || defined(CONFIG_MACH_U300_BS335)
 	{
 		.name  = "gpio3",
 		.start = IRQ_U300_GPIO_PORT3,
@@ -201,8 +196,6 @@ static struct resource gpio_resources[] = {
 		.end   = IRQ_U300_GPIO_PORT4,
 		.flags = IORESOURCE_IRQ,
 	},
-#endif
-#ifdef CONFIG_MACH_U300_BS335
 	{
 		.name  = "gpio5",
 		.start = IRQ_U300_GPIO_PORT5,
@@ -215,7 +208,6 @@ static struct resource gpio_resources[] = {
 		.end   = IRQ_U300_GPIO_PORT6,
 		.flags = IORESOURCE_IRQ,
 	},
-#endif /* CONFIG_MACH_U300_BS335 */
 };
 
 static struct resource keypad_resources[] = {
@@ -323,7 +315,6 @@ static struct resource dma_resource[] = {
 	}
 };
 
-#ifdef CONFIG_MACH_U300_BS335
 /* points out all dma slave channels.
  * Syntax is [A1, B1, A2, B2, .... ,-1,-1]
  * Select all channels from A to B, end of list is marked with -1,-1
@@ -336,14 +327,6 @@ static int dma_slave_channels[] = {
 static int dma_memcpy_channels[] = {
 	U300_DMA_GENERAL_PURPOSE_0, U300_DMA_GENERAL_PURPOSE_8, -1, -1};
 
-#else /* CONFIG_MACH_U300_BS335 */
-
-static int dma_slave_channels[] = {U300_DMA_MSL_TX_0, U300_DMA_SPI_RX, -1, -1};
-static int dma_memcpy_channels[] = {
-	U300_DMA_GENERAL_PURPOSE_0, U300_DMA_GENERAL_PURPOSE_10, -1, -1};
-
-#endif
-
 /** register dma for memory access
  *
  * active  1 means dma intends to access memory
@@ -1395,7 +1378,6 @@ const struct coh_dma_channel chan_config[U300_DMA_CHANNELS] = {
 		.param.ctrl_lli = flags_memcpy_lli,
 		.param.ctrl_lli_last = flags_memcpy_lli_last,
 	},
-#ifdef CONFIG_MACH_U300_BS335
 	{
 		.number = U300_DMA_UART1_TX,
 		.name = "UART1 TX",
@@ -1406,28 +1388,6 @@ const struct coh_dma_channel chan_config[U300_DMA_CHANNELS] = {
 		.name = "UART1 RX",
 		.priority_high = 0,
 	}
-#else
-	{
-		.number = U300_DMA_GENERAL_PURPOSE_9,
-		.name = "GENERAL 09",
-		.priority_high = 0,
-
-		.param.config = flags_memcpy_config,
-		.param.ctrl_lli_chained = flags_memcpy_lli_chained,
-		.param.ctrl_lli = flags_memcpy_lli,
-		.param.ctrl_lli_last = flags_memcpy_lli_last,
-	},
-	{
-		.number = U300_DMA_GENERAL_PURPOSE_10,
-		.name = "GENERAL 10",
-		.priority_high = 0,
-
-		.param.config = flags_memcpy_config,
-		.param.ctrl_lli_chained = flags_memcpy_lli_chained,
-		.param.ctrl_lli = flags_memcpy_lli,
-		.param.ctrl_lli_last = flags_memcpy_lli_last,
-	}
-#endif
 };
 
 
@@ -1480,18 +1440,8 @@ static struct platform_device pinctrl_device = {
  * GPIO block, with different number of ports.
  */
 static struct u300_gpio_platform u300_gpio_plat = {
-#if defined(CONFIG_MACH_U300_BS2X) || defined(CONFIG_MACH_U300_BS330)
-	.variant = U300_GPIO_COH901335,
-	.ports = 3,
-#endif
-#ifdef CONFIG_MACH_U300_BS335
 	.variant = U300_GPIO_COH901571_3_BS335,
 	.ports = 7,
-#endif
-#ifdef CONFIG_MACH_U300_BS365
-	.variant = U300_GPIO_COH901571_3_BS365,
-	.ports = 5,
-#endif
 	.gpio_base = 0,
 	.gpio_irq_base = IRQ_U300_GPIO_BASE,
 	.pinctrl_device = &pinctrl_device,
@@ -1756,29 +1706,11 @@ static void __init u300_init_check_chip(void)
 	printk(KERN_INFO "Initializing U300 system on %s baseband chip " \
 	       "(chip ID 0x%04x)\n", chipname, val);
 
-#ifdef CONFIG_MACH_U300_BS330
-	if ((val & 0xFF00U) != 0xd800) {
-		printk(KERN_ERR "Platform configured for BS330 " \
-		       "with DB3200 but %s detected, expect problems!",
-		       chipname);
-	}
-#endif
-#ifdef CONFIG_MACH_U300_BS335
 	if ((val & 0xFF00U) != 0xf000 && (val & 0xFF00U) != 0xf100) {
 		printk(KERN_ERR "Platform configured for BS335 " \
 		       " with DB3350 but %s detected, expect problems!",
 		       chipname);
 	}
-#endif
-#ifdef CONFIG_MACH_U300_BS365
-	if ((val & 0xFF00U) != 0xe800) {
-		printk(KERN_ERR "Platform configured for BS365 " \
-		       "with DB3210 but %s detected, expect problems!",
-		       chipname);
-	}
-#endif
-
-
 }
 
 /*
diff --git a/arch/arm/mach-u300/i2c.c b/arch/arm/mach-u300/i2c.c
index cb04bd6..0d4620e 100644
--- a/arch/arm/mach-u300/i2c.c
+++ b/arch/arm/mach-u300/i2c.c
@@ -1,7 +1,7 @@
 /*
  * arch/arm/mach-u300/i2c.c
  *
- * Copyright (C) 2009 ST-Ericsson AB
+ * Copyright (C) 2009-2012 ST-Ericsson AB
  * License terms: GNU General Public License (GPL) version 2
  *
  * Register board i2c devices
@@ -261,7 +261,6 @@ static struct i2c_board_info __initdata bus0_i2c_board_info[] = {
 };
 
 static struct i2c_board_info __initdata bus1_i2c_board_info[] = {
-#ifdef CONFIG_MACH_U300_BS335
 	{
 		.type = "fwcam",
 		.addr = 0x10,
@@ -270,9 +269,6 @@ static struct i2c_board_info __initdata bus1_i2c_board_info[] = {
 		.type = "fwcam",
 		.addr = 0x5d,
 	},
-#else
-	{ },
-#endif
 };
 
 void __init u300_i2c_register_board_devices(void)
diff --git a/arch/arm/mach-u300/include/mach/dma_channels.h b/arch/arm/mach-u300/include/mach/dma_channels.h
index b239149..4e8a88f 100644
--- a/arch/arm/mach-u300/include/mach/dma_channels.h
+++ b/arch/arm/mach-u300/include/mach/dma_channels.h
@@ -3,7 +3,7 @@
  * arch/arm/mach-u300/include/mach/dma_channels.h
  *
  *
- * Copyright (C) 2007-2009 ST-Ericsson
+ * Copyright (C) 2007-2012 ST-Ericsson
  * License terms: GNU General Public License (GPL) version 2
  * Map file for the U300 dma driver.
  * Author: Per Friden <per.friden@stericsson.com>
@@ -50,19 +50,10 @@
 #define U300_DMA_GENERAL_PURPOSE_6    35
 #define U300_DMA_GENERAL_PURPOSE_7    36
 #define U300_DMA_GENERAL_PURPOSE_8    37
-#ifdef CONFIG_MACH_U300_BS335
 #define U300_DMA_UART1_TX             38
 #define U300_DMA_UART1_RX             39
-#else
-#define U300_DMA_GENERAL_PURPOSE_9    38
-#define U300_DMA_GENERAL_PURPOSE_10   39
-#endif
 
-#ifdef CONFIG_MACH_U300_BS335
 #define U300_DMA_DEVICE_CHANNELS      32
-#else
-#define U300_DMA_DEVICE_CHANNELS      30
-#endif
 #define U300_DMA_CHANNELS             40
 
 
diff --git a/arch/arm/mach-u300/include/mach/irqs.h b/arch/arm/mach-u300/include/mach/irqs.h
index ec09c1e..c09386b 100644
--- a/arch/arm/mach-u300/include/mach/irqs.h
+++ b/arch/arm/mach-u300/include/mach/irqs.h
@@ -3,7 +3,7 @@
  * arch/arm/mach-u300/include/mach/irqs.h
  *
  *
- * Copyright (C) 2006-2009 ST-Ericsson AB
+ * Copyright (C) 2006-2012 ST-Ericsson AB
  * License terms: GNU General Public License (GPL) version 2
  * IRQ channel definitions for the U300 platforms.
  * Author: Linus Walleij <linus.walleij@stericsson.com>
@@ -31,10 +31,6 @@
 #define IRQ_U300_XGAM_GAMCON		14
 #define IRQ_U300_XGAM_CDI		15
 #define IRQ_U300_XGAM_CDICON		16
-#if defined(CONFIG_MACH_U300_BS2X) || defined(CONFIG_MACH_U300_BS330)
-/* MMIACC not used on the DB3210 or DB3350 chips */
-#define IRQ_U300_XGAM_MMIACC		17
-#endif
 #define IRQ_U300_XGAM_PDI		18
 #define IRQ_U300_XGAM_PDICON		19
 #define IRQ_U300_XGAM_GAMEACC		20
@@ -55,8 +51,6 @@
 #define IRQ_U300_GPIO_PORT1		34
 #define IRQ_U300_GPIO_PORT2		35
 
-#if defined(CONFIG_MACH_U300_BS2X) || defined(CONFIG_MACH_U300_BS330) || \
-    defined(CONFIG_MACH_U300_BS335)
 /* These are for DB3150, DB3200 and DB3350 */
 #define IRQ_U300_WDOG			36
 #define IRQ_U300_EVHIST			37
@@ -68,15 +62,8 @@
 #define IRQ_U300_RTC			43
 #define IRQ_U300_NFIF			44
 #define IRQ_U300_NFIF2			45
-#endif
-
-/* DB3150 and DB3200 have only 45 IRQs */
-#if defined(CONFIG_MACH_U300_BS2X) || defined(CONFIG_MACH_U300_BS330)
-#define U300_VIC_IRQS_END		46
-#endif
 
 /* The DB3350-specific interrupt lines */
-#ifdef CONFIG_MACH_U300_BS335
 #define IRQ_U300_ISP_F0			46
 #define IRQ_U300_ISP_F1			47
 #define IRQ_U300_ISP_F2			48
@@ -89,25 +76,6 @@
 #define IRQ_U300_GPIO_PORT5		55
 #define IRQ_U300_GPIO_PORT6		56
 #define U300_VIC_IRQS_END		57
-#endif
-
-/* The DB3210-specific interrupt lines */
-#ifdef CONFIG_MACH_U300_BS365
-#define IRQ_U300_GPIO_PORT3		36
-#define IRQ_U300_GPIO_PORT4		37
-#define IRQ_U300_WDOG			38
-#define IRQ_U300_EVHIST			39
-#define IRQ_U300_MSPRO			40
-#define IRQ_U300_MMCSD_MCIINTR0		41
-#define IRQ_U300_MMCSD_MCIINTR1		42
-#define IRQ_U300_I2C0			43
-#define IRQ_U300_I2C1			44
-#define IRQ_U300_RTC			45
-#define IRQ_U300_NFIF			46
-#define IRQ_U300_NFIF2			47
-#define IRQ_U300_SYSCON_PLL_LOCK	48
-#define U300_VIC_IRQS_END		49
-#endif
 
 /* Maximum 8*7 GPIO lines */
 #ifdef CONFIG_PINCTRL_COH901
diff --git a/arch/arm/mach-u300/include/mach/syscon.h b/arch/arm/mach-u300/include/mach/syscon.h
index 6e84f07..10bdd0b 100644
--- a/arch/arm/mach-u300/include/mach/syscon.h
+++ b/arch/arm/mach-u300/include/mach/syscon.h
@@ -3,7 +3,7 @@
  * arch/arm/mach-u300/include/mach/syscon.h
  *
  *
- * Copyright (C) 2008 ST-Ericsson AB
+ * Copyright (C) 2008-2012 ST-Ericsson AB
  *
  * Author: Rickard Andersson <rickard.andersson@stericsson.com>
  */
@@ -36,9 +36,7 @@
 #define U300_SYSCON_CSR_PLL13_LOCK_IND				(0x0001)
 /* Reset lines for SLOW devices 16bit (R/W) */
 #define U300_SYSCON_RSR						(0x0014)
-#ifdef CONFIG_MACH_U300_BS335
 #define U300_SYSCON_RSR_PPM_RESET_EN				(0x0200)
-#endif
 #define U300_SYSCON_RSR_ACC_TMR_RESET_EN			(0x0100)
 #define U300_SYSCON_RSR_APP_TMR_RESET_EN			(0x0080)
 #define U300_SYSCON_RSR_RTC_RESET_EN				(0x0040)
@@ -50,9 +48,7 @@
 #define U300_SYSCON_RSR_SLOW_BRIDGE_RESET_EN			(0x0001)
 /* Reset lines for FAST devices 16bit (R/W) */
 #define U300_SYSCON_RFR						(0x0018)
-#ifdef CONFIG_MACH_U300_BS335
 #define U300_SYSCON_RFR_UART1_RESET_ENABLE			(0x0080)
-#endif
 #define U300_SYSCON_RFR_SPI_RESET_ENABLE			(0x0040)
 #define U300_SYSCON_RFR_MMC_RESET_ENABLE			(0x0020)
 #define U300_SYSCON_RFR_PCM_I2S1_RESET_ENABLE			(0x0010)
@@ -62,10 +58,8 @@
 #define U300_SYSCON_RFR_FAST_BRIDGE_RESET_ENABLE		(0x0001)
 /* Reset lines for the rest of the peripherals 16bit (R/W) */
 #define U300_SYSCON_RRR						(0x001c)
-#ifdef CONFIG_MACH_U300_BS335
 #define U300_SYSCON_RRR_CDS_RESET_EN				(0x4000)
 #define U300_SYSCON_RRR_ISP_RESET_EN				(0x2000)
-#endif
 #define U300_SYSCON_RRR_INTCON_RESET_EN				(0x1000)
 #define U300_SYSCON_RRR_MSPRO_RESET_EN				(0x0800)
 #define U300_SYSCON_RRR_XGAM_RESET_EN				(0x0100)
@@ -79,9 +73,7 @@
 #define U300_SYSCON_RRR_AAIF_RESET_EN				(0x0001)
 /* Clock enable for SLOW peripherals 16bit (R/W) */
 #define U300_SYSCON_CESR					(0x0020)
-#ifdef CONFIG_MACH_U300_BS335
 #define U300_SYSCON_CESR_PPM_CLK_EN				(0x0200)
-#endif
 #define U300_SYSCON_CESR_ACC_TMR_CLK_EN				(0x0100)
 #define U300_SYSCON_CESR_APP_TMR_CLK_EN				(0x0080)
 #define U300_SYSCON_CESR_KEYPAD_CLK_EN				(0x0040)
@@ -92,24 +84,20 @@
 #define U300_SYSCON_CESR_SLOW_BRIDGE_CLK_EN			(0x0001)
 /* Clock enable for FAST peripherals 16bit (R/W) */
 #define U300_SYSCON_CEFR					(0x0024)
-#ifdef CONFIG_MACH_U300_BS335
 #define U300_SYSCON_CEFR_UART1_CLK_EN				(0x0200)
-#endif
 #define U300_SYSCON_CEFR_I2S1_CORE_CLK_EN			(0x0100)
 #define U300_SYSCON_CEFR_I2S0_CORE_CLK_EN			(0x0080)
 #define U300_SYSCON_CEFR_SPI_CLK_EN				(0x0040)
 #define U300_SYSCON_CEFR_MMC_CLK_EN				(0x0020)
-#define U300_SYSCON_CEFR_I2S1_CLK_EN    			(0x0010)
-#define U300_SYSCON_CEFR_I2S0_CLK_EN     			(0x0008)
-#define U300_SYSCON_CEFR_I2C1_CLK_EN     			(0x0004)
-#define U300_SYSCON_CEFR_I2C0_CLK_EN     			(0x0002)
+#define U300_SYSCON_CEFR_I2S1_CLK_EN				(0x0010)
+#define U300_SYSCON_CEFR_I2S0_CLK_EN				(0x0008)
+#define U300_SYSCON_CEFR_I2C1_CLK_EN				(0x0004)
+#define U300_SYSCON_CEFR_I2C0_CLK_EN				(0x0002)
 #define U300_SYSCON_CEFR_FAST_BRIDGE_CLK_EN			(0x0001)
 /* Clock enable for the rest of the peripherals 16bit (R/W) */
 #define U300_SYSCON_CERR					(0x0028)
-#ifdef CONFIG_MACH_U300_BS335
 #define U300_SYSCON_CERR_CDS_CLK_EN				(0x2000)
 #define U300_SYSCON_CERR_ISP_CLK_EN				(0x1000)
-#endif
 #define U300_SYSCON_CERR_MSPRO_CLK_EN				(0x0800)
 #define U300_SYSCON_CERR_AHB_SUBSYS_BRIDGE_CLK_EN		(0x0400)
 #define U300_SYSCON_CERR_SEMI_CLK_EN				(0x0200)
@@ -124,9 +112,7 @@
 #define U300_SYSCON_CERR_AAIF_CLK_EN				(0x0001)
 /* Single block clock enable 16bit (-/W) */
 #define U300_SYSCON_SBCER					(0x002c)
-#ifdef CONFIG_MACH_U300_BS335
 #define U300_SYSCON_SBCER_PPM_CLK_EN				(0x0009)
-#endif
 #define U300_SYSCON_SBCER_ACC_TMR_CLK_EN			(0x0008)
 #define U300_SYSCON_SBCER_APP_TMR_CLK_EN			(0x0007)
 #define U300_SYSCON_SBCER_KEYPAD_CLK_EN				(0x0006)
@@ -135,9 +121,7 @@
 #define U300_SYSCON_SBCER_BTR_CLK_EN				(0x0002)
 #define U300_SYSCON_SBCER_UART_CLK_EN				(0x0001)
 #define U300_SYSCON_SBCER_SLOW_BRIDGE_CLK_EN			(0x0000)
-#ifdef CONFIG_MACH_U300_BS335
 #define U300_SYSCON_SBCER_UART1_CLK_EN				(0x0019)
-#endif
 #define U300_SYSCON_SBCER_I2S1_CORE_CLK_EN			(0x0018)
 #define U300_SYSCON_SBCER_I2S0_CORE_CLK_EN			(0x0017)
 #define U300_SYSCON_SBCER_SPI_CLK_EN				(0x0016)
@@ -147,10 +131,8 @@
 #define U300_SYSCON_SBCER_I2C1_CLK_EN				(0x0012)
 #define U300_SYSCON_SBCER_I2C0_CLK_EN				(0x0011)
 #define U300_SYSCON_SBCER_FAST_BRIDGE_CLK_EN			(0x0010)
-#ifdef CONFIG_MACH_U300_BS335
 #define U300_SYSCON_SBCER_CDS_CLK_EN				(0x002D)
 #define U300_SYSCON_SBCER_ISP_CLK_EN				(0x002C)
-#endif
 #define U300_SYSCON_SBCER_MSPRO_CLK_EN				(0x002B)
 #define U300_SYSCON_SBCER_AHB_SUBSYS_BRIDGE_CLK_EN		(0x002A)
 #define U300_SYSCON_SBCER_SEMI_CLK_EN				(0x0029)
@@ -168,9 +150,7 @@
 /* Same values as above for SBCER */
 /* Clock force SLOW peripherals 16bit (R/W) */
 #define U300_SYSCON_CFSR					(0x003c)
-#ifdef CONFIG_MACH_U300_BS335
 #define U300_SYSCON_CFSR_PPM_CLK_FORCE_EN			(0x0200)
-#endif
 #define U300_SYSCON_CFSR_ACC_TMR_CLK_FORCE_EN			(0x0100)
 #define U300_SYSCON_CFSR_APP_TMR_CLK_FORCE_EN			(0x0080)
 #define U300_SYSCON_CFSR_KEYPAD_CLK_FORCE_EN			(0x0020)
@@ -184,10 +164,8 @@
 /* Values not defined. Define if you want to use them. */
 /* Clock force the rest of the peripherals 16bit (R/W) */
 #define U300_SYSCON_CFRR					(0x44)
-#ifdef CONFIG_MACH_U300_BS335
 #define U300_SYSCON_CFRR_CDS_CLK_FORCE_EN			(0x2000)
 #define U300_SYSCON_CFRR_ISP_CLK_FORCE_EN			(0x1000)
-#endif
 #define U300_SYSCON_CFRR_MSPRO_CLK_FORCE_EN			(0x0800)
 #define U300_SYSCON_CFRR_AHB_SUBSYS_BRIDGE_CLK_FORCE_EN		(0x0400)
 #define U300_SYSCON_CFRR_SEMI_CLK_FORCE_EN			(0x0200)
diff --git a/arch/arm/mach-u300/include/mach/u300-regs.h b/arch/arm/mach-u300/include/mach/u300-regs.h
index 65f87c5..1e49d90 100644
--- a/arch/arm/mach-u300/include/mach/u300-regs.h
+++ b/arch/arm/mach-u300/include/mach/u300-regs.h
@@ -28,7 +28,6 @@
 #define PLAT_NAND_CLE			(1 << 16)
 #define PLAT_NAND_ALE			(1 << 17)
 
-
 /* AHB Peripherals */
 #define U300_AHB_PER_PHYS_BASE		0xa0000000
 #define U300_AHB_PER_VIRT_BASE		0xff010000
@@ -46,11 +45,7 @@
 #define U300_BOOTROM_VIRT_BASE		0xffff0000
 
 /* SEMI config base */
-#ifdef CONFIG_MACH_U300_BS335
 #define U300_SEMI_CONFIG_BASE		0x2FFE0000
-#else
-#define U300_SEMI_CONFIG_BASE		0x30000000
-#endif
 
 /*
  * AHB peripherals
@@ -99,10 +94,8 @@
 /* SPI controller */
 #define U300_SPI_BASE			(U300_FAST_PER_PHYS_BASE+0x6000)
 
-#ifdef CONFIG_MACH_U300_BS335
 /* Fast UART1 on U335 only */
 #define U300_UART1_BASE			(U300_SLOW_PER_PHYS_BASE+0x7000)
-#endif
 
 /*
  * SLOW peripherals
@@ -151,10 +144,8 @@
  * REST peripherals
  */
 
-/* ISP (image signal processor) is only available in U335 */
-#ifdef CONFIG_MACH_U300_BS335
+/* ISP (image signal processor) */
 #define U300_ISP_BASE			(0xA0008000)
-#endif
 
 /* DMA Controller base */
 #define U300_DMAC_BASE			(0xC0020000)
@@ -166,17 +157,9 @@
 #define U300_APEX_BASE			(0xc0030000)
 
 /* Video Encoder Base */
-#ifdef CONFIG_MACH_U300_BS335
 #define U300_VIDEOENC_BASE		(0xc0080000)
-#else
-#define U300_VIDEOENC_BASE		(0xc0040000)
-#endif
 
 /* XGAM Base */
 #define U300_XGAM_BASE			(0xd0000000)
 
-/*
- * Virtual accessor macros for static devices
- */
-
 #endif
diff --git a/arch/arm/mach-u300/u300-gpio.h b/arch/arm/mach-u300/u300-gpio.h
index 847dc25..83f5077 100644
--- a/arch/arm/mach-u300/u300-gpio.h
+++ b/arch/arm/mach-u300/u300-gpio.h
@@ -1,50 +1,11 @@
 /*
- * Individual pin assignments for the B26/S26. Notice that the
- * actual usage of these pins depends on the PAD MUX settings, that
- * is why the same number can potentially appear several times.
- * In the reference design each pin is only used for one purpose.
- * These were determined by inspecting the B26/S26 schematic:
- * 2/1911-ROA 128 1603
- */
-#ifdef CONFIG_MACH_U300_BS2X
-#define U300_GPIO_PIN_UART_RX		0
-#define U300_GPIO_PIN_UART_TX		1
-#define U300_GPIO_PIN_GPIO02		2  /* Unrouted */
-#define U300_GPIO_PIN_GPIO03		3  /* Unrouted */
-#define U300_GPIO_PIN_CAM_SLEEP		4
-#define U300_GPIO_PIN_CAM_REG_EN	5
-#define U300_GPIO_PIN_GPIO06		6  /* Unrouted */
-#define U300_GPIO_PIN_GPIO07		7  /* Unrouted */
-
-#define U300_GPIO_PIN_GPIO08		8  /* Service point SP2321 */
-#define U300_GPIO_PIN_GPIO09		9  /* Service point SP2322 */
-#define U300_GPIO_PIN_PHFSENSE		10 /* Headphone jack sensing */
-#define U300_GPIO_PIN_MMC_CLKRET	11 /* Clock return from MMC/SD card */
-#define U300_GPIO_PIN_MMC_CD		12 /* MMC Card insertion detection */
-#define U300_GPIO_PIN_FLIPSENSE		13 /* Mechanical flip sensing */
-#define U300_GPIO_PIN_GPIO14		14 /* DSP JTAG Port RTCK */
-#define U300_GPIO_PIN_GPIO15		15 /* Unrouted */
-
-#define U300_GPIO_PIN_GPIO16		16 /* Unrouted */
-#define U300_GPIO_PIN_GPIO17		17 /* Unrouted */
-#define U300_GPIO_PIN_GPIO18		18 /* Unrouted */
-#define U300_GPIO_PIN_GPIO19		19 /* Unrouted */
-#define U300_GPIO_PIN_GPIO20		20 /* Unrouted */
-#define U300_GPIO_PIN_GPIO21		21 /* Unrouted */
-#define U300_GPIO_PIN_GPIO22		22 /* Unrouted */
-#define U300_GPIO_PIN_GPIO23		23 /* Unrouted */
-#endif
-
-/*
- * Individual pin assignments for the B330/S330 and B365/S365.
+ * Individual pin assignments for the B335/S335.
  * Notice that the actual usage of these pins depends on the
  * PAD MUX settings, that is why the same number can potentially
  * appear several times. In the reference design each pin is only
  * used for one purpose. These were determined by inspecting the
  * S365 schematic.
  */
-#if defined(CONFIG_MACH_U300_BS330) || defined(CONFIG_MACH_U300_BS365) || \
-    defined(CONFIG_MACH_U300_BS335)
 #define U300_GPIO_PIN_UART_RX		0
 #define U300_GPIO_PIN_UART_TX		1
 #define U300_GPIO_PIN_UART_CTS		2
@@ -90,8 +51,6 @@
 #define U300_GPIO_PIN_GPIO38		38 /* Unrouted */
 #define U300_GPIO_PIN_GPIO39		39 /* Unrouted */
 
-#ifdef CONFIG_MACH_U300_BS335
-
 #define U300_GPIO_PIN_GPIO40		40 /* Unrouted */
 #define U300_GPIO_PIN_GPIO41		41 /* Unrouted */
 #define U300_GPIO_PIN_GPIO42		42 /* Unrouted */
@@ -109,6 +68,3 @@
 #define U300_GPIO_PIN_GPIO53		53 /* Unrouted */
 #define U300_GPIO_PIN_GPIO54		54 /* Unrouted */
 #define U300_GPIO_PIN_GPIO55		55 /* Unrouted */
-#endif
-
-#endif
diff --git a/arch/arm/mach-u300/u300.c b/arch/arm/mach-u300/u300.c
index f30c69d..4e56e8c 100644
--- a/arch/arm/mach-u300/u300.c
+++ b/arch/arm/mach-u300/u300.c
@@ -29,23 +29,7 @@ static void __init u300_init_machine(void)
 	u300_init_devices();
 }
 
-#ifdef CONFIG_MACH_U300_BS2X
-#define MACH_U300_STRING "Ericsson AB U300 S25/S26/B25/B26 Prototype Board"
-#endif
-
-#ifdef CONFIG_MACH_U300_BS330
-#define MACH_U300_STRING "Ericsson AB U330 S330/B330 Prototype Board"
-#endif
-
-#ifdef CONFIG_MACH_U300_BS335
-#define MACH_U300_STRING "Ericsson AB U335 S335/B335 Prototype Board"
-#endif
-
-#ifdef CONFIG_MACH_U300_BS365
-#define MACH_U300_STRING "Ericsson AB U365 S365/B365 Prototype Board"
-#endif
-
-MACHINE_START(U300, MACH_U300_STRING)
+MACHINE_START(U300, "Ericsson AB U335 S335/B335 Prototype Board")
 	/* Maintainer: Linus Walleij <linus.walleij@stericsson.com> */
 	.atag_offset	= 0x100,
 	.map_io		= u300_map_io,
-- 
1.7.11.3
