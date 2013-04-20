From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 21 Apr 2013 00:01:59 +0200
Subject: [PATCH] clocksource: add samsung pwm timer driver
Message-ID: <201304210002.00125.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Figa <t.figa@samsung.com>

This adds a new clocksource driver for the PWM timer that is
present in most Samsung SoCs, based on the existing driver in
arch/arm/plat-samsung/samsung-time.c and many changes implemented by
Tomasz Figa.

Originally, the conversion of all Samsung machines to the new driver was
planned for 3.10, but that work ended up being too late and too invasive
just before the merge window.

Unfortunately, other changes in the Exynos platform resulted in some
Exynos4 setups, particularly the Universal C210 board to be broken. In
order to fix that with minimum risk, so we now leave the existing pwm
clocksource driver in place for all older platforms and use the new
driver only for device tree enabled boards. This way, we can get the
broken machines running again using DT descriptions.

All clocksource changes were implemented by Tomasz, while the DT
registration was rewritten by Arnd.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
This is my final attempt to fix the Exynos4 regressions we have, since
Tomasz put a lot of work into getting this running, and I gave him a
hard time about some of the earlier patches.

Tomasz, can you have a look at this to see if it would actually help?
I have removed all the non-DT registration from your code, as well
as the interface to the pwm subsystem, since I assume the existing
code will work for all users we care about.

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 73fcddb..5b8ba91 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -75,3 +75,13 @@ config CLKSRC_EXYNOS_MCT
 	def_bool y if ARCH_EXYNOS
 	help
 	  Support for Multi Core Timer controller on Exynos SoCs.
+
+config CLKSRC_SAMSUNG_PWM
+	def_bool ARCH_EXYNOS4
+	depends on OF
+	select CLKSRC_MMIO
+	help
+	  This is a new clocksource driver for the PWM timer found in
+	  Samsung S3C, S5P and Exynos SoCs, replacing an earlier driver
+	  for all devicetree enabled platforms. This driver will be
+	  needed only on systems that do not have the Exynos MCT available.
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index cd1f09c..2289f0c 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_ARCH_TEGRA)	+= tegra20_timer.o
 obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
 obj-$(CONFIG_CADENCE_TTC_TIMER)	+= cadence_ttc_timer.o
 obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
+obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+= samsung_pwm_timer.o
 
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
 obj-$(CONFIG_CLKSRC_METAG_GENERIC)	+= metag_generic.o
diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
new file mode 100644
index 0000000..1752457
--- /dev/null
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -0,0 +1,477 @@
+/*
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * samsung - Common hr-timer support (s3c and s5p)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <clocksource/samsung_pwm.h>
+
+#include <asm/sched_clock.h>
+
+/*
+ * Clocksource driver
+ */
+
+#define REG_TCFG0			0x00
+#define REG_TCFG1			0x04
+#define REG_TCON			0x08
+#define REG_TINT_CSTAT			0x44
+
+#define REG_TCNTB(chan)			(0x0c + 12 * (chan))
+#define REG_TCMPB(chan)			(0x10 + 12 * (chan))
+
+#define TCFG0_PRESCALER_MASK		0xff
+#define TCFG0_PRESCALER1_SHIFT		8
+
+#define TCFG1_SHIFT(x)	  		((x) * 4)
+#define TCFG1_MUX_MASK	  		0xf
+
+#define TCON_START(chan)		(1 << (4 * (chan) + 0))
+#define TCON_MANUALUPDATE(chan)		(1 << (4 * (chan) + 1))
+#define TCON_INVERT(chan)		(1 << (4 * (chan) + 2))
+#define TCON_AUTORELOAD(chan)		(1 << (4 * (chan) + 3))
+
+struct samsung_timer_source {
+	unsigned int event_id;
+	unsigned int source_id;
+	unsigned int tcnt_max;
+	unsigned int tscaler_div;
+	unsigned int tdiv;
+};
+
+static struct samsung_pwm *pwm;
+static struct clk *timerclk;
+static struct samsung_timer_source timer_source;
+static unsigned long clock_count_per_tick;
+
+static void samsung_timer_set_prescale(struct samsung_pwm *pwm,
+					unsigned int channel, u16 prescale)
+{
+	unsigned long flags;
+	u8 shift = 0;
+	u32 reg;
+
+	if (channel >= 2)
+		shift = TCFG0_PRESCALER1_SHIFT;
+
+	spin_lock_irqsave(&pwm->slock, flags);
+
+	reg = readl(pwm->base + REG_TCFG0);
+	reg &= ~(TCFG0_PRESCALER_MASK << shift);
+	reg |= (prescale - 1) << shift;
+	writel(reg, pwm->base + REG_TCFG0);
+
+	spin_unlock_irqrestore(&pwm->slock, flags);
+}
+
+static void samsung_timer_set_divisor(struct samsung_pwm *pwm,
+					unsigned int channel, u8 divisor)
+{
+	u8 shift = TCFG1_SHIFT(channel);
+	unsigned long flags;
+	u32 reg;
+	u8 bits;
+
+	bits = (fls(divisor) - 1) - pwm->variant.div_base;
+
+	spin_lock_irqsave(&pwm->slock, flags);
+
+	reg = readl(pwm->base + REG_TCFG1);
+	reg &= ~(TCFG1_MUX_MASK << shift);
+	reg |= bits << shift;
+	writel(reg, pwm->base + REG_TCFG1);
+
+	spin_unlock_irqrestore(&pwm->slock, flags);
+}
+
+static void samsung_time_stop(unsigned int channel)
+{
+	unsigned long tcon;
+	unsigned long flags;
+
+	if (channel > 0)
+		++channel;
+
+	spin_lock_irqsave(&pwm->slock, flags);
+
+	tcon = __raw_readl(pwm->base + REG_TCON);
+	tcon &= ~TCON_START(channel);
+	__raw_writel(tcon, pwm->base + REG_TCON);
+
+	spin_unlock_irqrestore(&pwm->slock, flags);
+}
+
+static void samsung_time_setup(unsigned int channel, unsigned long tcnt)
+{
+	unsigned long tcon;
+	unsigned long flags;
+	unsigned int tcon_chan = channel;
+
+	if (tcon_chan > 0)
+		++tcon_chan;
+
+	spin_lock_irqsave(&pwm->slock, flags);
+
+	tcon = __raw_readl(pwm->base + REG_TCON);
+
+	tcnt--;
+
+	tcon &= ~(TCON_START(tcon_chan) | TCON_AUTORELOAD(tcon_chan));
+	tcon |= TCON_MANUALUPDATE(tcon_chan);
+
+	__raw_writel(tcnt, pwm->base + REG_TCNTB(channel));
+	__raw_writel(tcnt, pwm->base + REG_TCMPB(channel));
+	__raw_writel(tcon, pwm->base + REG_TCON);
+
+	spin_unlock_irqrestore(&pwm->slock, flags);
+}
+
+static void samsung_time_start(unsigned int channel, bool periodic)
+{
+	unsigned long tcon;
+	unsigned long flags;
+
+	if (channel > 0)
+		++channel;
+
+	spin_lock_irqsave(&pwm->slock, flags);
+
+	tcon = __raw_readl(pwm->base + REG_TCON);
+
+	tcon &= ~TCON_MANUALUPDATE(channel);
+	tcon |= TCON_START(channel);
+
+	if (periodic)
+		tcon |= TCON_AUTORELOAD(channel);
+	else
+		tcon &= ~TCON_AUTORELOAD(channel);
+
+	__raw_writel(tcon, pwm->base + REG_TCON);
+
+	spin_unlock_irqrestore(&pwm->slock, flags);
+}
+
+static int samsung_set_next_event(unsigned long cycles,
+				struct clock_event_device *evt)
+{
+	samsung_time_setup(timer_source.event_id, cycles);
+	samsung_time_start(timer_source.event_id, false);
+
+	return 0;
+}
+
+static void samsung_timer_resume(void)
+{
+	/* event timer restart */
+	samsung_time_setup(timer_source.event_id, clock_count_per_tick);
+	samsung_time_start(timer_source.event_id, true);
+
+	/* source timer restart */
+	samsung_time_setup(timer_source.source_id, timer_source.tcnt_max);
+	samsung_time_start(timer_source.source_id, true);
+}
+
+static void samsung_set_mode(enum clock_event_mode mode,
+				struct clock_event_device *evt)
+{
+	samsung_time_stop(timer_source.event_id);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		samsung_time_setup(timer_source.event_id, clock_count_per_tick);
+		samsung_time_start(timer_source.event_id, true);
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+		break;
+
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		break;
+
+	case CLOCK_EVT_MODE_RESUME:
+		samsung_timer_resume();
+		break;
+	}
+}
+
+static struct clock_event_device time_event_device = {
+	.name		= "samsung_event_timer",
+	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.rating		= 200,
+	.set_next_event	= samsung_set_next_event,
+	.set_mode	= samsung_set_mode,
+};
+
+static irqreturn_t samsung_clock_event_isr(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	if (pwm->variant.has_tint_cstat) {
+		u32 mask = (1 << timer_source.event_id);
+		writel(mask | (mask << 5), pwm->base + REG_TINT_CSTAT);
+	}
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction samsung_clock_event_irq = {
+	.name		= "samsung_time_irq",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= samsung_clock_event_isr,
+	.dev_id		= &time_event_device,
+};
+
+static void __init samsung_clockevent_init(void)
+{
+	unsigned long pclk;
+	unsigned long clock_rate;
+	unsigned int irq_number;
+
+	pclk = clk_get_rate(timerclk);
+
+	samsung_timer_set_prescale(pwm, timer_source.event_id,
+						timer_source.tscaler_div);
+	samsung_timer_set_divisor(pwm, timer_source.event_id,
+						timer_source.tdiv);
+
+	clock_rate = pclk / (timer_source.tscaler_div * timer_source.tdiv);
+	clock_count_per_tick = clock_rate / HZ;
+
+	time_event_device.cpumask = cpumask_of(0);
+	clockevents_config_and_register(&time_event_device, clock_rate, 1, -1);
+
+	irq_number = pwm->irq[timer_source.event_id];
+	setup_irq(irq_number, &samsung_clock_event_irq);
+
+	if (pwm->variant.has_tint_cstat) {
+		u32 mask = (1 << timer_source.event_id);
+		writel(mask | (mask << 5), pwm->base + REG_TINT_CSTAT);
+	}
+}
+
+static void __iomem *samsung_timer_reg(void)
+{
+	switch (timer_source.source_id) {
+	case 0:
+	case 1:
+	case 2:
+	case 3:
+		return pwm->base + timer_source.source_id * 0x0c + 0x14;
+
+	case 4:
+		return pwm->base + 0x40;
+
+	default:
+		BUG();
+	}
+}
+
+/*
+ * Override the global weak sched_clock symbol with this
+ * local implementation which uses the clocksource to get some
+ * better resolution when scheduling the kernel. We accept that
+ * this wraps around for now, since it is just a relative time
+ * stamp. (Inspired by U300 implementation.)
+ */
+static u32 notrace samsung_read_sched_clock(void)
+{
+	void __iomem *reg = samsung_timer_reg();
+
+	if (!reg)
+		return 0;
+
+	return ~__raw_readl(reg);
+}
+
+static void __init samsung_clocksource_init(void)
+{
+	void __iomem *reg = samsung_timer_reg();
+	unsigned long pclk;
+	unsigned long clock_rate;
+	int ret;
+
+	pclk = clk_get_rate(timerclk);
+
+	samsung_timer_set_prescale(pwm, timer_source.source_id,
+						timer_source.tscaler_div);
+	samsung_timer_set_divisor(pwm, timer_source.source_id,
+						timer_source.tdiv);
+
+	clock_rate = pclk / (timer_source.tscaler_div * timer_source.tdiv);
+
+	samsung_time_setup(timer_source.source_id, timer_source.tcnt_max);
+	samsung_time_start(timer_source.source_id, true);
+
+	setup_sched_clock(samsung_read_sched_clock,
+						pwm->variant.bits, clock_rate);
+
+	ret = clocksource_mmio_init(reg, "samsung_clocksource_timer",
+					clock_rate, 250, pwm->variant.bits,
+					clocksource_mmio_readl_down);
+	if (ret)
+		panic("samsung_clocksource_timer: can't register clocksource\n");
+}
+
+static void __init samsung_timer_resources(void)
+{
+	timerclk = clk_get(NULL, "timers");
+	if (IS_ERR(timerclk))
+		panic("failed to get timers clock for timer");
+
+	clk_prepare_enable(timerclk);
+
+	timer_source.tcnt_max = (1UL << pwm->variant.bits) - 1;
+	if (pwm->variant.bits == 16) {
+		timer_source.tscaler_div = 25;
+		timer_source.tdiv = 2;
+	} else {
+		timer_source.tscaler_div = 2;
+		timer_source.tdiv = 1;
+	}
+}
+
+/*
+ * PWM master driver
+ */
+static void __init samsung_pwm_clocksource_init(void)
+{
+	u8 mask;
+	int channel;
+
+	if (!pwm)
+		panic("no pwm clocksource device found");
+
+	mask = ~pwm->variant.output_mask & ((1 << SAMSUNG_PWM_NUM) - 1);
+	channel = fls(mask) - 1;
+	if (channel < 0)
+		panic("failed to find PWM channel for clocksource");
+	timer_source.source_id = channel;
+
+	mask &= ~(1 << channel);
+	channel = fls(mask) - 1;
+	if (channel < 0)
+		panic("failed to find PWM channel for clock event");
+	timer_source.event_id = channel;
+
+	samsung_timer_resources();
+	samsung_clockevent_init();
+	samsung_clocksource_init();
+}
+
+static void __init samsung_pwm_alloc(struct device_node *np,
+				     const struct samsung_pwm_variant *variant)
+{
+	struct resource res;
+	struct property *prop;
+	const __be32 *cur;
+	u32 val;
+	int i;
+
+	pwm = kzalloc(sizeof(*pwm), GFP_KERNEL);
+	if (!pwm) {
+		pr_err("%s: could not allocate PWM device struct\n", __func__);
+		return;
+	}
+	memcpy(&pwm->variant, variant, sizeof(pwm->variant));
+	spin_lock_init(&pwm->slock);
+	for (i = 0; i < SAMSUNG_PWM_NUM; ++i)
+		pwm->irq[i] = irq_of_parse_and_map(np, i);
+
+	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
+		if (val >= SAMSUNG_PWM_NUM) {
+			pr_warning("%s: invalid channel index in samsung,pwm-outputs property\n",
+								__func__);
+			continue;
+		}
+		pwm->variant.output_mask |= 1 << val;
+	}
+
+	of_address_to_resource(np, 0, &res);
+	if (!request_mem_region(res.start,
+				resource_size(&res), "samsung-pwm")) {
+		pr_err("%s: failed to request IO mem region\n", __func__);
+		return;
+	}
+
+	pwm->base = ioremap(res.start, resource_size(&res));
+	if (!pwm->base) {
+		pr_err("%s: failed to map PWM registers\n", __func__);
+		release_mem_region(res.start, resource_size(&res));
+		return;
+	}
+
+	samsung_pwm_clocksource_init();
+}
+
+static const struct samsung_pwm_variant s3c24xx_variant = {
+	.bits		= 16,
+	.div_base	= 1,
+	.has_tint_cstat	= false,
+	.tclk_mask	= (1 << 4),
+};
+
+static void __init s3c2410_pwm_clocksource_init(struct device_node *np)
+{
+	samsung_pwm_alloc(np, &s3c24xx_variant);
+}
+CLOCKSOURCE_OF_DECLARE(s3c2410_pwm, "samsung,s3c2410-pwm", s3c2410_pwm_clocksource_init);
+
+static const struct samsung_pwm_variant s3c64xx_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= (1 << 7) | (1 << 6) | (1 << 5),
+};
+
+static void __init s3c64xx_pwm_clocksource_init(struct device_node *np)
+{
+	samsung_pwm_alloc(np, &s3c64xx_variant);
+}
+CLOCKSOURCE_OF_DECLARE(s3c6400_pwm, "samsung,s3c6400-pwm", s3c64xx_pwm_clocksource_init);
+
+static const struct samsung_pwm_variant s5p64x0_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= 0,
+};
+
+static void __init s5p64x0_pwm_clocksource_init(struct device_node *np)
+{
+	samsung_pwm_alloc(np, &s5p64x0_variant);
+}
+CLOCKSOURCE_OF_DECLARE(s5p6440_pwm, "samsung,s5p6440-pwm", s5p64x0_pwm_clocksource_init);
+
+static const struct samsung_pwm_variant s5p_variant = {
+	.bits		= 32,
+	.div_base	= 0,
+	.has_tint_cstat	= true,
+	.tclk_mask	= (1 << 5),
+};
+
+static void __init s5p_pwm_clocksource_init(struct device_node *np)
+{
+	samsung_pwm_alloc(np, &s5p_variant);
+}
+CLOCKSOURCE_OF_DECLARE(s5pc100_pwm, "samsung,s5pc100-pwm", s5p_pwm_clocksource_init);
diff --git a/include/clocksource/samsung_pwm.h b/include/clocksource/samsung_pwm.h
new file mode 100644
index 0000000..eff8668
--- /dev/null
+++ b/include/clocksource/samsung_pwm.h
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __CLOCKSOURCE_SAMSUNG_PWM_H
+#define __CLOCKSOURCE_SAMSUNG_PWM_H
+
+#include <linux/spinlock.h>
+
+#define SAMSUNG_PWM_NUM		5
+
+struct platform_device;
+struct device_node;
+
+struct samsung_pwm_variant {
+	u8 bits;
+	u8 div_base;
+	u8 tclk_mask;
+	u8 output_mask;
+	bool has_tint_cstat;
+};
+
+struct samsung_pwm {
+	struct samsung_pwm_variant variant;
+	spinlock_t slock;
+	void __iomem *base;
+	int irq[SAMSUNG_PWM_NUM];
+};
+
+#endif /* __CLOCKSOURCE_SAMSUNG_PWM_H */
