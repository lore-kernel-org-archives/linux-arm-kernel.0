From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 Apr 2013 16:31:43 -0700
Subject: [PATCH V4 1/6] clk: OMAP: introduce device tree binding to
 kernel clock data
In-Reply-To: <1365807278-554-2-git-send-email-nm@ti.com>
References: <1365807278-554-1-git-send-email-nm@ti.com>
 <1365807278-554-2-git-send-email-nm@ti.com>
Message-ID: <20130412233142.GE10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [130412 15:59]:
> --- /dev/null
> +++ b/drivers/clk/omap/clk.c
> +/**
> + * omap_clk_src_get() - Get OMAP clock from node name when needed
> + * @clkspec:	clkspec argument
> + * @data:	unused
> + *
> + * REVISIT: We assume the following:
> + * 1. omap clock names end with _ck
> + * 2. omap clock names are under 32 characters in length
> + */
> +static struct clk *omap_clk_src_get(struct of_phandle_args *clkspec, void *data)
> +{
> +	struct clk *clk;
> +	char clk_name[32];
> +	struct device_node *np = clkspec->np;
> +
> +	/* Set up things so consumer can call clk_get() with name */

I would leave out the comment above, it's a leftover from
the clk_add_alias() version that we don't need because of
of_clk_get().

> +	snprintf(clk_name, 32, "%s_ck", np->name);
> +	clk = clk_get(NULL, clk_name);
> +	if (IS_ERR(clk)) {
> +		pr_err("%s: could not get clock %s(%ld)\n", __func__,
> +		       clk_name, PTR_ERR(clk));
> +		goto out;
> +	}
> +	clk_put(clk);
> +
> +out:
> +	return clk;
> +}
> +
> +/**
> + * omap_clk_probe() - create link from DT definition to clock data
> + * @pdev:	device node
> + *
> + * NOTE: We assume that omap clocks are not removed.
> + */

How about drop the comment on clocks being removed above.
It no longer an issue, so maybe something like this instead:

* Note that we look up the clock lazily when the consumer
* driver does of_clk_get() and initialize a NULL clock here.

> +static int omap_clk_probe(struct platform_device *pdev)
> +{
> +	int res;
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	/* This allows the driver to of_clk_get() */
> +	res = of_clk_add_provider(np, omap_clk_src_get, NULL);
> +	if (res)
> +		dev_err(&pdev->dev, "could not add provider(%d)\n", res);
> +
> +	return res;
> +}
> +
> +/* We assume here that OMAP clocks will not be removed */

Then the above comment can be removed too.

Regards,

Tony
