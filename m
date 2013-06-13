From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 13 Jun 2013 19:08:42 +0200
Subject: [RFC/PATCH v2 2/2] gpio-rcar: Add DT support
In-Reply-To: <20130612114911.638683E0A56@localhost>
References: <1369136406-23800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1369136406-23800-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20130612114911.638683E0A56@localhost>
Message-ID: <2687390.IKNGX5KlWy@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

Thanks for the review.

On Wednesday 12 June 2013 12:49:11 Grant Likely wrote:
> On Tue, 21 May 2013 13:40:06 +0200, Laurent Pinchart wrote:
> > Add DT bindings for the gpio-rcar driver and read the device
> > configuration from the DT node at probe time if available.
> > 
> > Cc: devicetree-discuss at lists.ozlabs.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  .../devicetree/bindings/gpio/renesas,gpio-rcar.txt | 52 +++++++++++++++++
> >  drivers/gpio/gpio-rcar.c                           | 66 ++++++++++++++---
> >  2 files changed, 108 insertions(+), 10 deletions(-)
> >  create mode 100644
> >  Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt

[snip]

> > diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> > index 0f3d647..c153837 100644
> > --- a/drivers/gpio/gpio-rcar.c
> > +++ b/drivers/gpio/gpio-rcar.c

[snip]

> > +static void gpio_rcar_parse_pdata(struct gpio_rcar_priv *p)
> > +{
> > +	struct gpio_rcar_config *pdata = p->pdev->dev.platform_data;
> > +#ifdef CONFIG_OF
> > +	struct device_node *np = p->pdev->dev.of_node;
> > +	struct of_phandle_args args;
> > +	int ret;
> > +#endif
> > +
> > +	if (pdata)
> > +		p->config = *pdata;
> > +#ifdef CONFIG_OF
> > +	else if (np) {
> 
> Try this:
> 	else if ((IS_ENABLED(CONFIG_OF)) && np) {
> 
> It's much better than adding #ifdef blocks to .c files. In v3.11 a bunch
> of the OF forward declarations get pulled out from under the #ifdef
> block so that you can use the above construct.

As a pull request has already been sent to the ARM SoC maintainers, and given 
that this isn't a critical issue, I'll address it as a follow-up patch if 
that's fine with you.

> > +		ret = of_parse_phandle_with_args(np, "gpio-ranges",
> > +				"#gpio-range-cells", 0, &args);
> > +		p->config.number_of_pins = ret == 0 && args.args_count == 3
> > +					 ? args.args[2]
> > +					 : RCAR_MAX_GPIO_PER_BANK;
> > +		p->config.gpio_base = -1;
> > +	}
> > +#endif
> > +
> > +	if (p->config.number_of_pins == 0 ||
> > +	    p->config.number_of_pins > RCAR_MAX_GPIO_PER_BANK) {
> > +		dev_warn(&p->pdev->dev,
> > +			 "Invalid number of gpio lines %u, using %u\n",
> > +			 p->config.number_of_pins, RCAR_MAX_GPIO_PER_BANK);
> > +		p->config.number_of_pins = RCAR_MAX_GPIO_PER_BANK;
> > +	}
> > +}

-- 
Regards,

Laurent Pinchart
