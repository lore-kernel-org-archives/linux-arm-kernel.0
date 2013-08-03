From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 03 Aug 2013 16:02:36 +0200
Subject: [PATCHv5 01/31] CLK: clkdev: add support for looking up clocks
 from DT
In-Reply-To: <1375460751-23676-2-git-send-email-t-kristo@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
 <1375460751-23676-2-git-send-email-t-kristo@ti.com>
Message-ID: <2002722.lT3pR1Ni8o@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

On Friday 02 of August 2013 19:25:20 Tero Kristo wrote:
> clk_get_sys / clk_get can now find clocks from device-tree. If a DT
> clock is found, an entry is added to the clk_lookup list also for
> subsequent searches.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> ---
>  drivers/clk/clkdev.c |   33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 442a313..cbeb252 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -93,6 +93,18 @@ struct clk *of_clk_get_by_name(struct device_node
> *np, const char *name) EXPORT_SYMBOL(of_clk_get_by_name);
>  #endif
> 
> +/**
> + * clkdev_add_nolock - add lookup entry for a clock
> + * @cl: pointer to new clock lookup entry
> + *
> + * Non-locking version, used internally by clk_find() to add DT based
> + * clock lookup entries.
> + */
> +static void clkdev_add_nolock(struct clk_lookup *cl)
> +{
> +	list_add_tail(&cl->node, &clocks);
> +}
> +
>  /*
>   * Find the correct struct clk for the device and connection ID.
>   * We do slightly fuzzy matching here:
> @@ -106,6 +118,9 @@ static struct clk_lookup *clk_find(const char
> *dev_id, const char *con_id) {
>  	struct clk_lookup *p, *cl = NULL;
>  	int match, best_found = 0, best_possible = 0;
> +	struct device_node *node;
> +	struct clk *clk;
> +	struct of_phandle_args clkspec;
> 
>  	if (dev_id)
>  		best_possible += 2;
> @@ -133,6 +148,24 @@ static struct clk_lookup *clk_find(const char
> *dev_id, const char *con_id) break;
>  		}
>  	}
> +
> +	if (cl)
> +		return cl;
> +
> +	/* If clock was not found, attempt to look-up from DT */
> +	node = of_find_node_by_name(NULL, con_id);

Why are we introducing the "lookup by name" brokenness to the yet (mostly) 
sane DT world?

We already have a good way of binding things together in DT, which is 
using phandles.

Not even saying that this (or something this patch relies on) breaks the 
ePAPR recommendation about node naming, which states that node names 
should not be used to convey platform-specific data, but instead should be 
as generic as possible to show what kind of hardware is represented by the 
node.

Best regards,
Tomasz

P.S. Added missing DT maintainers to CC.

> +	clkspec.np = node;
> +
> +	clk = of_clk_get_from_provider(&clkspec);
> +
> +	if (!IS_ERR(clk)) {
> +		/* We found a clock, add node to clkdev */
> +		cl = clkdev_alloc(clk, con_id, dev_id);
> +		if (cl)
> +			clkdev_add_nolock(cl);
> +	}
> +
>  	return cl;
>  }
