From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  2 Feb 2010 15:59:22 -0800
Subject: [PATCH 10/16] ARM: LPC32XX: Converted most register types to void
	__iomem *
In-Reply-To: <LPC32XX architecture files (updated)>
References: <LPC32XX architecture files (updated)>
Message-ID: <1265155168-28909-11-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Most defined registers addresses used for readl/writel were untyped.
These have been changed to (void __iomem *).

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/clock.c                 |    2 +-
 arch/arm/mach-lpc32xx/clock.h                 |    2 +-
 arch/arm/mach-lpc32xx/gpiolib.c               |   60 ++-----
 arch/arm/mach-lpc32xx/include/mach/platform.h |  233 +++++++++++++------------
 arch/arm/mach-lpc32xx/pm_events.c             |  161 +++++++++---------
 arch/arm/mach-lpc32xx/serial.c                |    2 +-
 6 files changed, 221 insertions(+), 239 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index befe6fa..1b8616f 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -600,7 +600,7 @@ static struct clk clk_i2c1 = {
 static struct clk clk_i2c2 = {
 	.parent		= &clk_pclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= USB_OTG_IOBASE + 0xFF4,
+	.enable_reg	= (void __iomem *) (USB_OTG_IOBASE + 0xFF4),
 	.enable_mask	= 0x4,
 };
 
diff --git a/arch/arm/mach-lpc32xx/clock.h b/arch/arm/mach-lpc32xx/clock.h
index f37f245..619c332 100644
--- a/arch/arm/mach-lpc32xx/clock.h
+++ b/arch/arm/mach-lpc32xx/clock.h
@@ -34,7 +34,7 @@ struct clk {
 	u32 (*get_rate) (struct clk *clk);
 
 	/* Register address and bit mask for simple clocks */
-	u32 enable_reg;
+	void __iomem *enable_reg;
 	u32 enable_mask;
 };
 
diff --git a/arch/arm/mach-lpc32xx/gpiolib.c b/arch/arm/mach-lpc32xx/gpiolib.c
index beed7eb..13930d4 100644
--- a/arch/arm/mach-lpc32xx/gpiolib.c
+++ b/arch/arm/mach-lpc32xx/gpiolib.c
@@ -89,52 +89,32 @@ static char *gpo_p3_names[LPC32XX_GPO_P3_MAX] = {
 
 static struct gpio_regs gpio_grp_regs[] = {
 	{
-		.inp_state	=
-			(void __iomem *) LPC32XX_GPIO_P0_INP_STATE(GPIOBASE),
-		.outp_set	=
-			(void __iomem *) LPC32XX_GPIO_P0_OUTP_SET(GPIOBASE),
-		.outp_clr	=
-			(void __iomem *) LPC32XX_GPIO_P0_OUTP_CLR(GPIOBASE),
-		.dir_set	=
-			(void __iomem *) LPC32XX_GPIO_P0_DIR_SET(GPIOBASE),
-		.dir_clr	=
-			(void __iomem *) LPC32XX_GPIO_P0_DIR_CLR(GPIOBASE),
+		.inp_state	= LPC32XX_GPIO_P0_INP_STATE(GPIOBASE),
+		.outp_set	= LPC32XX_GPIO_P0_OUTP_SET(GPIOBASE),
+		.outp_clr	= LPC32XX_GPIO_P0_OUTP_CLR(GPIOBASE),
+		.dir_set	= LPC32XX_GPIO_P0_DIR_SET(GPIOBASE),
+		.dir_clr	= LPC32XX_GPIO_P0_DIR_CLR(GPIOBASE),
 	},
 	{
-		.inp_state	=
-			(void __iomem *) LPC32XX_GPIO_P1_INP_STATE(GPIOBASE),
-		.outp_set	=
-			(void __iomem *) LPC32XX_GPIO_P1_OUTP_SET(GPIOBASE),
-		.outp_clr	=
-			(void __iomem *) LPC32XX_GPIO_P1_OUTP_CLR(GPIOBASE),
-		.dir_set	=
-			(void __iomem *) LPC32XX_GPIO_P1_DIR_SET(GPIOBASE),
-		.dir_clr	=
-			(void __iomem *) LPC32XX_GPIO_P1_DIR_CLR(GPIOBASE),
+		.inp_state	= LPC32XX_GPIO_P1_INP_STATE(GPIOBASE),
+		.outp_set	= LPC32XX_GPIO_P1_OUTP_SET(GPIOBASE),
+		.outp_clr	= LPC32XX_GPIO_P1_OUTP_CLR(GPIOBASE),
+		.dir_set	= LPC32XX_GPIO_P1_DIR_SET(GPIOBASE),
+		.dir_clr	= LPC32XX_GPIO_P1_DIR_CLR(GPIOBASE),
 	},
 	{
-		.inp_state	=
-			(void __iomem *) LPC32XX_GPIO_P2_INP_STATE(GPIOBASE),
-		.outp_set	=
-			(void __iomem *) LPC32XX_GPIO_P2_OUTP_SET(GPIOBASE),
-		.outp_clr	=
-			(void __iomem *) LPC32XX_GPIO_P2_OUTP_CLR(GPIOBASE),
-		.dir_set	=
-			(void __iomem *) LPC32XX_GPIO_P2_DIR_SET(GPIOBASE),
-		.dir_clr	=
-			(void __iomem *) LPC32XX_GPIO_P2_DIR_CLR(GPIOBASE),
+		.inp_state	= LPC32XX_GPIO_P2_INP_STATE(GPIOBASE),
+		.outp_set	= LPC32XX_GPIO_P2_OUTP_SET(GPIOBASE),
+		.outp_clr	= LPC32XX_GPIO_P2_OUTP_CLR(GPIOBASE),
+		.dir_set	= LPC32XX_GPIO_P2_DIR_SET(GPIOBASE),
+		.dir_clr	= LPC32XX_GPIO_P2_DIR_CLR(GPIOBASE),
 	},
 	{
-		.inp_state	=
-			(void __iomem *) LPC32XX_GPIO_P3_INP_STATE(GPIOBASE),
-		.outp_set	=
-			(void __iomem *) LPC32XX_GPIO_P3_OUTP_SET(GPIOBASE),
-		.outp_clr	=
-			(void __iomem *) LPC32XX_GPIO_P3_OUTP_CLR(GPIOBASE),
-		.dir_set	=
-			(void __iomem *) LPC32XX_GPIO_P2_DIR_SET(GPIOBASE),
-		.dir_clr	=
-			(void __iomem *) LPC32XX_GPIO_P2_DIR_CLR(GPIOBASE),
+		.inp_state	= LPC32XX_GPIO_P3_INP_STATE(GPIOBASE),
+		.outp_set	= LPC32XX_GPIO_P3_OUTP_SET(GPIOBASE),
+		.outp_clr	= LPC32XX_GPIO_P3_OUTP_CLR(GPIOBASE),
+		.dir_set	= LPC32XX_GPIO_P2_DIR_SET(GPIOBASE),
+		.dir_clr	= LPC32XX_GPIO_P2_DIR_CLR(GPIOBASE),
 	},
 };
 
diff --git a/arch/arm/mach-lpc32xx/include/mach/platform.h b/arch/arm/mach-lpc32xx/include/mach/platform.h
index adc932b..93541f4 100644
--- a/arch/arm/mach-lpc32xx/include/mach/platform.h
+++ b/arch/arm/mach-lpc32xx/include/mach/platform.h
@@ -23,6 +23,8 @@
 #ifndef __ASM_ARCH_PLATFORM_H
 #define __ASM_ARCH_PLATFORM_H
 
+#define IOMEM(x, y)			(__force void __iomem *)((x) + (y))
+
 #define _SBF(f, v)			(((v)) << (f))
 #define _BIT(n)				(1 << (n))
 
@@ -135,54 +137,55 @@
 /*
  * Clock and Power control register offsets
  */
-#define LPC32XX_CLKPWR_DEBUG_CTRL(x)		((x) + 0x000)
-#define LPC32XX_CLKPWR_BOOTMAP(x)		((x) + 0x014)
-#define LPC32XX_CLKPWR_P01_ER(x)		((x) + 0x018)
-#define LPC32XX_CLKPWR_USBCLK_PDIV(x)		((x) + 0x01C)
-#define LPC32XX_CLKPWR_INT_ER(x)		((x) + 0x020)
-#define LPC32XX_CLKPWR_INT_RS(x)		((x) + 0x024)
-#define LPC32XX_CLKPWR_INT_SR(x)		((x) + 0x028)
-#define LPC32XX_CLKPWR_INT_AP(x)		((x) + 0x02C)
-#define LPC32XX_CLKPWR_PIN_ER(x)		((x) + 0x030)
-#define LPC32XX_CLKPWR_PIN_RS(x)		((x) + 0x034)
-#define LPC32XX_CLKPWR_PIN_SR(x)		((x) + 0x038)
-#define LPC32XX_CLKPWR_PIN_AP(x)		((x) + 0x03C)
-#define LPC32XX_CLKPWR_HCLK_DIV(x)		((x) + 0x040)
-#define LPC32XX_CLKPWR_PWR_CTRL(x)		((x) + 0x044)
-#define LPC32XX_CLKPWR_PLL397_CTRL(x)		((x) + 0x048)
-#define LPC32XX_CLKPWR_MAIN_OSC_CTRL(x)		((x) + 0x04C)
-#define LPC32XX_CLKPWR_SYSCLK_CTRL(x)		((x) + 0x050)
-#define LPC32XX_CLKPWR_LCDCLK_CTRL(x)		((x) + 0x054)
-#define LPC32XX_CLKPWR_HCLKPLL_CTRL(x)		((x) + 0x058)
-#define LPC32XX_CLKPWR_ADC_CLK_CTRL_1(x)	((x) + 0x060)
-#define LPC32XX_CLKPWR_USB_CTRL(x)		((x) + 0x064)
-#define LPC32XX_CLKPWR_SDRAMCLK_CTRL(x)		((x) + 0x068)
-#define LPC32XX_CLKPWR_DDR_LAP_NOM(x)		((x) + 0x06C)
-#define LPC32XX_CLKPWR_DDR_LAP_COUNT(x)		((x) + 0x070)
-#define LPC32XX_CLKPWR_DDR_LAP_DELAY(x)		((x) + 0x074)
-#define LPC32XX_CLKPWR_SSP_CLK_CTRL(x)		((x) + 0x078)
-#define LPC32XX_CLKPWR_I2S_CLK_CTRL(x)		((x) + 0x07C)
-#define LPC32XX_CLKPWR_MS_CTRL(x)		((x) + 0x080)
-#define LPC32XX_CLKPWR_MACCLK_CTRL(x)		((x) + 0x090)
-#define LPC32XX_CLKPWR_TEST_CLK_SEL(x)		((x) + 0x0A4)
-#define LPC32XX_CLKPWR_SFW_INT(x)		((x) + 0x0A8)
-#define LPC32XX_CLKPWR_I2C_CLK_CTRL(x)		((x) + 0x0AC)
-#define LPC32XX_CLKPWR_KEY_CLK_CTRL(x)		((x) + 0x0B0)
-#define LPC32XX_CLKPWR_ADC_CLK_CTRL(x)		((x) + 0x0B4)
-#define LPC32XX_CLKPWR_PWM_CLK_CTRL(x)		((x) + 0x0B8)
-#define LPC32XX_CLKPWR_TIMER_CLK_CTRL(x)	((x) + 0x0BC)
-#define LPC32XX_CLKPWR_TIMERS_PWMS_CLK_CTRL_1(x) ((x) + 0x0C0)
-#define LPC32XX_CLKPWR_SPI_CLK_CTRL(x)		((x) + 0x0C4)
-#define LPC32XX_CLKPWR_NAND_CLK_CTRL(x)		((x) + 0x0C8)
-#define LPC32XX_CLKPWR_UART3_CLK_CTRL(x)	((x) + 0x0D0)
-#define LPC32XX_CLKPWR_UART4_CLK_CTRL(x)	((x) + 0x0D4)
-#define LPC32XX_CLKPWR_UART5_CLK_CTRL(x)	((x) + 0x0D8)
-#define LPC32XX_CLKPWR_UART6_CLK_CTRL(x)	((x) + 0x0DC)
-#define LPC32XX_CLKPWR_IRDA_CLK_CTRL(x)		((x) + 0x0E0)
-#define LPC32XX_CLKPWR_UART_CLK_CTRL(x)		((x) + 0x0E4)
-#define LPC32XX_CLKPWR_DMA_CLK_CTRL(x)		((x) + 0x0E8)
-#define LPC32XX_CLKPWR_AUTOCLOCK(x)		((x) + 0x0EC)
-#define LPC32XX_CLKPWR_DEVID(x, y)		((x) + 0x130 + (y))
+#define LPC32XX_CLKPWR_DEBUG_CTRL(x)		IOMEM((x), 0x000)
+#define LPC32XX_CLKPWR_BOOTMAP(x)		IOMEM((x), 0x014)
+#define LPC32XX_CLKPWR_P01_ER(x)		IOMEM((x), 0x018)
+#define LPC32XX_CLKPWR_USBCLK_PDIV(x)		IOMEM((x), 0x01C)
+#define LPC32XX_CLKPWR_INT_ER(x)		IOMEM((x), 0x020)
+#define LPC32XX_CLKPWR_INT_RS(x)		IOMEM((x), 0x024)
+#define LPC32XX_CLKPWR_INT_SR(x)		IOMEM((x), 0x028)
+#define LPC32XX_CLKPWR_INT_AP(x)		IOMEM((x), 0x02C)
+#define LPC32XX_CLKPWR_PIN_ER(x)		IOMEM((x), 0x030)
+#define LPC32XX_CLKPWR_PIN_RS(x)		IOMEM((x), 0x034)
+#define LPC32XX_CLKPWR_PIN_SR(x)		IOMEM((x), 0x038)
+#define LPC32XX_CLKPWR_PIN_AP(x)		IOMEM((x), 0x03C)
+#define LPC32XX_CLKPWR_HCLK_DIV(x)		IOMEM((x), 0x040)
+#define LPC32XX_CLKPWR_PWR_CTRL(x)		IOMEM((x), 0x044)
+#define LPC32XX_CLKPWR_PLL397_CTRL(x)		IOMEM((x), 0x048)
+#define LPC32XX_CLKPWR_MAIN_OSC_CTRL(x)		IOMEM((x), 0x04C)
+#define LPC32XX_CLKPWR_SYSCLK_CTRL(x)		IOMEM((x), 0x050)
+#define LPC32XX_CLKPWR_LCDCLK_CTRL(x)		IOMEM((x), 0x054)
+#define LPC32XX_CLKPWR_HCLKPLL_CTRL(x)		IOMEM((x), 0x058)
+#define LPC32XX_CLKPWR_ADC_CLK_CTRL_1(x)	IOMEM((x), 0x060)
+#define LPC32XX_CLKPWR_USB_CTRL(x)		IOMEM((x), 0x064)
+#define LPC32XX_CLKPWR_SDRAMCLK_CTRL(x)		IOMEM((x), 0x068)
+#define LPC32XX_CLKPWR_DDR_LAP_NOM(x)		IOMEM((x), 0x06C)
+#define LPC32XX_CLKPWR_DDR_LAP_COUNT(x)		IOMEM((x), 0x070)
+#define LPC32XX_CLKPWR_DDR_LAP_DELAY(x)		IOMEM((x), 0x074)
+#define LPC32XX_CLKPWR_SSP_CLK_CTRL(x)		IOMEM((x), 0x078)
+#define LPC32XX_CLKPWR_I2S_CLK_CTRL(x)		IOMEM((x), 0x07C)
+#define LPC32XX_CLKPWR_MS_CTRL(x)		IOMEM((x), 0x080)
+#define LPC32XX_CLKPWR_MACCLK_CTRL(x)		IOMEM((x), 0x090)
+#define LPC32XX_CLKPWR_TEST_CLK_SEL(x)		IOMEM((x), 0x0A4)
+#define LPC32XX_CLKPWR_SFW_INT(x)		IOMEM((x), 0x0A8)
+#define LPC32XX_CLKPWR_I2C_CLK_CTRL(x)		IOMEM((x), 0x0AC)
+#define LPC32XX_CLKPWR_KEY_CLK_CTRL(x)		IOMEM((x), 0x0B0)
+#define LPC32XX_CLKPWR_ADC_CLK_CTRL(x)		IOMEM((x), 0x0B4)
+#define LPC32XX_CLKPWR_PWM_CLK_CTRL(x)		IOMEM((x), 0x0B8)
+#define LPC32XX_CLKPWR_TIMER_CLK_CTRL(x)	IOMEM((x), 0x0BC)
+#define LPC32XX_CLKPWR_TIMERS_PWMS_CLK_CTRL_1(x) IOMEM((x), 0x0C0)
+#define LPC32XX_CLKPWR_SPI_CLK_CTRL(x)		IOMEM((x), 0x0C4)
+#define LPC32XX_CLKPWR_NAND_CLK_CTRL(x)		IOMEM((x), 0x0C8)
+#define LPC32XX_CLKPWR_UART3_CLK_CTRL(x)	IOMEM((x), 0x0D0)
+#define LPC32XX_CLKPWR_UART4_CLK_CTRL(x)	IOMEM((x), 0x0D4)
+#define LPC32XX_CLKPWR_UART5_CLK_CTRL(x)	IOMEM((x), 0x0D8)
+#define LPC32XX_CLKPWR_UART6_CLK_CTRL(x)	IOMEM((x), 0x0DC)
+#define LPC32XX_CLKPWR_IRDA_CLK_CTRL(x)		IOMEM((x), 0x0E0)
+#define LPC32XX_CLKPWR_UART_CLK_CTRL(x)		IOMEM((x), 0x0E4)
+#define LPC32XX_CLKPWR_DMA_CLK_CTRL(x)		IOMEM((x), 0x0E8)
+#define LPC32XX_CLKPWR_AUTOCLOCK(x)		IOMEM((x), 0x0EC)
+#define LPC32XX_CLKPWR_DEVID(x, y)		(__force void __iomem *)\
+						((x) + 0x130 + (y))
 
 /*
  * clkpwr_debug_ctrl register definitions
@@ -600,23 +603,23 @@
  * Timer/counter register offsets
  *
  */
-#define LCP32XX_TIMER_IR(x)			((x) + 0x00)
-#define LCP32XX_TIMER_TCR(x)			((x) + 0x04)
-#define LCP32XX_TIMER_TC(x)			((x) + 0x08)
-#define LCP32XX_TIMER_PR(x)			((x) + 0x0C)
-#define LCP32XX_TIMER_PC(x)			((x) + 0x10)
-#define LCP32XX_TIMER_MCR(x)			((x) + 0x14)
-#define LCP32XX_TIMER_MR0(x)			((x) + 0x18)
-#define LCP32XX_TIMER_MR1(x)			((x) + 0x1C)
-#define LCP32XX_TIMER_MR2(x)			((x) + 0x20)
-#define LCP32XX_TIMER_MR3(x)			((x) + 0x24)
-#define LCP32XX_TIMER_CCR(x)			((x) + 0x28)
-#define LCP32XX_TIMER_CR0(x)			((x) + 0x2C)
-#define LCP32XX_TIMER_CR1(x)			((x) + 0x30)
-#define LCP32XX_TIMER_CR2(x)			((x) + 0x34)
-#define LCP32XX_TIMER_CR3(x)			((x) + 0x38)
-#define LCP32XX_TIMER_EMR(x)			((x) + 0x3C)
-#define LCP32XX_TIMER_CTCR(x)			((x) + 0x70)
+#define LCP32XX_TIMER_IR(x)			IOMEM((x), 0x00)
+#define LCP32XX_TIMER_TCR(x)			IOMEM((x), 0x04)
+#define LCP32XX_TIMER_TC(x)			IOMEM((x), 0x08)
+#define LCP32XX_TIMER_PR(x)			IOMEM((x), 0x0C)
+#define LCP32XX_TIMER_PC(x)			IOMEM((x), 0x10)
+#define LCP32XX_TIMER_MCR(x)			IOMEM((x), 0x14)
+#define LCP32XX_TIMER_MR0(x)			IOMEM((x), 0x18)
+#define LCP32XX_TIMER_MR1(x)			IOMEM((x), 0x1C)
+#define LCP32XX_TIMER_MR2(x)			IOMEM((x), 0x20)
+#define LCP32XX_TIMER_MR3(x)			IOMEM((x), 0x24)
+#define LCP32XX_TIMER_CCR(x)			IOMEM((x), 0x28)
+#define LCP32XX_TIMER_CR0(x)			IOMEM((x), 0x2C)
+#define LCP32XX_TIMER_CR1(x)			IOMEM((x), 0x30)
+#define LCP32XX_TIMER_CR2(x)			IOMEM((x), 0x34)
+#define LCP32XX_TIMER_CR3(x)			IOMEM((x), 0x38)
+#define LCP32XX_TIMER_EMR(x)			IOMEM((x), 0x3C)
+#define LCP32XX_TIMER_CTCR(x)			IOMEM((x), 0x70)
 
 /*
  * ir register definitions
@@ -642,23 +645,23 @@
  * Standard UART register offsets
  *
  */
-#define LPC32XX_UART_DLL_FIFO(x)		((x) + 0x00)
-#define LPC32XX_UART_DLM_IER(x)			((x) + 0x04)
-#define LPC32XX_UART_IIR_FCR(x)			((x) + 0x08)
-#define LPC32XX_UART_LCR_(x)			((x) + 0x0C)
-#define LPC32XX_UART_MODEM_CTRL(x)		((x) + 0x10)
-#define LPC32XX_UART_LSR_(x)			((x) + 0x14)
-#define LPC32XX_UART_MODEM_STATUS(x)		((x) + 0x18)
-#define LPC32XX_UART_RXLEV(x)			((x) + 0x1C)
+#define LPC32XX_UART_DLL_FIFO(x)		IOMEM((x), 0x00)
+#define LPC32XX_UART_DLM_IER(x)			IOMEM((x), 0x04)
+#define LPC32XX_UART_IIR_FCR(x)			IOMEM((x), 0x08)
+#define LPC32XX_UART_LCR_(x)			IOMEM((x), 0x0C)
+#define LPC32XX_UART_MODEM_CTRL(x)		IOMEM((x), 0x10)
+#define LPC32XX_UART_LSR_(x)			IOMEM((x), 0x14)
+#define LPC32XX_UART_MODEM_STATUS(x)		IOMEM((x), 0x18)
+#define LPC32XX_UART_RXLEV(x)			IOMEM((x), 0x1C)
 
 /*
  *
  * UART control structure offsets
  *
  */
-#define LPC32XX_UARTCTL_CTRL(x)			((x) + 0x00)
-#define LPC32XX_UARTCTL_CLKMODE(x)		((x) + 0x04)
-#define LPC32XX_UARTCTL_CLOOP(x)		((x) + 0x08)
+#define LPC32XX_UARTCTL_CTRL(x)			IOMEM((x), 0x00)
+#define LPC32XX_UARTCTL_CLKMODE(x)		IOMEM((x), 0x04)
+#define LPC32XX_UARTCTL_CLOOP(x)		IOMEM((x), 0x08)
 
 /*
  * ctrl register definitions
@@ -690,44 +693,44 @@
  * GPIO Module Register offsets
  *
  */
-#define LPC32XX_GPIO_P3_INP_STATE(x)		((x) + 0x000)
-#define LPC32XX_GPIO_P3_OUTP_SET(x)		((x) + 0x004)
-#define LPC32XX_GPIO_P3_OUTP_CLR(x)		((x) + 0x008)
-#define LPC32XX_GPIO_P3_OUTP_STATE(x)		((x) + 0x00C)
-#define LPC32XX_GPIO_P2_DIR_SET(x)		((x) + 0x010)
-#define LPC32XX_GPIO_P2_DIR_CLR(x)		((x) + 0x014)
-#define LPC32XX_GPIO_P2_DIR_STATE(x)		((x) + 0x018)
-#define LPC32XX_GPIO_P2_INP_STATE(x)		((x) + 0x01C)
-#define LPC32XX_GPIO_P2_OUTP_SET(x)		((x) + 0x020)
-#define LPC32XX_GPIO_P2_OUTP_CLR(x)		((x) + 0x024)
-#define LPC32XX_GPIO_P2_MUX_SET(x)		((x) + 0x028)
-#define LPC32XX_GPIO_P2_MUX_CLR(x)		((x) + 0x02C)
-#define LPC32XX_GPIO_P2_MUX_STATE(x)		((x) + 0x030)
-#define LPC32XX_GPIO_P0_INP_STATE(x)		((x) + 0x040)
-#define LPC32XX_GPIO_P0_OUTP_SET(x)		((x) + 0x044)
-#define LPC32XX_GPIO_P0_OUTP_CLR(x)		((x) + 0x048)
-#define LPC32XX_GPIO_P0_OUTP_STATE(x)		((x) + 0x04C)
-#define LPC32XX_GPIO_P0_DIR_SET(x)		((x) + 0x050)
-#define LPC32XX_GPIO_P0_DIR_CLR(x)		((x) + 0x054)
-#define LPC32XX_GPIO_P0_DIR_STATE(x)		((x) + 0x058)
-#define LPC32XX_GPIO_P1_INP_STATE(x)		((x) + 0x060)
-#define LPC32XX_GPIO_P1_OUTP_SET(x)		((x) + 0x064)
-#define LPC32XX_GPIO_P1_OUTP_CLR(x)		((x) + 0x068)
-#define LPC32XX_GPIO_P1_OUTP_STATE(x)		((x) + 0x06C)
-#define LPC32XX_GPIO_P1_DIR_SET(x)		((x) + 0x070)
-#define LPC32XX_GPIO_P1_DIR_CLR(x)		((x) + 0x074)
-#define LPC32XX_GPIO_P1_DIR_STATE(x)		((x) + 0x078)
-#define LPC32XX_GPIO_P_MUX_SET(x)		((x) + 0x100)
-#define LPC32XX_GPIO_P_MUX_CLR(x)		((x) + 0x104)
-#define LPC32XX_GPIO_P_MUX_STATE(x)		((x) + 0x108)
-#define LPC32XX_GPIO_P3_MUX_SET(x)		((x) + 0x110)
-#define LPC32XX_GPIO_P3_MUX_CLR(x)		((x) + 0x114)
-#define LPC32XX_GPIO_P3_MUX_STATE(x)		((x) + 0x118)
-#define LPC32XX_GPIO_P0_MUX_SET(x)		((x) + 0x120)
-#define LPC32XX_GPIO_P0_MUX_CLR(x)		((x) + 0x124)
-#define LPC32XX_GPIO_P0_MUX_STATE(x)		((x) + 0x128)
-#define LPC32XX_GPIO_P1_MUX_SET(x)		((x) + 0x130)
-#define LPC32XX_GPIO_P1_MUX_CLR(x)		((x) + 0x134)
-#define LPC32XX_GPIO_P1_MUX_STATE(x)		((x) + 0x138)
+#define LPC32XX_GPIO_P3_INP_STATE(x)		IOMEM((x), 0x000)
+#define LPC32XX_GPIO_P3_OUTP_SET(x)		IOMEM((x), 0x004)
+#define LPC32XX_GPIO_P3_OUTP_CLR(x)		IOMEM((x), 0x008)
+#define LPC32XX_GPIO_P3_OUTP_STATE(x)		IOMEM((x), 0x00C)
+#define LPC32XX_GPIO_P2_DIR_SET(x)		IOMEM((x), 0x010)
+#define LPC32XX_GPIO_P2_DIR_CLR(x)		IOMEM((x), 0x014)
+#define LPC32XX_GPIO_P2_DIR_STATE(x)		IOMEM((x), 0x018)
+#define LPC32XX_GPIO_P2_INP_STATE(x)		IOMEM((x), 0x01C)
+#define LPC32XX_GPIO_P2_OUTP_SET(x)		IOMEM((x), 0x020)
+#define LPC32XX_GPIO_P2_OUTP_CLR(x)		IOMEM((x), 0x024)
+#define LPC32XX_GPIO_P2_MUX_SET(x)		IOMEM((x), 0x028)
+#define LPC32XX_GPIO_P2_MUX_CLR(x)		IOMEM((x), 0x02C)
+#define LPC32XX_GPIO_P2_MUX_STATE(x)		IOMEM((x), 0x030)
+#define LPC32XX_GPIO_P0_INP_STATE(x)		IOMEM((x), 0x040)
+#define LPC32XX_GPIO_P0_OUTP_SET(x)		IOMEM((x), 0x044)
+#define LPC32XX_GPIO_P0_OUTP_CLR(x)		IOMEM((x), 0x048)
+#define LPC32XX_GPIO_P0_OUTP_STATE(x)		IOMEM((x), 0x04C)
+#define LPC32XX_GPIO_P0_DIR_SET(x)		IOMEM((x), 0x050)
+#define LPC32XX_GPIO_P0_DIR_CLR(x)		IOMEM((x), 0x054)
+#define LPC32XX_GPIO_P0_DIR_STATE(x)		IOMEM((x), 0x058)
+#define LPC32XX_GPIO_P1_INP_STATE(x)		IOMEM((x), 0x060)
+#define LPC32XX_GPIO_P1_OUTP_SET(x)		IOMEM((x), 0x064)
+#define LPC32XX_GPIO_P1_OUTP_CLR(x)		IOMEM((x), 0x068)
+#define LPC32XX_GPIO_P1_OUTP_STATE(x)		IOMEM((x), 0x06C)
+#define LPC32XX_GPIO_P1_DIR_SET(x)		IOMEM((x), 0x070)
+#define LPC32XX_GPIO_P1_DIR_CLR(x)		IOMEM((x), 0x074)
+#define LPC32XX_GPIO_P1_DIR_STATE(x)		IOMEM((x), 0x078)
+#define LPC32XX_GPIO_P_MUX_SET(x)		IOMEM((x), 0x100)
+#define LPC32XX_GPIO_P_MUX_CLR(x)		IOMEM((x), 0x104)
+#define LPC32XX_GPIO_P_MUX_STATE(x)		IOMEM((x), 0x108)
+#define LPC32XX_GPIO_P3_MUX_SET(x)		IOMEM((x), 0x110)
+#define LPC32XX_GPIO_P3_MUX_CLR(x)		IOMEM((x), 0x114)
+#define LPC32XX_GPIO_P3_MUX_STATE(x)		IOMEM((x), 0x118)
+#define LPC32XX_GPIO_P0_MUX_SET(x)		IOMEM((x), 0x120)
+#define LPC32XX_GPIO_P0_MUX_CLR(x)		IOMEM((x), 0x124)
+#define LPC32XX_GPIO_P0_MUX_STATE(x)		IOMEM((x), 0x128)
+#define LPC32XX_GPIO_P1_MUX_SET(x)		IOMEM((x), 0x130)
+#define LPC32XX_GPIO_P1_MUX_CLR(x)		IOMEM((x), 0x134)
+#define LPC32XX_GPIO_P1_MUX_STATE(x)		IOMEM((x), 0x138)
 
 #endif
diff --git a/arch/arm/mach-lpc32xx/pm_events.c b/arch/arm/mach-lpc32xx/pm_events.c
index ffd46c4..835207d 100644
--- a/arch/arm/mach-lpc32xx/pm_events.c
+++ b/arch/arm/mach-lpc32xx/pm_events.c
@@ -30,306 +30,306 @@
 #include "pm.h"
 
 struct lpc32xx_event_info {
-	u32 offs;
+	void __iomem *reg;
 	u32 mask;
 };
 
 static const struct lpc32xx_event_info events[LPC32XX_LAST_EVENT + 1] = {
 	[LPC32XX_WKUP_GPI_08] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O8_BIT,
 	},
 	[LPC32XX_WKUP_GPI_09] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O9_BIT,
 	},
 	[LPC32XX_WKUP_GPI_19] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_19_BIT,
 	},
 	[LPC32XX_WKUP_SPI2_DATIN] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_SPI2_DATIN_BIT,
 	},
 	[LPC32XX_WKUP_GPI_07] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O7_BIT,
 	},
 	[LPC32XX_WKUP_SPI1_DATIN] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_SPI1_DATIN_BIT,
 	},
 	[LPC32XX_WKUP_SYSCLKEN] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_SYSCLKEN_BIT,
 	},
 	[LPC32XX_WKUP_GPI00] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O0_BIT,
 	},
 	[LPC32XX_WKUP_GPI01] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O1_BIT,
 	},
 	[LPC32XX_WKUP_GPI02] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O2_BIT,
 	},
 	[LPC32XX_WKUP_GPI03] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O3_BIT,
 	},
 	[LPC32XX_WKUP_GPI04] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O4_BIT,
 	},
 	[LPC32XX_WKUP_GPI05] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O5_BIT,
 	},
 	[LPC32XX_WKUP_GPI06] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O6_BIT,
 	},
 	[LPC32XX_WKUP_MSDIO_START] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_MSDIO_SRT_BIT,
 	},
 	[LPC32XX_WKUP_SDIO_INT_N] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_MSDIO_INT_BIT,
 	},
 	[LPC32XX_WKUP_U1_RX] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_U1_RX_BIT,
 	},
 	[LPC32XX_WKUP_U2_RX] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_U2_RX_BIT,
 	},
 	[LPC32XX_WKUP_U2_HCTS] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_U2_HCTS_BIT,
 	},
 	[LPC32XX_WKUP_U3_RX] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_U3_RX_BIT,
 	},
 	[LPC32XX_WKUP_GPI_28] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_11_BIT,
 	},
 	[LPC32XX_WKUP_U5_RX] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_U5_RX_BIT,
 	},
 	[LPC32XX_WKUP_U6_IRRX] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_U6_IRRX_BIT,
 	},
 	[LPC32XX_WKUP_U7_HCTS] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_U7_HCTS_BIT,
 	},
 	[LPC32XX_WKUP_U7_RX] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_EXTSRC_U7_RX_BIT,
 	},
 
 	[LPC32XX_WKUP_GPIO_00] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_00_BIT,
 	},
 	[LPC32XX_WKUP_GPIO_01] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_01_BIT,
 	},
 	[LPC32XX_WKUP_GPIO_02] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_02_BIT,
 	},
 	[LPC32XX_WKUP_GPIO_03] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_03_BIT,
 	},
 	[LPC32XX_WKUP_GPIO_04] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_04_BIT,
 	},
 	[LPC32XX_WKUP_GPIO_05] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_05_BIT,
 	},
 	[LPC32XX_WKUP_P0_P1_ALL] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_P0P1_BIT,
 	},
 	[LPC32XX_WKUP_MAC_START] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_MAC_BIT,
 	},
 	[LPC32XX_WKUP_KEY_IRQ] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_KEY_BIT,
 	},
 	[LPC32XX_WKUP_USB_OTG_ATX_INT_N] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_USBATXINT_BIT,
 	},
 	[LPC32XX_WKUP_USB_OTG_TIMER] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_USBOTGTIMER_BIT,
 	},
 	[LPC32XX_WKUP_USB_I2C_INT] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_I2C_BIT,
 	},
 	[LPC32XX_WKUP_USB_INT] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_USB_BIT,
 	},
 	[LPC32XX_WKUP_USB_NEED_CLK] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_USBNEEDCLK_BIT,
 	},
 	[LPC32XX_WKUP_RTC_INT] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_RTC_BIT,
 	},
 	[LPC32XX_WKUP_MSTIMER_INT] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_MSTIMER_BIT,
 	},
 	[LPC32XX_WKUP_USB_AHC_NEED_CLK] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_USBAHNEEDCLK_BIT,
 	},
 	[LPC32XX_WKUP_TS_AUX_INT] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_TS_AUX_BIT,
 	},
 	[LPC32XX_WKUP_TS_P_INT] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_TS_P_BIT,
 	},
 	[LPC32XX_WKUP_TS_INT] = {
-		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.reg = LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_INTSRC_ADC_BIT,
 	},
 	[LPC32XX_WKUP_P0_0] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO0_BIT,
 	},
 	[LPC32XX_WKUP_P0_1] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO1_BIT,
 	},
 	[LPC32XX_WKUP_P0_2] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO2_BIT,
 	},
 	[LPC32XX_WKUP_P0_3] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO3_BIT,
 	},
 	[LPC32XX_WKUP_P0_4] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO4_BIT,
 	},
 	[LPC32XX_WKUP_P0_5] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO5_BIT,
 	},
 	[LPC32XX_WKUP_P0_6] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO6_BIT,
 	},
 	[LPC32XX_WKUP_P0_7] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO7_BIT,
 	},
 	[LPC32XX_WKUP_P1_3] = {
-		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO3_BIT,
 	},
 	[LPC32XX_WKUP_P1_4] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO4_BIT,
 	},
 	[LPC32XX_WKUP_P1_5] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO5_BIT,
 	},
 	[LPC32XX_WKUP_P1_6] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO6_BIT,
 	},
 	[LPC32XX_WKUP_P1_7] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO7_BIT,
 	},
 	[LPC32XX_WKUP_P1_8] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO8_BIT,
 	},
 	[LPC32XX_WKUP_P1_9] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO9_BIT,
 	},
 	[LPC32XX_WKUP_P1_10] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO10_BIT,
 	},
 	[LPC32XX_WKUP_P1_11] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO11_BIT,
 	},
 	[LPC32XX_WKUP_P1_12] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO12_BIT,
 	},
 	[LPC32XX_WKUP_P1_13] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO13_BIT,
 	},
 	[LPC32XX_WKUP_P1_14] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO14_BIT,
 	},
 	[LPC32XX_WKUP_P1_15] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO15_BIT,
 	},
 	[LPC32XX_WKUP_P1_16] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO16_BIT,
 	},
 	[LPC32XX_WKUP_P1_17] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO17_BIT,
 	},
 	[LPC32XX_WKUP_P1_18] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO18_BIT,
 	},
 	[LPC32XX_WKUP_P1_19] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO19_BIT,
 	},
 	[LPC32XX_WKUP_P1_20] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO20_BIT,
 	},
 	[LPC32XX_WKUP_P1_21] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO21_BIT,
 	},
 	[LPC32XX_WKUP_P1_22] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO22_BIT,
 	},
 	[LPC32XX_WKUP_P1_23] = {
-		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.reg = LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE),
 		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO23_BIT,
 	},
 };
@@ -360,14 +360,14 @@ void lpc32xx_event_init(void)
 
 void lpc32xx_event_enable(enum lpc32xx_events event_id)
 {
-	writel(readl(CLKPWR_IOBASE + events[event_id].offs) |
-		events[event_id].mask, CLKPWR_IOBASE + events[event_id].offs);
+	writel(readl(events[event_id].reg) | events[event_id].mask,
+		events[event_id].reg);
 }
 
 void lpc32xx_event_disable(enum lpc32xx_events event_id)
 {
-	writel(readl(CLKPWR_IOBASE + events[event_id].offs) &
-		~events[event_id].mask, CLKPWR_IOBASE + events[event_id].offs);
+	writel(readl(events[event_id].reg) & ~events[event_id].mask,
+		events[event_id].reg);
 }
 
 extern int lpc32xx_event_set(enum lpc32xx_events event_id,
@@ -403,8 +403,7 @@ int lpc32xx_event_enabled(enum lpc32xx_events event_id)
 {
 	u32 tmp;
 
-	tmp = readl(CLKPWR_IOBASE + events[event_id].offs) &
-		events[event_id].mask;
+	tmp = readl(events[event_id].reg) & events[event_id].mask;
 
 	return (tmp != 0);
 }
diff --git a/arch/arm/mach-lpc32xx/serial.c b/arch/arm/mach-lpc32xx/serial.c
index 3a0acfd..a2b8e12 100644
--- a/arch/arm/mach-lpc32xx/serial.c
+++ b/arch/arm/mach-lpc32xx/serial.c
@@ -90,7 +90,7 @@ static struct plat_serial8250_port serial_std_platform_data[] = {
 struct uartinit {
 	char *uart_ck_name;
 	u32 ck_mode_mask;
-	u32 pdiv_clk_reg;
+	void __iomem *pdiv_clk_reg;
 };
 
 static struct uartinit uartinit_data[] __initdata = {
-- 
1.6.6
