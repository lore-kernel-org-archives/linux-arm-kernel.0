From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sun, 02 Mar 2014 23:15:40 +0100
Subject: [PATCH 3/4] clk: shmobile: add CPG driver for rz-platforms
In-Reply-To: <1393621768-12568-4-git-send-email-wsa@the-dreams.de>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <1393621768-12568-4-git-send-email-wsa@the-dreams.de>
Message-ID: <1569751.q5lJmQcb3K@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thank you for the patch.

On Friday 28 February 2014 22:09:27 Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> ---
> 
> Mike: if you are fine with this driver, it would be good if you could apply
> it. Then, we can deal with the orthogonal dependencies in mach-shmobile
> seperately and know that the driver is already in place when the rest gets
> resolved. Thanks!
> 
>  drivers/clk/shmobile/Makefile |   1 +
>  drivers/clk/shmobile/clk-rz.c | 112 +++++++++++++++++++++++++++++++++++++++

There's one large missing piece here: the DT bindings documentation.

>  2 files changed, 113 insertions(+)
>  create mode 100644 drivers/clk/shmobile/clk-rz.c
> 
> diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
> index 9ecef14..5404cb9 100644
> --- a/drivers/clk/shmobile/Makefile
> +++ b/drivers/clk/shmobile/Makefile
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_ARCH_EMEV2)		+= clk-emev2.o
> +obj-$(CONFIG_ARCH_R7S72100)		+= clk-rz.o
>  obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o
>  obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o
>  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-div6.o
> diff --git a/drivers/clk/shmobile/clk-rz.c b/drivers/clk/shmobile/clk-rz.c
> new file mode 100644
> index 0000000..ec1c795
> --- /dev/null
> +++ b/drivers/clk/shmobile/clk-rz.c
> @@ -0,0 +1,112 @@
> +/*
> + * rz Core CPG Clocks
> + *
> + * Copyright (C) 2013 Ideas On Board SPRL
> + * Copyright (C) 2014 Wolfram Sang, Sang Engineering
> <wsa@sang-engineering.com> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +
> +struct rz_cpg {
> +	struct clk_onecell_data data;
> +	void __iomem *reg;
> +};
> +
> +#define CPG_FRQCR	0x10
> +#define CPG_FRQCR2	0x14
> +
> +/*
> ---------------------------------------------------------------------------
> -- + * Initialization
> + */
> +
> +static struct clk * __init
> +rz_cpg_register_clock(struct device_node *np, struct rz_cpg *cpg, const
> char *name)
> +{
> +	u32 val;
> +	unsigned mult, frqcr_tab[4] = { 3, 2, 0, 1 };

I would declare the table as static const outside of this function.

> +
> +	if (strcmp(name, "pll") == 0) {
> +		/* FIXME: cpg_mode should be read from GPIO. But no GPIO support yet 
*/
> +		unsigned cpg_mode = 0; /* hardcoded to EXTAL for now */

It won't make a difference yet, but shouldn't this be moved to 
rz_cpg_clocks_init() ?

> +		const char *parent_name = of_clk_get_parent_name(np, 0);

You should select the parent depending on the mode (again it won't make any 
difference yet, but the code will be ready, and DT bindings should document 
two parents).

> +
> +		mult = cpg_mode ? (32 / 4) : 30;
> +		return clk_register_fixed_factor(NULL, name, parent_name, 0, mult, 
1);
> +	}
> +
> +	/* FIXME:"i" and "g" are variable clocks with non-integer dividers (e.g.
> 2/3)
> +	 * and the constraint that always g <= i. To get the rz platform started,
> +	 * let them run at fixed current speed and implement the details later.
> +	 */
> +	if (strcmp(name, "i") == 0)
> +		val = (clk_readl(cpg->reg + CPG_FRQCR) >> 8) & 3;
> +	else if (strcmp(name, "g") == 0)
> +		val = clk_readl(cpg->reg + CPG_FRQCR2) & 3;

The registers are 16 bits wide, are 32 bits accessed valid ? I suppose they 
work as you use them.

> +	else
> +		return ERR_PTR(-EINVAL);
> +
> +	mult = frqcr_tab[val];
> +	return clk_register_fixed_factor(NULL, name, "pll", 0, mult, 3);
> +}
> +
> +static void __init rz_cpg_clocks_init(struct device_node *np)
> +{
> +	struct rz_cpg *cpg;
> +	struct clk **clks;
> +	unsigned i;

unsigned int maybe ? I'm not sure what the preferred kernel coding style is.

> +	int num_clks;
> +
> +	num_clks = of_property_count_strings(np, "clock-output-names");
> +	if (WARN(num_clks < 0, "can't count CPG clocks\n"))

Do such failures really deserve a WARN ? Isn't a pr_err() enough ?

What if num_clks == 0 ?

> +		goto out;
> +
> +	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
> +	if (WARN(!cpg, "out of memory!\n"))
> +		goto out;
> +
> +	clks = kzalloc(num_clks * sizeof(*clks), GFP_KERNEL);
> +	if (WARN(!clks, "out of memory!\n"))
> +		goto free_cpg;

Does kzalloc alloc warn internally when it fails to allocate memory ? If so 
you could remove the error message. You could also perform the two allocations 
and check the result once only.

> +	cpg->data.clks = clks;
> +	cpg->data.clk_num = num_clks;
> +
> +	cpg->reg = of_iomap(np, 0);
> +	if (WARN(!cpg->reg, "can't remap CPG registers!\n"))
> +		goto free_clks;
> +
> +	for (i = 0; i < num_clks; ++i) {
> +		const char *name;
> +		struct clk *clk;
> +
> +		of_property_read_string_index(np, "clock-output-names", i, &name);
> +
> +		clk = rz_cpg_register_clock(np, cpg, name);
> +		if (IS_ERR(clk))
> +			pr_err("%s: failed to register %s %s clock (%ld)\n",
> +			       __func__, np->name, name, PTR_ERR(clk));
> +		else
> +			cpg->data.clks[i] = clk;
> +	}
> +
> +	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
> +	return;
> +
> +free_clks:
> +	kfree(clks);
> +free_cpg:
> +	kfree(cpg);

I would remove that as done in the other CPG drivers, given that a small 
memory leak when the system will anyway fail to boot isn't really an issue.

> +out:
> +	return;
> +}
> +CLK_OF_DECLARE(rz_cpg_clks, "renesas,rz-cpg-clocks",
> +	       rz_cpg_clocks_init);

-- 
Regards,

Laurent Pinchart
