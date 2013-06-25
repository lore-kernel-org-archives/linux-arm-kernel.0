From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 25 Jun 2013 21:14:52 +0300
Subject: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
In-Reply-To: <CAAwP0s1LTj1gu8o2mQd3arzH9-9Wfn2G+wsQ=4DpnMRXb7LADw@mail.gmail.com>
References: <20130516214430.GN5600@atomide.com>
 <20130520174621.GI10378@atomide.com>
 <20130605223355.EDC113E10E4@localhost>
 <20130606155341.GL3331@atomide.com>
 <20130623221605.GA3150@blackmetal.musicnaut.iki.fi>
 <CAAwP0s1DkMu8Vfka43hS4Wj-927q=O5u-coyFsPBgy3qtA_vjw@mail.gmail.com>
 <20130623234326.GA20703@blackmetal.musicnaut.iki.fi>
 <CAAwP0s00RwP7jCMF1O8j8Ndhu=VfD2dMA5fzr6jWvQ7PziXBCw@mail.gmail.com>
 <20130624072112.GQ5523@atomide.com>
 <CAAwP0s1LTj1gu8o2mQd3arzH9-9Wfn2G+wsQ=4DpnMRXb7LADw@mail.gmail.com>
Message-ID: <20130625181452.GE20703@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 05:35:18PM +0200, Javier Martinez Canillas wrote:
> Ok, so something like the following patch should do it (tested on an
> OMAP3 board):
> 
> From b9e262c688fb7f3ad733f140b55dddbc8e4716e6 Mon Sep 17 00:00:00 2001
> From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Date: Mon, 24 Jun 2013 17:13:23 +0200
> Subject: [PATCH 1/1] gpio/omap: don't use linear domain mapping for OMAP1
> 
> commit ede4d7a5 ("gpio/omap: convert gpio irq domain to linear mapping")
> converted the OMAP GPIO driver to use a linear mapping for the GPIO IRQ
> domain instead of using a legacy mapping. Not using a legacy mapping has
> a number of benefits but it requires the platform to support SPARSE_IRQ
> which currently is not supported on OMAP1.
> 
> So this change caused a regression on OMAP1 platforms [1].
> 
> Since this issue is not present on all OMAP2+ platforms, there is no need to
> revert the driver to use legacy domain mapping for all the platforms.
> 
> [1]: http://www.mail-archive.com/linux-omap at vger.kernel.org/msg89005.html
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

I tested this on OMAP1 / 770, and it's fine.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks,

A.

> ---
>  drivers/gpio/gpio-omap.c |   22 +++++++++++++++++++++-
>  1 files changed, 21 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index d3f7d2d..4a43036 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1094,6 +1094,9 @@ static int omap_gpio_probe(struct platform_device *pdev)
>  	const struct omap_gpio_platform_data *pdata;
>  	struct resource *res;
>  	struct gpio_bank *bank;
> +#ifdef CONFIG_ARCH_OMAP1
> +	int irq_base;
> +#endif
> 
>  	match = of_match_device(of_match_ptr(omap_gpio_match), dev);
> 
> @@ -1135,11 +1138,28 @@ static int omap_gpio_probe(struct platform_device *pdev)
>  				pdata->get_context_loss_count;
>  	}
> 
> +#ifdef CONFIG_ARCH_OMAP1
> +	/*
> +	 * REVISIT: Once we have OMAP1 supporting SPARSE_IRQ, we can drop
> +	 * irq_alloc_descs() and irq_domain_add_legacy() and just use a
> +	 * linear IRQ domain mapping for all OMAP platforms.
> +	 */
> +	irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
> +	if (irq_base < 0) {
> +		dev_err(dev, "Couldn't allocate IRQ numbers\n");
> +		return -ENODEV;
> +	}
> 
> +	bank->domain = irq_domain_add_legacy(node, bank->width, irq_base,
> +					     0, &irq_domain_simple_ops, NULL);
> +#else
>  	bank->domain = irq_domain_add_linear(node, bank->width,
>  					     &irq_domain_simple_ops, NULL);
> -	if (!bank->domain)
> +#endif
> +	if (!bank->domain) {
> +		dev_err(dev, "Couldn't register an IRQ domain\n");
>  		return -ENODEV;
> +	}
> 
>  	if (bank->regs->set_dataout && bank->regs->clr_dataout)
>  		bank->set_dataout = _set_gpio_dataout_reg;
> -- 
> 1.7.7.6
