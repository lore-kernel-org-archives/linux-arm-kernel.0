From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 06 Nov 2013 13:56:18 +0100
Subject: [PATCH 3/3] clk: shmobile: Add R8A7790 clocks support
In-Reply-To: <20131106071809.GC17384@verge.net.au>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383058511-26046-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131106071809.GC17384@verge.net.au>
Message-ID: <1808894.OunndLaMUR@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wednesday 06 November 2013 16:18:09 Simon Horman wrote:
> On Tue, Oct 29, 2013 at 03:55:11PM +0100, Laurent Pinchart wrote:
> > The R8A7790 has several clocks that are too custom to be supported in a
> > generic driver. Those clocks can be divided in two categories:
> > 
> > - Fixed rate clocks with multiplier and divisor set according to boot
> >   mode configuration
> > 
> > - Custom divider clocks with SoC-specific divider values
> > 
> > This driver supports both.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  .../bindings/clock/renesas,r8a7790-cpg-clocks.txt  |  26 +++
> >  drivers/clk/shmobile/Makefile                      |   1 +
> >  drivers/clk/shmobile/clk-r8a7790.c                 | 176 ++++++++++++++++
> >  include/dt-bindings/clock/r8a7790-clock.h          |  10 ++
> >  include/linux/clk/shmobile.h                       |  19 +++
> >  5 files changed, 232 insertions(+)
> >  create mode 100644
> >  Documentation/devicetree/bindings/clock/renesas,r8a7790-cpg-clocks.txt
> >  create mode 100644 drivers/clk/shmobile/clk-r8a7790.c
> >  create mode 100644 include/linux/clk/shmobile.h
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/clock/renesas,r8a7790-cpg-clocks.txt
> > b/Documentation/devicetree/bindings/clock/renesas,r8a7790-cpg-clocks.txt
> > new file mode 100644
> > index 0000000..d889917
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/clock/renesas,r8a7790-cpg-clocks.txt
> > @@ -0,0 +1,26 @@
> > +* Renesas R8A7790 Clock Pulse Generator (CPG)
> > +
> > +The CPG generates core clocks for the R8A7790. It includes three PLLs and
> > +several fixed ratio dividers.
> > +
> > +Required Properties:
> > +
> > +  - compatible: Must be "renesas,r8a7790-cpg-clocks"
> > +  - reg: Base address and length of the memory resource used by the CPG
> > +  - clocks: Reference to the parent clock
> > +  - #clock-cells: Must be 1
> > +  - clock-output-names: The name of the clocks, must be "main", "pll1",
> 
> s/The name/The names/

Will fix, thank you.

> > +    "pll3", "lb", "qspi", "sdh", "sd0", "sd1".
> > +
> > +
> > +Example
> > +-------
> > +
> > +	cpg_clocks: cpg_clocks {
> > +		compatible = "renesas,r8a7790-cpg-clocks";
> > +		reg = <0 0xe6150000 0 0x1000>;
> > +		clocks = <&extal_clk>;
> > +		#clock-cells = <1>;
> > +		clock-output-names = "main", "pll1", "pll3", "lb",
> > +				     "qspi", "sdh", "sd0", "sd1";
> > +	};
> 
> I wonder if it makes sense to craft a more generic bindings document.
> 
> I am currently working on clock support for the r8a7779 (H1) based
> on this patch series and I expect the bindings to end up being
> more or less the same.
> 
> I expect there to be similar support to be added for many other renesas SoCs
> over time.

That's a good idea. I'll gladly review patches :-)

> > diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
> > index 3275c78..949f29e 100644
> > --- a/drivers/clk/shmobile/Makefile
> > +++ b/drivers/clk/shmobile/Makefile
> > @@ -1,4 +1,5 @@
> >  obj-$(CONFIG_ARCH_EMEV2)		+= clk-emev2.o
> > +obj-$(CONFIG_ARCH_R8A7790)		+= clk-r8a7790.o
> >  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-div6.o
> >  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-mstp.o
> > diff --git a/drivers/clk/shmobile/clk-r8a7790.c
> > b/drivers/clk/shmobile/clk-r8a7790.c new file mode 100644
> > index 0000000..2e76638
> > --- /dev/null
> > +++ b/drivers/clk/shmobile/clk-r8a7790.c
> > @@ -0,0 +1,176 @@
> > +/*
> > + * r8a7790 Core CPG Clocks
> > + *
> > + * Copyright (C) 2013  Ideas On Board SPRL
> > + *
> > + * Contact: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; version 2 of the License.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/clkdev.h>
> > +#include <linux/clk/shmobile.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/spinlock.h>
> > +
> > +#include <dt-bindings/clock/r8a7790-clock.h>
> > +
> > +#define CPG_NUM_CLOCKS			(R8A7790_CLK_SD1 + 1)
> 
> Perhaps R8A7790_NUM_CLOCKS in r8a7790-clock.h would be nicer.

Good question. The dt-bindings/ headers are primarly meant to store macros 
used by .dts files and (possibly) shared with C code. Given that 
R8A7790_NUM_CLOCKS isn't used by .dts files I'm not sure it would belong to 
that header.

> > +
> > +struct r8a7790_cpg {
> > +	struct clk_onecell_data data;
> > +	spinlock_t lock;
> > +	void __iomem *reg;
> > +};
> > +
> > +/*
> > + *   MD		EXTAL		PLL0	PLL1	PLL3
> > + * 14 13 19	(MHz)		*1	*1
> > + *---------------------------------------------------
> > + * 0  0  0	15 x 1		x172/2	x208/2	x106
> > + * 0  0  1	15 x 1		x172/2	x208/2	x88
> > + * 0  1  0	20 x 1		x130/2	x156/2	x80
> > + * 0  1  1	20 x 1		x130/2	x156/2	x66
> > + * 1  0  0	26 / 2		x200/2	x240/2	x122
> > + * 1  0  1	26 / 2		x200/2	x240/2	x102
> > + * 1  1  0	30 / 2		x172/2	x208/2	x106
> > + * 1  1  1	30 / 2		x172/2	x208/2	x88
> > + *
> > + * *1 :	Table 7.6 indicates VCO ouput (PLLx = VCO/2)
> > + */
> > +#define CPG_PLL_CONFIG_INDEX(md)	((((md) & BIT(14)) >> 12) | \
> > +					 (((md) & BIT(13)) >> 12) | \
> > +					 (((md) & BIT(19)) >> 19))
> > +struct cpg_pll_config {
> > +	unsigned int extal_div;
> > +	unsigned int pll1_mult;
> > +	unsigned int pll3_mult;
> > +};
> > +
> > +static const struct cpg_pll_config cpg_pll_configs[8] = {
> > +	{ 1, 208, 106 }, { 1, 208,  88 }, { 1, 156,  80 }, { 1, 156,  66 },
> > +	{ 2, 240, 122 }, { 2, 240, 102 }, { 2, 208, 106 }, { 2, 208,  88 },
> > +};
> > +
> > +/* SDHI divisors */
> > +static const struct clk_div_table cpg_sdh_div_table[] = {
> > +	{  0,  2 }, {  1,  3 }, {  2,  4 }, {  3,  6 },
> > +	{  4,  8 }, {  5, 12 }, {  6, 16 }, {  7, 18 },
> > +	{  8, 24 }, { 10, 36 }, { 11, 48 }, {  0,  0 },
> > +};
> > +
> > +static const struct clk_div_table cpg_sd01_div_table[] = {
> > +	{  5, 12 }, {  6, 16 }, {  7, 18 }, {  8, 24 },
> > +	{ 10, 36 }, { 11, 48 }, { 12, 10 }, {  0,  0 },
> > +};
> 
> Can any or all of the above three constants be __initconst?

Not the clk_div_table arrays, as they're stored in the divider clock structure 
internally and used at runtime. The cpg_pll_configs array, however, can. I'll 
fix that.

> > +
> > +static u32 cpg_mode __initdata;
> > +
> > +#define CPG_SDCKCR			0x00000074
> > +
> > +static void __init r8a7790_cpg_clocks_init(struct device_node *np)
> > +{
> > +	const struct cpg_pll_config *config;
> > +	struct r8a7790_cpg *cpg;
> > +	struct clk **clks;
> > +	unsigned int i;
> > +
> > +	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
> 
> Nit: s/sizeof(*cpg)/sizeof *cpg/, sizeof is an operator.

That's what I do in my non-kernel code, but the kernel coding style uses (). 
It took me a bit of time to get used to it :-)

> > +	clks = kzalloc(CPG_NUM_CLOCKS * sizeof(*clks), GFP_KERNEL);
> > +	if (cpg == NULL || clks == NULL) {
> > +		kfree(clks);
> > +		kfree(cpg);
> > +		pr_err("%s: failed to allocate cpg\n", __func__);
> > +		return;
> > +	}
> > +
> > +	spin_lock_init(&cpg->lock);
> > +
> > +	cpg->data.clks = clks;
> > +	cpg->data.clk_num = CPG_NUM_CLOCKS;
> > +
> > +	cpg->reg = of_iomap(np, 0);
> > +	if (WARN_ON(cpg->reg == NULL)) {
> > +		kfree(cpg->data.clks);
> > +		kfree(cpg);
> > +		return;
> > +	}
> 
> Perhaps this error checking could be merged with that of cpg and clks?

Morimoto-san has already pointed-out that issue. Here was my answer, your 
opinion would be appreciated.

Given that a failure to allocate memory or ioremap registers will lead to a 
boot failure, I wonder whether we couldn't just remove the kfree() calls and 
leak memory. Is there a point in cleaning up behind us if the system will no 
boot due to missing core clocks anyway ?

> > +
> > +	config = &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_mode)];
> > +
> > +	for (i = 0; i < CPG_NUM_CLOCKS; ++i) {
> > +		const struct clk_div_table *table = NULL;
> > +		const char *parent_name = "main";
> > +		const char *name;
> > +		unsigned int shift;
> > +		unsigned int mult = 1;
> > +		unsigned int div = 1;
> > +		struct clk *clk;
> > +
> > +		of_property_read_string_index(np, "clock-output-names", i,
> > +					      &name);
> > +
> > +		switch (i) {
> > +		case R8A7790_CLK_MAIN:
> > +			parent_name = of_clk_get_parent_name(np, 0);
> > +			div = config->extal_div;
> > +			break;
> > +		case R8A7790_CLK_PLL1:
> > +			mult = config->pll1_mult / 2;
> > +			break;
> > +		case R8A7790_CLK_PLL3:
> > +			mult = config->pll3_mult;
> > +			break;
> > +		case R8A7790_CLK_LB:
> > +			div = cpg_mode & BIT(18) ? 36 : 24;
> > +			break;
> > +		case R8A7790_CLK_QSPI:
> > +			div = (cpg_mode & (BIT(3) | BIT(2) | BIT(1))) == BIT(2)
> > +			    ? 16 : 20;
> > +			break;
> > +		case R8A7790_CLK_SDH:
> > +			table = cpg_sdh_div_table;
> > +			shift = 8;
> > +			break;
> > +		case R8A7790_CLK_SD0:
> > +			table = cpg_sd01_div_table;
> > +			shift = 4;
> > +			break;
> > +		case R8A7790_CLK_SD1:
> > +			table = cpg_sd01_div_table;
> > +			shift = 0;
> > +			break;
> > +		}
> 
> I wonder if it would be good to and skip the portions below if the switch
> statement hits a default: case.

Yes, but that would be a bug in the driver, as all cases should be handled :-)

> Also, if i was an enum type then I think the C compiler would warn
> about any missing cases. That might be nice too.

It would be, but the DT compiler doesn't support enums, so we're stuck with 
#define's if we want to share them between .dts and C files.

> > +
> > +		if (!table)
> > +			clk = clk_register_fixed_factor(NULL, name, parent_name,
> > +							0, mult, div);
> > +		else
> > +			clk = clk_register_divider_table(NULL, name,
> > +							 parent_name, 0,
> > +							 cpg->reg + CPG_SDCKCR,
> > +							 shift, 4, 0, table,
> > +							 &cpg->lock);
> > +
> > +		if (IS_ERR(clk))
> > +			pr_err("%s: failed to register %s %s clock (%ld)\n",
> > +			       __func__, np->name, name, PTR_ERR(clk));
> > +	}
> > +
> > +	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
> > +}
> > +CLK_OF_DECLARE(r8a7790_cpg_clks, "renesas,r8a7790-cpg-clocks",
> > +	       r8a7790_cpg_clocks_init);
> > +
> > +void __init r8a7790_clocks_init(u32 mode)
> > +{
> > +	cpg_mode = mode;
> > +
> > +	of_clk_init(NULL);
> > +}
> > diff --git a/include/dt-bindings/clock/r8a7790-clock.h
> > b/include/dt-bindings/clock/r8a7790-clock.h index 19f2b48..f0ed742 100644
> > --- a/include/dt-bindings/clock/r8a7790-clock.h
> > +++ b/include/dt-bindings/clock/r8a7790-clock.h
> > @@ -10,6 +10,16 @@
> > 
> >  #ifndef __DT_BINDINGS_CLOCK_R8A7790_H__
> >  #define __DT_BINDINGS_CLOCK_R8A7790_H__
> > 
> > +/* CPG */
> > +#define R8A7790_CLK_MAIN		0
> > +#define R8A7790_CLK_PLL1		1
> > +#define R8A7790_CLK_PLL3		2
> > +#define R8A7790_CLK_LB			3
> > +#define R8A7790_CLK_QSPI		4
> > +#define R8A7790_CLK_SDH			5
> > +#define R8A7790_CLK_SD0			6
> > +#define R8A7790_CLK_SD1			7
> > +
> > 
> >  /* MSTP1 */
> >  #define R8A7790_CLK_CMT0		20
> > 
> > diff --git a/include/linux/clk/shmobile.h b/include/linux/clk/shmobile.h
> > new file mode 100644
> > index 0000000..b090855
> > --- /dev/null
> > +++ b/include/linux/clk/shmobile.h
> > @@ -0,0 +1,19 @@
> > +/*
> > + * Copyright 2013 Ideas On Board SPRL
> > + *
> > + * Contact: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +
> > +#ifndef __LINUX_CLK_SHMOBILE_H_
> > +#define __LINUX_CLK_SHMOBILE_H_
> > +
> > +#include <linux/types.h>
> > +
> > +void r8a7790_clocks_init(u32 mode);
> > +
> > +#endif
-- 
Regards,

Laurent Pinchart
