From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Tue,  9 Feb 2010 18:59:50 +0200
Subject: [PATCHv3 2/7] mxc: refactor timer code to use timer versions
In-Reply-To: <a003708ad4ee9384226251431c7953a24079ff80.1265733173.git.amit.kucheria@canonical.com>
References: <cover.1265733173.git.amit.kucheria@canonical.com>
	<a003708ad4ee9384226251431c7953a24079ff80.1265733173.git.amit.kucheria@canonical.com>
Message-ID: <0f3332c4fabb2227b1bc15dc7542017d08f10a09.1265733173.git.amit.kucheria@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Refactor the timer code into version 1 and version 2.

Essentially there are 2 versions of the timer hardware on Freescale MXC
hardware. Version 1 is found on MX1/MXL, MX21 and MX27. Version 2 is found on
MX25, MX31, MX35, MX37, MX51, and future parts.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
---
 arch/arm/plat-mxc/time.c |   41 ++++++++++++++++++++++++++---------------
 1 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index 844567e..c1ce51a 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -30,9 +30,15 @@
 #include <asm/mach/time.h>
 #include <mach/common.h>
 
+/*
+ * There are 2 versions of the timer hardware on Freescale MXC hardware.
+ * Version 1: MX1/MXL, MX21, MX27.
+ * Version 2: MX25, MX31, MX35, MX37, MX51
+ */
+
 /* defines common for all i.MX */
 #define MXC_TCTL		0x00
-#define MXC_TCTL_TEN		(1 << 0)
+#define MXC_TCTL_TEN		(1 << 0) /* Enable module */
 #define MXC_TPRER		0x04
 
 /* MX1, MX21, MX27 */
@@ -47,8 +53,8 @@
 #define MX2_TSTAT_CAPT		(1 << 1)
 #define MX2_TSTAT_COMP		(1 << 0)
 
-/* MX31, MX35, MX25, MXC91231 */
-#define MX3_TCTL_WAITEN		(1 << 3)
+/* MX31, MX35, MX25, MXC91231, MX5 */
+#define MX3_TCTL_WAITEN		(1 << 3) /* Wait enable mode */
 #define MX3_TCTL_CLK_IPG	(1 << 6)
 #define MX3_TCTL_FRR		(1 << 9)
 #define MX3_IR			0x0c
@@ -57,6 +63,9 @@
 #define MX3_TCN			0x24
 #define MX3_TCMP		0x10
 
+#define timer_is_v1()	(cpu_is_mx1() || cpu_is_mx21() || cpu_is_mx27())
+#define timer_is_v2()	(!timer_is_v1())
+
 static struct clock_event_device clockevent_mxc;
 static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
 
@@ -66,7 +75,7 @@ static inline void gpt_irq_disable(void)
 {
 	unsigned int tmp;
 
-	if (cpu_is_mx3() || cpu_is_mx25())
+	if (timer_is_v2())
 		__raw_writel(0, timer_base + MX3_IR);
 	else {
 		tmp = __raw_readl(timer_base + MXC_TCTL);
@@ -76,7 +85,7 @@ static inline void gpt_irq_disable(void)
 
 static inline void gpt_irq_enable(void)
 {
-	if (cpu_is_mx3() || cpu_is_mx25())
+	if (timer_is_v2())
 		__raw_writel(1<<0, timer_base + MX3_IR);
 	else {
 		__raw_writel(__raw_readl(timer_base + MXC_TCTL) | MX1_2_TCTL_IRQEN,
@@ -86,11 +95,13 @@ static inline void gpt_irq_enable(void)
 
 static void gpt_irq_acknowledge(void)
 {
-	if (cpu_is_mx1())
-		__raw_writel(0, timer_base + MX1_2_TSTAT);
-	if (cpu_is_mx2())
-		__raw_writel(MX2_TSTAT_CAPT | MX2_TSTAT_COMP, timer_base + MX1_2_TSTAT);
-	if (cpu_is_mx3() || cpu_is_mx25())
+	if (timer_is_v1()) {
+		if (cpu_is_mx1())
+			__raw_writel(0, timer_base + MX1_2_TSTAT);
+		else
+			__raw_writel(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
+				timer_base + MX1_2_TSTAT);
+	} else if (timer_is_v2())
 		__raw_writel(MX3_TSTAT_OF1, timer_base + MX3_TSTAT);
 }
 
@@ -117,7 +128,7 @@ static int __init mxc_clocksource_init(struct clk *timer_clk)
 {
 	unsigned int c = clk_get_rate(timer_clk);
 
-	if (cpu_is_mx3() || cpu_is_mx25())
+	if (timer_is_v2())
 		clocksource_mxc.read = mx3_get_cycles;
 
 	clocksource_mxc.mult = clocksource_hz2mult(c,
@@ -180,7 +191,7 @@ static void mxc_set_mode(enum clock_event_mode mode,
 
 	if (mode != clockevent_mode) {
 		/* Set event time into far-far future */
-		if (cpu_is_mx3() || cpu_is_mx25())
+		if (timer_is_v2())
 			__raw_writel(__raw_readl(timer_base + MX3_TCN) - 3,
 					timer_base + MX3_TCMP);
 		else
@@ -233,7 +244,7 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evt = &clockevent_mxc;
 	uint32_t tstat;
 
-	if (cpu_is_mx3() || cpu_is_mx25())
+	if (timer_is_v2())
 		tstat = __raw_readl(timer_base + MX3_TSTAT);
 	else
 		tstat = __raw_readl(timer_base + MX1_2_TSTAT);
@@ -264,7 +275,7 @@ static int __init mxc_clockevent_init(struct clk *timer_clk)
 {
 	unsigned int c = clk_get_rate(timer_clk);
 
-	if (cpu_is_mx3() || cpu_is_mx25())
+	if (timer_is_v2())
 		clockevent_mxc.set_next_event = mx3_set_next_event;
 
 	clockevent_mxc.mult = div_sc(c, NSEC_PER_SEC,
@@ -296,7 +307,7 @@ void __init mxc_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
 	__raw_writel(0, timer_base + MXC_TCTL);
 	__raw_writel(0, timer_base + MXC_TPRER); /* see datasheet note */
 
-	if (cpu_is_mx3() || cpu_is_mx25())
+	if (timer_is_v2())
 		tctl_val = MX3_TCTL_CLK_IPG | MX3_TCTL_FRR | MX3_TCTL_WAITEN | MXC_TCTL_TEN;
 	else
 		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
-- 
1.6.3.3
