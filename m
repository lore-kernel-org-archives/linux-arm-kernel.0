From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Jul 2013 12:10:58 +0800
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <51E4BF98.8030604@wwwdotorg.org>
References: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
 <20130716015038.GD28375@S2101-09.ap.freescale.net>
 <51E4BF98.8030604@wwwdotorg.org>
Message-ID: <20130716041056.GA30067@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 09:35:52PM -0600, Stephen Warren wrote:
> > It's a little bit late to register gpio-reset driver at module_init
> > time, because gpio-reset provides reset control via gpio for other
> > devices which are mostly probed at module_init time too.  And it
> > becomes even worse, when the gpio comes from IO expander on I2C bus,
> > e.g. pca953x.  In that case, gpio-reset needs to be ready before I2C
> > bus driver which is generally ready at subsys_initcall time.  Let's
> > register gpio-reset driver in arch_initcall() to have it ready early
> > enough.
> 
> There's no need for the reset driver to be registered before its users;
> the users of the reset GPIO will simply have their probe deferred until
> the reset controller is available, and then everything will work out
> just fine.
> 
> > The defer probe mechanism is not used here, because a reset controller
> > driver should be reasonably registered early than other devices.  More
> > importantly, defer probe doe not help in some nasty cases, e.g. the
> > gpio-pca953x device itself needs a reset from gpio-reset driver to start
> > working.
> 
> That should work fine with deferred probe.

I should probably rework the commit log.  But I do not see a problem
to register gpio-reset driver a little bit earlier.  On the other hand,
if we reply on deferred probe, many drivers probe could be deferred.
For example, on my system, the gpio-pca953x on I2C bus works as a GPIO
controller and provides resets to many board level components.
Deferring probe of gpio-pca953x on I2C bus means every single probe of
all these components gets deferred.  IMO, this situation should be
reasonably avoided.

Shawn
