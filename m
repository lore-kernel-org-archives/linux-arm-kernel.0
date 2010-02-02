From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  2 Feb 2010 15:59:15 -0800
Subject: [PATCH 03/16] ARM: LPC32XX: Added LPC32XX identifier to high level
	macro names
In-Reply-To: <LPC32XX architecture files (updated)>
References: <LPC32XX architecture files (updated)>
Message-ID: <1265155168-28909-4-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Arch specific macro names used for system base addresses, clock
rates, and sizing have been updated to include the LPC32XX
identifier. This may help prevent potential conflicts with Linux
identifiers in the future.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/clock.c                    |   18 ++--
 arch/arm/mach-lpc32xx/common.c                   |   34 +++---
 arch/arm/mach-lpc32xx/common.h                   |    2 +-
 arch/arm/mach-lpc32xx/gpiolib.c                  |    2 +-
 arch/arm/mach-lpc32xx/include/mach/debug-macro.S |    8 +-
 arch/arm/mach-lpc32xx/include/mach/entry-macro.S |    6 +-
 arch/arm/mach-lpc32xx/include/mach/platform.h    |  140 +++++++++++-----------
 arch/arm/mach-lpc32xx/include/mach/uncompress.h  |   14 +-
 arch/arm/mach-lpc32xx/irq.c                      |   31 +++---
 arch/arm/mach-lpc32xx/phy3250.c                  |   22 ++--
 arch/arm/mach-lpc32xx/pm.c                       |    6 +-
 arch/arm/mach-lpc32xx/serial.c                   |   34 +++---
 arch/arm/mach-lpc32xx/suspend.S                  |    4 +-
 arch/arm/mach-lpc32xx/timer.c                    |    8 +-
 14 files changed, 163 insertions(+), 166 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index d404b67..eb522a5 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -110,11 +110,11 @@ static struct clk clk_usbpll;
  */
 const u32 pll_postdivs[4] = {1, 2, 4, 8};
 
-#define USB_OTG_IOBASE io_p2v(USB_BASE)
+#define USB_OTG_IOBASE io_p2v(LPC32XX_USB_BASE)
 
 /* 32KHz clock has a fixed rate and is not stoppable */
 static struct clk osc_32KHz = {
-	.rate		= CLOCK_OSC_FREQ,
+	.rate		= LPC32XX_CLOCK_OSC_FREQ,
 };
 
 static int local_pll397_enable(struct clk *clk, int enable)
@@ -132,7 +132,7 @@ static int local_pll397_enable(struct clk *clk, int enable)
 		/* Enable PLL397 */
 		reg &= ~CLKPWR_SYSCTRL_PLL397_DIS;
 		writel(reg, CLKPWR_PLL397_CTRL(CLKPWR_IOBASE));
-		clk->rate = CLOCK_OSC_FREQ * 397;
+		clk->rate = LPC32XX_CLOCK_OSC_FREQ * 397;
 
 		/* Wait for PLL397 lock */
 		while (((readl(CLKPWR_PLL397_CTRL(CLKPWR_IOBASE)) &
@@ -163,7 +163,7 @@ static int local_oscmain_enable(struct clk *clk, int enable)
 		/* Enable main oscillator */
 		reg &= ~CLKPWR_MOSC_DISABLE;
 		writel(reg, CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE));
-		clk->rate = MAIN_OSC_FREQ;
+		clk->rate = LPC32XX_MAIN_OSC_FREQ;
 
 		/* Wait for main oscillator to start */
 		while (((readl(CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE)) &
@@ -182,12 +182,12 @@ static int local_oscmain_enable(struct clk *clk, int enable)
 static struct clk osc_pll397 = {
 	.parent		= &osc_32KHz,
 	.enable		= &local_pll397_enable,
-	.rate		= CLOCK_OSC_FREQ * 397,
+	.rate		= LPC32XX_CLOCK_OSC_FREQ * 397,
 };
 
 static struct clk osc_main = {
 	.enable		= &local_oscmain_enable,
-	.rate		= MAIN_OSC_FREQ,
+	.rate		= LPC32XX_MAIN_OSC_FREQ,
 };
 
 static struct clk clk_sys;
@@ -757,7 +757,7 @@ static u32 clcd_get_rate(struct clk *clk)
 		return 0;
 
 	rate = clk_get_rate(clk->parent);
-	tmp = readl((io_p2v(LCD_BASE)) + CLCD_TIM2);
+	tmp = readl((io_p2v(LPC32XX_LCD_BASE)) + CLCD_TIM2);
 
 	/* Only supports internal clocking */
 	if (tmp & TIM2_BCD)
@@ -773,7 +773,7 @@ static int clcd_set_rate(struct clk *clk, u32 rate)
 {
 	u32 tmp, prate, div;
 
-	tmp = readl((io_p2v(LCD_BASE)) + CLCD_TIM2);
+	tmp = readl((io_p2v(LPC32XX_LCD_BASE)) + CLCD_TIM2);
 	prate = clk_get_rate(clk->parent);
 
 	if (rate == prate) {
@@ -791,7 +791,7 @@ static int clcd_set_rate(struct clk *clk, u32 rate)
 		tmp &= ~TIM2_BCD;
 		tmp |= (div & 0x1F);
 		tmp |= (((div >> 5) & 0x1F) << 27);
-		writel(tmp, ((io_p2v(LCD_BASE)) + CLCD_TIM2));
+		writel(tmp, ((io_p2v(LPC32XX_LCD_BASE)) + CLCD_TIM2));
 		local_onoff_enable(clk, 1);
 	}
 
diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index 77c98b4..f4e2113 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -36,15 +36,15 @@
 #include <mach/platform.h>
 #include "common.h"
 
-#define WDT_IOBASE io_p2v(WDTIM_BASE)
+#define WDT_IOBASE io_p2v(LPC32XX_WDTIM_BASE)
 
 /*
  * Watchdog timer
  */
 static struct resource watchdog_resources[] = {
 	[0] = {
-		.start = WDTIM_BASE,
-		.end = WDTIM_BASE + SZ_4K - 1,
+		.start = LPC32XX_WDTIM_BASE,
+		.end = LPC32XX_WDTIM_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 };
@@ -61,19 +61,19 @@ struct platform_device watchdog_device = {
  */
 static struct i2c_pnx_data i2c0_data = {
 	.name = I2C_CHIP_NAME "0",
-	.base = I2C1_BASE,
+	.base = LPC32XX_I2C1_BASE,
 	.irq = IRQ_I2C_1,
 };
 
 static struct i2c_pnx_data i2c1_data = {
 	.name = I2C_CHIP_NAME "1",
-	.base = I2C2_BASE,
+	.base = LPC32XX_I2C2_BASE,
 	.irq = IRQ_I2C_2,
 };
 
 static struct i2c_pnx_data i2c2_data = {
 	.name = "USB-I2C",
-	.base = OTG_I2C_BASE,
+	.base = LPC32XX_OTG_I2C_BASE,
 	.irq = IRQ_USB_I2C,
 };
 
@@ -238,26 +238,26 @@ u32 clk_get_pclk_div(void)
 
 static struct map_desc lpc32xx_io_desc[] __initdata = {
 	{
-		.virtual	= io_p2v(AHB0_START),
-		.pfn		= __phys_to_pfn(AHB0_START),
-		.length		= AHB0_SIZE,
+		.virtual	= io_p2v(LPC32XX_AHB0_START),
+		.pfn		= __phys_to_pfn(LPC32XX_AHB0_START),
+		.length		= LPC32XX_AHB0_SIZE,
 		.type		= MT_DEVICE
 	},
 	{
-		.virtual	= io_p2v(AHB1_START),
-		.pfn		= __phys_to_pfn(AHB1_START),
-		.length		= AHB1_SIZE,
+		.virtual	= io_p2v(LPC32XX_AHB1_START),
+		.pfn		= __phys_to_pfn(LPC32XX_AHB1_START),
+		.length		= LPC32XX_AHB1_SIZE,
 		.type		= MT_DEVICE
 	},
 	{
-		.virtual	= io_p2v(FABAPB_START),
-		.pfn		= __phys_to_pfn(FABAPB_START),
-		.length		= FABAPB_SIZE,
+		.virtual	= io_p2v(LPC32XX_FABAPB_START),
+		.pfn		= __phys_to_pfn(LPC32XX_FABAPB_START),
+		.length		= LPC32XX_FABAPB_SIZE,
 		.type		= MT_DEVICE
 	},
 	{
-		.virtual	= io_p2v(IRAM_BASE),
-		.pfn		= __phys_to_pfn(IRAM_BASE),
+		.virtual	= io_p2v(LPC32XX_IRAM_BASE),
+		.pfn		= __phys_to_pfn(LPC32XX_IRAM_BASE),
 		.length		= CONFIG_ARCH_LPC32XX_IRAM_SIZE,
 		.type		= MT_DEVICE
 	},
diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
index ab8d2b2..08fdfba 100644
--- a/arch/arm/mach-lpc32xx/common.h
+++ b/arch/arm/mach-lpc32xx/common.h
@@ -25,7 +25,7 @@
 
 #include <linux/platform_device.h>
 
-#define CLKPWR_IOBASE io_p2v(CLK_PM_BASE)
+#define CLKPWR_IOBASE io_p2v(LPC32XX_CLK_PM_BASE)
 
 /*
  * Arch specific platform device structures
diff --git a/arch/arm/mach-lpc32xx/gpiolib.c b/arch/arm/mach-lpc32xx/gpiolib.c
index 30cf252..803c48f 100644
--- a/arch/arm/mach-lpc32xx/gpiolib.c
+++ b/arch/arm/mach-lpc32xx/gpiolib.c
@@ -29,7 +29,7 @@
 #include <mach/hardware.h>
 #include <mach/platform.h>
 
-#define GPIOBASE io_p2v(GPIO_BASE)
+#define GPIOBASE io_p2v(LPC32XX_GPIO_BASE)
 
 struct gpio_regs {
 	void __iomem *inp_state;
diff --git a/arch/arm/mach-lpc32xx/include/mach/debug-macro.S b/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
index 641daba..e03a1b7 100644
--- a/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-lpc32xx/include/mach/debug-macro.S
@@ -29,19 +29,19 @@
 */
 
 #ifdef CONFIG_ARCH_LPC32XX_DEBUGO_U3
-#define UARTDB_BASE UART3_BASE
+#define UARTDB_BASE LPC32XX_UART3_BASE
 #endif
 
 #ifdef CONFIG_ARCH_LPC32XX_DEBUGO_U4
-#define UARTDB_BASE UART4_BASE
+#define UARTDB_BASE LPC32XX_UART4_BASE
 #endif
 
 #ifdef CONFIG_ARCH_LPC32XX_DEBUGO_U5
-#define UARTDB_BASE UART5_BASE
+#define UARTDB_BASE LPC32XX_UART5_BASE
 #endif
 
 #ifdef CONFIG_ARCH_LPC32XX_DEBUGO_U6
-#define UARTDB_BASE UART6_BASE
+#define UARTDB_BASE LPC32XX_UART6_BASE
 #endif
 
 	.macro	addruart,rx
diff --git a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
index ba1bdd6..01331f1 100644
--- a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
@@ -38,7 +38,7 @@
  */
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 	/* Get MIC status first */
-	ldr	\base, =IO_ADDRESS(MIC_BASE)
+	ldr	\base, =IO_ADDRESS(LPC32XX_MIC_BASE)
 	ldr	\irqstat, [\base, #INTC_STAT]
 	and	\irqstat, \irqstat, #0xFFFFFFFC
 	mov	\tmp, #0
@@ -48,7 +48,7 @@
 	bne	1000f
 
 	/* SIC1 interrupts start at offset 32 */
-	ldr	\base, =IO_ADDRESS(SIC1_BASE)
+	ldr	\base, =IO_ADDRESS(LPC32XX_SIC1_BASE)
 	ldr	\irqstat, [\base, #INTC_STAT]
 	mov	\tmp, #32
 
@@ -57,7 +57,7 @@
 	bne	1000f
 
 	/* SIC2 interrupts start at offset 64 */
-	ldr	\base, =IO_ADDRESS(SIC2_BASE)
+	ldr	\base, =IO_ADDRESS(LPC32XX_SIC2_BASE)
 	ldr	\irqstat, [\base, #INTC_STAT]
 	mov	\tmp, #64
 
diff --git a/arch/arm/mach-lpc32xx/include/mach/platform.h b/arch/arm/mach-lpc32xx/include/mach/platform.h
index 48305a5..42fe08d 100644
--- a/arch/arm/mach-lpc32xx/include/mach/platform.h
+++ b/arch/arm/mach-lpc32xx/include/mach/platform.h
@@ -29,110 +29,108 @@
 /*
  * AHB 0 physical base addresses
  */
-#define SLC_BASE			0x20020000
-#define SSP0_BASE			0x20084000
-#define SPI1_BASE			0x20088000
-#define SSP1_BASE			0x2008C000
-#define SPI2_BASE			0x20090000
-#define I2S0_BASE			0x20094000
-#define SD_BASE				0x20098000
-#define I2S1_BASE			0x2009C000
-#define MLC_BASE			0x200A8000
-#define AHB0_START			SLC_BASE
-#define AHB0_SIZE			((MLC_BASE - SLC_BASE) + SZ_4K)
+#define LPC32XX_SLC_BASE			0x20020000
+#define LPC32XX_SSP0_BASE			0x20084000
+#define LPC32XX_SPI1_BASE			0x20088000
+#define LPC32XX_SSP1_BASE			0x2008C000
+#define LPC32XX_SPI2_BASE			0x20090000
+#define LPC32XX_I2S0_BASE			0x20094000
+#define LPC32XX_SD_BASE				0x20098000
+#define LPC32XX_I2S1_BASE			0x2009C000
+#define LPC32XX_MLC_BASE			0x200A8000
+#define LPC32XX_AHB0_START			LPC32XX_SLC_BASE
+#define LPC32XX_AHB0_SIZE			((LPC32XX_MLC_BASE -\
+						LPC32XX_SLC_BASE) + SZ_4K)
 
 /*
  * AHB 1 physical base addresses
  */
-#define DMA_BASE			0x31000000
-#define USB_BASE			0x31020000
-#define USBH_BASE			0x31020000
-#define USB_OTG_BASE			0x31020000
-#define OTG_I2C_BASE			0x31020300
-#define LCD_BASE			0x31040000
-#define ETHERNET_BASE			0x31060000
-#define EMC_BASE			0x31080000
-#define ETB_CFG_BASE			0x310C0000
-#define ETB_DATA_BASE			0x310E0000
-#define AHB1_START			DMA_BASE
-#define AHB1_SIZE			((EMC_BASE - DMA_BASE) + SZ_4K)
+#define LPC32XX_DMA_BASE			0x31000000
+#define LPC32XX_USB_BASE			0x31020000
+#define LPC32XX_USBH_BASE			0x31020000
+#define LPC32XX_USB_OTG_BASE			0x31020000
+#define LPC32XX_OTG_I2C_BASE			0x31020300
+#define LPC32XX_LCD_BASE			0x31040000
+#define LPC32XX_ETHERNET_BASE			0x31060000
+#define LPC32XX_EMC_BASE			0x31080000
+#define LPC32XX_ETB_CFG_BASE			0x310C0000
+#define LPC32XX_ETB_DATA_BASE			0x310E0000
+#define LPC32XX_AHB1_START			LPC32XX_DMA_BASE
+#define LPC32XX_AHB1_SIZE			((LPC32XX_EMC_BASE -\
+						LPC32XX_DMA_BASE) + SZ_4K)
 
 /*
  * FAB physical base addresses
  */
-#define CLK_PM_BASE			0x40004000
-#define MIC_BASE			0x40008000
-#define SIC1_BASE			0x4000C000
-#define SIC2_BASE			0x40010000
-#define HS_UART1_BASE			0x40014000
-#define HS_UART2_BASE			0x40018000
-#define HS_UART7_BASE			0x4001C000
-#define RTC_BASE			0x40024000
-#define RTC_RAM_BASE			0x40024080
-#define GPIO_BASE			0x40028000
-#define PWM3_BASE			0x4002C000
-#define PWM4_BASE			0x40030000
-#define MSTIM_BASE			0x40034000
-#define HSTIM_BASE			0x40038000
-#define WDTIM_BASE			0x4003C000
-#define DEBUG_CTRL_BASE			0x40040000
-#define TIMER0_BASE			0x40044000
-#define ADC_BASE			0x40048000
-#define TIMER1_BASE			0x4004C000
-#define KSCAN_BASE			0x40050000
-#define UART_CTRL_BASE			0x40054000
-#define TIMER2_BASE			0x40058000
-#define PWM1_BASE			0x4005C000
-#define PWM2_BASE			0x4005C004
-#define TIMER3_BASE			0x40060000
+#define LPC32XX_CLK_PM_BASE			0x40004000
+#define LPC32XX_MIC_BASE			0x40008000
+#define LPC32XX_SIC1_BASE			0x4000C000
+#define LPC32XX_SIC2_BASE			0x40010000
+#define LPC32XX_HS_UART1_BASE			0x40014000
+#define LPC32XX_HS_UART2_BASE			0x40018000
+#define LPC32XX_HS_UART7_BASE			0x4001C000
+#define LPC32XX_RTC_BASE			0x40024000
+#define LPC32XX_RTC_RAM_BASE			0x40024080
+#define LPC32XX_GPIO_BASE			0x40028000
+#define LPC32XX_PWM3_BASE			0x4002C000
+#define LPC32XX_PWM4_BASE			0x40030000
+#define LPC32XX_MSTIM_BASE			0x40034000
+#define LPC32XX_HSTIM_BASE			0x40038000
+#define LPC32XX_WDTIM_BASE			0x4003C000
+#define LPC32XX_DEBUG_CTRL_BASE			0x40040000
+#define LPC32XX_TIMER0_BASE			0x40044000
+#define LPC32XX_ADC_BASE			0x40048000
+#define LPC32XX_TIMER1_BASE			0x4004C000
+#define LPC32XX_KSCAN_BASE			0x40050000
+#define LPC32XX_UART_CTRL_BASE			0x40054000
+#define LPC32XX_TIMER2_BASE			0x40058000
+#define LPC32XX_PWM1_BASE			0x4005C000
+#define LPC32XX_PWM2_BASE			0x4005C004
+#define LPC32XX_TIMER3_BASE			0x40060000
 
 /*
  * APB physical base addresses
  */
 
-#define UART3_BASE			0x40080000
-#define UART4_BASE			0x40088000
-#define UART5_BASE			0x40090000
-#define UART6_BASE			0x40098000
-#define I2C1_BASE			0x400A0000
-#define I2C2_BASE			0x400A8000
+#define LPC32XX_UART3_BASE			0x40080000
+#define LPC32XX_UART4_BASE			0x40088000
+#define LPC32XX_UART5_BASE			0x40090000
+#define LPC32XX_UART6_BASE			0x40098000
+#define LPC32XX_I2C1_BASE			0x400A0000
+#define LPC32XX_I2C2_BASE			0x400A8000
 
 /*
  * FAB and APB base and sizing
  */
-#define FABAPB_START			CLK_PM_BASE
-#define FABAPB_SIZE			((I2C2_BASE - CLK_PM_BASE) + SZ_4K)
+#define LPC32XX_FABAPB_START			LPC32XX_CLK_PM_BASE
+#define LPC32XX_FABAPB_SIZE			((LPC32XX_I2C2_BASE -\
+						LPC32XX_CLK_PM_BASE) + SZ_4K)
 
 /*
  * Internal memory Bases
  */
-#define IRAM_BASE			0x08000000
-#define IROM_BASE			0x0C000000
+#define LPC32XX_IRAM_BASE			0x08000000
+#define LPC32XX_IROM_BASE			0x0C000000
 
 /*
  * External Static Memory Bank Address Space Bases
  */
-#define EMC_CS0_BASE			0xE0000000
-#define EMC_CS1_BASE			0xE1000000
-#define EMC_CS2_BASE			0xE2000000
-#define EMC_CS3_BASE			0xE3000000
+#define LPC32XX_EMC_CS0_BASE			0xE0000000
+#define LPC32XX_EMC_CS1_BASE			0xE1000000
+#define LPC32XX_EMC_CS2_BASE			0xE2000000
+#define LPC32XX_EMC_CS3_BASE			0xE3000000
 
 /*
  * External SDRAM Memory Bank Address Space Bases
  */
-#define EMC_DYCS0_BASE			0x80000000
-#define EMC_DYCS1_BASE			0xA0000000
+#define LPC32XX_EMC_DYCS0_BASE			0x80000000
+#define LPC32XX_EMC_DYCS1_BASE			0xA0000000
 
 /*
  * Clock and crystal information
  */
-#define MAIN_OSC_FREQ			13000000
-#define CLOCK_OSC_FREQ			32768
-
-/*
- * IRAM size
-*/
-#define LPC32XX_IRAM_SIZE 		CONFIG_ARCH_LPC32XX_IRAM_SIZE
+#define LPC32XX_MAIN_OSC_FREQ			13000000
+#define LPC32XX_CLOCK_OSC_FREQ			32768
 
 /*
  * Clock and Power control register offsets
diff --git a/arch/arm/mach-lpc32xx/include/mach/uncompress.h b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
index a00ecc5..94c29a8 100644
--- a/arch/arm/mach-lpc32xx/include/mach/uncompress.h
+++ b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
@@ -34,15 +34,15 @@
  * High speed UART uncompress output support
 */
 #ifdef CONFIG_ARCH_LPC32XX_UNCOMP_HSU1
-#define HS_UARTX_BASE	(HS_UART1_BASE)
+#define HS_UARTX_BASE	(LPC32XX_HS_UART1_BASE)
 #endif
 
 #ifdef CONFIG_ARCH_LPC32XX_UNCOMP_HSU2
-#define HS_UARTX_BASE	(HS_UART2_BASE)
+#define HS_UARTX_BASE	(LPC32XX_HS_UART2_BASE)
 #endif
 
 #ifdef CONFIG_ARCH_LPC32XX_UNCOMP_HSU7
-#define HS_UARTX_BASE	(HS_UART7_BASE)
+#define HS_UARTX_BASE	(LPC32XX_HS_UART7_BASE)
 #endif
 
 #define HSUART_FIFO	(HS_UARTX_BASE + 0x00)
@@ -72,19 +72,19 @@ static inline void flush(void)
 #define UART_STATUS_TX_MT	(1 << 6)
 
 #ifdef CONFIG_ARCH_LPC32XX_UNCOMP_U3
-#define UARTX_BASE	(UART3_BASE)
+#define UARTX_BASE	(LPC32XX_UART3_BASE)
 #endif
 
 #ifdef CONFIG_ARCH_LPC32XX_UNCOMP_U4
-#define UARTX_BASE	(UART4_BASE)
+#define UARTX_BASE	(LPC32XX_UART4_BASE)
 #endif
 
 #ifdef CONFIG_ARCH_LPC32XX_UNCOMP_U5
-#define UARTX_BASE	(UART5_BASE)
+#define UARTX_BASE	(LPC32XX_UART5_BASE)
 #endif
 
 #ifdef CONFIG_ARCH_LPC32XX_UNCOMP_U6
-#define UARTX_BASE	(UART6_BASE)
+#define UARTX_BASE	(LPC32XX_UART6_BASE)
 #endif
 
 #define UART_DATA	(UARTX_BASE + 0x00)
diff --git a/arch/arm/mach-lpc32xx/irq.c b/arch/arm/mach-lpc32xx/irq.c
index 8a1b57d..3e45d32 100644
--- a/arch/arm/mach-lpc32xx/irq.c
+++ b/arch/arm/mach-lpc32xx/irq.c
@@ -51,13 +51,13 @@ static void get_controller(unsigned int irq, unsigned int *base,
 	unsigned int *irqbit)
 {
 	if (irq < 32) {
-		*base = io_p2v(MIC_BASE);
+		*base = io_p2v(LPC32XX_MIC_BASE);
 		*irqbit = 1 << irq;
 	} else if (irq < 64) {
-		*base = io_p2v(SIC1_BASE);
+		*base = io_p2v(LPC32XX_SIC1_BASE);
 		*irqbit = 1 << (irq - 32);
 	} else {
-		*base = io_p2v(SIC2_BASE);
+		*base = io_p2v(LPC32XX_SIC2_BASE);
 		*irqbit = 1 << (irq - 64);
 	}
 }
@@ -197,19 +197,19 @@ void __init lpc32xx_init_irq(void)
 	unsigned int i, vloc;
 
 	/* Setup MIC */
-	vloc = io_p2v(MIC_BASE);
+	vloc = io_p2v(LPC32XX_MIC_BASE);
 	writel(0, (vloc + INTC_MASK));
 	writel(MIC_APR_DEFAULT, (vloc + INTC_POLAR));
 	writel(MIC_ATR_DEFAULT, (vloc + INTC_ACT_TYPE));
 
 	/* Setup SIC1 */
-	vloc = io_p2v(SIC1_BASE);
+	vloc = io_p2v(LPC32XX_SIC1_BASE);
 	writel(0, (vloc + INTC_MASK));
 	writel(SIC1_APR_DEFAULT, (vloc + INTC_POLAR));
 	writel(SIC1_ATR_DEFAULT, (vloc + INTC_ACT_TYPE));
 
 	/* Setup SIC2 */
-	vloc = io_p2v(SIC2_BASE);
+	vloc = io_p2v(LPC32XX_SIC2_BASE);
 	writel(0, (vloc + INTC_MASK));
 	writel(SIC2_APR_DEFAULT, (vloc + INTC_POLAR));
 	writel(SIC2_ATR_DEFAULT, (vloc + INTC_ACT_TYPE));
@@ -221,17 +221,16 @@ void __init lpc32xx_init_irq(void)
 	}
 
 	/* Set default mappings */
-	lpc32xx_set_default_mappings(io_p2v(MIC_BASE), MIC_APR_DEFAULT,
+	lpc32xx_set_default_mappings(io_p2v(LPC32XX_MIC_BASE), MIC_APR_DEFAULT,
 		MIC_ATR_DEFAULT, 0);
-	lpc32xx_set_default_mappings(io_p2v(SIC1_BASE), SIC1_APR_DEFAULT,
-		SIC1_ATR_DEFAULT, 32);
-	lpc32xx_set_default_mappings(io_p2v(SIC2_BASE), SIC2_APR_DEFAULT,
-		SIC2_ATR_DEFAULT, 64);
+	lpc32xx_set_default_mappings(io_p2v(LPC32XX_SIC1_BASE),
+		SIC1_APR_DEFAULT, SIC1_ATR_DEFAULT, 32);
+	lpc32xx_set_default_mappings(io_p2v(LPC32XX_SIC2_BASE),
+		SIC2_APR_DEFAULT, SIC2_ATR_DEFAULT, 64);
 
 	/* mask all interrupts except SUBIRQA and SUBFIQ */
-	writel((1 << IRQ_SUB1IRQ) | (1 << IRQ_SUB2IRQ) |
-			(1 << IRQ_SUB1FIQ) | (1 << IRQ_SUB2FIQ),
-		(io_p2v(MIC_BASE) + INTC_MASK));
-	writel(0, (io_p2v(SIC1_BASE) + INTC_MASK));
-	writel(0, (io_p2v(SIC2_BASE) + INTC_MASK));
+	writel((1 << IRQ_SUB1IRQ) | (1 << IRQ_SUB2IRQ) | (1 << IRQ_SUB1FIQ) |
+		(1 << IRQ_SUB2FIQ), (io_p2v(LPC32XX_MIC_BASE) + INTC_MASK));
+	writel(0, (io_p2v(LPC32XX_SIC1_BASE) + INTC_MASK));
+	writel(0, (io_p2v(LPC32XX_SIC2_BASE) + INTC_MASK));
 }
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index aa29aa6..4ee9714 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -87,9 +87,9 @@ static int lpc32xx_clcd_setup(struct clcd_fb *fb)
 
 	fb->fb.screen_base = (void *) NULL;
 #ifdef CONFIG_MACH_LPC32XX_IRAM_FOR_CLCD
-	if (PANEL_SIZE <= LPC32XX_IRAM_SIZE) {
-		fb->fb.screen_base = (void *) io_p2v(IRAM_BASE);
-		fb->fb.fix.smem_start = (dma_addr_t) IRAM_BASE;
+	if (PANEL_SIZE <= CONFIG_ARCH_LPC32XX_IRAM_SIZE) {
+		fb->fb.screen_base = (void *) io_p2v(LPC32XX_IRAM_BASE);
+		fb->fb.fix.smem_start = (dma_addr_t) LPC32XX_IRAM_BASE;
 	}
 #endif
 
@@ -118,7 +118,7 @@ static int lpc32xx_clcd_setup(struct clcd_fb *fb)
 static int lpc32xx_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
 {
 #ifdef CONFIG_MACH_LPC32XX_IRAM_FOR_CLCD
-	if (PANEL_SIZE <= LPC32XX_IRAM_SIZE) {
+	if (PANEL_SIZE <= CONFIG_ARCH_LPC32XX_IRAM_SIZE) {
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 		if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			(vma->vm_end - vma->vm_start), vma->vm_page_prot)) {
@@ -138,7 +138,7 @@ static int lpc32xx_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
 static void lpc32xx_clcd_remove(struct clcd_fb *fb)
 {
 #ifdef CONFIG_MACH_LPC32XX_IRAM_FOR_CLCD
-	if (PANEL_SIZE > LPC32XX_IRAM_SIZE)
+	if (PANEL_SIZE > CONFIG_ARCH_LPC32XX_IRAM_SIZE)
 		dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
 			fb->fb.screen_base, fb->fb.fix.smem_start);
 
@@ -186,8 +186,8 @@ static struct amba_device clcd_device = {
 		.platform_data		= &lpc32xx_clcd_data,
 	},
 	.res				= {
-		.start			= LCD_BASE,
-		.end			= (LCD_BASE + SZ_4K - 1),
+		.start			= LPC32XX_LCD_BASE,
+		.end			= (LPC32XX_LCD_BASE + SZ_4K - 1),
 		.flags			= IORESOURCE_MEM,
 	},
 	.dma_mask			= ~0,
@@ -234,8 +234,8 @@ static struct amba_device ssp0_device = {
 		.platform_data		= &lpc32xx_ssp0_data,
 	},
 	.res				= {
-		.start			= SSP0_BASE,
-		.end			= (SSP0_BASE + SZ_4K - 1),
+		.start			= LPC32XX_SSP0_BASE,
+		.end			= (LPC32XX_SSP0_BASE + SZ_4K - 1),
 		.flags			= IORESOURCE_MEM,
 	},
 	.dma_mask			= ~0,
@@ -414,8 +414,8 @@ arch_initcall(lpc32xx_display_uid);
 
 MACHINE_START(PHY3250, "Phytec 3250 board with the LPC3250 Microcontroller")
 	/* Maintainer: Kevin Wells, NXP Semiconductors */
-	.phys_io	= UART5_BASE,
-	.io_pg_offst	= ((io_p2v(UART5_BASE))>>18) & 0xfffc,
+	.phys_io	= LPC32XX_UART5_BASE,
+	.io_pg_offst	= ((io_p2v(LPC32XX_UART5_BASE))>>18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= lpc32xx_map_io,
 	.init_irq	= lpc32xx_init_irq,
diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
index 8535e99..5f0a805 100644
--- a/arch/arm/mach-lpc32xx/pm.c
+++ b/arch/arm/mach-lpc32xx/pm.c
@@ -90,7 +90,7 @@
 #include "clock.h"
 #include "pm.h"
 
-#define TEMP_IRAM_AREA  io_p2v(IRAM_BASE)
+#define TEMP_IRAM_AREA  io_p2v(LPC32XX_IRAM_BASE)
 
 static void *iram_swap_area;
 
@@ -151,8 +151,8 @@ static int __init lpc32xx_pm_init(void)
 {
 	/* Setup SDRAM self-refresh clock to automatically
 	   disable on start of self-refresh */
-	writel(readl(io_p2v(EMC_BASE) + EMC_DYN_MEM_CTRL_OFS) | EMC_SRMMC,
-		io_p2v(EMC_BASE) + EMC_DYN_MEM_CTRL_OFS);
+	writel(readl(io_p2v(LPC32XX_EMC_BASE) + EMC_DYN_MEM_CTRL_OFS) |
+		EMC_SRMMC, io_p2v(LPC32XX_EMC_BASE) + EMC_DYN_MEM_CTRL_OFS);
 
 	/* Allocate some space for temporary IRAM storage */
 	iram_swap_area = kmalloc(lpc32xx_sys_suspend_sz, GFP_ATOMIC);
diff --git a/arch/arm/mach-lpc32xx/serial.c b/arch/arm/mach-lpc32xx/serial.c
index 1c15121..e4479ba 100644
--- a/arch/arm/mach-lpc32xx/serial.c
+++ b/arch/arm/mach-lpc32xx/serial.c
@@ -38,10 +38,10 @@
 static struct plat_serial8250_port serial_std_platform_data[] = {
 #ifdef CONFIG_ARCH_LPC32XX_UART5_ENABLE
 	{
-		.membase        = (void *) io_p2v(UART5_BASE),
-		.mapbase        = UART5_BASE,
+		.membase        = (void *) io_p2v(LPC32XX_UART5_BASE),
+		.mapbase        = LPC32XX_UART5_BASE,
 		.irq		= IRQ_UART_IIR5,
-		.uartclk	= MAIN_OSC_FREQ,
+		.uartclk	= LPC32XX_MAIN_OSC_FREQ,
 		.regshift	= 2,
 		.iotype		= UPIO_MEM32,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
@@ -50,10 +50,10 @@ static struct plat_serial8250_port serial_std_platform_data[] = {
 #endif
 #ifdef CONFIG_ARCH_LPC32XX_UART3_ENABLE
 	{
-		.membase	= (void *) io_p2v(UART3_BASE),
-		.mapbase        = UART3_BASE,
+		.membase	= (void *) io_p2v(LPC32XX_UART3_BASE),
+		.mapbase        = LPC32XX_UART3_BASE,
 		.irq		= IRQ_UART_IIR3,
-		.uartclk	= MAIN_OSC_FREQ,
+		.uartclk	= LPC32XX_MAIN_OSC_FREQ,
 		.regshift	= 2,
 		.iotype		= UPIO_MEM32,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
@@ -62,10 +62,10 @@ static struct plat_serial8250_port serial_std_platform_data[] = {
 #endif
 #ifdef CONFIG_ARCH_LPC32XX_UART4_ENABLE
 	{
-		.membase	= (void *) io_p2v(UART4_BASE),
-		.mapbase        = UART4_BASE,
+		.membase	= (void *) io_p2v(LPC32XX_UART4_BASE),
+		.mapbase        = LPC32XX_UART4_BASE,
 		.irq		= IRQ_UART_IIR4,
-		.uartclk	= MAIN_OSC_FREQ,
+		.uartclk	= LPC32XX_MAIN_OSC_FREQ,
 		.regshift	= 2,
 		.iotype		= UPIO_MEM32,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
@@ -74,10 +74,10 @@ static struct plat_serial8250_port serial_std_platform_data[] = {
 #endif
 #ifdef CONFIG_ARCH_LPC32XX_UART6_ENABLE
 	{
-		.membase	= (void *) io_p2v(UART6_BASE),
-		.mapbase        = UART6_BASE,
+		.membase	= (void *) io_p2v(LPC32XX_UART6_BASE),
+		.mapbase        = LPC32XX_UART6_BASE,
 		.irq		= IRQ_UART_IIR6,
-		.uartclk	= MAIN_OSC_FREQ,
+		.uartclk	= LPC32XX_MAIN_OSC_FREQ,
 		.regshift	= 2,
 		.iotype		= UPIO_MEM32,
 		.flags		= UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
@@ -169,7 +169,7 @@ void __init lpc32xx_serial_init(void)
 	}
 
 	/* This needs to be done after all UART clocks are setup */
-	writel(clkmodes, UARTCTL_CLKMODE(io_p2v(UART_CTRL_BASE)));
+	writel(clkmodes, UARTCTL_CLKMODE(io_p2v(LPC32XX_UART_CTRL_BASE)));
 	for (i = 0; i < ARRAY_SIZE(uartinit_data) - 1; i++) {
 		/* Force a flush of the RX FIFOs to work around a HW bug */
 		puart = serial_std_platform_data[i].membase;
@@ -182,18 +182,18 @@ void __init lpc32xx_serial_init(void)
 	}
 
 	/* IrDA pulsing support on UART6. This only enables the IrDA mux */
-	tmp = readl(UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
+	tmp = readl(UARTCTL_CTRL(io_p2v(LPC32XX_UART_CTRL_BASE)));
 #ifdef CONFIG_ARCH_LPC32XX_UART6_IRDAMODE
 	tmp &= ~UART_UART6_IRDAMOD_BYPASS;
 #else
 	tmp |= UART_UART6_IRDAMOD_BYPASS;
 #endif
-	writel(tmp, UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
+	writel(tmp, UARTCTL_CTRL(io_p2v(LPC32XX_UART_CTRL_BASE)));
 
 	/* Disable UART5->USB transparent mode or USB won't work */
-	tmp = readl(UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
+	tmp = readl(UARTCTL_CTRL(io_p2v(LPC32XX_UART_CTRL_BASE)));
 	tmp &= ~UART_U5_ROUTE_TO_USB;
-	writel(tmp, UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
+	writel(tmp, UARTCTL_CTRL(io_p2v(LPC32XX_UART_CTRL_BASE)));
 
 	platform_add_devices(lpc32xx_serial_devs,
 		ARRAY_SIZE(lpc32xx_serial_devs));
diff --git a/arch/arm/mach-lpc32xx/suspend.S b/arch/arm/mach-lpc32xx/suspend.S
index 075708b..aa06be8 100644
--- a/arch/arm/mach-lpc32xx/suspend.S
+++ b/arch/arm/mach-lpc32xx/suspend.S
@@ -143,8 +143,8 @@ ENTRY(lpc32xx_sys_suspend)
 	ldmfd	r0!, {r1 - r7, sp, pc}
 
 reg_bases:
-	.long	IO_ADDRESS(CLK_PM_BASE)
-	.long	IO_ADDRESS(EMC_BASE)
+	.long	IO_ADDRESS(LPC32XX_CLK_PM_BASE)
+	.long	IO_ADDRESS(LPC32XX_EMC_BASE)
 
 tmp_stack:
 	.long	0, 0, 0, 0, 0, 0, 0, 0, 0
diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
index 9c06346..c5fa62d 100644
--- a/arch/arm/mach-lpc32xx/timer.c
+++ b/arch/arm/mach-lpc32xx/timer.c
@@ -35,8 +35,8 @@
 #include <mach/platform.h>
 #include "common.h"
 
-#define TIMER0_IOBASE io_p2v(TIMER0_BASE)
-#define TIMER1_IOBASE io_p2v(TIMER1_BASE)
+#define TIMER0_IOBASE io_p2v(LPC32XX_TIMER0_BASE)
+#define TIMER1_IOBASE io_p2v(LPC32XX_TIMER1_BASE)
 
 static cycle_t lpc32xx_clksrc_read(struct clocksource *cs)
 {
@@ -141,9 +141,9 @@ static void __init lpc32xx_timer_init(void)
 	   it to compute the PLL frequency and the PCLK divider to get the base
 	   timer rates. This rate is needed to compute the tick rate. */
 	if (clk_is_sysclk_mainosc() != 0)
-		clkrate = MAIN_OSC_FREQ;
+		clkrate = LPC32XX_MAIN_OSC_FREQ;
 	else
-		clkrate = 397 * CLOCK_OSC_FREQ;
+		clkrate = 397 * LPC32XX_CLOCK_OSC_FREQ;
 
 	/* Get ARM HCLKPLL register and convert it into a frequency*/
 	pllreg = readl(CLKPWR_HCLKPLL_CTRL(CLKPWR_IOBASE)) & 0x1FFFF;
-- 
1.6.6
