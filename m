From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 13 Jul 2014 08:37:52 +0400
Subject: [PATCH v2 RESEND 1/2] clk: Add CLPS711X clk driver
Message-ID: <1405226272-2973-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the clock driver for Cirrus Logic CLPS711X series SoCs
using common clock infrastructure.
Designed primarily for migration CLPS711X subarch for multiplatform & DT,
for this as the "OF" and "non-OF" calls implemented.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/Makefile                       |   1 +
 drivers/clk/clk-clps711x.c                 | 192 +++++++++++++++++++++++++++++
 include/dt-bindings/clock/clps711x-clock.h |  27 ++++
 3 files changed, 220 insertions(+)
 create mode 100644 drivers/clk/clk-clps711x.c
 create mode 100644 include/dt-bindings/clock/clps711x-clock.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 312742c..c57728e 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-fractional-divider.o
 obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
 obj-$(CONFIG_ARCH_BCM2835)		+= clk-bcm2835.o
+obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
 obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
 obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
 obj-$(CONFIG_MACH_LOONGSON1)		+= clk-ls1x.o
diff --git a/drivers/clk/clk-clps711x.c b/drivers/clk/clk-clps711x.c
new file mode 100644
index 0000000..715eec1
--- /dev/null
+++ b/drivers/clk/clk-clps711x.c
@@ -0,0 +1,192 @@
+/*
+ *  Cirrus Logic CLPS711X CLK driver
+ *
+ *  Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/mfd/syscon/clps711x.h>
+
+#include <dt-bindings/clock/clps711x-clock.h>
+
+#define CLPS711X_SYSCON1	(0x0100)
+#define CLPS711X_SYSCON2	(0x1100)
+#define CLPS711X_SYSFLG2	(CLPS711X_SYSCON2 + SYSFLG_OFFSET)
+#define CLPS711X_PLLR		(0xa5a8)
+
+#define CLPS711X_EXT_FREQ	(13000000)
+#define CLPS711X_OSC_FREQ	(3686400)
+
+static const struct clk_div_table spi_div_table[] = {
+	{ .val = 0, .div = 32, },
+	{ .val = 1, .div = 8, },
+	{ .val = 2, .div = 2, },
+	{ .val = 3, .div = 1, },
+};
+
+static const struct clk_div_table timer_div_table[] = {
+	{ .val = 0, .div = 256, },
+	{ .val = 1, .div = 1, },
+};
+
+struct clps711x_clk {
+	struct clk_onecell_data	clk_data;
+	spinlock_t		lock;
+	struct clk		*clks[CLPS711X_CLK_MAX];
+};
+
+static struct clps711x_clk * __init _clps711x_clk_init(void __iomem *base,
+						       u32 fref)
+{
+	u32 tmp, f_cpu, f_pll, f_bus, f_tim, f_pwm, f_spi;
+	struct clps711x_clk *clps711x_clk;
+	unsigned i;
+
+	if (!base)
+		return ERR_PTR(-ENOMEM);
+
+	clps711x_clk = kzalloc(sizeof(*clps711x_clk), GFP_KERNEL);
+	if (!clps711x_clk)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&clps711x_clk->lock);
+
+	/* Read PLL multiplier value and sanity check */
+	tmp = readl(base + CLPS711X_PLLR) >> 24;
+	if (((tmp >= 10) && (tmp <= 50)) || !fref)
+		f_pll = DIV_ROUND_UP(CLPS711X_OSC_FREQ * tmp, 2);
+	else
+		f_pll = fref;
+
+	tmp = readl(base + CLPS711X_SYSFLG2);
+	if (tmp & SYSFLG2_CKMODE) {
+		f_cpu = CLPS711X_EXT_FREQ;
+		f_bus = CLPS711X_EXT_FREQ;
+		f_spi = DIV_ROUND_CLOSEST(CLPS711X_EXT_FREQ, 96);
+		f_pll = 0;
+		f_pwm = DIV_ROUND_CLOSEST(CLPS711X_EXT_FREQ, 128);
+	} else {
+		f_cpu = f_pll;
+		if (f_cpu > 36864000)
+			f_bus = DIV_ROUND_UP(f_cpu, 2);
+		else
+			f_bus = 36864000 / 2;
+		f_spi = DIV_ROUND_CLOSEST(f_cpu, 576);
+		f_pwm = DIV_ROUND_CLOSEST(f_cpu, 768);
+	}
+
+	if (tmp & SYSFLG2_CKMODE) {
+		if (readl(base + CLPS711X_SYSCON2) & SYSCON2_OSTB)
+			f_tim = DIV_ROUND_CLOSEST(CLPS711X_EXT_FREQ, 26);
+		else
+			f_tim = DIV_ROUND_CLOSEST(CLPS711X_EXT_FREQ, 24);
+	} else
+		f_tim = DIV_ROUND_CLOSEST(f_cpu, 144);
+
+	tmp = readl(base + CLPS711X_SYSCON1);
+	/* Timer1 in free running mode.
+	 * Counter will wrap around to 0xffff when it underflows
+	 * and will continue to count down.
+	 */
+	tmp &= ~(SYSCON1_TC1M | SYSCON1_TC1S);
+	/* Timer2 in prescale mode.
+	 * Value writen is automatically re-loaded when
+	 * the counter underflows.
+	 */
+	tmp |= SYSCON1_TC2M | SYSCON1_TC2S;
+	writel(tmp, base + CLPS711X_SYSCON1);
+
+	clps711x_clk->clks[CLPS711X_CLK_DUMMY] =
+		clk_register_fixed_rate(NULL, "dummy", NULL, CLK_IS_ROOT, 0);
+	clps711x_clk->clks[CLPS711X_CLK_CPU] =
+		clk_register_fixed_rate(NULL, "cpu", NULL, CLK_IS_ROOT, f_cpu);
+	clps711x_clk->clks[CLPS711X_CLK_BUS] =
+		clk_register_fixed_rate(NULL, "bus", NULL, CLK_IS_ROOT, f_bus);
+	clps711x_clk->clks[CLPS711X_CLK_PLL] =
+		clk_register_fixed_rate(NULL, "pll", NULL, CLK_IS_ROOT, f_pll);
+	clps711x_clk->clks[CLPS711X_CLK_TIMERREF] =
+		clk_register_fixed_rate(NULL, "timer_ref", NULL, CLK_IS_ROOT,
+					f_tim);
+	clps711x_clk->clks[CLPS711X_CLK_TIMER1] =
+		clk_register_divider_table(NULL, "timer1", "timer_ref", 0,
+					   base + CLPS711X_SYSCON1, 5, 1, 0,
+					   timer_div_table, &clps711x_clk->lock);
+	clps711x_clk->clks[CLPS711X_CLK_TIMER2] =
+		clk_register_divider_table(NULL, "timer2", "timer_ref", 0,
+					   base + CLPS711X_SYSCON1, 7, 1, 0,
+					   timer_div_table, &clps711x_clk->lock);
+	clps711x_clk->clks[CLPS711X_CLK_PWM] =
+		clk_register_fixed_rate(NULL, "pwm", NULL, CLK_IS_ROOT, f_pwm);
+	clps711x_clk->clks[CLPS711X_CLK_SPIREF] =
+		clk_register_fixed_rate(NULL, "spi_ref", NULL, CLK_IS_ROOT,
+					f_spi);
+	clps711x_clk->clks[CLPS711X_CLK_SPI] =
+		clk_register_divider_table(NULL, "spi", "spi_ref", 0,
+					   base + CLPS711X_SYSCON1, 16, 2, 0,
+					   spi_div_table, &clps711x_clk->lock);
+	clps711x_clk->clks[CLPS711X_CLK_UART] =
+		clk_register_fixed_factor(NULL, "uart", "bus", 0, 1, 10);
+	clps711x_clk->clks[CLPS711X_CLK_TICK] =
+		clk_register_fixed_rate(NULL, "tick", NULL, CLK_IS_ROOT, 64);
+
+	for (i = 0; i < CLPS711X_CLK_MAX; i++)
+		if (IS_ERR(clps711x_clk->clks[i]))
+			pr_err("clk %i: register failed with %ld\n",
+			       i, PTR_ERR(clps711x_clk->clks[i]));
+
+	return clps711x_clk;
+}
+
+void __init clps711x_clk_init(void __iomem *base)
+{
+	struct clps711x_clk *clps711x_clk;
+
+	clps711x_clk = _clps711x_clk_init(base, 73728000);
+
+	BUG_ON(IS_ERR(clps711x_clk));
+
+	/* Clocksource */
+	clk_register_clkdev(clps711x_clk->clks[CLPS711X_CLK_TIMER1],
+			    NULL, "clps711x-timer.0");
+	clk_register_clkdev(clps711x_clk->clks[CLPS711X_CLK_TIMER2],
+			    NULL, "clps711x-timer.1");
+
+	/* Drivers */
+	clk_register_clkdev(clps711x_clk->clks[CLPS711X_CLK_PWM],
+			    NULL, "clps711x-pwm");
+	clk_register_clkdev(clps711x_clk->clks[CLPS711X_CLK_UART],
+			    NULL, "clps711x-uart.0");
+	clk_register_clkdev(clps711x_clk->clks[CLPS711X_CLK_UART],
+			    NULL, "clps711x-uart.1");
+}
+
+#ifdef CONFIG_OF
+static void __init clps711x_clk_init_dt(struct device_node *np)
+{
+	void __iomem *base = of_iomap(np, 0);
+	struct clps711x_clk *clps711x_clk;
+	u32 fref = 0;
+
+	WARN_ON(of_property_read_u32(np, "startup-frequency", &fref));
+
+	clps711x_clk = _clps711x_clk_init(base, fref);
+	BUG_ON(IS_ERR(clps711x_clk));
+
+	clps711x_clk->clk_data.clks = clps711x_clk->clks;
+	clps711x_clk->clk_data.clk_num = CLPS711X_CLK_MAX;
+	of_clk_add_provider(np, of_clk_src_onecell_get,
+			    &clps711x_clk->clk_data);
+}
+CLK_OF_DECLARE(clps711x, "cirrus,clps711x-clk", clps711x_clk_init_dt);
+#endif
diff --git a/include/dt-bindings/clock/clps711x-clock.h b/include/dt-bindings/clock/clps711x-clock.h
new file mode 100644
index 0000000..0c4c80b
--- /dev/null
+++ b/include/dt-bindings/clock/clps711x-clock.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_CLPS711X_H
+#define __DT_BINDINGS_CLOCK_CLPS711X_H
+
+#define CLPS711X_CLK_DUMMY	0
+#define CLPS711X_CLK_CPU	1
+#define CLPS711X_CLK_BUS	2
+#define CLPS711X_CLK_PLL	3
+#define CLPS711X_CLK_TIMERREF	4
+#define CLPS711X_CLK_TIMER1	5
+#define CLPS711X_CLK_TIMER2	6
+#define CLPS711X_CLK_PWM	7
+#define CLPS711X_CLK_SPIREF	8
+#define CLPS711X_CLK_SPI	9
+#define CLPS711X_CLK_UART	10
+#define CLPS711X_CLK_TICK	11
+#define CLPS711X_CLK_MAX	12
+
+#endif
-- 
1.8.5.5
