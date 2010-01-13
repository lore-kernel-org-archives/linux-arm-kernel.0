From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 12 Jan 2010 18:11:28 -0700
Subject: [PATCH] ep93xx: move timer defines into core.c and document
Message-ID: <201001121811.28763.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ep93xx: move timer defines into core.c and document

The timer defines are only used in core.c. Move them so
they will not be globaly exposed.

While here, add additional defines to document the magic
numbers used in the registers. Also, add some comments
for clarification.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersus.com>

---

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 41064bd..d8b8802 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -84,13 +84,40 @@ void __init ep93xx_map_io(void)
  * to use this timer for something else.  We also use timer 4 for keeping
  * track of lost jiffies.
  */
-static unsigned int last_jiffy_time;
-
+#define EP93XX_TIMER_REG(x)		(EP93XX_TIMER_BASE + (x))
+#define EP93XX_TIMER1_LOAD		EP93XX_TIMER_REG(0x00)
+#define EP93XX_TIMER1_VALUE		EP93XX_TIMER_REG(0x04)
+#define EP93XX_TIMER1_CONTROL		EP93XX_TIMER_REG(0x08)
+#define EP93XX_TIMER123_CONTROL_ENABLE	(1 << 7)
+#define EP93XX_TIMER123_CONTROL_MODE	(1 << 6)
+#define EP93XX_TIMER123_CONTROL_CLKSEL	(1 << 3)
+#define EP93XX_TIMER1_CLEAR		EP93XX_TIMER_REG(0x0c)
+#define EP93XX_TIMER2_LOAD		EP93XX_TIMER_REG(0x20)
+#define EP93XX_TIMER2_VALUE		EP93XX_TIMER_REG(0x24)
+#define EP93XX_TIMER2_CONTROL		EP93XX_TIMER_REG(0x28)
+#define EP93XX_TIMER2_CLEAR		EP93XX_TIMER_REG(0x2c)
+#define EP93XX_TIMER4_VALUE_LOW		EP93XX_TIMER_REG(0x60)
+#define EP93XX_TIMER4_VALUE_HIGH	EP93XX_TIMER_REG(0x64)
+#define EP93XX_TIMER4_VALUE_HIGH_ENABLE	(1 << 8)
+#define EP93XX_TIMER3_LOAD		EP93XX_TIMER_REG(0x80)
+#define EP93XX_TIMER3_VALUE		EP93XX_TIMER_REG(0x84)
+#define EP93XX_TIMER3_CONTROL		EP93XX_TIMER_REG(0x88)
+#define EP93XX_TIMER3_CLEAR		EP93XX_TIMER_REG(0x8c)
+
+#define EP93XX_TIMER123_CLOCK		508469
+#define EP93XX_TIMER4_CLOCK		983040
+
+#define TIMER1_RELOAD			((EP93XX_TIMER123_CLOCK / HZ) - 1)
 #define TIMER4_TICKS_PER_JIFFY		DIV_ROUND_CLOSEST(CLOCK_TICK_RATE, HZ)
 
+static unsigned int last_jiffy_time;
+
 static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
 {
+	/* Writing any value clears the timer interrupt */
 	__raw_writel(1, EP93XX_TIMER1_CLEAR);
+
+	/* Recover lost jiffies */
 	while ((signed long)
 		(__raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time)
 						>= TIMER4_TICKS_PER_JIFFY) {
@@ -109,13 +136,18 @@ static struct irqaction ep93xx_timer_irq = {
 
 static void __init ep93xx_timer_init(void)
 {
+	u32 tmode = EP93XX_TIMER123_CONTROL_MODE |
+		    EP93XX_TIMER123_CONTROL_CLKSEL;
+
 	/* Enable periodic HZ timer.  */
-	__raw_writel(0x48, EP93XX_TIMER1_CONTROL);
-	__raw_writel((508469 / HZ) - 1, EP93XX_TIMER1_LOAD);
-	__raw_writel(0xc8, EP93XX_TIMER1_CONTROL);
+	__raw_writel(tmode, EP93XX_TIMER1_CONTROL);
+	__raw_writel(TIMER1_RELOAD, EP93XX_TIMER1_LOAD);
+	__raw_writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
+			EP93XX_TIMER1_CONTROL);
 
 	/* Enable lost jiffy timer.  */
-	__raw_writel(0x100, EP93XX_TIMER4_VALUE_HIGH);
+	__raw_writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
+			EP93XX_TIMER4_VALUE_HIGH);
 
 	setup_irq(IRQ_EP93XX_TIMER1, &ep93xx_timer_irq);
 }
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index cd35912..93e2ecc 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -92,21 +92,6 @@
 
 /* APB peripherals */
 #define EP93XX_TIMER_BASE		EP93XX_APB_IOMEM(0x00010000)
-#define EP93XX_TIMER_REG(x)		(EP93XX_TIMER_BASE + (x))
-#define EP93XX_TIMER1_LOAD		EP93XX_TIMER_REG(0x00)
-#define EP93XX_TIMER1_VALUE		EP93XX_TIMER_REG(0x04)
-#define EP93XX_TIMER1_CONTROL		EP93XX_TIMER_REG(0x08)
-#define EP93XX_TIMER1_CLEAR		EP93XX_TIMER_REG(0x0c)
-#define EP93XX_TIMER2_LOAD		EP93XX_TIMER_REG(0x20)
-#define EP93XX_TIMER2_VALUE		EP93XX_TIMER_REG(0x24)
-#define EP93XX_TIMER2_CONTROL		EP93XX_TIMER_REG(0x28)
-#define EP93XX_TIMER2_CLEAR		EP93XX_TIMER_REG(0x2c)
-#define EP93XX_TIMER4_VALUE_LOW		EP93XX_TIMER_REG(0x60)
-#define EP93XX_TIMER4_VALUE_HIGH	EP93XX_TIMER_REG(0x64)
-#define EP93XX_TIMER3_LOAD		EP93XX_TIMER_REG(0x80)
-#define EP93XX_TIMER3_VALUE		EP93XX_TIMER_REG(0x84)
-#define EP93XX_TIMER3_CONTROL		EP93XX_TIMER_REG(0x88)
-#define EP93XX_TIMER3_CLEAR		EP93XX_TIMER_REG(0x8c)
 
 #define EP93XX_I2S_BASE			EP93XX_APB_IOMEM(0x00020000)
 
