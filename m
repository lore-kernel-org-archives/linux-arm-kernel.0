From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 18:31:36 +0100
Subject: [PATCH 18/19] ARM: bcmring: convert to sp804 clocksource
In-Reply-To: <20110516172334.GD13659@n2100.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
Message-ID: <E1QM1do-0003EP-DQ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bcmring has a set of four sp804 timers incorporated, yet it has its
own copy of the sp804 code.  Convert its clocksource implementation
to the standard sp804 support code.

Cc: Jiandong Zheng <jdzheng@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig             |    1 +
 arch/arm/mach-bcmring/core.c |  108 +++++++++++++++++-------------------------
 2 files changed, 45 insertions(+), 64 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 43f003a..903c9c4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -297,6 +297,7 @@ config ARCH_BCMRING
 	depends on MMU
 	select CPU_V6
 	select ARM_AMBA
+	select ARM_TIMER_SP804
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
index 8fc2035..0ea33ff 100644
--- a/arch/arm/mach-bcmring/core.c
+++ b/arch/arm/mach-bcmring/core.c
@@ -37,6 +37,7 @@
 #include <linux/io.h>
 #include <asm/irq.h>
 #include <asm/hardware/arm_timer.h>
+#include <asm/hardware/timer-sp.h>
 #include <asm/mach-types.h>
 
 #include <asm/mach/arch.h>
@@ -97,6 +98,35 @@ static struct clk dummy_apb_pclk = {
 	.mode = CLK_MODE_XTAL,
 };
 
+/* Timer 0 - 25 MHz, Timer3 at bus clock rate, typically  150-166 MHz */
+#if defined(CONFIG_ARCH_FPGA11107)
+/* fpga cpu/bus are currently 30 times slower so scale frequency as well to */
+/* slow down Linux's sense of time */
+#define TIMER0_FREQUENCY_MHZ  (tmrHw_LOW_FREQUENCY_MHZ * 30)
+#define TIMER1_FREQUENCY_MHZ  (tmrHw_LOW_FREQUENCY_MHZ * 30)
+#define TIMER3_FREQUENCY_MHZ  (tmrHw_HIGH_FREQUENCY_MHZ * 30)
+#define TIMER3_FREQUENCY_KHZ   (tmrHw_HIGH_FREQUENCY_HZ / 1000 * 30)
+#else
+#define TIMER0_FREQUENCY_MHZ  tmrHw_LOW_FREQUENCY_MHZ
+#define TIMER1_FREQUENCY_MHZ  tmrHw_LOW_FREQUENCY_MHZ
+#define TIMER3_FREQUENCY_MHZ  tmrHw_HIGH_FREQUENCY_MHZ
+#define TIMER3_FREQUENCY_KHZ  (tmrHw_HIGH_FREQUENCY_HZ / 1000)
+#endif
+
+static struct clk sp804_timer1_clk = {
+	.name = "sp804-timer-1",
+	.type = CLK_TYPE_PRIMARY,
+	.mode = CLK_MODE_XTAL,
+	.rate_hz = TIMER1_FREQUENCY_MHZ * 1000000,
+};
+
+static struct clk sp804_timer3_clk = {
+	.name = "sp804-timer-3",
+	.type = CLK_TYPE_PRIMARY,
+	.mode = CLK_MODE_XTAL,
+	.rate_hz = TIMER3_FREQUENCY_KHZ * 1000,
+};
+
 static struct clk_lookup lookups[] = {
 	{			/* Bus clock */
 		.con_id = "apb_pclk",
@@ -107,6 +137,14 @@ static struct clk_lookup lookups[] = {
 	}, {			/* UART1 */
 		.dev_id = "uartb",
 		.clk = &uart_clk,
+	}, {			/* SP804 timer 1 */
+		.dev_id = "sp804",
+		.con_id = "timer1",
+		.clk = &sp804_timer1_clk,
+	}, {			/* SP804 timer 3 */
+		.dev_id = "sp804",
+		.con_id = "timer3",
+		.clk = &sp804_timer3_clk,
 	}
 };
 
@@ -162,25 +200,10 @@ void __init bcmring_amba_init(void)
 /*
  * Where is the timer (VA)?
  */
-#define TIMER0_VA_BASE		 MM_IO_BASE_TMR
-#define TIMER1_VA_BASE		(MM_IO_BASE_TMR + 0x20)
-#define TIMER2_VA_BASE		(MM_IO_BASE_TMR + 0x40)
-#define TIMER3_VA_BASE          (MM_IO_BASE_TMR + 0x60)
-
-/* Timer 0 - 25 MHz, Timer3 at bus clock rate, typically  150-166 MHz */
-#if defined(CONFIG_ARCH_FPGA11107)
-/* fpga cpu/bus are currently 30 times slower so scale frequency as well to */
-/* slow down Linux's sense of time */
-#define TIMER0_FREQUENCY_MHZ  (tmrHw_LOW_FREQUENCY_MHZ * 30)
-#define TIMER1_FREQUENCY_MHZ  (tmrHw_LOW_FREQUENCY_MHZ * 30)
-#define TIMER3_FREQUENCY_MHZ  (tmrHw_HIGH_FREQUENCY_MHZ * 30)
-#define TIMER3_FREQUENCY_KHZ   (tmrHw_HIGH_FREQUENCY_HZ / 1000 * 30)
-#else
-#define TIMER0_FREQUENCY_MHZ  tmrHw_LOW_FREQUENCY_MHZ
-#define TIMER1_FREQUENCY_MHZ  tmrHw_LOW_FREQUENCY_MHZ
-#define TIMER3_FREQUENCY_MHZ  tmrHw_HIGH_FREQUENCY_MHZ
-#define TIMER3_FREQUENCY_KHZ  (tmrHw_HIGH_FREQUENCY_HZ / 1000)
-#endif
+#define TIMER0_VA_BASE		((void __iomem *)MM_IO_BASE_TMR)
+#define TIMER1_VA_BASE		((void __iomem *)(MM_IO_BASE_TMR + 0x20))
+#define TIMER2_VA_BASE		((void __iomem *)(MM_IO_BASE_TMR + 0x40))
+#define TIMER3_VA_BASE          ((void __iomem *)(MM_IO_BASE_TMR + 0x60))
 
 #define TICKS_PER_uSEC     TIMER0_FREQUENCY_MHZ
 
@@ -189,10 +212,7 @@ void __init bcmring_amba_init(void)
  *
  */
 #define mSEC_1                          1000
-#define mSEC_5                          (mSEC_1 * 5)
 #define mSEC_10                         (mSEC_1 * 10)
-#define mSEC_25                         (mSEC_1 * 25)
-#define SEC_1                           (mSEC_1 * 1000)
 
 /*
  * How long is the timer interval?
@@ -279,53 +299,13 @@ static struct irqaction bcmring_timer_irq = {
 	.handler = bcmring_timer_interrupt,
 };
 
-static cycle_t bcmring_get_cycles_timer1(struct clocksource *cs)
-{
-	return ~readl(TIMER1_VA_BASE + TIMER_VALUE);
-}
-
-static cycle_t bcmring_get_cycles_timer3(struct clocksource *cs)
-{
-	return ~readl(TIMER3_VA_BASE + TIMER_VALUE);
-}
-
-static struct clocksource clocksource_bcmring_timer1 = {
-	.name = "timer1",
-	.rating = 200,
-	.read = bcmring_get_cycles_timer1,
-	.mask = CLOCKSOURCE_MASK(32),
-	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static struct clocksource clocksource_bcmring_timer3 = {
-	.name = "timer3",
-	.rating = 100,
-	.read = bcmring_get_cycles_timer3,
-	.mask = CLOCKSOURCE_MASK(32),
-	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 static int __init bcmring_clocksource_init(void)
 {
 	/* setup timer1 as free-running clocksource */
-	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
-	writel(0xffffffff, TIMER1_VA_BASE + TIMER_LOAD);
-	writel(0xffffffff, TIMER1_VA_BASE + TIMER_VALUE);
-	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
-	       TIMER1_VA_BASE + TIMER_CTRL);
-
-	clocksource_register_khz(&clocksource_bcmring_timer1,
-				 TIMER1_FREQUENCY_MHZ * 1000);
+	sp804_clocksource_init(TIMER1_VA_BASE, "timer1");
 
 	/* setup timer3 as free-running clocksource */
-	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
-	writel(0xffffffff, TIMER3_VA_BASE + TIMER_LOAD);
-	writel(0xffffffff, TIMER3_VA_BASE + TIMER_VALUE);
-	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
-	       TIMER3_VA_BASE + TIMER_CTRL);
-
-	clocksource_register_khz(&clocksource_bcmring_timer3,
-				 TIMER3_FREQUENCY_KHZ);
+	sp804_clocksource_init(TIMER3_VA_BASE, "timer3");
 
 	return 0;
 }
-- 
1.7.4.4
