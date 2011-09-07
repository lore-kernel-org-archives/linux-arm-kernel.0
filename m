From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 7 Sep 2011 10:31:33 +0200
Subject: =?y?q?=5BPATCH=204/4=5D=20mach-integrator=3A=20get=20timer=20frequency=20from=20clock?=
Message-ID: <1315384293-27438-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

We already have a clock definition for the 24MHz clock in
the Integrator, use that instead of some unclear defines
from the platform.h header. Also delete the senseless
comment that the file shouldn't be edited, I just edited it
and the world didn't come to an end, so it's obviously
false. If anyone still has the mentioned ".s file" and the
s2h awk script generating that header, raise your hand
(and give me your files).

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/core.c                  |    4 ++
 arch/arm/mach-integrator/include/mach/platform.h |   12 -------
 arch/arm/mach-integrator/integrator_ap.c         |   35 +++++++++++++--------
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 77315b9..82ebc8d 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -126,6 +126,10 @@ static struct clk_lookup lookups[] = {
 	{	/* Bus clock */
 		.con_id		= "apb_pclk",
 		.clk		= &dummy_apb_pclk,
+	}, {
+		/* Integrator/AP timer frequency */
+		.dev_id		= "ap_timer",
+		.clk		= &clk24mhz,
 	}, {	/* UART0 */
 		.dev_id		= "mb:16",
 		.clk		= &uartclk,
diff --git a/arch/arm/mach-integrator/include/mach/platform.h b/arch/arm/mach-integrator/include/mach/platform.h
index 5e6ea5c..ec467ba 100644
--- a/arch/arm/mach-integrator/include/mach/platform.h
+++ b/arch/arm/mach-integrator/include/mach/platform.h
@@ -13,9 +13,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-/* DO NOT EDIT!! - this file automatically generated
- *                 from .s file by awk -f s2h.awk
- */
 /**************************************************************************
  * * Copyright ?? ARM Limited 1998.  All rights reserved.
  * ***********************************************************************/
@@ -399,15 +396,6 @@
 #define INTEGRATOR_TIMER1_BASE          (INTEGRATOR_CT_BASE + 0x100)
 #define INTEGRATOR_TIMER2_BASE          (INTEGRATOR_CT_BASE + 0x200)
 
-#define TICKS_PER_uSEC                  24
-
-/*
- *  These are useconds NOT ticks.
- *
- */
-#define mSEC_1                          1000
-#define mSEC_10                         (mSEC_1 * 10)
-
 #define INTEGRATOR_CSR_BASE             0x10000000
 #define INTEGRATOR_CSR_SIZE             0x10000000
 
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 55d3c84..3f9f8e0 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -27,6 +27,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/kmi.h>
+#include <linux/clk.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
@@ -322,13 +323,14 @@ static void __init ap_init(void)
 #define TIMER1_VA_BASE IO_ADDRESS(INTEGRATOR_TIMER1_BASE)
 #define TIMER2_VA_BASE IO_ADDRESS(INTEGRATOR_TIMER2_BASE)
 
-static void integrator_clocksource_init(u32 khz)
+static void integrator_clocksource_init(unsigned long inrate)
 {
 	void __iomem *base = (void __iomem *)TIMER2_VA_BASE;
 	u32 ctrl = TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC;
+	unsigned long rate = inrate;
 
-	if (khz >= 1500) {
-		khz /= 16;
+	if (rate >= 1500000) {
+		rate /= 16;
 		ctrl |= TIMER_CTRL_DIV16;
 	}
 
@@ -336,7 +338,7 @@ static void integrator_clocksource_init(u32 khz)
 	writel(ctrl, base + TIMER_CTRL);
 
 	clocksource_mmio_init(base + TIMER_VALUE, "timer2",
-		khz * 1000, 200, 16, clocksource_mmio_readl_down);
+			rate, 200, 16, clocksource_mmio_readl_down);
 }
 
 static void __iomem * const clkevt_base = (void __iomem *)TIMER1_VA_BASE;
@@ -405,23 +407,24 @@ static struct irqaction integrator_timer_irq = {
 	.dev_id		= &integrator_clockevent,
 };
 
-static void integrator_clockevent_init(u32 khz)
+static void integrator_clockevent_init(unsigned long inrate)
 {
 	unsigned int ctrl = 0;
+	unsigned long rate = inrate;
 
 	/* Calculate and program a divisor */
-	if (khz * 1000 > 0x100000 * HZ) {
-		khz /= 256;
+	if (rate > 0x100000 * HZ) {
+		rate /= 256;
 		ctrl |= TIMER_CTRL_DIV256;
-	} else if (khz * 1000 > 0x10000 * HZ) {
-		khz /= 16;
+	} else if (rate > 0x10000 * HZ) {
+		rate /= 16;
 		ctrl |= TIMER_CTRL_DIV16;
 	}
 	writel(ctrl, clkevt_base + TIMER_CTRL);
 
 	setup_irq(IRQ_TIMERINT1, &integrator_timer_irq);
 	clockevents_config_and_register(&integrator_clockevent,
-					khz * 1000,
+					rate,
 					1,
 					0xffffU);
 }
@@ -431,14 +434,20 @@ static void integrator_clockevent_init(u32 khz)
  */
 static void __init ap_init_timer(void)
 {
-	u32 khz = TICKS_PER_uSEC * 1000;
+	struct clk *clk;
+	unsigned long rate;
+
+	clk = clk_get_sys("ap_timer", NULL);
+	BUG_ON(IS_ERR(clk));
+	clk_enable(clk);
+	rate = clk_get_rate(clk);
 
 	writel(0, TIMER0_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 
-	integrator_clocksource_init(khz);
-	integrator_clockevent_init(khz);
+	integrator_clocksource_init(rate);
+	integrator_clockevent_init(rate);
 }
 
 static struct sys_timer ap_timer = {
-- 
1.7.3.2
