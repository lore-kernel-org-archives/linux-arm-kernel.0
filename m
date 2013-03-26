From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 26 Mar 2013 18:43:33 +0100
Subject: [PATCH v2 01/10] arm: zynq: Use standard timer binding
In-Reply-To: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <dcbc38c6f1e319a31693ef0d69195fafc42a5de0.1364319776.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use cdns,ttc because this driver is Cadence Rev06
Triple Timer Counter and everybody can use it
without xilinx specific function name or probing.

Also use standard dt description for timer
and also prepare for moving to clocksource
initialization.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
v2: Update year in copyright
    Fix typo fault
    Remove all zynq specific names

Steffen: I have done this change based on our discussion.
Moving to generic location will be done in the next patch.

Josh: We have talked about this change at ELC.
Using standard dt binding as other timers.

I have also discussed this with Rob some time ago.
https://patchwork.kernel.org/patch/2112791/
---
 arch/arm/boot/dts/zynq-7000.dtsi |   45 +------
 arch/arm/boot/dts/zynq-zc702.dts |   10 --
 arch/arm/mach-zynq/common.c      |    1 +
 arch/arm/mach-zynq/timer.c       |  261 +++++++++++++++++++++++++++-----------
 4 files changed, 195 insertions(+), 122 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 5914b56..51243db 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -111,56 +111,23 @@
 		};
 
 		ttc0: ttc0 at f8001000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "xlnx,ttc";
+			interrupt-parent = <&intc>;
+			interrupts = < 0 10 4 0 11 4 0 12 4 >;
+			compatible = "cdns,ttc";
 			reg = <0xF8001000 0x1000>;
 			clocks = <&cpu_clk 3>;
 			clock-names = "cpu_1x";
 			clock-ranges;
-
-			ttc0_0: ttc0.0 {
-				status = "disabled";
-				reg = <0>;
-				interrupts = <0 10 4>;
-			};
-			ttc0_1: ttc0.1 {
-				status = "disabled";
-				reg = <1>;
-				interrupts = <0 11 4>;
-			};
-			ttc0_2: ttc0.2 {
-				status = "disabled";
-				reg = <2>;
-				interrupts = <0 12 4>;
-			};
 		};
 
 		ttc1: ttc1 at f8002000 {
-			#interrupt-parent = <&intc>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "xlnx,ttc";
+			interrupt-parent = <&intc>;
+			interrupts = < 0 37 4 0 38 4 0 39 4 >;
+			compatible = "cdns,ttc";
 			reg = <0xF8002000 0x1000>;
 			clocks = <&cpu_clk 3>;
 			clock-names = "cpu_1x";
 			clock-ranges;
-
-			ttc1_0: ttc1.0 {
-				status = "disabled";
-				reg = <0>;
-				interrupts = <0 37 4>;
-			};
-			ttc1_1: ttc1.1 {
-				status = "disabled";
-				reg = <1>;
-				interrupts = <0 38 4>;
-			};
-			ttc1_2: ttc1.2 {
-				status = "disabled";
-				reg = <2>;
-				interrupts = <0 39 4>;
-			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index c772942..86f44d5 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -32,13 +32,3 @@
 &ps_clk {
 	clock-frequency = <33333330>;
 };
-
-&ttc0_0 {
-	status = "ok";
-	compatible = "xlnx,ttc-counter-clocksource";
-};
-
-&ttc0_1 {
-	status = "ok";
-	compatible = "xlnx,ttc-counter-clockevent";
-};
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 5c89832..76493b0 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/clk/zynq.h>
+#include <linux/clocksource.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
diff --git a/arch/arm/mach-zynq/timer.c b/arch/arm/mach-zynq/timer.c
index f9fbc9c..82357d9 100644
--- a/arch/arm/mach-zynq/timer.c
+++ b/arch/arm/mach-zynq/timer.c
@@ -1,7 +1,7 @@
 /*
  * This file contains driver for the Xilinx PS Timer Counter IP.
  *
- *  Copyright (C) 2011 Xilinx
+ *  Copyright (C) 2011-2013 Xilinx
  *
  * based on arch/mips/kernel/time.c timer driver
  *
@@ -15,6 +15,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
 #include <linux/of_address.h>
@@ -24,6 +25,21 @@
 #include "common.h"
 
 /*
+ * This driver configures the 2 16-bit count-up timers as follows:
+ *
+ * T1: Timer 1, clocksource for generic timekeeping
+ * T2: Timer 2, clockevent source for hrtimers
+ * T3: Timer 3, <unused>
+ *
+ * The input frequency to the timer module for emulation is 2.5MHz which is
+ * common to all the timer channels (T1, T2, and T3). With a pre-scaler of 32,
+ * the timers are clocked at 78.125KHz (12.8 us resolution).
+
+ * The input frequency to the timer module in silicon is configurable and
+ * obtained from device tree. The pre-scaler of 32 is used.
+ */
+
+/*
  * Timer Register Offset Definitions of Timer 1, Increment base address by 4
  * and use same offsets for Timer 2
  */
@@ -44,17 +60,24 @@
 #define PRESCALE		2048	/* The exponent must match this */
 #define CLK_CNTRL_PRESCALE	((PRESCALE_EXPONENT - 1) << 1)
 #define CLK_CNTRL_PRESCALE_EN	1
-#define CNT_CNTRL_RESET		(1<<4)
+#define CNT_CNTRL_RESET		(1 << 4)
 
 /**
  * struct xttcps_timer - This definition defines local timer structure
  *
  * @base_addr:	Base address of timer
- **/
+ * @clk:	Associated clock source
+ * @clk_rate_change_nb	Notifier block for clock rate changes
+ */
 struct xttcps_timer {
-	void __iomem	*base_addr;
+	void __iomem *base_addr;
+	struct clk *clk;
+	struct notifier_block clk_rate_change_nb;
 };
 
+#define to_xttcps_timer(x) \
+		container_of(x, struct xttcps_timer, clk_rate_change_nb)
+
 struct xttcps_timer_clocksource {
 	struct xttcps_timer	xttc;
 	struct clocksource	cs;
@@ -66,7 +89,6 @@ struct xttcps_timer_clocksource {
 struct xttcps_timer_clockevent {
 	struct xttcps_timer		xttc;
 	struct clock_event_device	ce;
-	struct clk			*clk;
 };
 
 #define to_xttcps_timer_clkevent(x) \
@@ -167,8 +189,8 @@ static void xttcps_set_mode(enum clock_event_mode mode,
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		xttcps_set_interval(timer,
-				     DIV_ROUND_CLOSEST(clk_get_rate(xttce->clk),
-						       PRESCALE * HZ));
+				DIV_ROUND_CLOSEST(clk_get_rate(xttce->xttc.clk),
+					PRESCALE * HZ));
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 	case CLOCK_EVT_MODE_UNUSED:
@@ -189,79 +211,148 @@ static void xttcps_set_mode(enum clock_event_mode mode,
 	}
 }
 
-static void __init zynq_ttc_setup_clocksource(struct device_node *np,
-					     void __iomem *base)
+static int xttcps_rate_change_clocksource_cb(struct notifier_block *nb,
+		unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct xttcps_timer *xttcps = to_xttcps_timer(nb);
+	struct xttcps_timer_clocksource *xttccs = container_of(xttcps,
+			struct xttcps_timer_clocksource, xttc);
+
+	switch (event) {
+	case POST_RATE_CHANGE:
+		/*
+		 * Do whatever is necessary to maintain a proper time base
+		 *
+		 * I cannot find a way to adjust the currently used clocksource
+		 * to the new frequency. __clocksource_updatefreq_hz() sounds
+		 * good, but does not work. Not sure what's that missing.
+		 *
+		 * This approach works, but triggers two clocksource switches.
+		 * The first after unregister to clocksource jiffies. And
+		 * another one after the register to the newly registered timer.
+		 *
+		 * Alternatively we could 'waste' another HW timer to ping pong
+		 * between clock sources. That would also use one register and
+		 * one unregister call, but only trigger one clocksource switch
+		 * for the cost of another HW timer used by the OS.
+		 */
+		clocksource_unregister(&xttccs->cs);
+		clocksource_register_hz(&xttccs->cs,
+				ndata->new_rate / PRESCALE);
+		/* fall through */
+	case PRE_RATE_CHANGE:
+	case ABORT_RATE_CHANGE:
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static void __init xttc_setup_clocksource(struct clk *clk, void __iomem *base)
 {
 	struct xttcps_timer_clocksource *ttccs;
-	struct clk *clk;
 	int err;
-	u32 reg;
 
 	ttccs = kzalloc(sizeof(*ttccs), GFP_KERNEL);
 	if (WARN_ON(!ttccs))
 		return;
 
-	err = of_property_read_u32(np, "reg", &reg);
-	if (WARN_ON(err))
-		return;
+	ttccs->xttc.clk = clk;
 
-	clk = of_clk_get_by_name(np, "cpu_1x");
-	if (WARN_ON(IS_ERR(clk)))
-		return;
-
-	err = clk_prepare_enable(clk);
+	err = clk_prepare_enable(ttccs->xttc.clk);
 	if (WARN_ON(err))
 		return;
 
-	ttccs->xttc.base_addr = base + reg * 4;
+	ttccs->xttc.clk_rate_change_nb.notifier_call =
+		xttcps_rate_change_clocksource_cb;
+	ttccs->xttc.clk_rate_change_nb.next = NULL;
+	if (clk_notifier_register(ttccs->xttc.clk,
+				&ttccs->xttc.clk_rate_change_nb))
+		pr_warn("Unable to register clock notifier.\n");
 
-	ttccs->cs.name = np->name;
+	ttccs->xttc.base_addr = base;
+	ttccs->cs.name = "xttcps_clocksource";
 	ttccs->cs.rating = 200;
 	ttccs->cs.read = __xttc_clocksource_read;
 	ttccs->cs.mask = CLOCKSOURCE_MASK(16);
 	ttccs->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
+	/*
+	 * Setup the clock source counter to be an incrementing counter
+	 * with no interrupt and it rolls over at 0xFFFF. Pre-scale
+	 * it by 32 also. Let it start running now.
+	 */
 	__raw_writel(0x0,  ttccs->xttc.base_addr + XTTCPS_IER_OFFSET);
 	__raw_writel(CLK_CNTRL_PRESCALE | CLK_CNTRL_PRESCALE_EN,
 		     ttccs->xttc.base_addr + XTTCPS_CLK_CNTRL_OFFSET);
 	__raw_writel(CNT_CNTRL_RESET,
 		     ttccs->xttc.base_addr + XTTCPS_CNT_CNTRL_OFFSET);
 
-	err = clocksource_register_hz(&ttccs->cs, clk_get_rate(clk) / PRESCALE);
+	err = clocksource_register_hz(&ttccs->cs,
+			clk_get_rate(ttccs->xttc.clk) / PRESCALE);
 	if (WARN_ON(err))
 		return;
+
 }
 
-static void __init zynq_ttc_setup_clockevent(struct device_node *np,
-					    void __iomem *base)
+static int xttcps_rate_change_clockevent_cb(struct notifier_block *nb,
+		unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct xttcps_timer *xttcps = to_xttcps_timer(nb);
+	struct xttcps_timer_clockevent *xttcce = container_of(xttcps,
+			struct xttcps_timer_clockevent, xttc);
+
+	switch (event) {
+	case POST_RATE_CHANGE:
+	{
+		unsigned long flags;
+
+		/*
+		 * clockevents_update_freq should be called with IRQ disabled on
+		 * the CPU the timer provides events for. The timer we use is
+		 * common to both CPUs, not sure if we need to run on both
+		 * cores.
+		 */
+		local_irq_save(flags);
+		clockevents_update_freq(&xttcce->ce,
+				ndata->new_rate / PRESCALE);
+		local_irq_restore(flags);
+
+		/* fall through */
+	}
+	case PRE_RATE_CHANGE:
+	case ABORT_RATE_CHANGE:
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static void __init xttc_setup_clockevent(struct clk *clk,
+						void __iomem *base, u32 irq)
 {
 	struct xttcps_timer_clockevent *ttcce;
-	int err, irq;
-	u32 reg;
+	int err;
 
 	ttcce = kzalloc(sizeof(*ttcce), GFP_KERNEL);
 	if (WARN_ON(!ttcce))
 		return;
 
-	err = of_property_read_u32(np, "reg", &reg);
-	if (WARN_ON(err))
-		return;
+	ttcce->xttc.clk = clk;
 
-	ttcce->xttc.base_addr = base + reg * 4;
-
-	ttcce->clk = of_clk_get_by_name(np, "cpu_1x");
-	if (WARN_ON(IS_ERR(ttcce->clk)))
-		return;
-
-	err = clk_prepare_enable(ttcce->clk);
+	err = clk_prepare_enable(ttcce->xttc.clk);
 	if (WARN_ON(err))
 		return;
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (WARN_ON(!irq))
-		return;
+	ttcce->xttc.clk_rate_change_nb.notifier_call =
+		xttcps_rate_change_clockevent_cb;
+	ttcce->xttc.clk_rate_change_nb.next = NULL;
+	if (clk_notifier_register(ttcce->xttc.clk,
+				&ttcce->xttc.clk_rate_change_nb))
+		pr_warn("Unable to register clock notifier.\n");
 
-	ttcce->ce.name = np->name;
+	ttcce->xttc.base_addr = base;
+	ttcce->ce.name = "xttcps_clockevent";
 	ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	ttcce->ce.set_next_event = xttcps_set_next_event;
 	ttcce->ce.set_mode = xttcps_set_mode;
@@ -269,56 +360,80 @@ static void __init zynq_ttc_setup_clockevent(struct device_node *np,
 	ttcce->ce.irq = irq;
 	ttcce->ce.cpumask = cpu_possible_mask;
 
+	/*
+	 * Setup the clock event timer to be an interval timer which
+	 * is prescaled by 32 using the interval interrupt. Leave it
+	 * disabled for now.
+	 */
 	__raw_writel(0x23, ttcce->xttc.base_addr + XTTCPS_CNT_CNTRL_OFFSET);
 	__raw_writel(CLK_CNTRL_PRESCALE | CLK_CNTRL_PRESCALE_EN,
 		     ttcce->xttc.base_addr + XTTCPS_CLK_CNTRL_OFFSET);
 	__raw_writel(0x1,  ttcce->xttc.base_addr + XTTCPS_IER_OFFSET);
 
-	err = request_irq(irq, xttcps_clock_event_interrupt, IRQF_TIMER,
-			  np->name, ttcce);
+	err = request_irq(irq, xttcps_clock_event_interrupt,
+			  IRQF_DISABLED | IRQF_TIMER,
+			  ttcce->ce.name, ttcce);
 	if (WARN_ON(err))
 		return;
 
 	clockevents_config_and_register(&ttcce->ce,
-					clk_get_rate(ttcce->clk) / PRESCALE,
-					1, 0xfffe);
+			clk_get_rate(ttcce->xttc.clk) / PRESCALE, 1, 0xfffe);
 }
 
-static const __initconst struct of_device_id zynq_ttc_match[] = {
-	{ .compatible = "xlnx,ttc-counter-clocksource",
-		.data = zynq_ttc_setup_clocksource, },
-	{ .compatible = "xlnx,ttc-counter-clockevent",
-		.data = zynq_ttc_setup_clockevent, },
-	{}
-};
-
 /**
  * xttcps_timer_init - Initialize the timer
  *
  * Initializes the timer hardware and register the clock source and clock event
  * timers with Linux kernal timer framework
- **/
+ */
+static void __init xttcps_timer_init_of(struct device_node *timer)
+{
+	unsigned int irq;
+	void __iomem *timer_baseaddr;
+	struct clk *clk;
+
+	/*
+	 * Get the 1st Triple Timer Counter (TTC) block from the device tree
+	 * and use it. Note that the event timer uses the interrupt and it's the
+	 * 2nd TTC hence the irq_of_parse_and_map(,1)
+	 */
+	timer_baseaddr = of_iomap(timer, 0);
+	if (!timer_baseaddr) {
+		pr_err("ERROR: invalid timer base address\n");
+		BUG();
+	}
+
+	irq = irq_of_parse_and_map(timer, 1);
+	if (irq <= 0) {
+		pr_err("ERROR: invalid interrupt number\n");
+		BUG();
+	}
+
+	clk = of_clk_get_by_name(timer, "cpu_1x");
+	if (IS_ERR(clk)) {
+		pr_err("ERROR: timer input clock not found\n");
+		BUG();
+	}
+
+	xttc_setup_clocksource(clk, timer_baseaddr);
+	xttc_setup_clockevent(clk, timer_baseaddr + 4, irq);
+
+	pr_info("%s #0@%p, irq=%d\n", timer->name, timer_baseaddr, irq);
+}
+
 void __init xttcps_timer_init(void)
 {
-	struct device_node *np;
-
-	for_each_compatible_node(np, NULL, "xlnx,ttc") {
-		struct device_node *np_chld;
-		void __iomem *base;
-
-		base = of_iomap(np, 0);
-		if (WARN_ON(!base))
-			return;
-
-		for_each_available_child_of_node(np, np_chld) {
-			int (*cb)(struct device_node *np, void __iomem *base);
-			const struct of_device_id *match;
-
-			match = of_match_node(zynq_ttc_match, np_chld);
-			if (match) {
-				cb = match->data;
-				cb(np_chld, base);
-			}
-		}
+	const char * const timer_list[] = {
+		"cdns,ttc",
+		NULL
+	};
+	struct device_node *timer;
+
+	timer = of_find_compatible_node(NULL, NULL, timer_list[0]);
+	if (!timer) {
+		pr_err("ERROR: no compatible timer found\n");
+		BUG();
 	}
+
+	xttcps_timer_init_of(timer);
 }
-- 
1.7.9.7
