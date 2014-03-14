From: horms@verge.net.au (Simon Horman)
Date: Fri, 14 Mar 2014 16:59:40 +0900
Subject: [PATCH v4 01/19] clk: shmobile: r8a7779: Add clocks support
In-Reply-To: <1396603.8zjnV9HRUq@avalon>
References: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
 <1394701202-25823-2-git-send-email-horms+renesas@verge.net.au>
 <1396603.8zjnV9HRUq@avalon>
Message-ID: <20140314075939.GA31900@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 10:34:07AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> Thank you for the patch.
> 
> On Thursday 13 March 2014 17:59:44 Simon Horman wrote:
> > The R8A7779 SoC has several clocks that are too custom to be supported in a
> > generic driver. Those clocks are all fixed rate clocks with multiplier and
> > divisor set according to boot mode configuration.
> > 
> > Based on work for R-Car Gen2 SoCs by Laurent Pinchart.
> > 
> > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > ---
> > Under discussion
> > * Laurent Pinchart would like an "renesas,rcar-gen1-cpg-clocks" compat
> > string added. I am less enthusiastic.
> 
> Apart from this I have just a small comment, please see below. All the rest 
> looks good to me.
> 
> > v4
> > * As suggested by Geert Uytterhoeven
> >   - Remove double and from bindings documentation
> >   - Remove unused CPG_PLL_CONFIG_INDEX and struct cpg_pll_config
> >   - Correct order of cpg_clk_configs entries
> > * As suggested by Laurent Pinchart
> >   - Update copyright to include 2014
> >   - Remove reference to non-existent divider clocks in changelog
> >   - Do not map cpg->reg as it is not accessed
> >   - Return an error for unknown name values in r8a7779_cpg_register_clock()
> >   - Expose clkb in binding
> >   - Do not include MSPT registers in register range in binding example
> > * Write (BIT(2)|BIT(1)) instead of (BIT(1)|BIT(2)) as it is less confusing
> >   (to me)
> > v3
> > * As suggested by Laurent Pinchart
> >   - Added external clock input
> >   - Use PLLA ratio set bu MD11 and MD12
> >   - Add _div suffixes of fields of struct cpt_clk_config
> >   - Register PLLA as a fixed factor clock
> >   - Use sizeof() instead of sizeof
> >   - Use num_clks instead of CPG_NUM_CLOCKS in r8a7779_cpg_clocks_init()
> > 
> >   - I kept this as r8a7779 binding rather than moving to a R-Car Gen1
> >     binding which could be shared with other SoCs as I do not believe that
> >     the SoCs is are sufficiently similar.
> > ---
> >  .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  |  27 +++
> >  drivers/clk/shmobile/Makefile                      |   1 +
> >  drivers/clk/shmobile/clk-r8a7779.c                 | 181
> > +++++++++++++++++++++ include/linux/clk/shmobile.h                       | 
> >  3 +
> >  4 files changed, 212 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
> > create mode 100644 drivers/clk/shmobile/clk-r8a7779.c
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
> > b/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
> > new file mode 100644
> > index 0000000..ed3c8cb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
> > @@ -0,0 +1,27 @@
> > +* Renesas R8A7779 Clock Pulse Generator (CPG)
> > +
> > +The CPG generates core clocks for the R8A7779. It includes one PLL and
> > +several fixed ratio dividers
> > +
> > +Required Properties:
> > +
> > +  - compatible: Must be "renesas,r8a7779-cpg-clocks"
> > +  - reg: Base address and length of the memory resource used by the CPG
> > +
> > +  - clocks: Reference to the parent clock
> > +  - #clock-cells: Must be 1
> > +  - clock-output-names: The names of the clocks. Supported clocks are
> > "plla", +    "z", "zs", "s", "s1", "p", "b", "out".
> > +
> > +
> > +Example
> > +-------
> > +
> > +	cpg_clocks: cpg_clocks at ffc80000 {
> > +		compatible = "renesas,r8a7779-cpg-clocks";
> > +		reg = <0 0xffc80000 0 0x30>;
> > +		clocks = <&extal_clk>;
> > +		#clock-cells = <1>;
> > +		clock-output-names = "plla", "z", "zs", "s", "s1", "p",
> > +		                     "b", "out";
> > +	};
> > diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
> > index 9ecef14..2121ba0 100644
> > --- a/drivers/clk/shmobile/Makefile
> > +++ b/drivers/clk/shmobile/Makefile
> > @@ -1,4 +1,5 @@
> >  obj-$(CONFIG_ARCH_EMEV2)		+= clk-emev2.o
> > +obj-$(CONFIG_ARCH_R8A7779)		+= clk-r8a7779.o
> >  obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o
> >  obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o
> >  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-div6.o
> > diff --git a/drivers/clk/shmobile/clk-r8a7779.c
> > b/drivers/clk/shmobile/clk-r8a7779.c new file mode 100644
> > index 0000000..8974a41
> > --- /dev/null
> > +++ b/drivers/clk/shmobile/clk-r8a7779.c
> > @@ -0,0 +1,181 @@
> > +/*
> > + * r8a7779 Core CPG Clocks
> > + *
> > + * Copyright (C) 2013, 2014 Horms Solutions Ltd.
> > + *
> > + * Contact: Simon Horman <horms@verge.net.au>
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
> > +#include <dt-bindings/clock/r8a7779-clock.h>
> > +
> > +#define CPG_NUM_CLOCKS			(R8A7779_CLK_OUT + 1)
> > +
> > +struct r8a7779_cpg {
> > +	struct clk_onecell_data data;
> > +	spinlock_t lock;
> > +	void __iomem *reg;
> > +};
> > +
> > +/*
> > ---------------------------------------------------------------------------
> > -- + * CPG Clock Data
> > + */
> > +
> > +/*
> > + *		MD1 = 1			MD1 = 0
> > + *		(PLLA = 1500)		(PLLA = 1600)
> > + *		(MHz)			(MHz)
> > + *------------------------------------------------+--------------------
> > + * clkz		1000   (2/3)		800   (1/2)
> > + * clkzs	 250   (1/6)		200   (1/8)
> > + * clki		 750   (1/2)		800   (1/2)
> > + * clks		 250   (1/6)		200   (1/8)
> > + * clks1	 125   (1/12)		100   (1/16)
> > + * clks3	 187.5 (1/8)		200   (1/8)
> > + * clks4	  93.7 (1/16)		100   (1/16)
> > + * clkp		  62.5 (1/24)		 50   (1/32)
> > + * clkg		  62.5 (1/24)		 66.6 (1/24)
> > + * clkb, CLKOUT
> > + * (MD2 = 0)	  62.5 (1/24)		 66.6 (1/24)
> > + * (MD2 = 1)	  41.6 (1/36)		 50   (1/32)
> > + */
> > +
> > +#define CPG_CLK_CONFIG_INDEX(md)	(((md) & (BIT(2)|BIT(1))) >> 1)
> > +
> > +struct cpg_clk_config {
> > +	unsigned int z_mult;
> > +	unsigned int z_div;
> > +	unsigned int zs_and_s_div;
> > +	unsigned int s1_div;
> > +	unsigned int p_div;
> > +	unsigned int b_and_out_div;
> > +};
> > +
> > +static const struct cpg_clk_config cpg_clk_configs[4] __initconst = {
> > +	{ 1, 2, 8, 16, 32, 24 },
> > +	{ 2, 3, 6, 12, 24, 24 },
> > +	{ 1, 2, 8, 16, 32, 32 },
> > +	{ 2, 3, 6, 12, 24, 36 },
> > +};
> > +
> > +/*
> > + *   MD		PLLA Ratio
> > + * 12 11
> > + *------------------------
> > + * 0  0		x42
> > + * 0  1		x48
> > + * 1  0		x56
> > + * 1  1		x64
> > + */
> > +
> > +#define CPG_PLLA_MULT_INDEX(md)	(((md) & (BIT(12)|BIT(11))) >> 11)
> > +
> > +static const unsigned int cpg_plla_mult[4] __initconst = { 42, 48, 56, 64
> > }; +
> > +/*
> > ---------------------------------------------------------------------------
> > -- + * Initialization
> > + */
> > +
> > +static u32 cpg_mode __initdata;
> > +
> > +static struct clk * __init
> > +r8a7779_cpg_register_clock(struct device_node *np, struct r8a7779_cpg *cpg,
> > +			   const struct cpg_clk_config *config,
> > +			   unsigned int plla_mult, const char *name)
> > +{
> > +	const char *parent_name = "plla";
> > +	unsigned int mult = 1;
> > +	unsigned int div = 1;
> > +
> > +	if (!strcmp(name, "plla")) {
> > +		parent_name = of_clk_get_parent_name(np, 0);
> > +		mult = plla_mult;
> > +	} else if (!strcmp(name, "z")) {
> > +		div = config->z_div;
> > +		mult = config->z_mult;
> > +	} else if (!strcmp(name, "zs") || !strcmp(name, "s")) {
> > +		div = config->zs_and_s_div;
> > +	} else if (!strcmp(name, "s1")) {
> > +		div = config->s1_div;
> > +	} else if (!strcmp(name, "p")) {
> > +		div = config->p_div;
> > +	} else if (!strcmp(name, "b") || !strcmp(name, "out")) {
> > +		div = config->b_and_out_div;
> > +	} else {
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	return clk_register_fixed_factor(NULL, name, parent_name, 0, mult, div);
> > +}
> > +
> > +static void __init r8a7779_cpg_clocks_init(struct device_node *np)
> > +{
> > +	const struct cpg_clk_config *config;
> > +	struct r8a7779_cpg *cpg;
> > +	struct clk **clks;
> > +	unsigned int i, plla_mult;
> > +	int num_clks;
> > +
> > +	num_clks = of_property_count_strings(np, "clock-output-names");
> > +	if (num_clks < 0) {
> > +		pr_err("%s: failed to count clocks\n", __func__);
> > +		return;
> > +	}
> > +
> > +	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
> > +	clks = kzalloc(CPG_NUM_CLOCKS * sizeof(*clks), GFP_KERNEL);
> > +	if (cpg == NULL || clks == NULL) {
> > +		/* We're leaking memory on purpose, there's no point in cleaning
> > +		 * up as the system won't boot anyway.
> > +		 */
> > +		pr_err("%s: failed to allocate cpg\n", __func__);
> 
> It has recently been pointed out to me that kzalloc failures print an OOM 
> message to the kernel log, so there's no need to duplicate it.

Thanks, I will remove the pr_err() line.

> 
> > +		return;
> > +	}
> > +
> > +	spin_lock_init(&cpg->lock);
> > +
> > +	cpg->data.clks = clks;
> > +	cpg->data.clk_num = num_clks;
> > +
> > +	config = &cpg_clk_configs[CPG_CLK_CONFIG_INDEX(cpg_mode)];
> > +	plla_mult = cpg_plla_mult[CPG_PLLA_MULT_INDEX(cpg_mode)];
> > +
> > +	for (i = 0; i < num_clks; ++i) {
> > +		const char *name;
> > +		struct clk *clk;
> > +
> > +		of_property_read_string_index(np, "clock-output-names", i,
> > +					      &name);
> > +
> > +		clk = r8a7779_cpg_register_clock(np, cpg, config,
> > +						 plla_mult, name);
> > +		if (IS_ERR(clk))
> > +			pr_err("%s: failed to register %s %s clock (%ld)\n",
> > +			       __func__, np->name, name, PTR_ERR(clk));
> > +		else
> > +			cpg->data.clks[i] = clk;
> > +	}
> > +
> > +	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
> > +}
> > +CLK_OF_DECLARE(r8a7779_cpg_clks, "renesas,r8a7779-cpg-clocks",
> > +	       r8a7779_cpg_clocks_init);
> 
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
