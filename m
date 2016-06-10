From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 00:03:45 +0200
Subject: [PATCH 42/48] clocksource/drivers: Add a new driver for the Atmel ARM
 TC blocks
In-Reply-To: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465596231-21766-43-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a driver for the Atmel Timer Counter Blocks. This driver provides a
clocksource and a clockevent device. The clockevent device is linked to the
clocksource counter and so it will run at the same frequency.

This driver uses regmap and syscon to be able to probe early in the boot
and avoid having to switch on the TCB clocksource later. Using regmap also
means that unused TCB channels may be used by other drivers (PWM for
example).

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/Kconfig                 |  13 ++
 drivers/clocksource/Makefile                |   3 +-
 drivers/clocksource/timer-atmel-tcbclksrc.c | 305 ++++++++++++++++++++++++++++
 include/soc/at91/atmel_tcb.h                | 220 ++++++++++++++++++++
 4 files changed, 540 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clocksource/timer-atmel-tcbclksrc.c
 create mode 100644 include/soc/at91/atmel_tcb.h

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 47352d25c15e..ff7f4022c749 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -258,6 +258,19 @@ config ATMEL_ST
 	select CLKSRC_OF
 	select MFD_SYSCON
 
+config ATMEL_ARM_TCB_CLKSRC
+	bool "TC Block Clocksource"
+	select REGMAP_MMIO
+	depends on GENERIC_CLOCKEVENTS
+	depends on SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
+	default SOC_AT91RM9200 || SOC_AT91SAM9 || SOC_SAMA5
+	help
+	  Select this to get a high precision clocksource based on a
+	  TC block with a 5+ MHz base clock rate.
+	  On platforms with 16-bit counters, two timer channels are combined
+	  to make a single 32-bit timer.
+	  It can also be used as a clock event device supporting oneshot mode.
+
 config CLKSRC_METAG_GENERIC
 	def_bool y if METAG
 	help
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 473974f9590a..988f33de5808 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -1,7 +1,8 @@
 obj-$(CONFIG_CLKSRC_PROBE)	+= clksrc-probe.o
 obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
 obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
-obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
+obj-$(CONFIG_ATMEL_TCB_CLKSRC) += tcb_clksrc.o
+obj-$(CONFIG_ATMEL_ARM_TCB_CLKSRC)	+= timer-atmel-tcbclksrc.o
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
 obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= cs5535-clockevt.o
diff --git a/drivers/clocksource/timer-atmel-tcbclksrc.c b/drivers/clocksource/timer-atmel-tcbclksrc.c
new file mode 100644
index 000000000000..af0b1aab7a98
--- /dev/null
+++ b/drivers/clocksource/timer-atmel-tcbclksrc.c
@@ -0,0 +1,305 @@
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+#include <linux/sched_clock.h>
+#include <soc/at91/atmel_tcb.h>
+
+struct atmel_tcb_clksrc {
+	struct clocksource clksrc;
+	struct clock_event_device clkevt;
+	struct regmap *regmap;
+	struct clk *clk[2];
+	int channels[2];
+	u8 bits;
+	unsigned int irq;
+	bool registered;
+	bool irq_requested;
+};
+
+static struct atmel_tcb_clksrc tc = {
+	.clksrc = {
+		.name		= "tcb_clksrc",
+		.rating		= 200,
+		.mask		= CLOCKSOURCE_MASK(32),
+		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	},
+	.clkevt	= {
+		.name			= "tcb_clkevt",
+		.features		= CLOCK_EVT_FEAT_ONESHOT,
+		/* Should be lower than at91rm9200's system timer */
+		.rating			= 125,
+	},
+};
+
+static cycle_t tc_get_cycles(struct clocksource *cs)
+{
+	unsigned long	flags;
+	u32		lower, upper, tmp;
+
+	raw_local_irq_save(flags);
+	do {
+		regmap_read(tc.regmap, ATMEL_TC_CV(1), &upper);
+		regmap_read(tc.regmap, ATMEL_TC_CV(0), &lower);
+		regmap_read(tc.regmap, ATMEL_TC_CV(1), &tmp);
+	} while (upper != tmp);
+
+	raw_local_irq_restore(flags);
+	return (upper << 16) | lower;
+}
+
+static cycle_t tc_get_cycles32(struct clocksource *cs)
+{
+	u32 val;
+
+	regmap_read(tc.regmap, ATMEL_TC_CV(tc.channels[0]), &val);
+
+	return val;
+}
+
+static u64 tc_sched_clock_read(void)
+{
+	return tc_get_cycles(&tc.clksrc);
+}
+
+static u64 tc_sched_clock_read32(void)
+{
+	return tc_get_cycles32(&tc.clksrc);
+}
+
+static int tcb_clkevt_next_event(unsigned long delta,
+				 struct clock_event_device *d)
+{
+	u32 val;
+
+	regmap_read(tc.regmap, ATMEL_TC_CV(tc.channels[0]), &val);
+	regmap_write(tc.regmap, ATMEL_TC_RC(tc.channels[0]), val + delta);
+	regmap_write(tc.regmap, ATMEL_TC_IER(tc.channels[0]), ATMEL_TC_CPCS);
+
+	return 0;
+}
+
+static irqreturn_t tc_clkevt_irq(int irq, void *handle)
+{
+	unsigned int sr;
+
+	regmap_read(tc.regmap, ATMEL_TC_SR(tc.channels[0]), &sr);
+	if (sr & ATMEL_TC_CPCS) {
+		tc.clkevt.event_handler(&tc.clkevt);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int tcb_clkevt_oneshot(struct clock_event_device *dev)
+{
+	int ret;
+
+	if (tc.irq_requested)
+		return 0;
+
+	ret = request_irq(tc.irq, tc_clkevt_irq, IRQF_TIMER | IRQF_SHARED,
+			  "tcb_clkevt", &tc);
+	if (!ret)
+		tc.irq_requested = true;
+
+	return ret;
+}
+
+static int tcb_clkevt_shutdown(struct clock_event_device *dev)
+{
+	regmap_write(tc.regmap, ATMEL_TC_IDR(tc.channels[0]), 0xff);
+	if (tc.bits == 16)
+		regmap_write(tc.regmap, ATMEL_TC_IDR(tc.channels[1]), 0xff);
+
+	if (tc.irq_requested) {
+		free_irq(tc.irq, &tc);
+		tc.irq_requested = false;
+	}
+
+	return 0;
+}
+
+static void __init tcb_setup_dual_chan(struct atmel_tcb_clksrc *tc,
+				       int mck_divisor_idx)
+{
+	/* first channel: waveform mode, input mclk/8, clock TIOA on overflow */
+	regmap_write(tc->regmap, ATMEL_TC_CMR(tc->channels[0]),
+		     mck_divisor_idx	/* likely divide-by-8 */
+			| ATMEL_TC_CMR_WAVE
+			| ATMEL_TC_CMR_WAVESEL_UP	/* free-run */
+			| ATMEL_TC_CMR_ACPA(SET)	/* TIOA rises at 0 */
+			| ATMEL_TC_CMR_ACPC(CLEAR));	/* (duty cycle 50%) */
+	regmap_write(tc->regmap, ATMEL_TC_RA(tc->channels[0]), 0x0000);
+	regmap_write(tc->regmap, ATMEL_TC_RC(tc->channels[0]), 0x8000);
+	regmap_write(tc->regmap, ATMEL_TC_IDR(tc->channels[0]), 0xff);	/* no irqs */
+	regmap_write(tc->regmap, ATMEL_TC_CCR(tc->channels[0]),
+		     ATMEL_TC_CCR_CLKEN);
+
+	/* second channel: waveform mode, input TIOA */
+	regmap_write(tc->regmap, ATMEL_TC_CMR(tc->channels[1]),
+		     ATMEL_TC_CMR_XC(tc->channels[1])	/* input: TIOA */
+		     | ATMEL_TC_CMR_WAVE
+		     | ATMEL_TC_CMR_WAVESEL_UP);	/* free-run */
+	regmap_write(tc->regmap, ATMEL_TC_IDR(tc->channels[1]), 0xff);	/* no irqs */
+	regmap_write(tc->regmap, ATMEL_TC_CCR(tc->channels[1]),
+		     ATMEL_TC_CCR_CLKEN);
+
+	/* chain both channel, we assume the previous channel */
+	regmap_write(tc->regmap, ATMEL_TC_BMR,
+		     ATMEL_TC_BMR_TCXC(1 + tc->channels[1], tc->channels[1]));
+	/* then reset all the timers */
+	regmap_write(tc->regmap, ATMEL_TC_BCR, ATMEL_TC_BCR_SYNC);
+}
+
+static void __init tcb_setup_single_chan(struct atmel_tcb_clksrc *tc,
+					 int mck_divisor_idx)
+{
+	/* channel 0:  waveform mode, input mclk/8 */
+	regmap_write(tc->regmap, ATMEL_TC_CMR(tc->channels[0]),
+		     mck_divisor_idx	/* likely divide-by-8 */
+			| ATMEL_TC_CMR_WAVE
+			| ATMEL_TC_CMR_WAVESEL_UP	/* free-run */
+			);
+	regmap_write(tc->regmap, ATMEL_TC_IDR(tc->channels[0]), 0xff);	/* no irqs */
+	regmap_write(tc->regmap, ATMEL_TC_CCR(tc->channels[0]),
+		     ATMEL_TC_CCR_CLKEN);
+
+	/* then reset all the timers */
+	regmap_write(tc->regmap, ATMEL_TC_BCR, ATMEL_TC_BCR_SYNC);
+}
+
+static void __init tcb_clksrc_init(struct device_node *node)
+{
+	const struct of_device_id *match;
+	u32 rate, divided_rate = 0;
+	int best_divisor_idx = -1;
+	int i, err;
+
+	if (tc.registered)
+		return;
+
+	tc.regmap = syscon_node_to_regmap(node->parent);
+	if (IS_ERR(tc.regmap))
+		return;
+
+	match = of_match_node(atmel_tcb_dt_ids, node->parent);
+	tc.bits = (int)match->data;
+
+	err = of_property_read_u32_index(node, "reg", 0, &tc.channels[0]);
+	if (err)
+		return;
+
+	tc.channels[1] = -1;
+
+	if (tc.bits == 16) {
+		of_property_read_u32_index(node, "reg", 1, &tc.channels[1]);
+		if (tc.channels[1] == -1) {
+			pr_err("%s: clocksource needs two channels\n",
+			       node->parent->full_name);
+		}
+	}
+
+	tc.irq = tcb_irq_get(node, tc.channels[0]);
+	if (tc.irq < 0)
+		return;
+
+	tc.clk[0] = tcb_clk_get(node, tc.channels[0]);
+	if (IS_ERR(tc.clk[0]))
+		return;
+	err = clk_prepare_enable(tc.clk[0]);
+	if (err) {
+		pr_debug("can't enable T0 clk\n");
+		goto err_clk;
+	}
+
+	if (tc.bits == 16) {
+		tc.clk[1] = tcb_clk_get(node, tc.channels[1]);
+		if (IS_ERR(tc.clk[1]))
+			goto err_disable_t0;
+	}
+
+	/* How fast will we be counting?  Pick something over 5 MHz.  */
+	rate = (u32)clk_get_rate(tc.clk[0]);
+	for (i = 0; i < 5; i++) {
+		unsigned int divisor = atmel_tc_divisors[i];
+		unsigned int tmp;
+
+		if (!divisor)
+			continue;
+
+		tmp = rate / divisor;
+		pr_debug("TC: %u / %-3u [%d] --> %u\n", rate, divisor, i, tmp);
+		if (best_divisor_idx > 0) {
+			if (tmp < 5 * 1000 * 1000)
+				continue;
+		}
+		divided_rate = tmp;
+		best_divisor_idx = i;
+	}
+
+	pr_debug("%s: %s@%d.%03d MHz\n", tc.clksrc.name,
+		 node->parent->full_name, divided_rate / 1000000,
+		 ((divided_rate + 500000) % 1000000) / 1000);
+
+	if (tc.bits == 32) {
+		tc.clksrc.read = tc_get_cycles32;
+		tcb_setup_single_chan(&tc, best_divisor_idx);
+	} else {
+		err = clk_prepare_enable(tc.clk[1]);
+		if (err) {
+			pr_debug("can't enable T1 clk\n");
+			goto err_clk1;
+		}
+		tc.clksrc.read = tc_get_cycles,
+		tcb_setup_dual_chan(&tc, best_divisor_idx);
+	}
+
+	err = clocksource_register_hz(&tc.clksrc, divided_rate);
+	if (err)
+		goto err_disable_t1;
+
+	if (tc.bits == 32)
+		sched_clock_register(tc_sched_clock_read32, 32, divided_rate);
+	else
+		sched_clock_register(tc_sched_clock_read, 32, divided_rate);
+
+	tc.registered = true;
+
+	/* Set up and register clockevents */
+	tc.clkevt.cpumask = cpumask_of(0);
+	tc.clkevt.set_next_event = tcb_clkevt_next_event;
+	tc.clkevt.set_state_oneshot = tcb_clkevt_oneshot;
+	tc.clkevt.set_state_shutdown = tcb_clkevt_shutdown;
+	if (tc.bits == 16)
+		clockevents_config_and_register(&tc.clkevt, divided_rate, 1,
+						0xffff);
+	else
+		clockevents_config_and_register(&tc.clkevt, divided_rate, 1,
+						0xffffffff);
+	return;
+
+err_disable_t1:
+	if (tc.bits == 16)
+		clk_disable_unprepare(tc.clk[1]);
+
+err_clk1:
+	if (tc.bits == 16)
+		clk_put(tc.clk[1]);
+
+err_disable_t0:
+	clk_disable_unprepare(tc.clk[0]);
+
+err_clk:
+	clk_put(tc.clk[0]);
+
+	pr_err("%s: unable to register clocksource/clockevent\n",
+	       tc.clksrc.name);
+}
+CLOCKSOURCE_OF_DECLARE(atmel_tcb_clksrc, "atmel,tcb-clksrc",
+		       tcb_clksrc_init);
diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
new file mode 100644
index 000000000000..ceb279810ce4
--- /dev/null
+++ b/include/soc/at91/atmel_tcb.h
@@ -0,0 +1,220 @@
+/*
+ * Copyright (C) 2016 Atmel
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __SOC_ATMEL_TCB_H
+#define __SOC_ATMEL_TCB_H
+
+/* Channel registers */
+#define ATMEL_TC_COFFS(c)		((c) * 0x40)
+#define ATMEL_TC_CCR(c)			ATMEL_TC_COFFS(c)
+#define ATMEL_TC_CMR(c)			(ATMEL_TC_COFFS(c) + 0x4)
+#define ATMEL_TC_SMMR(c)		(ATMEL_TC_COFFS(c) + 0x8)
+#define ATMEL_TC_RAB(c)			(ATMEL_TC_COFFS(c) + 0xc)
+#define ATMEL_TC_CV(c)			(ATMEL_TC_COFFS(c) + 0x10)
+#define ATMEL_TC_RA(c)			(ATMEL_TC_COFFS(c) + 0x14)
+#define ATMEL_TC_RB(c)			(ATMEL_TC_COFFS(c) + 0x18)
+#define ATMEL_TC_RC(c)			(ATMEL_TC_COFFS(c) + 0x1c)
+#define ATMEL_TC_SR(c)			(ATMEL_TC_COFFS(c) + 0x20)
+#define ATMEL_TC_IER(c)			(ATMEL_TC_COFFS(c) + 0x24)
+#define ATMEL_TC_IDR(c)			(ATMEL_TC_COFFS(c) + 0x28)
+#define ATMEL_TC_IMR(c)			(ATMEL_TC_COFFS(c) + 0x2c)
+#define ATMEL_TC_EMR(c)			(ATMEL_TC_COFFS(c) + 0x30)
+
+/* Block registers */
+#define ATMEL_TC_BCR			0xc0
+#define ATMEL_TC_BMR			0xc4
+#define ATMEL_TC_QIER			0xc8
+#define ATMEL_TC_QIDR			0xcc
+#define ATMEL_TC_QIMR			0xd0
+#define ATMEL_TC_QISR			0xd4
+#define ATMEL_TC_FMR			0xd8
+#define ATMEL_TC_WPMR			0xe4
+
+/* CCR fields */
+#define ATMEL_TC_CCR_CLKEN		BIT(0)
+#define ATMEL_TC_CCR_CLKDIS		BIT(1)
+#define ATMEL_TC_CCR_SWTRG		BIT(2)
+
+/* Common CMR fields */
+#define ATMEL_TC_CMR_TCLKS_MSK		GENMASK(2, 0)
+#define ATMEL_TC_CMR_TCLK(x)		(x)
+#define ATMEL_TC_CMR_XC(x)		((x) + 5)
+#define ATMEL_TC_CMR_CLKI		BIT(3)
+#define ATMEL_TC_CMR_BURST_MSK		GENMASK(5, 4)
+#define ATMEL_TC_CMR_BURST_XC(x)	(((x) + 1) << 4)
+#define ATMEL_TC_CMR_WAVE		BIT(15)
+
+/* Capture mode CMR fields */
+#define ATMEL_TC_CMR_LDBSTOP		BIT(6)
+#define ATMEL_TC_CMR_LDBDIS		BIT(7)
+#define ATMEL_TC_CMR_ETRGEDG_MSK	GENMASK(9, 8)
+#define ATMEL_TC_CMR_ETRGEDG_NONE	(0 << 8)
+#define ATMEL_TC_CMR_ETRGEDG_RISING	(1 << 8)
+#define ATMEL_TC_CMR_ETRGEDG_FALLING	(2 << 8)
+#define ATMEL_TC_CMR_ETRGEDG_BOTH	(3 << 8)
+#define ATMEL_TC_CMR_ABETRG		BIT(10)
+#define ATMEL_TC_CMR_CPCTRG		BIT(14)
+#define ATMEL_TC_CMR_LDRA_MSK		GENMASK(17, 16)
+#define ATMEL_TC_CMR_LDRA_NONE		(0 << 16)
+#define ATMEL_TC_CMR_LDRA_RISING	(1 << 16)
+#define ATMEL_TC_CMR_LDRA_FALLING	(2 << 16)
+#define ATMEL_TC_CMR_LDRA_BOTH		(3 << 16)
+#define ATMEL_TC_CMR_LDRB_MSK		GENMASK(19, 18)
+#define ATMEL_TC_CMR_LDRB_NONE		(0 << 18)
+#define ATMEL_TC_CMR_LDRB_RISING	(1 << 18)
+#define ATMEL_TC_CMR_LDRB_FALLING	(2 << 18)
+#define ATMEL_TC_CMR_LDRB_BOTH		(3 << 18)
+#define ATMEL_TC_CMR_SBSMPLR_MSK	GENMASK(22, 20)
+#define ATMEL_TC_CMR_SBSMPLR(x)		((x) << 20)
+
+/* Waveform mode CMR fields */
+#define ATMEL_TC_CMR_CPCSTOP		BIT(6)
+#define ATMEL_TC_CMR_CPCDIS		BIT(7)
+#define ATMEL_TC_CMR_EEVTEDG_MSK	GENMASK(9, 8)
+#define ATMEL_TC_CMR_EEVTEDG_NONE	(0 << 8)
+#define ATMEL_TC_CMR_EEVTEDG_RISING	(1 << 8)
+#define ATMEL_TC_CMR_EEVTEDG_FALLING	(2 << 8)
+#define ATMEL_TC_CMR_EEVTEDG_BOTH	(3 << 8)
+#define ATMEL_TC_CMR_EEVT_MSK		GENMASK(11, 10)
+#define ATMEL_TC_CMR_EEVT_XC(x)		(((x) + 1) << 10)
+#define ATMEL_TC_CMR_ENETRG		BIT(12)
+#define ATMEL_TC_CMR_WAVESEL_MSK	GENMASK(14, 13)
+#define ATMEL_TC_CMR_WAVESEL_UP		(0 << 13)
+#define ATMEL_TC_CMR_WAVESEL_UPDOWN	(1 << 13)
+#define ATMEL_TC_CMR_WAVESEL_UPRC	(2 << 13)
+#define ATMEL_TC_CMR_WAVESEL_UPDOWNRC	(3 << 13)
+#define ATMEL_TC_CMR_ACPA_MSK		GENMASK(17, 16)
+#define ATMEL_TC_CMR_ACPA(a)		(ATMEL_TC_CMR_ACTION_##a << 16)
+#define ATMEL_TC_CMR_ACPC_MSK		GENMASK(19, 18)
+#define ATMEL_TC_CMR_ACPC(a)		(ATMEL_TC_CMR_ACTION_##a << 18)
+#define ATMEL_TC_CMR_AEEVT_MSK		GENMASK(21, 20)
+#define ATMEL_TC_CMR_AEEVT(a)		(ATMEL_TC_CMR_ACTION_##a << 20)
+#define ATMEL_TC_CMR_ASWTRG_MSK		GENMASK(23, 22)
+#define ATMEL_TC_CMR_ASWTRG(a)		(ATMEL_TC_CMR_ACTION_##a << 22)
+#define ATMEL_TC_CMR_BCPB_MSK		GENMASK(25, 24)
+#define ATMEL_TC_CMR_BCPB(a)		(ATMEL_TC_CMR_ACTION_##a << 24)
+#define ATMEL_TC_CMR_BCPC_MSK		GENMASK(27, 26)
+#define ATMEL_TC_CMR_BCPC(a)		(ATMEL_TC_CMR_ACTION_##a << 26)
+#define ATMEL_TC_CMR_BEEVT_MSK		GENMASK(29, 28)
+#define ATMEL_TC_CMR_BEEVT(a)		(ATMEL_TC_CMR_ACTION_##a << 28)
+#define ATMEL_TC_CMR_BSWTRG_MSK		GENMASK(31, 30)
+#define ATMEL_TC_CMR_BSWTRG(a)		(ATMEL_TC_CMR_ACTION_##a << 30)
+#define ATMEL_TC_CMR_ACTION_NONE	0
+#define ATMEL_TC_CMR_ACTION_SET		1
+#define ATMEL_TC_CMR_ACTION_CLEAR	2
+#define ATMEL_TC_CMR_ACTION_TOGGLE	3
+
+/* SMMR fields */
+#define ATMEL_TC_SMMR_GCEN		BIT(0)
+#define ATMEL_TC_SMMR_DOWN		BIT(1)
+
+/* SR/IER/IDR/IMR fields */
+#define ATMEL_TC_COVFS			BIT(0)
+#define ATMEL_TC_LOVRS			BIT(1)
+#define ATMEL_TC_CPAS			BIT(2)
+#define ATMEL_TC_CPBS			BIT(3)
+#define ATMEL_TC_CPCS			BIT(4)
+#define ATMEL_TC_LDRAS			BIT(5)
+#define ATMEL_TC_LDRBS			BIT(6)
+#define ATMEL_TC_ETRGS			BIT(7)
+#define ATMEL_TC_CLKSTA			BIT(16)
+#define ATMEL_TC_MTIOA			BIT(17)
+#define ATMEL_TC_MTIOB			BIT(18)
+
+/* EMR fields */
+#define ATMEL_TC_EMR_TRIGSRCA_MSK	GENMASK(1, 0)
+#define ATMEL_TC_EMR_TRIGSRCA_TIOA	0
+#define ATMEL_TC_EMR_TRIGSRCA_PWMX	1
+#define ATMEL_TC_EMR_TRIGSRCB_MSK	GENMASK(5, 4)
+#define ATMEL_TC_EMR_TRIGSRCB_TIOB	(0 << 4)
+#define ATMEL_TC_EMR_TRIGSRCB_PWM	(1 << 4)
+#define ATMEL_TC_EMR_NOCLKDIV		BIT(8)
+
+/* BCR fields */
+#define ATMEL_TC_BCR_SYNC		BIT(0)
+
+/* BMR fields */
+#define ATMEL_TC_BMR_TCXC_MSK(c)	GENMASK(((c) * 2) + 1, (c) * 2)
+#define ATMEL_TC_BMR_TCXC(x, c)		((x) << (2 * (c)))
+#define ATMEL_TC_BMR_QDEN		BIT(8)
+#define ATMEL_TC_BMR_POSEN		BIT(9)
+#define ATMEL_TC_BMR_SPEEDEN		BIT(10)
+#define ATMEL_TC_BMR_QDTRANS		BIT(11)
+#define ATMEL_TC_BMR_EDGPHA		BIT(12)
+#define ATMEL_TC_BMR_INVA		BIT(13)
+#define ATMEL_TC_BMR_INVB		BIT(14)
+#define ATMEL_TC_BMR_INVIDX		BIT(15)
+#define ATMEL_TC_BMR_SWAP		BIT(16)
+#define ATMEL_TC_BMR_IDXPHB		BIT(17)
+#define ATMEL_TC_BMR_AUTOC		BIT(18)
+#define ATMEL_TC_MAXFILT_MSK		GENMASK(25, 20)
+#define ATMEL_TC_MAXFILT(x)		(((x) - 1) << 20)
+#define ATMEL_TC_MAXCMP_MSK		GENMASK(29, 26)
+#define ATMEL_TC_MAXCMP(x)		((x) << 26)
+
+/* QEDC fields */
+#define ATMEL_TC_QEDC_IDX		BIT(0)
+#define ATMEL_TC_QEDC_DIRCHG		BIT(1)
+#define ATMEL_TC_QEDC_QERR		BIT(2)
+#define ATMEL_TC_QEDC_MPE		BIT(3)
+#define ATMEL_TC_QEDC_DIR		BIT(8)
+
+/* FMR fields */
+#define ATMEL_TC_FMR_ENCF(x)		BIT(x)
+
+/* WPMR fields */
+#define ATMEL_TC_WPMR_WPKEY		(0x54494d << 8)
+#define ATMEL_TC_WPMR_WPEN		BIT(0)
+
+static inline struct clk *tcb_clk_get(struct device_node *node, int channel)
+{
+	struct clk *clk;
+	char clk_name[] = "t0_clk";
+
+	clk_name[1] += channel;
+	clk = of_clk_get_by_name(node->parent, clk_name);
+	if (!IS_ERR(clk))
+		return clk;
+
+	return of_clk_get_by_name(node->parent, "t0_clk");
+}
+
+static inline int tcb_irq_get(struct device_node *node, int channel)
+{
+	int irq;
+
+	irq = of_irq_get(node->parent, channel);
+	if (irq > 0)
+		return irq;
+
+	return of_irq_get(node->parent, 0);
+}
+
+static const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
+
+static const struct of_device_id atmel_tcb_dt_ids[] = {
+	{
+		.compatible = "atmel,at91rm9200-tcb",
+		.data = (void *)16,
+	}, {
+		.compatible = "atmel,at91sam9x5-tcb",
+		.data = (void *)32,
+	}, {
+		/* sentinel */
+	}
+};
+
+#endif /* __SOC_ATMEL_TCB_H */
-- 
2.8.1
