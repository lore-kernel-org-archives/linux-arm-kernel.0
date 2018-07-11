From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 11 Jul 2018 21:41:47 +0200
Subject: [PATCH] ARM: at91: remove unnecessary
 of_platform_default_populate calls
In-Reply-To: <CAL_JsqKzv4=Vpej3kbjMBkFFOpJE_KQRgYr=Svftd_xs-Bj3-g@mail.gmail.com>
References: <20180619214020.18608-1-robh@kernel.org>
 <CAL_JsqLfnSOgOMdaJU3Q4h5_PGnNgd4rx+vKXdFVZnNEo6+JZA@mail.gmail.com>
 <20180711161443.GY16084@piout.net>
 <CAL_JsqKzv4=Vpej3kbjMBkFFOpJE_KQRgYr=Svftd_xs-Bj3-g@mail.gmail.com>
Message-ID: <20180711194147.GZ16084@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2018 12:13:17-0600, Rob Herring wrote:
> On Wed, Jul 11, 2018 at 10:15 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Hi,
> >
> > On 09/07/2018 09:50:47-0600, Rob Herring wrote:
> > > On Tue, Jun 19, 2018 at 3:40 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > The DT core will call of_platform_default_populate, so it is not
> > > > necessary for machine specific code to call it unless there are custom
> > > > match entries, auxdata or parent device. Neither of those apply here, so
> > > > remove the call.
> > > >
> > > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > Cc: linux-arm-kernel at lists.infradead.org
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  arch/arm/mach-at91/at91rm9200.c | 5 -----
> > > >  arch/arm/mach-at91/at91sam9.c   | 5 -----
> > > >  arch/arm/mach-at91/sama5.c      | 5 -----
> > > >  3 files changed, 15 deletions(-)
> > >
> > > Ping?
> > >
> >
> > This breaks the platform in two different ways:
> >  - PM is not working anymore because of the missing SRAM node
> >  - the pinctrl driver fails to probe and so many drivers are
> >    deferring the probe forever
> >
> > Relevant messages (once the earlycon crap is removed to let earlyprintk
> > do its job):
> >
> > at91_pm_sram_init: failed to find sram device!
> > AT91: PM not supported, due to no SRAM allocated
> 
> So the at91_pm_sram_init function tries to get SRAM platform device,
> but it doesn't exist yet. Of course, that is fragile because while the
> device may exist, it's just luck that it's driver has probed already.
> Would using .init_late hook instead of .init_machine work for you?
> 
> Ideally, couldn't much of this code be converted to a driver? It's a
> bit strange for initcall code to have a driver dependency.
> 

.init_late seems to work after testing quickly

You probably didn't see it because they still have a soc_device parent
but Arnd wanted us to remove it so it is gone.

> >
> > pinctrl-at91 ahb:apb:pinctrl at fc06a000: you need to specify at least one gpio-controller
> > pinctrl-at91: probe of ahb:apb:pinctrl at fc06a000 failed with error -22
> 
> So this one has the strange dependency that the child nodes probe
> before the parent node. That's backwards. Probe order is probably
> changing from link order (all the devices are created before drivers
> register) to device creation order. I think the fix is the pinctrl
> driver should just count the gpio child nodes rather than relying on
> aliases (which I'm not a fan of either). I can write a patch to do
> that.

I'll let you do that.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
