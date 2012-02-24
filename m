From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 24 Feb 2012 07:47:49 +0100
Subject: [PATCH v3 03/10] of: Add PWM support.
In-Reply-To: <201202231403.01614.arnd@arndb.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <201202221615.11605.arnd@arndb.de>
 <20120223075537.GB8621@avionic-0098.mockup.avionic-design.de>
 <201202231403.01614.arnd@arndb.de>
Message-ID: <20120224064749.GB18786@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann wrote:
> On Thursday 23 February 2012, Thierry Reding wrote:
> > * Arnd Bergmann wrote:
> > > On Wednesday 22 February 2012, Thierry Reding wrote:
> > > > This patch adds helpers to support device tree bindings for the generic
> > > > PWM API. Device tree binding documentation for PWM controllers is also
> > > > provided.
> > > > 
> > > > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > > > 
> > > >  Documentation/devicetree/bindings/pwm/pwm.txt |   48 +++++++++
> > > >  drivers/of/Kconfig                            |    6 +
> > > >  drivers/of/Makefile                           |    1 +
> > > >  drivers/of/pwm.c                              |  130 +++++++++++++++++++++++++
> > > >  include/linux/of_pwm.h                        |   51 ++++++++++
> > > >  include/linux/pwm.h                           |   17 +++
> > > 
> > > I think it would make more sense to stick the device tree specific parts
> > > into drivers/pwm/of.c instead of drivers/of/pwm.c, but it's not a strong
> > > preference on my part.
> > 
> > I was just following what everybody else seemed to be doing. drivers/of/
> > already has support code for GPIO, IRQ, I2C, PCI and whatnot.
> 
> Yes, as I said, it's not entirely clear what's best here, and it would
> be nice if other people could weigh in when they have a strong opinion
> one way or another.

Okay, I'll wait some more for others to join in.

[...]
> > > * Why not include the pwm_request() call in this and return the
> > >   pwm_device directly? You said that you want to get rid of the
> > >   pwm_id eventually, which is a good idea, but this interface still
> > >   forces one to use it.
> > 
> > Okay, that sounds sensible. I propose to rename the function to something like
> > of_request_pwm().
> 
> Sounds good.
> 
> > It would of course need an additional parameter (name) to
> > forward to pwm_request().
> 
> Not necessarily, it could use the dev_name(device) or the name
> of the property, or a combination of the two.

The problem with that is that usually the device would be named something
generic like "pwm", while in case where the PWM is used for the backlight
it makes sense to label the PWM device "backlight".

Looking at debugfs and seeing an entry "backlight" is much more straight-
forward than "pwm.0". I mean "pwm.0" doesn't carry any useful information
really, does it?

> > > * It is not clear what a pwm_spec is used for, or why a device
> > >   driver would need to be bothered by this. Maybe it just needs
> > >   more explanation, but it seems to me that if you do the previous
> > >   change, the pwm_spec would not be needed either.
> > 
> > pwm_spec is pretty much what the of_xlate() callback parses out of the data
> > provided by the device tree. Currently, of_pwm_simple_xlate() only parses the
> > period (in ns) but the idea was that if at some point in the future it was
> > decided to provide more than the period via the device tree it could be
> > extended without changing every call to of_get_named_pwm(). As I said, it also
> > plays quite nicely with the concept of the of_xlate() callback and sort of
> > serves as interface between the lower layer that retrieves PWM parameters and
> > the upper layers that use it.
> > 
> > Thinking about it, perhaps renaming it to pwm_params may be more descriptive.
> > Also to avoid breakage or confusion if fields get added it may be good to
> > provide a bitmask of valid fields filled in by the of_xlate() callback.
> > 
> > 	enum {
> > 		PWM_PARAMS_PERIOD,
> > 		...
> > 	};
> > 
> > 	struct pwm_params {
> > 		unsigned long fields;
> > 		unsigned int period;
> > 	};
> > 
> > Then again, maybe that's just over-engineering and directly returning via an
> > unsigned int *period_ns parameter would be better?
> 
> It certainly sounds like over-engineering to me. Why not keep all that
> information hidden inside the struct pwm_device and provide accessor
> functions like this?
> 
> unsigned int pwm_get_period(struct pwm_device *pwm);

Heh, I like that. It is the obvious thing to do. Why didn't I think of it?
:-)

> > > > +EXPORT_SYMBOL(of_get_named_pwm);
> > > 
> > > EXPORT_SYMBOL_GPL?
> > 
> > It was brought up at some point that it might be nice to allow non-GPL
> > drivers to use the PWM framework as well. I don't remember any discussion
> > resulting from the comment. Perhaps we should have that discussion now and
> > decide whether or not we want to keep it GPL-only or not.
> 
> I would definitely use EXPORT_SYMBOL_GPL for all new code unless it
> replaces an earlier interface that was available as EXPORT_SYMBOL.

I just grepped the code and noticed this:

	$ $ git grep -n 'EXPORT_SYMBOL.*(pwm_request)'
	arch/arm/mach-vt8500/pwm.c:139:EXPORT_SYMBOL(pwm_request);
	arch/arm/plat-mxc/pwm.c:183:EXPORT_SYMBOL(pwm_request);
	arch/arm/plat-samsung/pwm.c:83:EXPORT_SYMBOL(pwm_request);
	arch/unicore32/kernel/pwm.c:132:EXPORT_SYMBOL(pwm_request);
	drivers/mfd/twl6030-pwm.c:156:EXPORT_SYMBOL(pwm_request);
	drivers/misc/ab8500-pwm.c:108:EXPORT_SYMBOL(pwm_request);
	drivers/pwm/core.c:262:EXPORT_SYMBOL_GPL(pwm_request);

It seems like the legacy PWM API used to be non-GPL. Should I switch it back?
Also does it make sense to have something like of_request_pwm() GPL when the
rest of the API isn't?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120224/69fe359d/attachment.sig>
