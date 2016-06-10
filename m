From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 00:03:46 +0200
Subject: [PATCH 43/48] clocksource/drivers: Add a clockevent driver for Atmel
 TC blocks
In-Reply-To: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465596231-21766-44-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an independent clockevent driver for the Atmel Timer Counter Blocks.
This driver provides a single clockevent device. using its own TCB channel.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/Kconfig                 |  10 ++
 drivers/clocksource/Makefile                |   1 +
 drivers/clocksource/timer-atmel-tcbclkevt.c | 220 ++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 drivers/clocksource/timer-atmel-tcbclkevt.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index ff7f4022c749..1860f6f9b380 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -271,6 +271,16 @@ config ATMEL_ARM_TCB_CLKSRC
 	  to make a single 32-bit timer.
 	  It can also be used as a clock event device supporting oneshot mode.
 
+config ATMEL_ARM_TCB_CLKEVT
+	bool "TC Block Clockevent"
+	select REGMAP_MMIO
+	depends on GENERIC_CLOCKEVENTS
+	depends on SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
+	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
+	help
+	  Select this to get a high precision clockevent device based on a TC
+	  Block with the slow clock as its input.
+
 config CLKSRC_METAG_GENERIC
 	def_bool y if METAG
 	help
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 988f33de5808..c4a4155ccedc 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
 obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
 obj-$(CONFIG_ATMEL_TCB_CLKSRC) += tcb_clksrc.o
 obj-$(CONFIG_ATMEL_ARM_TCB_CLKSRC)	+= timer-atmel-tcbclksrc.o
+obj-$(CONFIG_ATMEL_ARM_TCB_CLKEVT)	+= timer-atmel-tcbclkevt.o
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
 obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= cs5535-clockevt.o
diff --git a/drivers/clocksource/timer-atmel-tcbclkevt.c b/drivers/clocksource/timer-atmel-tcbclkevt.c
new file mode 100644
index 000000000000..71440fd27b49
--- /dev/null
+++ b/drivers/clocksource/timer-atmel-tcbclkevt.c
@@ -0,0 +1,220 @@
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <soc/at91/atmel_tcb.h>
+
+struct tc_clkevt_device {
+	struct clock_event_device clkevt;
+	struct regmap *regmap;
+	struct clk *slow_clk;
+	struct clk *clk;
+	int channel;
+	int irq;
+};
+
+static struct tc_clkevt_device *to_tc_clkevt(struct clock_event_device *clkevt)
+{
+	return container_of(clkevt, struct tc_clkevt_device, clkevt);
+}
+
+static int tc_shutdown(struct clock_event_device *d)
+{
+	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
+
+	regmap_write(tcd->regmap, ATMEL_TC_IDR(tcd->channel), 0xff);
+	regmap_write(tcd->regmap, ATMEL_TC_CCR(tcd->channel),
+		     ATMEL_TC_CCR_CLKDIS);
+	if (!clockevent_state_detached(d))
+		clk_disable(tcd->clk);
+
+	return 0;
+}
+
+/* For now, we always use the 32K clock ... this optimizes for NO_HZ,
+ * because using one of the divided clocks would usually mean the
+ * tick rate can never be less than several dozen Hz (vs 0.5 Hz).
+ *
+ * A divided clock could be good for high resolution timers, since
+ * 30.5 usec resolution can seem "low".
+ */
+static int tc_set_oneshot(struct clock_event_device *d)
+{
+	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
+
+	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
+		tc_shutdown(d);
+
+	clk_enable(tcd->clk);
+
+	/* slow clock, count up to RC, then irq and stop */
+	regmap_write(tcd->regmap, ATMEL_TC_CMR(tcd->channel),
+		     ATMEL_TC_CMR_TCLK(4) | ATMEL_TC_CMR_CPCSTOP |
+		     ATMEL_TC_CMR_WAVE | ATMEL_TC_CMR_WAVESEL_UPRC);
+	regmap_write(tcd->regmap, ATMEL_TC_IER(tcd->channel),
+		     ATMEL_TC_CPCS);
+
+	return 0;
+}
+
+static int tc_set_periodic(struct clock_event_device *d)
+{
+	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
+
+	if (clockevent_state_oneshot(d) || clockevent_state_periodic(d))
+		tc_shutdown(d);
+
+	/* By not making the gentime core emulate periodic mode on top
+	 * of oneshot, we get lower overhead and improved accuracy.
+	 */
+	clk_enable(tcd->clk);
+
+	/* slow clock, count up to RC, then irq and restart */
+	regmap_write(tcd->regmap, ATMEL_TC_CMR(tcd->channel),
+		     ATMEL_TC_CMR_TCLK(4) | ATMEL_TC_CMR_WAVE |
+		     ATMEL_TC_CMR_WAVESEL_UPRC);
+	regmap_write(tcd->regmap, ATMEL_TC_RC(tcd->channel),
+		     (32768 + HZ / 2) / HZ);
+
+	/* Enable clock and interrupts on RC compare */
+	regmap_write(tcd->regmap, ATMEL_TC_IER(tcd->channel), ATMEL_TC_CPCS);
+	regmap_write(tcd->regmap, ATMEL_TC_CCR(tcd->channel),
+		     ATMEL_TC_CCR_CLKEN | ATMEL_TC_CCR_SWTRG);
+
+	return 0;
+}
+
+static int tc_next_event(unsigned long delta, struct clock_event_device *d)
+{
+	struct tc_clkevt_device *tcd = to_tc_clkevt(d);
+
+	regmap_write(tcd->regmap, ATMEL_TC_RC(tcd->channel), delta);
+	regmap_write(tcd->regmap, ATMEL_TC_CCR(tcd->channel),
+		     ATMEL_TC_CCR_CLKEN | ATMEL_TC_CCR_SWTRG);
+
+	return 0;
+}
+
+static struct tc_clkevt_device clkevt = {
+	.clkevt	= {
+		.features		= CLOCK_EVT_FEAT_PERIODIC |
+					  CLOCK_EVT_FEAT_ONESHOT,
+		/* Should be lower than at91rm9200's system timer */
+		.rating			= 140,
+		.set_next_event		= tc_next_event,
+		.set_state_shutdown	= tc_shutdown,
+		.set_state_periodic	= tc_set_periodic,
+		.set_state_oneshot	= tc_set_oneshot,
+	},
+};
+
+static irqreturn_t tc_clkevt_irq(int irq, void *handle)
+{
+	struct tc_clkevt_device	*tcd = handle;
+	unsigned int		sr;
+
+	regmap_read(tcd->regmap, ATMEL_TC_SR(tcd->channel), &sr);
+	if (sr & ATMEL_TC_CPCS) {
+		tcd->clkevt.event_handler(&tcd->clkevt);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int tcb_clkevt_probe(struct platform_device *pdev)
+{
+	struct tc_clkevt_device *tcd = &clkevt;
+	int ret;
+	struct device_node *node = pdev->dev.of_node;
+
+	ret = of_property_read_u32_index(node, "reg", 0, &tcd->channel);
+	if (ret)
+		return ret;
+
+	tcd->irq = tcb_irq_get(node, tcd->channel);
+	if (tcd->irq < 0)
+		return tcd->irq;
+
+	tcd->regmap = syscon_node_to_regmap(node->parent);
+	if (IS_ERR(tcd->regmap))
+		return PTR_ERR(tcd->regmap);
+
+	tcd->slow_clk = of_clk_get_by_name(node->parent, "slow_clk");
+	if (IS_ERR(tcd->slow_clk))
+		return PTR_ERR(tcd->slow_clk);
+
+	ret = clk_prepare_enable(tcd->slow_clk);
+	if (ret)
+		return ret;
+
+	tcd->clk = tcb_clk_get(node, tcd->channel);
+	if (IS_ERR(tcd->clk)) {
+		ret = PTR_ERR(tcd->clk);
+		goto err_slow;
+	}
+
+	clkevt.clkevt.name = dev_name(&pdev->dev);
+
+	/* try to enable clk to avoid future errors in mode change */
+	ret = clk_prepare_enable(tcd->clk);
+	if (ret)
+		goto err_slow;
+
+	clk_disable(tcd->clk);
+
+	clkevt.clkevt.cpumask = cpumask_of(0);
+
+	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
+
+	ret = request_irq(tcd->irq, tc_clkevt_irq, IRQF_TIMER | IRQF_SHARED,
+			  clkevt.clkevt.name, &clkevt);
+	if (ret)
+		goto err_clk;
+
+	return 0;
+
+err_clk:
+	clk_unprepare(tcd->clk);
+err_slow:
+	clk_disable_unprepare(tcd->slow_clk);
+
+	return ret;
+}
+
+static const struct of_device_id atmel_tcb_clkevt_dt_ids[] = {
+	{ .compatible = "atmel,tcb-clkevt" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, atmel_tcb_clkevt_dt_ids);
+
+static struct platform_driver tcb_clkevt_driver = {
+	.probe		= tcb_clkevt_probe,
+	.driver         = {
+		.name   = "atmel_tcb_clkevt",
+		.of_match_table = of_match_ptr(atmel_tcb_clkevt_dt_ids),
+	},
+};
+
+static int __init atmel_tcb_clkevt_init(void)
+{
+	return platform_driver_register(&tcb_clkevt_driver);
+}
+
+static void __exit atmel_tcb_clkevt_exit(void)
+{
+	platform_driver_unregister(&tcb_clkevt_driver);
+}
+
+early_platform_init("earlytimer", &tcb_clkevt_driver);
+subsys_initcall(atmel_tcb_clkevt_init);
+module_exit(atmel_tcb_clkevt_exit);
+
+MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@free-electrons.com>");
+MODULE_DESCRIPTION("Clockevents driver for Atmel Timer Counter Blocks");
+MODULE_LICENSE("GPL v2");
-- 
2.8.1
