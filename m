From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 05 Nov 2015 13:40:26 +0300
Subject: [PATCH v5 3/4] drivers: exynos-srom: Add support for bank
 configuration
In-Reply-To: <5639BFD8.6040006@samsung.com>
References: <cover.1446542020.git.p.fedin@samsung.com>
 <72fa025c634fa477b1d7a89c254bd3c9c43f2b27.1446542020.git.p.fedin@samsung.com>
 <5639BFD8.6040006@samsung.com>
Message-ID: <004001d117b6$62baa1a0$282fe4e0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> > +static int decode_sromc(struct exynos_srom *srom, struct device_node *np)
> 
> I missed that one previously: add prefix and more descriptive name, like:
> exynos_srom_parse_child()

 exynos_srom_configure_bank(), is this name OK?

> >  static int exynos_srom_probe(struct platform_device *pdev)
> >  {
> > -	struct device_node *np;
> > +	struct device_node *np, *child;
> >  	struct exynos_srom *srom;
> >  	struct device *dev = &pdev->dev;
> > +	bool error = false;
> 
> The 'error' name is misleading - like error for entire probe which is
> not true.
> 
> Instead split it to separate function like:
> 
> +static int exynos_srom_parse_children(....) {
> +       int ret = 0;
> +
> +	for_each_child_of_node(np, child) {
> +               ret = exynos_srom_parse_child(srom, child);
> +		if (ret) {
> +			dev_err(dev,
> +				"Could not decode bank configuration for %s: %d\n",
> +				child->name, ret);
> +			break;
> +		}
> +	}
> +
> +       return ret;
> +}

 Factoring out this loop is unnecessary, because i could just 'return 0' in the loop
instead of 'error = true'. Byt my idea is to go through all banks anyway, just in
case, to diagnose all of them. So that the user will be able to spot and fix all
broken banks at once, instead of doing one-by-one.
 I have renamed the variable to 'bool bad_bank_config', will this be OK?

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
