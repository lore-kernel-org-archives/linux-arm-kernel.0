From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 23 Feb 2012 08:55:37 +0100
Subject: [PATCH v3 03/10] of: Add PWM support.
In-Reply-To: <201202221615.11605.arnd@arndb.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-4-git-send-email-thierry.reding@avionic-design.de>
 <201202221615.11605.arnd@arndb.de>
Message-ID: <20120223075537.GB8621@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann wrote:
> On Wednesday 22 February 2012, Thierry Reding wrote:
> > This patch adds helpers to support device tree bindings for the generic
> > PWM API. Device tree binding documentation for PWM controllers is also
> > provided.
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > 
> >  Documentation/devicetree/bindings/pwm/pwm.txt |   48 +++++++++
> >  drivers/of/Kconfig                            |    6 +
> >  drivers/of/Makefile                           |    1 +
> >  drivers/of/pwm.c                              |  130 +++++++++++++++++++++++++
> >  include/linux/of_pwm.h                        |   51 ++++++++++
> >  include/linux/pwm.h                           |   17 +++
> 
> I think it would make more sense to stick the device tree specific parts
> into drivers/pwm/of.c instead of drivers/of/pwm.c, but it's not a strong
> preference on my part.

I was just following what everybody else seemed to be doing. drivers/of/
already has support code for GPIO, IRQ, I2C, PCI and whatnot.

[...]
> > +/**
> > + * of_node_to_pwmchip() - finds the PWM chip associated with a device node
> > + * @np: device node of the PWM chip
> > + *
> > + * Returns a pointer to the PWM chip associated with the specified device
> > + * node or NULL if the device node doesn't represent a PWM chip.
> > + */
> > +struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
> > +{
> > +	return pwmchip_find(np, of_pwmchip_is_match);
> > +}
> > +
> > +int of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args,
> > +			struct pwm_spec *spec)
> > +{
> > +	if (pc->of_pwm_n_cells < 2)
> > +		return -EINVAL;
> > +
> > +	if (args->args_count < pc->of_pwm_n_cells)
> > +		return -EINVAL;
> > +
> > +	if (args->args[0] >= pc->npwm)
> > +		return -EINVAL;
> > +
> > +	if (spec)
> > +		spec->period = args->args[1];
> > +
> > +	return args->args[0];
> > +}
> 
> I'm not sure why these functions are global. They are clearly marked
> so in your header file, but it seems that these are an implementation
> detail that neither a pwm controller driver not a driver using one
> would need to use directly.

Yes, I think both can be made static. of_pwm_simple_xlate() is supposed to be
the fallback when a chip doesn't explicitly specify one so it really isn't
necessary to export it (for that to be useful it is missing an EXPORT_SYMBOL
anyway).

> > +/**
> > + * of_get_named_pwm() - get a PWM number and period to use with the PWM API
> > + * @np: device node to get the PWM from
> > + * @propname: property name containing PWM specifier(s)
> > + * @index: index of the PWM
> > + * @spec: a pointer to a struct pwm_spec to fill in
> > + *
> > + * Returns PWM number to use with the Linux generic PWM API or a negative
> > + * error code on failure. If @spec is not NULL the function fills in the
> > + * values parsed from the device tree.
> > + */
> > +int of_get_named_pwm(struct device_node *np, const char *propname,
> > +		     int index, struct pwm_spec *spec)
> > +{
> 
> This interface does not feel right to me, in multiple ways:
> 
> * I would expect to pass a struct device in, not a device_node.

I was following the GPIO DT support code here. The corresponding
of_get_named_gpio_flags() takes a struct device_node. I guess that makes it
more generic since you can potentially have a struct device_node without a
corresponding struct device, right?

> * Why not include the pwm_request() call in this and return the
>   pwm_device directly? You said that you want to get rid of the
>   pwm_id eventually, which is a good idea, but this interface still
>   forces one to use it.

Okay, that sounds sensible. I propose to rename the function to something like
of_request_pwm(). It would of course need an additional parameter (name) to
forward to pwm_request().

> * It is not clear what a pwm_spec is used for, or why a device
>   driver would need to be bothered by this. Maybe it just needs
>   more explanation, but it seems to me that if you do the previous
>   change, the pwm_spec would not be needed either.

pwm_spec is pretty much what the of_xlate() callback parses out of the data
provided by the device tree. Currently, of_pwm_simple_xlate() only parses the
period (in ns) but the idea was that if at some point in the future it was
decided to provide more than the period via the device tree it could be
extended without changing every call to of_get_named_pwm(). As I said, it also
plays quite nicely with the concept of the of_xlate() callback and sort of
serves as interface between the lower layer that retrieves PWM parameters and
the upper layers that use it.

Thinking about it, perhaps renaming it to pwm_params may be more descriptive.
Also to avoid breakage or confusion if fields get added it may be good to
provide a bitmask of valid fields filled in by the of_xlate() callback.

	enum {
		PWM_PARAMS_PERIOD,
		...
	};

	struct pwm_params {
		unsigned long fields;
		unsigned int period;
	};

Then again, maybe that's just over-engineering and directly returning via an
unsigned int *period_ns parameter would be better?

> > +EXPORT_SYMBOL(of_get_named_pwm);
> 
> EXPORT_SYMBOL_GPL?

It was brought up at some point that it might be nice to allow non-GPL
drivers to use the PWM framework as well. I don't remember any discussion
resulting from the comment. Perhaps we should have that discussion now and
decide whether or not we want to keep it GPL-only or not.

> > +static inline int of_get_named_pwm(struct device_node *np,
> > +                                  const char *propname, int index,
> > +                                  unsigned int *period_ns)
> > +{
> 
> The function prototype does not match.

Yes, I must have forgotten to convert that when I changed that to struct
pwm_spec described above. Quite frankly I'm not sure about what is the best
alternative. Can anybody come up with more advantages or disadvantages for
both variations? Or perhaps there is even a better solution.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120223/53285309/attachment.sig>
