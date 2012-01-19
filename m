From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Jan 2012 19:05:12 +0100
Subject: [PATCH 3/3] ARM: at91/tc/clocksource: Add 32 bit variant to Timer
 Counter
In-Reply-To: <1326996312-9244-1-git-send-email-nicolas.ferre@atmel.com>
References: <1326996312-9244-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <d1105b63fce5787a4717ca92ad35397923078e99.1326995849.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoC have a 32 bit variant of Timer Counter Blocks. We do not
need the chaining of two 16 bit counters anymore for them.

The SoC nature is deduced from the device tree "compatible" string.
For non-device-tree configurations, backward compatibility is maintained
by using the default 16 bit counter configuration.

This patch addresses both the atmel_tclib and its user: tcb_clksrc
clocksource.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/clocksource/tcb_clksrc.c |   90 ++++++++++++++++++++++++++------------
 drivers/misc/atmel_tclib.c       |   20 ++++++++
 include/linux/atmel_tc.h         |   10 ++++
 3 files changed, 92 insertions(+), 28 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 55d0f95..32cb929 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -19,6 +19,8 @@
  *   - Two channels combine to create a free-running 32 bit counter
  *     with a base rate of 5+ MHz, packaged as a clocksource (with
  *     resolution better than 200 nsec).
+ *   - Some chips support 32 bit counter. A single channel is used for
+ *     this 32 bit free-running counter. the second channel is not used.
  *
  *   - The third channel may be used to provide a 16-bit clockevent
  *     source, used in either periodic or oneshot mode.  This runs
@@ -54,6 +56,11 @@ static cycle_t tc_get_cycles(struct clocksource *cs)
 	return (upper << 16) | lower;
 }
 
+static cycle_t tc_get_cycles32(struct clocksource *cs)
+{
+	return __raw_readl(tcaddr + ATMEL_TC_REG(0, CV));
+}
+
 static struct clocksource clksrc = {
 	.name           = "tcb_clksrc",
 	.rating         = 200,
@@ -209,6 +216,48 @@ static void __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
 
 #endif
 
+static void __init tcb_setup_dual_chan(struct atmel_tc *tc, int mck_divisor_idx)
+{
+	/* channel 0:  waveform mode, input mclk/8, clock TIOA0 on overflow */
+	__raw_writel(mck_divisor_idx			/* likely divide-by-8 */
+			| ATMEL_TC_WAVE
+			| ATMEL_TC_WAVESEL_UP		/* free-run */
+			| ATMEL_TC_ACPA_SET		/* TIOA0 rises@0 */
+			| ATMEL_TC_ACPC_CLEAR,		/* (duty cycle 50%) */
+			tcaddr + ATMEL_TC_REG(0, CMR));
+	__raw_writel(0x0000, tcaddr + ATMEL_TC_REG(0, RA));
+	__raw_writel(0x8000, tcaddr + ATMEL_TC_REG(0, RC));
+	__raw_writel(0xff, tcaddr + ATMEL_TC_REG(0, IDR));	/* no irqs */
+	__raw_writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(0, CCR));
+
+	/* channel 1:  waveform mode, input TIOA0 */
+	__raw_writel(ATMEL_TC_XC1			/* input: TIOA0 */
+			| ATMEL_TC_WAVE
+			| ATMEL_TC_WAVESEL_UP,		/* free-run */
+			tcaddr + ATMEL_TC_REG(1, CMR));
+	__raw_writel(0xff, tcaddr + ATMEL_TC_REG(1, IDR));	/* no irqs */
+	__raw_writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(1, CCR));
+
+	/* chain channel 0 to channel 1*/
+	__raw_writel(ATMEL_TC_TC1XC1S_TIOA0, tcaddr + ATMEL_TC_BMR);
+	/* then reset all the timers */
+	__raw_writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
+}
+
+static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_idx)
+{
+	/* channel 0:  waveform mode, input mclk/8 */
+	__raw_writel(mck_divisor_idx			/* likely divide-by-8 */
+			| ATMEL_TC_WAVE
+			| ATMEL_TC_WAVESEL_UP,		/* free-run */
+			tcaddr + ATMEL_TC_REG(0, CMR));
+	__raw_writel(0xff, tcaddr + ATMEL_TC_REG(0, IDR));	/* no irqs */
+	__raw_writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(0, CCR));
+
+	/* then reset all the timers */
+	__raw_writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
+}
+
 static int __init tcb_clksrc_init(void)
 {
 	static char bootinfo[] __initdata
@@ -260,34 +309,19 @@ static int __init tcb_clksrc_init(void)
 			divided_rate / 1000000,
 			((divided_rate + 500000) % 1000000) / 1000);
 
-	/* tclib will give us three clocks no matter what the
-	 * underlying platform supports.
-	 */
-	clk_enable(tc->clk[1]);
-
-	/* channel 0:  waveform mode, input mclk/8, clock TIOA0 on overflow */
-	__raw_writel(best_divisor_idx			/* likely divide-by-8 */
-			| ATMEL_TC_WAVE
-			| ATMEL_TC_WAVESEL_UP		/* free-run */
-			| ATMEL_TC_ACPA_SET		/* TIOA0 rises at 0 */
-			| ATMEL_TC_ACPC_CLEAR,		/* (duty cycle 50%) */
-			tcaddr + ATMEL_TC_REG(0, CMR));
-	__raw_writel(0x0000, tcaddr + ATMEL_TC_REG(0, RA));
-	__raw_writel(0x8000, tcaddr + ATMEL_TC_REG(0, RC));
-	__raw_writel(0xff, tcaddr + ATMEL_TC_REG(0, IDR));	/* no irqs */
-	__raw_writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(0, CCR));
-
-	/* channel 1:  waveform mode, input TIOA0 */
-	__raw_writel(ATMEL_TC_XC1			/* input: TIOA0 */
-			| ATMEL_TC_WAVE
-			| ATMEL_TC_WAVESEL_UP,		/* free-run */
-			tcaddr + ATMEL_TC_REG(1, CMR));
-	__raw_writel(0xff, tcaddr + ATMEL_TC_REG(1, IDR));	/* no irqs */
-	__raw_writel(ATMEL_TC_CLKEN, tcaddr + ATMEL_TC_REG(1, CCR));
-
-	/* chain channel 0 to channel 1, then reset all the timers */
-	__raw_writel(ATMEL_TC_TC1XC1S_TIOA0, tcaddr + ATMEL_TC_BMR);
-	__raw_writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
+	if (tc->tcb_config && tc->tcb_config->counter_width == 32) {
+		/* use apropriate function to read 32 bit counter */
+		clksrc.read = tc_get_cycles32;
+		/* setup ony channel 0 */
+		tcb_setup_single_chan(tc, best_divisor_idx);
+	} else {
+		/* tclib will give us three clocks no matter what the
+		 * underlying platform supports.
+		 */
+		clk_enable(tc->clk[1]);
+		/* setup both channel 0 & 1 */
+		tcb_setup_dual_chan(tc, best_divisor_idx);
+	}
 
 	/* and away we go! */
 	clocksource_register_hz(&clksrc, divided_rate);
diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index de6dea7..c8d8e38 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -114,9 +114,21 @@ void atmel_tc_free(struct atmel_tc *tc)
 EXPORT_SYMBOL_GPL(atmel_tc_free);
 
 #if defined(CONFIG_OF)
+static struct atmel_tcb_config tcb_rm9200_config = {
+	.counter_width = 16,
+};
+
+static struct atmel_tcb_config tcb_sam9x5_config = {
+	.counter_width = 32,
+};
+
 static const struct of_device_id atmel_tcb_dt_ids[] = {
 	{
 		.compatible = "atmel,at91rm9200-tcb",
+		.data = &tcb_rm9200_config,
+	}, {
+		.compatible = "atmel,at91sam9x5-tcb",
+		.data = &tcb_sam9x5_config,
 	}, {
 		/* sentinel */
 	}
@@ -150,6 +162,14 @@ static int __init tc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	/* Now take SoC information if available */
+	if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+		match = of_match_node(atmel_tcb_dt_ids, pdev->dev.of_node);
+		if (match)
+			tc->tcb_config = match->data;
+	}
+
 	tc->clk[0] = clk;
 	tc->clk[1] = clk_get(&pdev->dev, "t1_clk");
 	if (IS_ERR(tc->clk[1]))
diff --git a/include/linux/atmel_tc.h b/include/linux/atmel_tc.h
index 53ba65e..1d14b1dc 100644
--- a/include/linux/atmel_tc.h
+++ b/include/linux/atmel_tc.h
@@ -34,10 +34,19 @@
 struct clk;
 
 /**
+ * struct atmel_tcb_config - SoC data for a Timer/Counter Block
+ * @counter_width: size in bits of a timer counter register
+ */
+struct atmel_tcb_config {
+	size_t	counter_width;
+};
+
+/**
  * struct atmel_tc - information about a Timer/Counter Block
  * @pdev: physical device
  * @iomem: resource associated with the I/O register
  * @regs: mapping through which the I/O registers can be accessed
+ * @tcb_config: configuration data from SoC
  * @irq: irq for each of the three channels
  * @clk: internal clock source for each of the three channels
  * @node: list node, for tclib internal use
@@ -54,6 +63,7 @@ struct atmel_tc {
 	struct platform_device	*pdev;
 	struct resource		*iomem;
 	void __iomem		*regs;
+	struct atmel_tcb_config	*tcb_config;
 	int			irq[3];
 	struct clk		*clk[3];
 	struct list_head	node;
-- 
1.7.5.4
