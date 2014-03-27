From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 27 Mar 2014 10:55:44 +0100
Subject: [GIT PULL, RESEND] Reset controller fixes and updates
In-Reply-To: <201403270134.51520.arnd@arndb.de>
References: <1395219607.4300.14.camel@paszta.hi.pengutronix.de>
 <201403270134.51520.arnd@arndb.de>
Message-ID: <1395914144.3588.22.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 27.03.2014, 01:34 +0100 schrieb Arnd Bergmann:
> On Wednesday 19 March 2014, Philipp Zabel wrote:
> > The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> > 
> >   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.pengutronix.de/git/pza/linux.git reset/for_v3.15
> > 
> > for you to fetch changes up to b424080a9e086e683ad5fdc624a7cf3c024e0c0f:
> > 
> >   reset: Add optional resets and stubs (2014-03-09 19:53:45 +0100)
> > 
> 
> I've merged them into next/drivers now, sorry for the delay.

Thanks.

> Just one question that came in another thread, about the interface when
> the reset controllers are disabled: You return ERR_PTR(-ENOSYS)
> from reset_control_get_optional() here, and WARN_ON() any functions
> called later. Are you sure this is the best interface? We have other
> subsystems that just return a NULL pointer in this case so it doesn't
> trigger IS_ERR(), and then you can pass the NULL pointer into the
> other functions without causing an error message.

If the framework is enabled, but no reset control is set in the device
tree, reset_control_get_optional() returns -ENODEV. As the driver has to
check for errors anyway, returning -ENOSYS instead of NULL seemed to be
more explicit about what is going on. I see that the regulator framework
returns NULL in the stubs, though, so for the sake of consistency, we
could change reset.h to do the same:

	rstc = reset_control_get_optional(dev, NULL);
	if (PTR_ERR(rstc) == -ENODEV ||
	    PTR_ERR(rstc) == -ENOSYS) {
		soft_reset_instead();
		rstc = NULL;
	}
-->
	rstc = reset_control_get_optional(dev, NULL);
	if (PTR_ERR(rstc) == -ENODEV || rstc == NULL) {
		soft_reset_instead();
		rstc = NULL;
	}

should work well enough.

regards
Philipp
