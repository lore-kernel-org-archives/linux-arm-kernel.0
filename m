From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  2 Feb 2010 15:59:25 -0800
Subject: [PATCH 13/16] ARM: LPC32XX: Various fixes with readl/writel types
In-Reply-To: <LPC32XX architecture files (updated)>
References: <LPC32XX architecture files (updated)>
Message-ID: <1265155168-28909-14-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Fixed types used for readl/writel that would generate sparse
warnings.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/clock.c   |   12 +++++++-----
 arch/arm/mach-lpc32xx/phy3250.c |   16 +++++++++-------
 arch/arm/mach-lpc32xx/pm.c      |    6 +++---
 arch/arm/mach-lpc32xx/serial.c  |   14 +++++++++-----
 4 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 1b8616f..e51e801 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -102,6 +102,8 @@
 #include "clock.h"
 #include "common.h"
 
+#define LCD_REG(x) (__force void __iomem *) (io_p2v(LPC32XX_LCD_BASE) + (x))
+
 static struct clk clk_armpll;
 static struct clk clk_usbpll;
 
@@ -600,7 +602,7 @@ static struct clk clk_i2c1 = {
 static struct clk clk_i2c2 = {
 	.parent		= &clk_pclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= (void __iomem *) (USB_OTG_IOBASE + 0xFF4),
+	.enable_reg	= (__force void __iomem *) (USB_OTG_IOBASE + 0xFF4),
 	.enable_mask	= 0x4,
 };
 
@@ -761,7 +763,7 @@ static u32 clcd_get_rate(struct clk *clk)
 		return 0;
 
 	rate = clk_get_rate(clk->parent);
-	tmp = readl((io_p2v(LPC32XX_LCD_BASE)) + CLCD_TIM2);
+	tmp = readl(LCD_REG(CLCD_TIM2));
 
 	/* Only supports internal clocking */
 	if (tmp & TIM2_BCD)
@@ -777,7 +779,7 @@ static int clcd_set_rate(struct clk *clk, u32 rate)
 {
 	u32 tmp, prate, div;
 
-	tmp = readl((io_p2v(LPC32XX_LCD_BASE)) + CLCD_TIM2);
+	tmp = readl(LCD_REG(CLCD_TIM2));
 	prate = clk_get_rate(clk->parent);
 
 	if (rate == prate) {
@@ -795,7 +797,7 @@ static int clcd_set_rate(struct clk *clk, u32 rate)
 		tmp &= ~TIM2_BCD;
 		tmp |= (div & 0x1F);
 		tmp |= (((div >> 5) & 0x1F) << 27);
-		writel(tmp, ((io_p2v(LPC32XX_LCD_BASE)) + CLCD_TIM2));
+		writel(tmp, LCD_REG(CLCD_TIM2));
 		local_onoff_enable(clk, 1);
 	}
 
@@ -1000,7 +1002,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("lpc32xx_rtc", NULL, clk_rtc)
 };
 
-int __init clk_init(void)
+static int __init clk_init(void)
 {
 	int i;
 
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 80958b9..bd59aa9 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -85,17 +85,18 @@ static int lpc32xx_clcd_setup(struct clcd_fb *fb)
 {
 	dma_addr_t dma;
 
-	fb->fb.screen_base = (void *) NULL;
+	fb->fb.screen_base = (char __iomem *) NULL;
 #ifdef CONFIG_MACH_LPC32XX_IRAM_FOR_CLCD
 	if (PANEL_SIZE <= CONFIG_ARCH_LPC32XX_IRAM_SIZE) {
-		fb->fb.screen_base = (void *) io_p2v(LPC32XX_IRAM_BASE);
+		fb->fb.screen_base = (char __iomem *) io_p2v(LPC32XX_IRAM_BASE);
 		fb->fb.fix.smem_start = (dma_addr_t) LPC32XX_IRAM_BASE;
 	}
 #endif
 
 	if (fb->fb.screen_base == NULL) {
-		fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev,
-			PANEL_SIZE, &dma, GFP_KERNEL);
+		fb->fb.screen_base = (__force char __iomem *)
+			dma_alloc_writecombine(&fb->dev->dev, PANEL_SIZE,
+			&dma, GFP_KERNEL);
 		fb->fb.fix.smem_start = dma;
 	}
 
@@ -130,7 +131,7 @@ static int lpc32xx_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
 #endif
 
 	return dma_mmap_writecombine(&fb->dev->dev, vma,
-				     fb->fb.screen_base,
+				     (__force void *) fb->fb.screen_base,
 				     fb->fb.fix.smem_start,
 				     fb->fb.fix.smem_len);
 }
@@ -140,11 +141,12 @@ static void lpc32xx_clcd_remove(struct clcd_fb *fb)
 #ifdef CONFIG_MACH_LPC32XX_IRAM_FOR_CLCD
 	if (PANEL_SIZE > CONFIG_ARCH_LPC32XX_IRAM_SIZE)
 		dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
-			fb->fb.screen_base, fb->fb.fix.smem_start);
+			(__force void *) fb->fb.screen_base,
+			fb->fb.fix.smem_start);
 
 #else
 	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
-		fb->fb.screen_base, fb->fb.fix.smem_start);
+		(__force void *) fb->fb.screen_base, fb->fb.fix.smem_start);
 #endif
 }
 
diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
index 5f0a805..0be1a47 100644
--- a/arch/arm/mach-lpc32xx/pm.c
+++ b/arch/arm/mach-lpc32xx/pm.c
@@ -146,13 +146,13 @@ static struct platform_suspend_ops lpc32xx_pm_ops = {
 
 #define EMC_DYN_MEM_CTRL_OFS 0x20
 #define EMC_SRMMC           (1 << 3)
-
+#define EMC_CTRL_REG (__force void __iomem *)\
+	(io_p2v(LPC32XX_EMC_BASE) + EMC_DYN_MEM_CTRL_OFS)
 static int __init lpc32xx_pm_init(void)
 {
 	/* Setup SDRAM self-refresh clock to automatically
 	   disable on start of self-refresh */
-	writel(readl(io_p2v(LPC32XX_EMC_BASE) + EMC_DYN_MEM_CTRL_OFS) |
-		EMC_SRMMC, io_p2v(LPC32XX_EMC_BASE) + EMC_DYN_MEM_CTRL_OFS);
+	writel(readl(EMC_CTRL_REG) | EMC_SRMMC, EMC_CTRL_REG);
 
 	/* Allocate some space for temporary IRAM storage */
 	iram_swap_area = kmalloc(lpc32xx_sys_suspend_sz, GFP_ATOMIC);
diff --git a/arch/arm/mach-lpc32xx/serial.c b/arch/arm/mach-lpc32xx/serial.c
index a2b8e12..96d6d1b 100644
--- a/arch/arm/mach-lpc32xx/serial.c
+++ b/arch/arm/mach-lpc32xx/serial.c
@@ -38,7 +38,8 @@
 static struct plat_serial8250_port serial_std_platform_data[] = {
 #ifdef CONFIG_ARCH_LPC32XX_UART5_ENABLE
 	{
-		.membase        = (void *) io_p2v(LPC32XX_UART5_BASE),
+		.membase        =
+			(__force void __iomem *) io_p2v(LPC32XX_UART5_BASE),
 		.mapbase        = LPC32XX_UART5_BASE,
 		.irq		= IRQ_UART_IIR5,
 		.uartclk	= LPC32XX_MAIN_OSC_FREQ,
@@ -50,7 +51,8 @@ static struct plat_serial8250_port serial_std_platform_data[] = {
 #endif
 #ifdef CONFIG_ARCH_LPC32XX_UART3_ENABLE
 	{
-		.membase	= (void *) io_p2v(LPC32XX_UART3_BASE),
+		.membase	=
+			(__force void __iomem *) io_p2v(LPC32XX_UART3_BASE),
 		.mapbase        = LPC32XX_UART3_BASE,
 		.irq		= IRQ_UART_IIR3,
 		.uartclk	= LPC32XX_MAIN_OSC_FREQ,
@@ -62,7 +64,8 @@ static struct plat_serial8250_port serial_std_platform_data[] = {
 #endif
 #ifdef CONFIG_ARCH_LPC32XX_UART4_ENABLE
 	{
-		.membase	= (void *) io_p2v(LPC32XX_UART4_BASE),
+		.membase	=
+			(__force void __iomem *) io_p2v(LPC32XX_UART4_BASE),
 		.mapbase        = LPC32XX_UART4_BASE,
 		.irq		= IRQ_UART_IIR4,
 		.uartclk	= LPC32XX_MAIN_OSC_FREQ,
@@ -74,7 +77,8 @@ static struct plat_serial8250_port serial_std_platform_data[] = {
 #endif
 #ifdef CONFIG_ARCH_LPC32XX_UART6_ENABLE
 	{
-		.membase	= (void *) io_p2v(LPC32XX_UART6_BASE),
+		.membase	=
+			(__force void __iomem *) io_p2v(LPC32XX_UART6_BASE),
 		.mapbase        = LPC32XX_UART6_BASE,
 		.irq		= IRQ_UART_IIR6,
 		.uartclk	= LPC32XX_MAIN_OSC_FREQ,
@@ -144,7 +148,7 @@ void __init lpc32xx_serial_init(void)
 {
 	u32 tmp, clkmodes = 0;
 	struct clk *clk;
-	void *puart;
+	void __iomem *puart;
 	int i;
 
 	/* UART clocks are off, let clock driver manage them */
-- 
1.6.6
