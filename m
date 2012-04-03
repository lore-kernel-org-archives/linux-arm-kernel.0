From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 03 Apr 2012 09:37:58 -0600
Subject: GPIO range check in drivers/of/gpio.c
In-Reply-To: <4F7AB590.2090505@antcom.de>
References: <4F7AB590.2090505@antcom.de>
Message-ID: <20120403153759.037CA3E046E@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 03 Apr 2012 10:32:16 +0200, Roland Stigge <stigge@antcom.de> wrote:
> Hi,
> 
> I'm wondering about a range check in drivers/of/gpio.c:144:
> 
> > int of_gpio_simple_xlate(struct gpio_chip *gc,
> >			 const struct of_phandle_args *gpiospec, u32 *flags)
> > {
> >	/*
> >	 * We're discouraging gpio_cells < 2, since that way you'll have to
> >	 * write your own xlate function (that will have to retrive the GPIO
> >	 * number and the flags from a single gpio cell -- this is possible,
> >	 * but not recommended).
> >	 */
> >	if (gc->of_gpio_n_cells < 2) {
> >		WARN_ON(1);
> >		return -EINVAL;
> >	}
> >
> >	if (WARN_ON(gpiospec->args_count < gc->of_gpio_n_cells))
> >		return -EINVAL;
> >
> >	if (gpiospec->args[0] > gc->ngpio)
> >		return -EINVAL;
> 
> Shouldn't this be rather:
> 
> 	if (gpiospec->args[0] >= gc->ngpio)

Yes, I think you're right.  Can you craft, test and post a patch?

Thanks,
g.
