From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 1 Oct 2015 15:42:38 -0700
Subject: [PATCH 3/5] clk: berlin: add clk support for berlin4ct
In-Reply-To: <1442931156-5877-4-git-send-email-jszhang@marvell.com>
References: <1442931156-5877-1-git-send-email-jszhang@marvell.com>
 <1442931156-5877-4-git-send-email-jszhang@marvell.com>
Message-ID: <20151001224238.GS19319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22, Jisheng Zhang wrote:
> + */
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +
> +#include "clk.h"
> +
> +#define CLK_SOURCE_MAX	5
> +
> +static struct clk_onecell_data gateclk_data;
> +static struct clk_onecell_data clk_data;
> +
> +static DEFINE_SPINLOCK(lock);

This is really generic. How about berlin4ct_lock? That will make
lockdep happy because the name for the key will have some
meaning.

> +static void __init berlin4ct_gateclk_setup(struct device_node *np)
> +{
> +	int i, n, ret;
> +	void __iomem *base;
> +	struct clk **clks;
> +
> +	base = of_iomap(np, 0);
> +	if (WARN_ON(!base))
> +		return;
> +
> +	n = ARRAY_SIZE(berlin4ct_gates);
> +	clks = kzalloc(n * sizeof(struct clk *), GFP_KERNEL);

kcalloc()

> +	if (WARN_ON(!clks))

Same comment about dropping WARN_ON for an allocation failure.

> +		return;
> +
> +	for (i = 0; i < n; i++) {
> +		clks[i] = clk_register_gate(NULL, berlin4ct_gates[i].name,
> +				berlin4ct_gates[i].parent_name,
> +				berlin4ct_gates[i].flags, base,
> +				berlin4ct_gates[i].bit_idx, 0, &lock);
> +		WARN_ON(IS_ERR(clks[i]));
> +	}
> +
> +	gateclk_data.clks = clks;
> +	gateclk_data.clk_num = i;
> +
> +	ret = of_clk_add_provider(np, of_clk_src_onecell_get,
> +				  &gateclk_data);
> +	if (WARN_ON(ret))
> +		return;

Drop that return please.

> +
> +}
> +CLK_OF_DECLARE(berlin4ct_gateclk, "marvell,berlin4ct-gateclk",
> +	       berlin4ct_gateclk_setup);
> +
> +static void __init berlin4ct_clk_setup(struct device_node *np)
> +{
> +	int i, n, ret, num_parents;
> +	void __iomem *base;
> +	struct clk **clks;
> +	const char *parent_names[CLK_SOURCE_MAX];
> +
> +	num_parents = of_clk_get_parent_count(np);
> +	if (num_parents <= 0 || num_parents > CLK_SOURCE_MAX)
> +		return;
> +
> +	of_clk_parent_fill(np, parent_names, num_parents);
> +
> +	base = of_iomap(np, 0);
> +	if (WARN_ON(!base))
> +		return;
> +
> +	n = ARRAY_SIZE(berlin4ct_descs);
> +	clks = kzalloc(n * sizeof(struct clk *), GFP_KERNEL);

kcalloc()

> +	if (WARN_ON(!clks))

Same comment about dropping WARN_ON for an allocation failure.

> +		return;
> +
> +	for (i = 0; i < n; i++) {
> +		clks[i] = berlin_clk_register(berlin4ct_descs[i].name,
> +				num_parents, parent_names,
> +				berlin4ct_descs[i].flags,
> +				base + berlin4ct_descs[i].offset);
> +		WARN_ON(IS_ERR(clks[i]));
> +	}
> +
> +	clk_data.clks = clks;
> +	clk_data.clk_num = i;
> +
> +	ret = of_clk_add_provider(np, of_clk_src_onecell_get,
> +				  &clk_data);
> +	if (WARN_ON(ret))
> +		return;

Drop that return please.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
