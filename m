From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Mar 2014 12:19:42 +0100
Subject: [GIT PULL, RESEND] Reset controller fixes and updates
In-Reply-To: <1395914144.3588.22.camel@paszta.hi.pengutronix.de>
References: <1395219607.4300.14.camel@paszta.hi.pengutronix.de>
 <201403270134.51520.arnd@arndb.de>
 <1395914144.3588.22.camel@paszta.hi.pengutronix.de>
Message-ID: <5842119.SvnOUx24Xy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 March 2014 10:55:44 Philipp Zabel wrote:
> Am Donnerstag, den 27.03.2014, 01:34 +0100 schrieb Arnd Bergmann:
> > On Wednesday 19 March 2014, Philipp Zabel wrote:

> 
> > Just one question that came in another thread, about the interface when
> > the reset controllers are disabled: You return ERR_PTR(-ENOSYS)
> > from reset_control_get_optional() here, and WARN_ON() any functions
> > called later. Are you sure this is the best interface? We have other
> > subsystems that just return a NULL pointer in this case so it doesn't
> > trigger IS_ERR(), and then you can pass the NULL pointer into the
> > other functions without causing an error message.
> 
> If the framework is enabled, but no reset control is set in the device
> tree, reset_control_get_optional() returns -ENODEV. As the driver has to
> check for errors anyway, returning -ENOSYS instead of NULL seemed to be
> more explicit about what is going on. I see that the regulator framework
> returns NULL in the stubs, though, so for the sake of consistency, we
> could change reset.h to do the same:
> 
> 	rstc = reset_control_get_optional(dev, NULL);
> 	if (PTR_ERR(rstc) == -ENODEV ||
> 	    PTR_ERR(rstc) == -ENOSYS) {
> 		soft_reset_instead();
> 		rstc = NULL;
> 	}
> -->
> 	rstc = reset_control_get_optional(dev, NULL);
> 	if (PTR_ERR(rstc) == -ENODEV || rstc == NULL) {
> 		soft_reset_instead();
> 		rstc = NULL;
> 	}
> 
> should work well enough.

Actually, I would argue that when you do this, the normal implementation
of reset_control_get_optional() should also return NULL in case there
is no reset controller. That's at least how I would read the 'optional'
part of the function name.

It would let the users simply do

 	rstc = reset_control_get_optional(dev, NULL);
	if (IS_ERR(rstc)
		return PTR_ERR(rstc); /* something went wrong, e.g. -EPROBE_DEFER */
 	if (!rstc)
 		soft_reset_instead();

We should under no circumstances have an interface that forces
driver writers to use IS_ERR_OR_NULL(), because everybody always
gets that wrong.

	Arnd
