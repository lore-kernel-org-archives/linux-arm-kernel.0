From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 05 Feb 2013 12:18:30 +0100
Subject: [PATCH 1/3] clk: arm: sunxi: Add a new clock driver for sunxi SOCs
In-Reply-To: <1358835176-7197-2-git-send-email-emilio@elopez.com.ar>
References: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
 <1358835176-7197-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <5110EA86.3040205@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

I don't have this hardware by I have a few remarks regarding the way
you use the CCF, see my comments inline.
Mike, don't hesite to correct me if I am wrong.

On 01/22/2013 07:12 AM, Emilio L?pez wrote:
> This commit implements the base CPU clocks for sunxi devices. It has
> been tested using a slightly modified cpufreq driver from the
> linux-sunxi 3.0 tree.
> 
> Additionally, document the new bindings introduced by this patch, and drop
> the (now unused) old sunxi clock driver.
> 
> Idling:
>     / # find /sys/kernel/debug/clk -name clk_rate -print -exec cat {} \;
>     /sys/kernel/debug/clk/osc24M/pll1/cpu/axi/ahb/apb0/clk_rate
>     30000000
>     /sys/kernel/debug/clk/osc24M/pll1/cpu/axi/ahb/clk_rate
>     60000000
>     /sys/kernel/debug/clk/osc24M/pll1/cpu/axi/clk_rate
>     60000000
>     /sys/kernel/debug/clk/osc24M/pll1/cpu/clk_rate
>     60000000
>     /sys/kernel/debug/clk/osc24M/pll1/clk_rate
>     60000000
>     /sys/kernel/debug/clk/osc24M/clk_rate
>     24000000
>     /sys/kernel/debug/clk/osc32k/clk_rate
>     32768
> 
> After "yes >/dev/null &":
>     / # find /sys/kernel/debug/clk -name clk_rate -print -exec cat {} \;
>     /sys/kernel/debug/clk/osc24M/pll1/cpu/axi/ahb/apb0/clk_rate
>     84000000
>     /sys/kernel/debug/clk/osc24M/pll1/cpu/axi/ahb/clk_rate
>     168000000
>     /sys/kernel/debug/clk/osc24M/pll1/cpu/axi/clk_rate
>     336000000
>     /sys/kernel/debug/clk/osc24M/pll1/cpu/clk_rate
>     1008000000
>     /sys/kernel/debug/clk/osc24M/pll1/clk_rate
>     1008000000
>     /sys/kernel/debug/clk/osc24M/clk_rate
>     24000000
>     /sys/kernel/debug/clk/osc32k/clk_rate
>     32768
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  47 ++++
>  drivers/clk/Makefile                              |   2 +-
>  drivers/clk/clk-sunxi.c                           |  30 ---
>  drivers/clk/sunxi/Makefile                        |   5 +
>  drivers/clk/sunxi/clk-factors.c                   | 175 ++++++++++++++
>  drivers/clk/sunxi/clk-factors.h                   |  25 ++
>  drivers/clk/sunxi/clk-fixed-gate.c                | 152 +++++++++++++
>  drivers/clk/sunxi/clk-fixed-gate.h                |  13 ++
>  drivers/clk/sunxi/clk-sunxi.c                     | 265 ++++++++++++++++++++++
>  9 files changed, 683 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/sunxi.txt
>  delete mode 100644 drivers/clk/clk-sunxi.c
>  create mode 100644 drivers/clk/sunxi/Makefile
>  create mode 100644 drivers/clk/sunxi/clk-factors.c
>  create mode 100644 drivers/clk/sunxi/clk-factors.h
>  create mode 100644 drivers/clk/sunxi/clk-fixed-gate.c
>  create mode 100644 drivers/clk/sunxi/clk-fixed-gate.h
>  create mode 100644 drivers/clk/sunxi/clk-sunxi.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> new file mode 100644
> index 0000000..446c5ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -0,0 +1,47 @@
> +Device Tree Clock bindings for arch-sunxi
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : shall be one of the following:
> +	"allwinner,sunxi-osc-clk" - for a gatable oscillator
> +	"allwinner,sunxi-pll1-clk" - for the main PLL clock
> +	"allwinner,sunxi-cpu-clk" - for the CPU multiplexer clock
> +	"allwinner,sunxi-axi-clk" - for the sunxi AXI clock
> +	"allwinner,sunxi-ahb-clk" - for the sunxi AHB clock
> +	"allwinner,sunxi-apb0-clk" - for the sunxi APB0 clock
> +
> +Required properties for all clocks:
> +- reg : shall be the control register address for the clock.
> +- clocks : shall be the input parent clock(s) phandle for the clock, except for
> +	the root gatable oscillator clock where it is not present
> +- #clock-cells : from common clock binding; shall be set to 0.
> +
> +Additionally, the gatable oscillator clock requires:
> +- clock-frequency : shall be the frequency of the oscillator.
> +
> +
> +For example:
> +
> +osc24M: osc24M {
> +	#clock-cells = <0>;
> +	compatible = "allwinner,sunxi-osc-clk";
> +	reg = <0x01c20050 0x4>;
> +	clock-frequency = <24000000>;
> +};
> +
> +pll1: pll1 at 01c20000 {
> +	#clock-cells = <0>;
> +	compatible = "allwinner,sunxi-pll1-clk";
> +	reg = <0x01c20000 0x4>;
> +	clocks = <&osc24M>;
> +};
> +
> +cpu: cpu at 01c20054 {
> +	#clock-cells = <0>;
> +	compatible = "allwinner,sunxi-cpu-clk";
> +	reg = <0x01c20054 0x4>;
> +	clocks = <&osc32k>, <&osc24M>, <&pll1>;
> +};
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index ee90e87..129afed 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -20,7 +20,7 @@ endif
>  obj-$(CONFIG_MACH_LOONGSON1)	+= clk-ls1x.o
>  obj-$(CONFIG_ARCH_U8500)	+= ux500/
>  obj-$(CONFIG_ARCH_VT8500)	+= clk-vt8500.o
> -obj-$(CONFIG_ARCH_SUNXI)	+= clk-sunxi.o
> +obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
>  obj-$(CONFIG_ARCH_ZYNQ)		+= clk-zynq.o
>  
>  # Chip specific
> diff --git a/drivers/clk/clk-sunxi.c b/drivers/clk/clk-sunxi.c
> deleted file mode 100644
> index 0e831b5..0000000
> --- a/drivers/clk/clk-sunxi.c
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/*
> - * Copyright 2012 Maxime Ripard
> - *
> - * Maxime Ripard <maxime.ripard@free-electrons.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> -
> -#include <linux/clk-provider.h>
> -#include <linux/clkdev.h>
> -#include <linux/clk/sunxi.h>
> -#include <linux/of.h>
> -
> -static const __initconst struct of_device_id clk_match[] = {
> -	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
> -	{}
> -};
> -
> -void __init sunxi_init_clocks(void)
> -{
> -	of_clk_init(clk_match);
> -}
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> new file mode 100644
> index 0000000..8e773be
> --- /dev/null
> +++ b/drivers/clk/sunxi/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for sunxi specific clk
> +#
> +
> +obj-y += clk-sunxi.o clk-factors.o clk-fixed-gate.o
> diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
> new file mode 100644
> index 0000000..428b47d
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-factors.c
> @@ -0,0 +1,175 @@
> +/*
> + * Copyright (C) 2013 Emilio L?pez <emilio@elopez.com.ar>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Adjustable factor-based clock implementation
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/string.h>
> +
> +#include <linux/delay.h>
> +
> +#include "clk-factors.h"
> +
> +/*
> + * DOC: basic adjustable factor-based clock that cannot gate
> + *
> + * Traits of this clock:
> + * prepare - clk_prepare only ensures that parents are prepared
> + * enable - clk_enable only ensures that parents are enabled
> + * rate - rate is adjustable.
> + *        clk->rate = (parent->rate * N * (K + 1) >> P) / (M + 1)
> + * parent - fixed parent.  No clk_set_parent support
> + */
> +
> +struct clk_factors {
> +	struct clk_hw hw;
> +	void __iomem *reg;
> +	struct clk_factors_config *config;
> +	void (*get_factors) (u32 *rate, u8 *n, u8 *k, u8 *m, u8 *p);
> +	spinlock_t *lock;
> +};
> +
> +#define to_clk_factors(_hw) container_of(_hw, struct clk_factors, hw)
> +
> +#define SETMASK(len, pos)		(((-1U) >> (31-len))  << (pos))
> +#define CLRMASK(len, pos)		(~(SETMASK(len, pos)))
> +#define FACTOR_GET(bit, len, reg)	(((reg) & SETMASK(len, bit)) >> (bit))
> +
> +#define FACTOR_SET(bit, len, reg, val) \
> +	(((reg) & CLRMASK(len, bit)) | (val << (bit)))
> +
> +static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
> +					     unsigned long parent_rate)
> +{
> +	u8 n, k, p, m;
> +	u32 reg;
> +	unsigned long rate;
> +	struct clk_factors *factors = to_clk_factors(hw);
> +	struct clk_factors_config *config = factors->config;
> +
> +	/* Fetch the register value */
> +	reg = readl(factors->reg);
> +
> +	/* Get each individual factor */
> +	n = FACTOR_GET(config->nshift, config->nwidth, reg);
> +	k = FACTOR_GET(config->kshift, config->kwidth, reg);
> +	m = FACTOR_GET(config->mshift, config->mwidth, reg);
> +	p = FACTOR_GET(config->pshift, config->pwidth, reg);
> +
> +	/* Calculate the rate */
> +	rate = (parent_rate * n * (k + 1) >> p) / (m + 1);
> +
> +	return rate;
> +}
> +
> +static long clk_factors_round_rate(struct clk_hw *hw, unsigned long rate,
> +				   unsigned long *parent_rate)
> +{
> +	struct clk_factors *factors = to_clk_factors(hw);
> +	factors->get_factors((u32 *)&rate, NULL, NULL, NULL, NULL);
> +
> +	return rate;
> +}
> +
> +static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long parent_rate)
> +{
> +	u8 n, k, m, p;
> +	u32 reg;
> +	struct clk_factors *factors = to_clk_factors(hw);
> +	struct clk_factors_config *config = factors->config;
> +	unsigned long flags = 0;
> +
> +	factors->get_factors((u32 *)&rate, &n, &k, &m, &p);
> +
> +	if (factors->lock)
> +		spin_lock_irqsave(factors->lock, flags);
> +
> +	/* Fetch the register value */
> +	reg = readl(factors->reg);
> +
> +	/* Set up the new factors */
> +	reg = FACTOR_SET(config->nshift, config->nwidth, reg, n);
> +	reg = FACTOR_SET(config->kshift, config->kwidth, reg, k);
> +	reg = FACTOR_SET(config->mshift, config->mwidth, reg, m);
> +	reg = FACTOR_SET(config->pshift, config->pwidth, reg, p);
> +
> +	/* Apply them now */
> +	writel(reg, factors->reg);
> +
> +	/* delay 500us so pll stabilizes */
> +	__delay((rate >> 20) * 500 / 2);
> +
> +	if (factors->lock)
> +		spin_unlock_irqrestore(factors->lock, flags);
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops clk_factors_ops = {
> +	.recalc_rate = clk_factors_recalc_rate,
> +	.round_rate = clk_factors_round_rate,
> +	.set_rate = clk_factors_set_rate,
> +};
> +
> +/**
> + * clk_register_factors - register a factors clock with
> + * the clock framework
> + * @dev: device registering this clock
> + * @name: name of this clock
> + * @parent_name: name of clock's parent
> + * @flags: framework-specific flags
> + * @reg: register address to adjust factors
> + * @config: shift and width of factors n, k, m and p
> + * @get_factors: function to calculate the factors for a given frequency
> + * @lock: shared register lock for this clock
> + */
> +struct clk *clk_register_factors(struct device *dev, const char *name,
> +				 const char *parent_name,
> +				 unsigned long flags, void __iomem *reg,
> +				 struct clk_factors_config *config,
> +				 void (*get_factors) (u32 *rate, u8 *n, u8 *k,
> +						      u8 *m, u8 *p),
> +				 spinlock_t *lock)
> +{
> +	struct clk_factors *factors;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +
> +	/* allocate the factors */
> +	factors = kzalloc(sizeof(struct clk_factors), GFP_KERNEL);
> +	if (!factors) {
> +		pr_err("%s: could not allocate factors clk\n", __func__);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	init.name = name;
> +	init.ops = &clk_factors_ops;
> +	init.flags = flags;
> +	init.parent_names = (parent_name ? &parent_name : NULL);
> +	init.num_parents = (parent_name ? 1 : 0);
> +
> +	/* struct clk_factors assignments */
> +	factors->reg = reg;
> +	factors->config = config;
> +	factors->lock = lock;
> +	factors->hw.init = &init;
> +	factors->get_factors = get_factors;
> +
> +	/* register the clock */
> +	clk = clk_register(dev, &factors->hw);
> +
> +	if (IS_ERR(clk))
> +		kfree(factors);
> +
> +	return clk;
> +}
> diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
> new file mode 100644
> index 0000000..a24c889
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-factors.h
> @@ -0,0 +1,25 @@
> +#ifndef __MACH_SUNXI_CLK_FACTORS_H
> +#define __MACH_SUNXI_CLK_FACTORS_H
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +
> +struct clk_factors_config {
> +	u8 nshift;
> +	u8 nwidth;
> +	u8 kshift;
> +	u8 kwidth;
> +	u8 mshift;
> +	u8 mwidth;
> +	u8 pshift;
> +	u8 pwidth;
> +};
> +
> +struct clk *clk_register_factors(struct device *dev, const char *name,
> +				 const char *parent_name,
> +				 unsigned long flags, void __iomem *reg,
> +				 struct clk_factors_config *config,
> +				 void (*get_factors) (u32 *rate, u8 *n, u8 *k,
> +						      u8 *m, u8 *p),
> +				 spinlock_t *lock);
> +#endif
> diff --git a/drivers/clk/sunxi/clk-fixed-gate.c b/drivers/clk/sunxi/clk-fixed-gate.c
> new file mode 100644
> index 0000000..b16eda5
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk-fixed-gate.c
> @@ -0,0 +1,152 @@
> +/*
> + * Copyright (C) 2013 Emilio L?pez <emilio@elopez.com.ar>
> + *
> + * Based on drivers/clk/clk-gate.c,
> + *
> + * Copyright (C) 2010-2011 Canonical Ltd <jeremy.kerr@canonical.com>
> + * Copyright (C) 2011-2012 Mike Turquette, Linaro Ltd <mturquette@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Fixed rate, gated clock implementation
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/string.h>
> +
> +#include "clk-fixed-gate.h"
> +
> +/**
> + * DOC: fixed rate clock which can gate and ungate it's ouput
> + *
> + * Traits of this clock:
> + * prepare - clk_(un)prepare only ensures parent is (un)prepared
> + * enable - clk_enable and clk_disable are functional & control gating
> + * rate - rate is always a fixed value.  No clk_set_rate support
> + * parent - fixed parent.  No clk_set_parent support
> + */
> +

This file seems to be a copy and past of clk-fixed-rate.c and
clk-gate.c (as explained in your header). The purpose of the common
clock framework was to reduce code duplication not increase it! :)

The current way to achieve what you want is to declare two clock:
one fixed-rate and one gateable.

In this case your fixed clock will only be use by the gateable
one. Latter thecomposite clk may be a solution, if you really want to
only deal with one clock.

You could remove this file and its header, do a little change in the
dtsi with something like this:

osc24M_fixed: osc24M_fixed {
	#clock-cells = <0>;
	compatible = "fixed-clock";
	clock-frequency = <24000000>;
};

osc24M osc24M {
	#clock-cells = <0>;
	compatible = "allwinner,sunxi-osc-clk"
	reg = <0x01c20050 0x4>;
	clocks = <&osc24M_fixed>;
};

And modify sunxi_osc_clk_setup() as below


[...]

> +
> +static void __init sunxi_osc_clk_setup(struct device_node *node)
> +{
> +	struct clk *clk;
> +	const char *clk_name = node->name;
> +	void *reg;
> +	u32 rate;
> +
> +	reg = of_iomap(node, 0);

here you retrieve the name of the parent clock:

	clk = of_clk_get(np, 0);
	if (!IS_ERR(clk)) {
		parent_name = __clk_get_name(clk);
		clk_put(clk);
	}

We don't anymore to get the clock-frequency
> +
> +	if (of_property_read_u32(node, "clock-frequency", &rate))
> +		return;
> +

And here instead of clk_register_fixed_gate you can use the
clk_register_gate as below:
> +	clk = clk_register_fixed_gate(NULL, clk_name, NULL,
> +				      CLK_IS_ROOT | CLK_IGNORE_UNUSED,
> +				      reg, SUNXI_OSC24M_GATE, rate, &clk_lock);
> +
	clk = clk_register_gate(NULL, clk_name, parent_name,
			CLK_IGNORE_UNUSED, reg, SUNXI_OSC24M_GATE, 0, &clk->lock);

> +	if (clk) {
> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +		clk_register_clkdev(clk, clk_name, NULL);
> +	}
> +}
> +
> +
> +
> +/**
> + * sunxi_get_pll1_factors() - calculates n, k, m, p factors for PLL1
> + * PLL1 rate is calculated as follows
> + * rate = (parent_rate * n * (k + 1) >> p) / (m + 1);
> + * parent_rate is always 24Mhz
> + */
> +
> +static void sunxi_get_pll1_factors(u32 *freq, u8 *n, u8 *k, u8 *m, u8 *p)
> +{
> +	u8 div;
> +
> +	/* Normalize value to a 6M multiple */
> +	div = *freq / 6000000;
> +	*freq = 6000000 * div;
> +
> +	/* we were called to round the frequency, we can now return */
> +	if (n == NULL)
> +		return;
> +
> +	/* m is always zero for pll1 */
> +	*m = 0;
> +
> +	/* k is 1 only on these cases */
> +	if (*freq >= 768000000 || *freq == 42000000 || *freq == 54000000)
> +		*k = 1;
> +	else
> +		*k = 0;
> +
> +	/* p will be 3 for divs under 10 */
> +	if (div < 10)
> +		*p = 3;
> +
> +	/* p will be 2 for divs between 10 - 20 and odd divs under 32 */
> +	else if (div < 20 || (div < 32 && (div & 1)))
> +		*p = 2;
> +
> +	/* p will be 1 for even divs under 32, divs under 40 and odd pairs
> +	 * of divs between 40-62 */
> +	else if (div < 40 || (div < 64 && (div & 2)))
> +		*p = 1;
> +
> +	/* any other entries have p = 0 */
> +	else
> +		*p = 0;
> +
> +	/* calculate a suitable n based on k and p */
> +	div <<= *p;
> +	div /= (*k + 1);
> +	*n = div / 4;
> +}
> +
> +/**
> + * sunxi_pll1_clk_setup() - Setup function for PLL1 clock
> + */
> +
> +struct clk_factors_config pll1_config = {
> +	.nshift = 8,
> +	.nwidth = 5,
> +	.kshift = 4,
> +	.kwidth = 2,
> +	.mshift = 0,
> +	.mwidth = 2,
> +	.pshift = 16,
> +	.pwidth = 2,
> +};
> +
> +static void __init sunxi_pll1_clk_setup(struct device_node *node)
> +{
> +	struct clk *clk;
> +	const char *clk_name = node->name;
> +	const char *parent;
> +	void *reg;
> +
> +	reg = of_iomap(node, 0);
> +
> +	parent = of_clk_get_parent_name(node, 0);
> +
> +	clk = clk_register_factors(NULL, clk_name, parent, CLK_IGNORE_UNUSED,
> +				   reg, &pll1_config, sunxi_get_pll1_factors,
> +				   &clk_lock);
> +
> +	if (clk) {
> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +		clk_register_clkdev(clk, clk_name, NULL);
> +	}
> +}
> +
> +
> +
> +/**
> + * sunxi_cpu_clk_setup() - Setup function for CPU mux
> + */
> +
> +#define SUNXI_CPU_GATE		16
> +#define SUNXI_CPU_GATE_WIDTH	2
> +
> +static void __init sunxi_cpu_clk_setup(struct device_node *node)
> +{
> +	struct clk *clk;
> +	const char *clk_name = node->name;
> +	const char **parents = kmalloc(sizeof(char *) * 5, GFP_KERNEL);
> +	void *reg;
> +	int i = 0;
> +
> +	reg = of_iomap(node, 0);
> +
> +	while (i < 5 && (parents[i] = of_clk_get_parent_name(node, i)) != NULL)
> +		i++;
> +
> +	clk = clk_register_mux(NULL, clk_name, parents, i, 0, reg,
> +			       SUNXI_CPU_GATE, SUNXI_CPU_GATE_WIDTH,
> +			       0, &clk_lock);
> +
> +	if (clk) {
> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +		clk_register_clkdev(clk, clk_name, NULL);
> +	}
> +}
> +
> +
> +
> +/**
> + * sunxi_divider_clk_setup() - Setup function for simple divider clocks
> + */
> +
> +#define SUNXI_DIVISOR_WIDTH	2
> +
> +struct div_data {
> +	u8 div;
> +	u8 pow;
> +};
> +
> +static const __initconst struct div_data axi_data = {
> +	.div = 0,
> +	.pow = 0,
> +};
> +
> +static const __initconst struct div_data ahb_data = {
> +	.div = 4,
> +	.pow = 1,
> +};
> +
> +static const __initconst struct div_data apb0_data = {
> +	.div = 8,
> +	.pow = 1,
> +};
> +
> +static void __init sunxi_divider_clk_setup(struct device_node *node, u8 shift,
> +					   u8 power_of_two)
> +{
> +	struct clk *clk;
> +	const char *clk_name = node->name;
> +	const char *clk_parent;
> +	void *reg;
> +
> +	reg = of_iomap(node, 0);
> +
> +	clk_parent = of_clk_get_parent_name(node, 0);
> +
> +	clk = clk_register_divider(NULL, clk_name, clk_parent, 0,
> +				   reg, shift, SUNXI_DIVISOR_WIDTH,
> +				   power_of_two ? CLK_DIVIDER_POWER_OF_TWO : 0,
> +				   &clk_lock);
> +	if (clk) {
> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +		clk_register_clkdev(clk, clk_name, NULL);
> +	}
> +}
> +
> +
> +/* Matches for of_clk_init */
> +static const __initconst struct of_device_id clk_match[] = {
> +	{.compatible = "fixed-clock", .data = of_fixed_clk_setup,},
> +	{.compatible = "allwinner,sunxi-osc-clk", .data = sunxi_osc_clk_setup,},
> +	{.compatible = "allwinner,sunxi-pll1-clk", .data = sunxi_pll1_clk_setup,},
> +	{.compatible = "allwinner,sunxi-cpu-clk", .data = sunxi_cpu_clk_setup,},
> +	{}
> +};
> +
> +/* Matches for divider clocks */
> +static const __initconst struct of_device_id clk_div_match[] = {
> +	{.compatible = "allwinner,sunxi-axi-clk", .data = &axi_data,},
> +	{.compatible = "allwinner,sunxi-ahb-clk", .data = &ahb_data,},
> +	{.compatible = "allwinner,sunxi-apb0-clk", .data = &apb0_data,},
> +	{}
> +};
> +
> +static void __init of_sunxi_divider_clock_setup(void)
> +{
> +	struct device_node *np;
> +	const struct div_data *data;
> +	const struct of_device_id *match;
> +
> +	for_each_matching_node(np, clk_div_match) {
> +		match = of_match_node(clk_div_match, np);
> +		data = match->data;
> +		sunxi_divider_clk_setup(np, data->div, data->pow);
> +	}
> +}
> +
> +void __init sunxi_init_clocks(void)
> +{
> +	/* Register all the simple sunxi clocks on DT */
> +	of_clk_init(clk_match);
> +
> +	/* Register divider clocks */
> +	of_sunxi_divider_clock_setup();
> +}
> 

Regards,
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
