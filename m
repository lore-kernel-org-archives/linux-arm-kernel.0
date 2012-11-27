From: horms@verge.net.au (Simon Horman)
Date: Tue, 27 Nov 2012 12:36:37 +0900
Subject: [PATCH 4/7] ARM: shmobile: pfc-sh73a0: Register device tree
In-Reply-To: <7701261.79JI41uS12@avalon>
References: <1353889014-17142-1-git-send-email-horms@verge.net.au>
 <1353889014-17142-5-git-send-email-horms@verge.net.au>
 <7701261.79JI41uS12@avalon>
Message-ID: <20121127033635.GJ13206@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 03:06:37PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Monday 26 November 2012 09:16:51 Simon Horman wrote:
> > Register the pfc with sh73a0_init_gpio_dt() to allow
> > gpios provided by pfc to be accessed by devices which
> > are registered using device tree.
> > 
> > The motivation of this is to allow the gpio used for carrier detect
> > but the Micro SD SDHI port of the KZM-9A-GT board to be accessed
> > using device tree. Thus, allowing the SDHI device of the KZM-9A-GT
> > board to be registered using device tree.
> > 
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> >  arch/arm/mach-shmobile/pfc-sh73a0.c |   45 ++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> > 
> > diff --git a/arch/arm/mach-shmobile/pfc-sh73a0.c
> > b/arch/arm/mach-shmobile/pfc-sh73a0.c index b442f9d..d1a04c0b 100644
> > --- a/arch/arm/mach-shmobile/pfc-sh73a0.c
> > +++ b/arch/arm/mach-shmobile/pfc-sh73a0.c
> > @@ -2797,7 +2797,52 @@ static struct pinmux_info sh73a0_pinmux_info = {
> >  	.gpio_irq_size = ARRAY_SIZE(pinmux_irqs),
> >  };
> > 
> > +#ifdef CONFIG_OF_GPIO
> > +static int sh73a0_gpio_xlate(struct gpio_chip *gc,
> > +			     const struct of_phandle_args *gpiospec,
> > +			     u32 *flags)
> > +{
> > +	if (WARN_ON(gc->of_gpio_n_cells < 2))
> > +		return -EINVAL;
> > +
> > +	if (WARN_ON(gpiospec->args_count < gc->of_gpio_n_cells))
> > +		return -EINVAL;
> > +
> > +	if (gpiospec->args[0] > gc->ngpio)
> > +		return -EINVAL;
> > +
> > +	if (flags)
> > +		*flags = gpiospec->args[1];
> > +
> > +	return gpiospec->args[0];
> > +}
> 
> Is there any reason not to use of_gpio_simple_xlate here ? If there isn't, 
> of_xlate and of_gpio_n_cells default to of_gpio_simple_xlate and 2 
> respectively when of_xlate isn't specified, so you could omit both.

No reason other than that I wasn't aware of of_gpio_simple_xlate.
