From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 13:05:34 +0800
Subject: [PATCH v3 03/11] clocksource: sp804: add device tree support
In-Reply-To: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1363151142-32162-4-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parse clock & irq from device tree for sp804.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 .../devicetree/bindings/timer/arm,sp804.txt        |   27 +++++
 drivers/clocksource/timer-sp.c                     |  105 ++++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.txt

diff --git a/Documentation/devicetree/bindings/timer/arm,sp804.txt b/Documentation/devicetree/bindings/timer/arm,sp804.txt
new file mode 100644
index 0000000..ec1ae45
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/arm,sp804.txt
@@ -0,0 +1,27 @@
+ARM sp804 Dual Timers
+---------------------------------------
+
+Required properties:
+- compatible: Should be "arm,sp804" & "arm,primecell"
+- interrupts: Should contain the list of Dual Timer interrupts
+	interrupts = <0 0 4>, <0 1 4>;
+- reg: Should contain location and length for dual timer register.
+- clocks: clock driving the dual timer hardware
+	clocks = <&timclk0 &timclk1>;
+
+Optional properties:
+- arm,sp804-clocksource: Should contain the register offset of TIMER1 or
+  TIMER2 in Dual Timer Controller.
+	arm,sp804-clocksource = <0x20>;
+
+Example:
+
+	timer0: timer at fc800000 {
+		compatible = "arm,sp804", "arm,primecell";
+		reg = <0xfc800000 0x1000>;
+		/* timer00 & timer01 */
+		interrupts = <0 0 4>, <0 1 4>;
+		clocks = <&timclk0 &timclk1>;
+		clock-names = "apb_pclk";
+		status = "disabled";
+	};
diff --git a/drivers/clocksource/timer-sp.c b/drivers/clocksource/timer-sp.c
index a7f2510..63f757d 100644
--- a/drivers/clocksource/timer-sp.c
+++ b/drivers/clocksource/timer-sp.c
@@ -19,16 +19,23 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <asm/sched_clock.h>
 
+#define SP804_CLKSRC	"sp804 source"
+#define SP804_CLKEVT	"sp804 event"
+
 static long __init sp804_get_clock_rate(const char *name)
 {
 	struct clk *clk;
@@ -189,3 +196,101 @@ void __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
 	setup_irq(irq, &sp804_timer_irq);
 	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
 }
+
+static struct device_node *from = NULL;
+
+static struct of_device_id sp804_timer_match[] __initdata = {
+	{ .compatible = "arm,sp804", },
+	{}
+};
+
+static struct clk __init *sp804_dt_init_clk(struct device_node *np, int i,
+					    const char *name)
+{
+	struct clk_lookup *lookup = NULL;
+	struct clk *clk;
+
+	clk = of_clk_get(np, i);
+	if (IS_ERR(clk))
+		return clk;
+	lookup = clkdev_alloc(clk, name, "sp804");
+	if (!lookup) {
+		clk_put(clk);
+		return ERR_PTR(-EINVAL);
+	}
+	clkdev_add(lookup);
+	return clk;
+}
+
+static void __attribute__((__unused__)) __init sp804_dt_init(void)
+{
+	struct device_node *np = NULL;
+	struct clk *clksrc = NULL, *clkevt = NULL;
+	void __iomem *base;
+	int retsrc, retevt, i = 0, irq = 0;
+	u32 srcoffs = 0, evtoffs = 0;
+
+	np = of_find_matching_node(from, sp804_timer_match);
+	WARN_ON(!np);
+	if (!np) {
+		pr_err("Failed to find sp804 timer\n");
+		return;
+	}
+	from = np;
+	/* check whether timer node is available */
+	if (!of_device_is_available(np))
+		return;
+
+	base = of_iomap(np, 0);
+	WARN_ON(!base);
+	if (!base)
+		return;
+
+	retsrc = of_property_read_u32(np, "arm,sp804-clocksource", &srcoffs);
+	retevt = of_property_read_u32(np, "arm,sp804-clockevent", &evtoffs);
+	if (retsrc < 0 && retevt < 0)
+		goto err;
+
+	if (!retsrc) {
+		if (srcoffs) {
+			/* TIMER2 is clock source */
+			i = 1;
+			srcoffs = TIMER_2_BASE;
+		} else {
+			/* TIMER1 is clock source */
+			i = 0;
+			srcoffs = TIMER_1_BASE;
+		}
+		clksrc = sp804_dt_init_clk(np, i, SP804_CLKSRC);
+		if (IS_ERR(clksrc))
+			goto err;
+		sp804_clocksource_and_sched_clock_init(base + srcoffs,
+						       SP804_CLKSRC);
+	}
+	if (!retevt) {
+		if (evtoffs) {
+			/* TIMER2 is clock event */
+			i = 1;
+			evtoffs = TIMER_2_BASE;
+		} else {
+			/* TIMER1 is clock event */
+			i = 0;
+			evtoffs = TIMER_1_BASE;
+		}
+		irq = irq_of_parse_and_map(np, i);
+		if (irq < 0)
+			goto err_evt;
+		clkevt = sp804_dt_init_clk(np, i, SP804_CLKEVT);
+		if (IS_ERR(clkevt))
+			goto err_evt;
+		sp804_clockevents_init(base + evtoffs, irq, SP804_CLKEVT);
+	}
+
+	return;
+err_evt:
+	if (clksrc)
+		clk_put(clksrc);
+err:
+	iounmap(base);
+}
+CLOCKSOURCE_OF_DECLARE(sp804, "arm,sp804", sp804_dt_init)
-- 
1.7.10.4
