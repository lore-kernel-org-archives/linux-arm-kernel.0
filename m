From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 16 Jul 2013 11:59:18 +0200
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <51E4BF98.8030604@wwwdotorg.org>
References: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
 <20130716015038.GD28375@S2101-09.ap.freescale.net>
 <51E4BF98.8030604@wwwdotorg.org>
Message-ID: <1373968758.4327.17.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Am Montag, den 15.07.2013, 21:35 -0600 schrieb Stephen Warren:
> On 07/15/2013 07:50 PM, Shawn Guo wrote:
> > Hi Philipp,
> > 
> > On Thu, May 30, 2013 at 11:09:00AM +0200, Philipp Zabel wrote:
> >> This driver implements a reset controller device that toggle a gpio
> >> connected to a reset pin of a peripheral IC. The delay between assertion
> >> and de-assertion of the reset signal can be configured via device tree.
> >>
> >> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> >> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> > 
> > I see this patch is very useful, as GPIOs are widely used to reset
> > components/devices on board.  But I do not find the patch in v3.11-rc1.
> > What's your plan about it?
> > 
> > Also, I'm wondering if we should register the driver a little bit
> > early.  Please see the following patch.  If it makes sense to you,
> > I can send the patch to you, or you can just quash it into yours.
> > 
> > Shawn
> > 
> > ---8<--------
> > 
> > From 2f8ce9e5d6525b98f3828b707458e83fabb39d50 Mon Sep 17 00:00:00 2001
> > From: Shawn Guo <shawn.guo@linaro.org>
> > Date: Sun, 14 Jul 2013 20:41:00 +0800
> > Subject: [PATCH] ENGR00269945: reset: register gpio-reset driver in
> >  arch_initcall
> > 
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

Deferred probing is fine, but it'd be nice to keep the probe deferral
loops to a minimum where possible and/or reasonable.

regards
Philipp
