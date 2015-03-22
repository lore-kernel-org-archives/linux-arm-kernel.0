From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Mar 2015 03:54:42 +0100
Subject: [PATCH 05/10] ARM: s3c64xx: enable sparse IRQ support
In-Reply-To: <20150318000234.GU28806@sirena.org.uk>
References: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
 <6643361.dhtMagqMYZ@wuerfel> <20150318000234.GU28806@sirena.org.uk>
Message-ID: <201503220354.43125.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 March 2015, Mark Brown wrote:
> On Sun, Mar 08, 2015 at 10:42:59PM +0100, Arnd Bergmann wrote:

> > diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
> > index f395a5617142..cbe353a5450e 100644
> > --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> > +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> > @@ -855,7 +855,7 @@ static void __init crag6410_machine_init(void)
> >  MACHINE_START(WLF_CRAGG_6410, "Wolfson Cragganmore 6410")
> >       /* Maintainer: Mark Brown <broonie@opensource.wolfsonmicro.com> */
> >       .atag_offset    = 0x100,
> > -     .nr_irqs        = S3C64XX_NR_IRQS + 160,
> > +     .nr_irqs        = S3C64XX_NR_IRQS,
> >       .init_irq       = s3c6410_init_irq,
> >       .map_io         = crag6410_map_io,
> >       .init_machine   = crag6410_machine_init,
> 
> > The samsung-gpio driver does not allocate irq descriptors for itself
> > though, otherwise we could make the S3C64XX_NR_IRQS number smaller.
> 
> That's not the only thing, I'm still seeing an issue even with the
> change above.  The VICs are also complaining about preallocated
> descriptors, but they just assume the descriptors were preallocated and
> carry on happily.

Yes, that is the behavior I expected to see. The VIC driver would be
fine in theory with allocating the descriptors dynamically, but
the secondary irqchip (s3c_irq_eint) would need significant changes.

IIRC, another problem is the way that the first NR_IRQS_LEGACY interrupts
are always preallocated, but would not need to, once we fix the eint.
	Arnd
