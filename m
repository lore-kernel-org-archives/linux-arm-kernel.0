From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Jun 2015 15:50:18 +0200
Subject: [PATCH 1/5] ARM: ep93xx: move timer to its own file
In-Reply-To: <1434376222-4587-1-git-send-email-linus.walleij@linaro.org>
References: <1434376222-4587-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1434376222-4587-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This breaks the timer code out of the core file in preparation
for refactoring.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ep93xx/Makefile       |   2 +-
 arch/arm/mach-ep93xx/core.c         | 109 -----------------------------------
 arch/arm/mach-ep93xx/timer-ep93xx.c | 112 ++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 110 deletions(-)
 create mode 100644 arch/arm/mach-ep93xx/timer-ep93xx.c

diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
index 78d427b34b1f..b7ae4345ac08 100644
--- a/arch/arm/mach-ep93xx/Makefile
+++ b/arch/arm/mach-ep93xx/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
-obj-y			:= core.o clock.o
+obj-y			:= core.o clock.o timer-ep93xx.o
 
 obj-$(CONFIG_EP93XX_DMA)	+= dma.o
 
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 0e571f1749d6..5e2151bcc0c5 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -22,7 +22,6 @@
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 #include <linux/sys_soc.h>
-#include <linux/timex.h>
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
@@ -47,7 +46,6 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/time.h>
 
 #include "soc.h"
 
@@ -73,113 +71,6 @@ void __init ep93xx_map_io(void)
 	iotable_init(ep93xx_io_desc, ARRAY_SIZE(ep93xx_io_desc));
 }
 
-
-/*************************************************************************
- * Timer handling for EP93xx
- *************************************************************************
- * The ep93xx has four internal timers.  Timers 1, 2 (both 16 bit) and
- * 3 (32 bit) count down at 508 kHz, are self-reloading, and can generate
- * an interrupt on underflow.  Timer 4 (40 bit) counts down at 983.04 kHz,
- * is free-running, and can't generate interrupts.
- *
- * The 508 kHz timers are ideal for use for the timer interrupt, as the
- * most common values of HZ divide 508 kHz nicely.  We pick one of the 16
- * bit timers (timer 1) since we don't need more than 16 bits of reload
- * value as long as HZ >= 8.
- *
- * The higher clock rate of timer 4 makes it a better choice than the
- * other timers for use in gettimeoffset(), while the fact that it can't
- * generate interrupts means we don't have to worry about not being able
- * to use this timer for something else.  We also use timer 4 for keeping
- * track of lost jiffies.
- */
-#define EP93XX_TIMER_REG(x)		(EP93XX_TIMER_BASE + (x))
-#define EP93XX_TIMER1_LOAD		EP93XX_TIMER_REG(0x00)
-#define EP93XX_TIMER1_VALUE		EP93XX_TIMER_REG(0x04)
-#define EP93XX_TIMER1_CONTROL		EP93XX_TIMER_REG(0x08)
-#define EP93XX_TIMER123_CONTROL_ENABLE	(1 << 7)
-#define EP93XX_TIMER123_CONTROL_MODE	(1 << 6)
-#define EP93XX_TIMER123_CONTROL_CLKSEL	(1 << 3)
-#define EP93XX_TIMER1_CLEAR		EP93XX_TIMER_REG(0x0c)
-#define EP93XX_TIMER2_LOAD		EP93XX_TIMER_REG(0x20)
-#define EP93XX_TIMER2_VALUE		EP93XX_TIMER_REG(0x24)
-#define EP93XX_TIMER2_CONTROL		EP93XX_TIMER_REG(0x28)
-#define EP93XX_TIMER2_CLEAR		EP93XX_TIMER_REG(0x2c)
-#define EP93XX_TIMER4_VALUE_LOW		EP93XX_TIMER_REG(0x60)
-#define EP93XX_TIMER4_VALUE_HIGH	EP93XX_TIMER_REG(0x64)
-#define EP93XX_TIMER4_VALUE_HIGH_ENABLE	(1 << 8)
-#define EP93XX_TIMER3_LOAD		EP93XX_TIMER_REG(0x80)
-#define EP93XX_TIMER3_VALUE		EP93XX_TIMER_REG(0x84)
-#define EP93XX_TIMER3_CONTROL		EP93XX_TIMER_REG(0x88)
-#define EP93XX_TIMER3_CLEAR		EP93XX_TIMER_REG(0x8c)
-
-#define EP93XX_TIMER123_CLOCK		508469
-#define EP93XX_TIMER4_CLOCK		983040
-
-#define TIMER1_RELOAD			((EP93XX_TIMER123_CLOCK / HZ) - 1)
-#define TIMER4_TICKS_PER_JIFFY		DIV_ROUND_CLOSEST(EP93XX_TIMER4_CLOCK, HZ)
-
-static unsigned int last_jiffy_time;
-
-static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
-{
-	/* Writing any value clears the timer interrupt */
-	__raw_writel(1, EP93XX_TIMER1_CLEAR);
-
-	/* Recover lost jiffies */
-	while ((signed long)
-		(__raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time)
-						>= TIMER4_TICKS_PER_JIFFY) {
-		last_jiffy_time += TIMER4_TICKS_PER_JIFFY;
-		timer_tick();
-	}
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction ep93xx_timer_irq = {
-	.name		= "ep93xx timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= ep93xx_timer_interrupt,
-};
-
-static u32 ep93xx_gettimeoffset(void)
-{
-	int offset;
-
-	offset = __raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time;
-
-	/*
-	 * Timer 4 is based on a 983.04 kHz reference clock,
-	 * so dividing by 983040 gives the fraction of a second,
-	 * so dividing by 0.983040 converts to uS.
-	 * Refactor the calculation to avoid overflow.
-	 * Finally, multiply by 1000 to give nS.
-	 */
-	return (offset + (53 * offset / 3072)) * 1000;
-}
-
-void __init ep93xx_timer_init(void)
-{
-	u32 tmode = EP93XX_TIMER123_CONTROL_MODE |
-		    EP93XX_TIMER123_CONTROL_CLKSEL;
-
-	arch_gettimeoffset = ep93xx_gettimeoffset;
-
-	/* Enable periodic HZ timer.  */
-	__raw_writel(tmode, EP93XX_TIMER1_CONTROL);
-	__raw_writel(TIMER1_RELOAD, EP93XX_TIMER1_LOAD);
-	__raw_writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
-			EP93XX_TIMER1_CONTROL);
-
-	/* Enable lost jiffy timer.  */
-	__raw_writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
-			EP93XX_TIMER4_VALUE_HIGH);
-
-	setup_irq(IRQ_EP93XX_TIMER1, &ep93xx_timer_irq);
-}
-
-
 /*************************************************************************
  * EP93xx IRQ handling
  *************************************************************************/
diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
new file mode 100644
index 000000000000..978252c52661
--- /dev/null
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -0,0 +1,112 @@
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <asm/mach/time.h>
+#include "soc.h"
+
+/*************************************************************************
+ * Timer handling for EP93xx
+ *************************************************************************
+ * The ep93xx has four internal timers.  Timers 1, 2 (both 16 bit) and
+ * 3 (32 bit) count down at 508 kHz, are self-reloading, and can generate
+ * an interrupt on underflow.  Timer 4 (40 bit) counts down at 983.04 kHz,
+ * is free-running, and can't generate interrupts.
+ *
+ * The 508 kHz timers are ideal for use for the timer interrupt, as the
+ * most common values of HZ divide 508 kHz nicely.  We pick one of the 16
+ * bit timers (timer 1) since we don't need more than 16 bits of reload
+ * value as long as HZ >= 8.
+ *
+ * The higher clock rate of timer 4 makes it a better choice than the
+ * other timers for use in gettimeoffset(), while the fact that it can't
+ * generate interrupts means we don't have to worry about not being able
+ * to use this timer for something else.  We also use timer 4 for keeping
+ * track of lost jiffies.
+ */
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
+#define TIMER4_TICKS_PER_JIFFY		DIV_ROUND_CLOSEST(EP93XX_TIMER4_CLOCK, HZ)
+
+static unsigned int last_jiffy_time;
+
+static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
+{
+	/* Writing any value clears the timer interrupt */
+	__raw_writel(1, EP93XX_TIMER1_CLEAR);
+
+	/* Recover lost jiffies */
+	while ((signed long)
+		(__raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time)
+						>= TIMER4_TICKS_PER_JIFFY) {
+		last_jiffy_time += TIMER4_TICKS_PER_JIFFY;
+		timer_tick();
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction ep93xx_timer_irq = {
+	.name		= "ep93xx timer",
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= ep93xx_timer_interrupt,
+};
+
+static u32 ep93xx_gettimeoffset(void)
+{
+	int offset;
+
+	offset = __raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time;
+
+	/*
+	 * Timer 4 is based on a 983.04 kHz reference clock,
+	 * so dividing by 983040 gives the fraction of a second,
+	 * so dividing by 0.983040 converts to uS.
+	 * Refactor the calculation to avoid overflow.
+	 * Finally, multiply by 1000 to give nS.
+	 */
+	return (offset + (53 * offset / 3072)) * 1000;
+}
+
+void __init ep93xx_timer_init(void)
+{
+	u32 tmode = EP93XX_TIMER123_CONTROL_MODE |
+		    EP93XX_TIMER123_CONTROL_CLKSEL;
+
+	arch_gettimeoffset = ep93xx_gettimeoffset;
+
+	/* Enable periodic HZ timer.  */
+	__raw_writel(tmode, EP93XX_TIMER1_CONTROL);
+	__raw_writel(TIMER1_RELOAD, EP93XX_TIMER1_LOAD);
+	__raw_writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
+			EP93XX_TIMER1_CONTROL);
+
+	/* Enable lost jiffy timer.  */
+	__raw_writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
+			EP93XX_TIMER4_VALUE_HIGH);
+
+	setup_irq(IRQ_EP93XX_TIMER1, &ep93xx_timer_irq);
+}
-- 
1.9.3
