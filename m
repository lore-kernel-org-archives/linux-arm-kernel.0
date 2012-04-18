From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Apr 2012 16:22:34 +0000
Subject: [PATCH 02/16] drivers/gpio: gpio-nomadik: Add support for
 irqdomains
In-Reply-To: <CACRpkdaUDBwHb24eALidivgZGJS=xBpXNoYJUcAWrzCwYqi2ag@mail.gmail.com>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdaUDBwHb24eALidivgZGJS=xBpXNoYJUcAWrzCwYqi2ag@mail.gmail.com>
Message-ID: <201204181622.34692.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 April 2012, Linus Walleij wrote:
> On Tue, Apr 17, 2012 at 12:43 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
> > index d11f389..af12139 100644
> > --- a/arch/arm/mach-ux500/cpu.c
> > +++ b/arch/arm/mach-ux500/cpu.c
> > @@ -30,6 +30,7 @@
> >
> >  void __iomem *_PRCMU_BASE;
> >
> > +/* FIXME: should we set up the GPIO domain here? */
> 
> Why on earth would we want to do that?
> 
> Get rid of the comment simply...

I asked Lee to put it in ;-)

The problem is that we cannot put the interrupt resources into the platform
device until the irq domain has been added. Right now, we set the gic
interrupt domain from init_IRQ(), then add the load the gpio
driver from core_initcall(nmk_gpio_init) and add the platform devices
from arch_initcall(customize_machine).

This feels fragile because it depends on the gpio device getting probed
before any device using the gpio interrupts. It does seem to work fine
right now, but I'm not convinced that this is just coincidence.

	Arnd
