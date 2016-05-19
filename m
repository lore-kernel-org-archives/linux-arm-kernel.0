From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 May 2016 15:29:14 +0200
Subject: [PATCH] ARM: lpc32xx: fix NR_IRQS confict
In-Reply-To: <1463659769.14963.4.camel@localhost>
References: <1463646968-1047336-1-git-send-email-arnd@arndb.de>
 <573D8F92.3010902@mleia.com> <1463659769.14963.4.camel@localhost>
Message-ID: <3344142.lW8euGrkl5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 May 2016 08:09:29 Sylvain Lemieux wrote:
> Hi Arnd,
> 
> On Thu, 2016-05-19 at 13:04 +0300, Vladimir Zapolskiy wrote:
> > Hi Arnd,
> > 
> > On 19.05.2016 11:35, Arnd Bergmann wrote:
> > > With the change to sparse IRQs, the lpc32xx platform gets a warning about
> > > conflicting macros:
> > > 
> > > In file included from arch/arm/mach-lpc32xx/irq.c:31:0:
> > > arch/arm/mach-lpc32xx/include/mach/irqs.h:115:0: warning: "NR_IRQS" redefined
> > >  #define NR_IRQS    96
> > > arch/arm/include/asm/irq.h:9:0: note: this is the location of the previous definition
> > >  #define NR_IRQS NR_IRQS_LEGACY
> > > 
> > > In the irq controller driver, we surely need the local number instead of
> > > the generic NR_IRQS definition, so I'm renaming that one to LPC32XX_NR_IRQS.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Fixes: 8cb17b5ed017 ("irqchip: Add LPC32xx interrupt controller driver")
> > 
> > I think that the entire removal of arch/arm/mach-lpc32xx/irq.c is the proper fix,
> > since it is a dead code now - http://www.spinics.net/lists/arm-kernel/msg499976.html
> > 
> > I believe you can apply that change and add Fixes: tag.

Ok, I've applied that on the next/late branch for arm-soc now, and one patch
on top that removes the NR_IRQS definition from mach/irqs.h

> I also submitted a patch that remove this warning at the source
> (GPIO driver broken to_irq support), until the GPIO driver update is
> done.
> 
> Please refer to this link:
> http://thread.gmane.org/gmane.linux.kernel.gpio/16837

This is in another subsystem, so I'm not applying this to arm-soc, but
the warning should be gone with my one-line change to remove NR_IRQS
anyway.

Linus, if you want to put it in the gpio tree for v4.7, feel free to
add my Acked-by: Arnd Bergmann <arnd@arndb.de>, otherwise I guess it's
enough to have this in v4.8.

	Arnd
