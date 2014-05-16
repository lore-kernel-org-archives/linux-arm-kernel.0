From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 16 May 2014 19:17:12 +0200
Subject: [PATCH v4 3/8] clk: samsung: add infrastructure to register cpu
 clocks
In-Reply-To: <1400029876-5830-4-git-send-email-thomas.ab@samsung.com>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
 <1400029876-5830-4-git-send-email-thomas.ab@samsung.com>
Message-ID: <53764818.5080602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 14.05.2014 03:11, Thomas Abraham wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> The CPU clock provider supplies the clock to the CPU clock domain. The
> composition and organization of the CPU clock provider could vary among
> Exynos SoCs. A CPU clock provider can be composed of clock mux, dividers
> and gates. This patch defines a new clock type for CPU clock provider and
> adds infrastructure to register the CPU clock providers for Samsung
> platforms.
> 
> Cc: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  drivers/clk/samsung/Makefile  |    2 +-
>  drivers/clk/samsung/clk-cpu.c |  458 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/samsung/clk.h     |    5 +
>  3 files changed, 464 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/clk/samsung/clk-cpu.c
> 
> diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
> index 8eb4799..e2b453f 100644
> --- a/drivers/clk/samsung/Makefile
> +++ b/drivers/clk/samsung/Makefile
> @@ -2,7 +2,7 @@
>  # Samsung Clock specific Makefile
>  #
>  
> -obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-pll.o
> +obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-pll.o clk-cpu.o
>  obj-$(CONFIG_ARCH_EXYNOS4)	+= clk-exynos4.o
>  obj-$(CONFIG_SOC_EXYNOS5250)	+= clk-exynos5250.o
>  obj-$(CONFIG_SOC_EXYNOS5420)	+= clk-exynos5420.o
> diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
> new file mode 100644
> index 0000000..6a40862
> --- /dev/null
> +++ b/drivers/clk/samsung/clk-cpu.c
> @@ -0,0 +1,458 @@
> +/*
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + * Author: Thomas Abraham <thomas.ab@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This file contains the utility functions to register the cpu clocks
> + * for samsung platforms.

s/cpu/CPU/
s/samsung/Samsung/

> +*/
> +
> +#include <linux/errno.h>
> +#include "clk.h"
> +
> +#define SRC_CPU			0x0
> +#define STAT_CPU		0x200
> +#define DIV_CPU0		0x300
> +#define DIV_CPU1		0x304
> +#define DIV_STAT_CPU0		0x400
> +#define DIV_STAT_CPU1		0x404
> +
> +#define MAX_DIV			8
> +
> +#define EXYNOS4210_ARM_DIV1(div) ((div & 0x7) + 1)
> +#define EXYNOS4210_ARM_DIV2(div) (((div >> 28) & 0x7) + 1)
> +
> +#define EXYNOS4210_DIV_CPU0(d5, d4, d3, d2, d1, d0)			\
> +		((d5 << 24) | (d4 << 20) | (d3 << 16) | (d2 << 12) |	\
> +		 (d1 << 8) | (d0 <<  4))
> +#define EXYNOS4210_DIV_CPU1(d2, d1, d0)					\
> +		((d2 << 8) | (d1 << 4) | (d0 << 0))

Macro arguments should be put into parentheses to make sure that whole
argument is subject to further arithmetic operations.

> +
> +#define EXYNOS4210_DIV1_HPM_MASK	((0x7 << 0) | (0x7 << 4))
> +#define EXYNOS4210_MUX_HPM_MASK		(1 << 20)
> +
> +/**
> + * struct exynos4210_armclk_data: config data to setup exynos4210 cpu clocks.
> + * @prate:	frequency of the parent clock.
> + * @div0:	value to be programmed in the div_cpu0 register.
> + * @div1:	value to be programmed in the div_cpu1 register.
> + *
> + * This structure holds the divider configuration data for divider clocks
> + * belonging to the CMU_CPU clock domain. The parent frequency at which these
> + * divider values are vaild is specified in @prate.

s/vaild/valid/

> + */
> +struct exynos4210_armclk_data {
> +	unsigned long	prate;
> +	unsigned int	div0;
> +	unsigned int	div1;
> +};
> +
> +/**
> + * struct exynos_cpuclk: information about clock supplied to a CPU core.
> + * @hw:		handle between ccf and cpu clock.

s/ccf/CCF/
s/cpu/CPU/

> + * @alt_parent:	alternate parent clock to use when switching the speed
> + *		of the primary parent clock.
> + * @ctrl_base:	base address of the clock controller.
> + * @offset:	offset from the ctrl_base address where the cpu clock div/mux

s/cpu/CPU/

> + *		registers can be accessed.
> + * @clk_nb:	clock notifier registered for changes in clock speed of the
> + *		primary parent clock.
> + * @lock:	register access lock.
> + * @data:	optional data which the acutal instantiation of this clock
> + *		can use.

s/acutal/actual/

> + */
> +struct exynos_cpuclk {
> +	struct clk_hw		hw;
> +	struct clk		*alt_parent;
> +	void __iomem		*ctrl_base;
> +	unsigned long		offset;
> +	struct notifier_block	clk_nb;
> +	spinlock_t		*lock;
> +	void			*data;
> +};
> +
> +#define to_exynos_cpuclk_hw(hw) container_of(hw, struct exynos_cpuclk, hw)
> +#define to_exynos_cpuclk_nb(nb) container_of(nb, struct exynos_cpuclk, clk_nb)
> +
> +/**
> + * struct exynos_cpuclk_soc_data: soc specific data for cpu clocks.
> + * @parser:	pointer to a function that can parse SoC specific data.
> + * @ops:	clock operations to be used for this clock.
> + * @offset:	optional offset from base of clock controller register base, to
> + *		be used when accessing clock controller registers related to the
> + *		cpu clock.

s/cpu/CPU/

> + * @clk_cb:	the clock notifier callback to be called for changes in the
> + *		clock rate of the primary parent clock.
> + *
> + * This structure provides SoC specific data for ARM clocks. Based on
> + * the compatible value of the clock controller node, the value of the
> + * fields in this structure can be populated.
> + */
> +struct exynos_cpuclk_soc_data {
> +	int (*parser)(struct device_node *, void **);

Here you don't have argument names, but...

> +	const struct clk_ops *ops;
> +	unsigned int offset;
> +	int (*clk_cb)(struct notifier_block *nb, unsigned long evt, void *data);

...here you have. Please keep some consistency.

> +};
> +
> +/* common round rate callback useable for all types of cpu clocks */

s/cpu/CPU/

> +static long exynos_cpuclk_round_rate(struct clk_hw *hw,
> +			unsigned long drate, unsigned long *prate)

Hmm, the long return type will overflow with *prate > INT_MAX and
best_div == 1, I wonder why it is defined so in CCF, even though it
shouldn't return error codes...

> +{
> +	struct clk *parent = __clk_get_parent(hw->clk);
> +	unsigned long max_prate = __clk_round_rate(parent, UINT_MAX);
> +	unsigned long t_prate, div = 1, best_div = 1;
> +	unsigned long delta, min_delta = UINT_MAX;

By the way, shouldn't this function take into account the list of
available CPU rates and round drate to a less or equal supported one?
Otherwise, in further code you might hit cases where an unsupported rate
is requested, which is against the CCF semantics, if .round_rate()
operation is provided.

> +
> +	do {
> +		t_prate = __clk_round_rate(parent, drate * div);
> +		delta = drate - (t_prate / div);
> +		if (delta < min_delta) {
> +			*prate = t_prate;
> +			best_div = div;
> +			min_delta = delta;
> +		}
> +		if (!delta)
> +			break;
> +		div++;
> +	} while ((drate * div) < max_prate && div <= MAX_DIV);
> +
> +	return *prate / best_div;
> +}
> +
> +static unsigned long _calc_div(unsigned long prate, unsigned long drate)
> +{
> +	unsigned long div = prate / drate;
> +
> +	WARN_ON(div >= MAX_DIV);
> +	return (!(prate % drate)) ? div-- : div;

Could you explain what is the purpose of this check and adjustment?

If my assumption that this is essentially DIV_ROUND_UP(prate, drate) - 1
is true then this probably used to obtain a divisor value to get less or
equal rate than drate. Is it right?

> +}
> +
> +/* helper function to register a cpu clock */
> +static int __init exynos_cpuclk_register(unsigned int lookup_id,
> +		const char *name, const char **parents,
> +		unsigned int num_parents, void __iomem *base,

The num_parents argument doesn't seem to be used in the code. Maybe
instead you should simply replace it and parents arguments with (const
char *parent) and (const char *alt_parent)?

> +		const struct exynos_cpuclk_soc_data *soc_data,
> +		struct device_node *np, const struct clk_ops *ops,
> +		spinlock_t *lock)
> +{
> +	struct exynos_cpuclk *cpuclk;
> +	struct clk_init_data init;
> +	struct clk *clk;
> +	int ret;
> +
> +	cpuclk = kzalloc(sizeof(*cpuclk), GFP_KERNEL);
> +	if (!cpuclk) {
> +		pr_err("%s: could not allocate memory for %s clock\n",
> +					__func__, name);
> +		return -ENOMEM;
> +	}
> +
> +	init.name = name;
> +	init.flags = CLK_SET_RATE_PARENT;
> +	init.parent_names = parents;
> +	init.num_parents = 1;
> +	init.ops = ops;
> +
> +	cpuclk->hw.init = &init;
> +	cpuclk->ctrl_base = base;
> +	cpuclk->lock = lock;
> +
> +	ret = soc_data->parser(np, &cpuclk->data);
> +	if (ret) {
> +		pr_err("%s: error %d in parsing %s clock data",
> +				__func__, ret, name);
> +		ret = -EINVAL;
> +		goto free_cpuclk;
> +	}
> +	cpuclk->offset = soc_data->offset;
> +	init.ops = soc_data->ops;
> +
> +	cpuclk->clk_nb.notifier_call = soc_data->clk_cb;
> +	if (clk_notifier_register(__clk_lookup(parents[0]), &cpuclk->clk_nb)) {
> +		pr_err("%s: failed to register clock notifier for %s\n",
> +				__func__, name);
> +		goto free_cpuclk_data;
> +	}
> +
> +	cpuclk->alt_parent = __clk_lookup(parents[1]);
> +	if (!cpuclk->alt_parent) {
> +		pr_err("%s: could not lookup alternate parent %s\n",
> +				__func__, parents[1]);
> +		ret = -EINVAL;
> +		goto free_cpuclk_data;

Shouldn't it be goto unregister_notifier and the notifier unregistered
there?

> +	}
> +
> +	clk = clk_register(NULL, &cpuclk->hw);
> +	if (IS_ERR(clk)) {
> +		pr_err("%s: could not register cpuclk %s\n", __func__,	name);
> +		ret = PTR_ERR(clk);
> +		goto free_cpuclk_data;

Ditto.

> +	}
> +
> +	samsung_clk_add_lookup(clk, lookup_id);
> +	return 0;
> +
> +free_cpuclk_data:
> +	kfree(cpuclk->data);
> +free_cpuclk:
> +	kfree(cpuclk);
> +	return ret;
> +}
> +
> +static void _exynos4210_set_armclk_div(void __iomem *base, unsigned long div)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(10);
> +
> +	writel((readl(base + DIV_CPU0) & ~0x7) | div, base + DIV_CPU0);

The 0x7 could be defined as a preprocessor macro. Also for increased
readability, this could be split into separate read, modify and write.

> +	while (time_before(jiffies, timeout))
> +		if (!readl(base + DIV_STAT_CPU0))
> +			return;
> +	pr_err("%s: timeout in divider stablization\n", __func__);
> +}
> +
> +static unsigned long exynos4210_armclk_recalc_rate(struct clk_hw *hw,
> +				unsigned long parent_rate)
> +{
> +	struct exynos_cpuclk *armclk = to_exynos_cpuclk_hw(hw);
> +	void __iomem *base = armclk->ctrl_base + armclk->offset;
> +	unsigned long div0 = readl(base + DIV_CPU0);
> +
> +	return parent_rate / EXYNOS4210_ARM_DIV1(div0) /
> +				EXYNOS4210_ARM_DIV2(div0);
> +}
> +
> +static int exynos4210_armclk_pre_rate_change(struct clk_notifier_data *ndata,
> +			struct exynos_cpuclk *armclk, void __iomem *base)
> +{
> +	struct exynos4210_armclk_data *armclk_data = armclk->data;
> +	unsigned long alt_prate = clk_get_rate(armclk->alt_parent);
> +	unsigned long alt_div, div0, div1, tdiv0, mux_reg;
> +	unsigned long cur_armclk_rate, timeout;
> +	unsigned long flags;
> +
> +	/* find out the divider values to use for clock data */
> +	while (armclk_data->prate != ndata->new_rate) {

I assume this code relies on the assumption that target DIV_CORE and
DIV_CORE2 are always 0 (divide by 1)? Otherwise it should compare
armclk_data->prate with new parent rate, not new target armclk rate,
which would be parent rate divided by DIV_CORE and DIV_CORE2.

> +		if (armclk_data->prate == 0)
> +			return -EINVAL;
> +		armclk_data++;
> +	}
> +
> +	div0 = armclk_data->div0;
> +	div1 = armclk_data->div1;

A comment about the following if would be nice.

> +	if (readl(base + SRC_CPU) & EXYNOS4210_MUX_HPM_MASK) {
> +		div1 = readl(base + DIV_CPU1) & EXYNOS4210_DIV1_HPM_MASK;
> +		div1 |= ((armclk_data->div1) & ~EXYNOS4210_DIV1_HPM_MASK);
> +	}
> +
> +	/*
> +	 * if the new and old parent clock speed is less than the clock speed
> +	 * of the alternate parent, then it should be ensured that at no point
> +	 * the armclk speed is more than the old_prate until the dividers are
> +	 * set.
> +	 */
> +	tdiv0 = readl(base + DIV_CPU0);
> +	cur_armclk_rate = ndata->old_rate / EXYNOS4210_ARM_DIV1(tdiv0) /
> +				EXYNOS4210_ARM_DIV2(tdiv0);
> +	if (alt_prate > cur_armclk_rate) {

Shouldn't you compare two parent rates here, not alt parent rate with
current armclk rate?

Also, this condition compares only alt rate with current rate. Let's see:

1) old >= alt && new >= alt => alt < old X new

The voltage will be always enough to handle the switch, so no division
is needed.

2) old < alt && new >= alt => old < alt <= new

The voltage will be switched to higher or equal necessary one for alt
rate, so no division is needed.

3) old < alt && new < alt => old X new < alt

The voltage won't be enough for alt rate so division is needed.

4) old >= alt && new < alt => new < alt <= old

Current voltage is enough for alt rate and it will be lowered only after
the switching finishes, so division is not needed.

This means that division is necessary only if both new and old rates are
lower than alt and this is what the comment above says, but not what the
code does, which is slightly inefficient.

> +		alt_div = _calc_div(alt_prate, cur_armclk_rate);
> +		_exynos4210_set_armclk_div(base, alt_div);
> +		div0 |= alt_div;

Hmm, this code is barely readable. It is not clear whether _calc_div()
is returning a value ready to be written to the register or real divisor
value. I'd make _calc_div() to simply return raw divisor value and then
use a macro that calculates required bitfield value.

Another thing is whether 8 is big enough maximum divisor. If not, both
DIV_CORE and DIV_CORE2 should be used together to form a 6-bit divisor,
which lets you divide by up to 64.

> +	}
> +
> +	/* select sclk_mpll as the alternate parent */
> +	spin_lock_irqsave(armclk->lock, flags);

Hmm, is the start of critical section really here? The big
read-modify-write section seems to begin at

	if (readl(base + SRC_CPU) & EXYNOS4210_MUX_HPM_MASK) {
		div1 = readl(base + DIV_CPU1) & EXYNOS4210_DIV1_HPM_MASK;

> +	mux_reg = readl(base + SRC_CPU);
> +	writel(mux_reg | (1 << 16), base + SRC_CPU);
> +
> +	timeout = jiffies + msecs_to_jiffies(10);
> +	while (time_before(jiffies, timeout))
> +		if (((readl(base + STAT_CPU) >> 16) & 0x7) == 2)
> +			break;
> +	spin_unlock_irqrestore(armclk->lock, flags);

Is this really end of critical secion? More writes to registers are
happening below. Keep in mind that APLL_RATIO field of CLK_DIV_CPU0
register is used by generic divider clock - "sclk_apll".

> +
> +	if (((readl(base + STAT_CPU) >> 16) & 0x7) != 2)
> +		pr_err("%s: re-parenting to sclk_mpll failed\n", __func__);
> +
> +	/* alternate parent is active now. set the dividers */
> +	writel(div0, base + DIV_CPU0);
> +	timeout = jiffies + msecs_to_jiffies(10);
> +	while (time_before(jiffies, timeout))
> +		if (!readl(base + DIV_STAT_CPU0))
> +			break;
> +
> +	if (readl(base + DIV_STAT_CPU0))
> +		pr_err("%s: timeout in divider0 stablization\n", __func__);
> +
> +	writel(div1, base + DIV_CPU1);
> +	timeout = jiffies + msecs_to_jiffies(10);
> +	while (time_before(jiffies, timeout))
> +		if (!readl(base + DIV_STAT_CPU1))
> +			break;
> +	if (readl(base + DIV_STAT_CPU1))
> +		pr_err("%s: timeout in divider1 stablization\n", __func__);

IMHO to be safe, the spin_unlock_irqrestore() should be called here.

> +
> +	return 0;
> +}
> +
> +static int exynos4210_armclk_post_rate_change(struct exynos_cpuclk *armclk,
> +			void __iomem *base)
> +{
> +	unsigned long mux_reg, flags;
> +	unsigned long timeout = jiffies + msecs_to_jiffies(10);
> +
> +	spin_lock_irqsave(armclk->lock, flags);
> +	mux_reg = readl(base + SRC_CPU);
> +	writel(mux_reg & ~(1 << 16), base + SRC_CPU);

Please replace (1 << 16) with appropriate macro.

> +	while (time_before(jiffies, timeout))
> +		if (((readl(base + STAT_CPU) >> 16) & 0x7) == 1)
> +			break;
> +	spin_unlock_irqrestore(armclk->lock, flags);
> +
> +	if (((readl(base + STAT_CPU) >> 16) & 0x7) != 1)
> +		pr_err("%s: re-parenting to mout_apll failed\n", __func__);
> +
> +	return 0;
> +}
> +
> +/*
> + * This clock notifier is called when the frequency of the parent clock
> + * of armclk is to be changed. This notifier handles the setting up all
> + * the divider clocks, remux to temporary parent and handling the safe
> + * frequency levels when using temporary parent.
> + */
> +static int exynos4210_armclk_notifier_cb(struct notifier_block *nb,
> +				unsigned long event, void *data)
> +{
> +	struct clk_notifier_data *ndata = data;
> +	struct exynos_cpuclk *armclk = to_exynos_cpuclk_nb(nb);
> +	void __iomem *base =  armclk->ctrl_base + armclk->offset;
> +	int err = 0;
> +
> +	if (event == PRE_RATE_CHANGE)
> +		err = exynos4210_armclk_pre_rate_change(ndata, armclk, base);
> +	else if (event == POST_RATE_CHANGE)
> +		err = exynos4210_armclk_post_rate_change(armclk, base);
> +
> +	return notifier_from_errno(err);
> +}
> +
> +static int exynos4210_armclk_set_rate(struct clk_hw *hw, unsigned long drate,
> +					unsigned long prate)
> +{
> +	struct exynos_cpuclk *armclk = to_exynos_cpuclk_hw(hw);
> +	void __iomem *base = armclk->ctrl_base + armclk->offset;
> +	unsigned long div;
> +
> +	div = drate < prate ? _calc_div(prate, drate) : 0;
> +	_exynos4210_set_armclk_div(base, div);

Hmm, the code above in pre_rate_change() assumed that both DIV_CORE and
DIV_CORE2 are 0, but here it sets DIV_CORE to a potentially non-zero
value. It doesn't look correct.

> +	return 0;
> +}
> +
> +static const struct clk_ops exynos4210_armclk_clk_ops = {
> +	.recalc_rate = exynos4210_armclk_recalc_rate,
> +	.round_rate = exynos_cpuclk_round_rate,
> +	.set_rate = exynos4210_armclk_set_rate,
> +};
> +
> +/*
> + * parse divider configuration data from dt for all the cpu clock domain
> + * clocks in exynos4210 and compatible SoC's.
> + */
> +static int __init exynos4210_armclk_parser(struct device_node *np, void **data)
> +{
> +	struct exynos4210_armclk_data *tdata;
> +	u32 cfg[10], num_rows, row, col;
> +	struct property *prop;
> +	const __be32 *ptr = NULL;
> +	u32 cells;
> +	int ret;
> +
> +	if (of_property_read_u32(np, "samsung,armclk-cells", &cells))
> +		return -EINVAL;
> +	prop = of_find_property(np, "samsung,armclk-divider-table", NULL);

You should rather use the *lenp argument of of_find_property(), instead
of dereferencing the struct.

> +	if (!prop)
> +		return -EINVAL;
> +	if (!prop->value)
> +		return -EINVAL;

You can skip the check above, as the calculation below will give you
num_rows equal 0 in this case.

> +	if ((prop->length / sizeof(u32)) % cells)
> +		return -EINVAL;
> +	num_rows = (prop->length / sizeof(u32)) / cells;
> +
> +	/* allocate a zero terminated table */
> +	*data = kzalloc(sizeof(*tdata) * (num_rows + 1), GFP_KERNEL);
> +	if (!*data)
> +		ret = -ENOMEM;

Shouldn't you just return -ENOMEM here?

Best regards,
Tomasz
