From: manabian@gmail.com (Joachim Eastwood)
Date: Wed,  1 Apr 2015 23:20:39 +0200
Subject: [PATCH 2/6] clocksource: add lpc32xx timer driver
In-Reply-To: <1427923243-26296-1-git-send-email-manabian@gmail.com>
References: <1427923243-26296-1-git-send-email-manabian@gmail.com>
Message-ID: <1427923243-26296-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for using the NXP LPC timer as clocksource and
clock event. These timers are present on many NXP devices
including LPC32xx, LPC17xx, LPC18xx and LPC43xx.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 drivers/clocksource/Kconfig        |  10 ++
 drivers/clocksource/Makefile       |   1 +
 drivers/clocksource/time-lpc32xx.c | 249 +++++++++++++++++++++++++++++++++++++
 3 files changed, 260 insertions(+)
 create mode 100644 drivers/clocksource/time-lpc32xx.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a0b036ccb118..5fa8a28ebf35 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -106,6 +106,16 @@ config CLKSRC_EFM32
 	  Support to use the timers of EFM32 SoCs as clock source and clock
 	  event device.
 
+config CLKSRC_LPC32XX
+	bool "Clocksource for NXP's LPC SoC series" if !ARCH_LPC18XX
+	depends on OF && ARM && (ARCH_LPC18XX || COMPILE_TEST)
+	select CLKSRC_MMIO
+	default ARCH_LPC18XX
+	help
+	  Support to use the timers of LPC SoCs as clock source and clock
+	  event device. These timers are present on many NXP devices
+	  including LPC32xx, LPC17xx, LPC18xx and LPC43xx.
+
 config ARM_ARCH_TIMER
 	bool
 	select CLKSRC_OF if OF
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 752d5c70b0ef..c3f0ae067802 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_ARCH_BCM_MOBILE)	+= bcm_kona_timer.o
 obj-$(CONFIG_CADENCE_TTC_TIMER)	+= cadence_ttc_timer.o
 obj-$(CONFIG_CLKSRC_EFM32)	+= time-efm32.o
 obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
+obj-$(CONFIG_CLKSRC_LPC32XX)	+= time-lpc32xx.o
 obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+= samsung_pwm_timer.o
 obj-$(CONFIG_FSL_FTM_TIMER)	+= fsl_ftm_timer.o
 obj-$(CONFIG_VF_PIT_TIMER)	+= vf_pit_timer.o
diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
new file mode 100644
index 000000000000..294fb0bcb712
--- /dev/null
+++ b/drivers/clocksource/time-lpc32xx.c
@@ -0,0 +1,249 @@
+/*
+ * Clocksource driver for NXP LPC32xx/18xx/43xx timer
+ *
+ * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
+ *
+ * Based on:
+ * time-efm32 Copyright (C) 2013 Pengutronix
+ * mach-lpc32xx/timer.c Copyright (C) 2009 - 2010 NXP Semiconductors
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define LPC32XX_TIMER_IR		0x000
+#define  LPC32XX_TIMER_IR_MR0INT	BIT(0)
+#define LPC32XX_TIMER_TCR		0x004
+#define  LPC32XX_TIMER_TCR_CEN		BIT(0)
+#define  LPC32XX_TIMER_TCR_CRST		BIT(1)
+#define LPC32XX_TIMER_TC		0x008
+#define LPC32XX_TIMER_PR		0x00c
+#define LPC32XX_TIMER_MCR		0x014
+#define  LPC32XX_TIMER_MCR_MR0I		BIT(0)
+#define  LPC32XX_TIMER_MCR_MR0R		BIT(1)
+#define  LPC32XX_TIMER_MCR_MR0S		BIT(2)
+#define LPC32XX_TIMER_MR0		0x018
+
+struct lpc32xx_clock_event_ddata {
+	struct clock_event_device evtdev;
+	void __iomem *base;
+};
+
+static int lpc32xx_clkevt_next_event(unsigned long delta,
+				     struct clock_event_device *evtdev)
+{
+	struct lpc32xx_clock_event_ddata *ddata =
+		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
+
+	writel_relaxed(LPC32XX_TIMER_TCR_CRST, ddata->base + LPC32XX_TIMER_TCR);
+	writel_relaxed(delta, ddata->base + LPC32XX_TIMER_PR);
+	writel_relaxed(LPC32XX_TIMER_TCR_CEN, ddata->base + LPC32XX_TIMER_TCR);
+
+	return 0;
+}
+
+static void lpc32xx_clkevt_mode(enum clock_event_mode mode,
+				struct clock_event_device *evtdev)
+{
+	struct lpc32xx_clock_event_ddata *ddata =
+		container_of(evtdev, struct lpc32xx_clock_event_ddata, evtdev);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		WARN_ON(1);
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		/*
+		 * Disable the timer. When using oneshot, we must also
+		 * disable the timer to wait for the first call to
+		 * set_next_event().
+		 */
+		writel_relaxed(0, ddata->base + LPC32XX_TIMER_TCR);
+		break;
+
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+static irqreturn_t lpc32xx_clock_event_handler(int irq, void *dev_id)
+{
+	struct lpc32xx_clock_event_ddata *ddata = dev_id;
+
+	/* Clear match */
+	writel_relaxed(LPC32XX_TIMER_IR_MR0INT, ddata->base + LPC32XX_TIMER_IR);
+
+	ddata->evtdev.event_handler(&ddata->evtdev);
+
+	return IRQ_HANDLED;
+}
+
+static struct lpc32xx_clock_event_ddata lpc32xx_clk_event_ddata = {
+	.evtdev = {
+		.name           = "lpc3250 clockevent",
+		.features       = CLOCK_EVT_FEAT_ONESHOT,
+		.rating         = 300,
+		.set_next_event = lpc32xx_clkevt_next_event,
+		.set_mode       = lpc32xx_clkevt_mode,
+	},
+};
+
+static struct irqaction lpc32xx_clock_event_irq = {
+	.name		= "lpc3250 clockevent",
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= lpc32xx_clock_event_handler,
+	.dev_id		= &lpc32xx_clk_event_ddata,
+};
+
+static int __init lpc32xx_clocksource_init(struct device_node *np)
+{
+	void __iomem *base;
+	unsigned long rate;
+	struct clk *clk;
+	int ret;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("%s: clock get failed (%lu)\n", __func__, PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("%s: clock enable failed (%d)\n", __func__, ret);
+		goto err_clk_enable;
+	}
+
+	rate = clk_get_rate(clk);
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("%s: unable to map registers\n", __func__);
+		ret = -EADDRNOTAVAIL;
+		goto err_iomap;
+	}
+
+	writel_relaxed(LPC32XX_TIMER_TCR_CRST, base + LPC32XX_TIMER_TCR);
+	writel_relaxed(0, base + LPC32XX_TIMER_PR);
+	writel_relaxed(0, base + LPC32XX_TIMER_MCR);
+	writel_relaxed(LPC32XX_TIMER_TCR_CEN, base + LPC32XX_TIMER_TCR);
+
+	ret = clocksource_mmio_init(base + LPC32XX_TIMER_TC, "lpc3250 timer",
+				    rate, 300, 32, clocksource_mmio_readl_up);
+	if (ret) {
+		pr_err("failed to init clocksource (%d)\n", ret);
+		goto err_clocksource_init;
+	}
+
+	return 0;
+
+err_clocksource_init:
+	iounmap(base);
+err_iomap:
+	clk_disable_unprepare(clk);
+err_clk_enable:
+	clk_put(clk);
+	return ret;
+}
+
+static int __init lpc32xx_clockevent_init(struct device_node *np)
+{
+	void __iomem *base;
+	unsigned long rate;
+	struct clk *clk;
+	int ret, irq;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("%s: clock get failed (%lu)\n", __func__, PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("%s: clock enable failed (%d)\n", __func__, ret);
+		goto err_clk_enable;
+	}
+
+	rate = clk_get_rate(clk);
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("%s: unable to map registers\n", __func__);
+		ret = -EADDRNOTAVAIL;
+		goto err_iomap;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (!irq) {
+		pr_err("%s: get irq failed\n", __func__);
+		ret = -ENOENT;
+		goto err_get_irq;
+	}
+
+	/* Initial timer setup */
+	writel_relaxed(0, base + LPC32XX_TIMER_TCR);
+	writel_relaxed(LPC32XX_TIMER_IR_MR0INT, base + LPC32XX_TIMER_IR);
+	writel_relaxed(1, base + LPC32XX_TIMER_MR0);
+	writel_relaxed(LPC32XX_TIMER_MCR_MR0I | LPC32XX_TIMER_MCR_MR0R |
+		       LPC32XX_TIMER_MCR_MR0S, base + LPC32XX_TIMER_MCR);
+
+	lpc32xx_clk_event_ddata.base = base;
+
+	setup_irq(irq, &lpc32xx_clock_event_irq);
+
+	clockevents_config_and_register(&lpc32xx_clk_event_ddata.evtdev,
+					rate, 1, -1);
+
+	return 0;
+
+err_get_irq:
+	iounmap(base);
+err_iomap:
+	clk_disable_unprepare(clk);
+err_clk_enable:
+	clk_put(clk);
+	return ret;
+}
+
+/*
+ * This function asserts that we have exactly one clocksource and one
+ * clock_event_device in the end.
+ */
+static void __init lpc32xx_timer_init(struct device_node *np)
+{
+	static int has_clocksource, has_clockevent;
+	int ret;
+
+	if (!has_clocksource) {
+		ret = lpc32xx_clocksource_init(np);
+		if (!ret) {
+			has_clocksource = 1;
+			return;
+		}
+	}
+
+	if (!has_clockevent) {
+		ret = lpc32xx_clockevent_init(np);
+		if (!ret) {
+			has_clockevent = 1;
+			return;
+		}
+	}
+}
+CLOCKSOURCE_OF_DECLARE(lpc32xx_timer, "nxp,lpc3250-timer", lpc32xx_timer_init);
-- 
1.8.0
