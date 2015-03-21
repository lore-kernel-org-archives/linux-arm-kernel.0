From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Sat, 21 Mar 2015 16:38:21 +0000
Subject: [PATCH 05/10] ARM: s3c64xx: enable sparse IRQ support
In-Reply-To: <20150318000234.GU28806@sirena.org.uk>
References: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
 <1425299763-4066822-6-git-send-email-arnd@arndb.de>
 <20150306174316.GA26692@opensource.wolfsonmicro.com>
 <6643361.dhtMagqMYZ@wuerfel> <20150318000234.GU28806@sirena.org.uk>
Message-ID: <20150321163821.GE23705@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 12:02:34AM +0000, Mark Brown wrote:
> On Sun, Mar 08, 2015 at 10:42:59PM +0100, Arnd Bergmann wrote:
> > On Friday 06 March 2015 17:43:16 Charles Keepax wrote:
> > diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
> > index f395a5617142..cbe353a5450e 100644
> > --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> > +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> > @@ -855,7 +855,7 @@ static void __init crag6410_machine_init(void)
> >  MACHINE_START(WLF_CRAGG_6410, "Wolfson Cragganmore 6410")
> >  	/* Maintainer: Mark Brown <broonie@opensource.wolfsonmicro.com> */
> >  	.atag_offset	= 0x100,
> > -	.nr_irqs	= S3C64XX_NR_IRQS + 160,
> > +	.nr_irqs	= S3C64XX_NR_IRQS,
> >  	.init_irq	= s3c6410_init_irq,
> >  	.map_io		= crag6410_map_io,
> >  	.init_machine	= crag6410_machine_init,
> 
> > The samsung-gpio driver does not allocate irq descriptors for itself
> > though, otherwise we could make the S3C64XX_NR_IRQS number smaller.
> 
> That's not the only thing, I'm still seeing an issue even with the
> change above.  The VICs are also complaining about preallocated
> descriptors, but they just assume the descriptors were preallocated and
> carry on happily.  I'd also expect this to be affecting both wm831xs but
> it's only affecting the WM8311 on the base board, not the primary
> WM8312, so this seems to be a red herring.
> 
> I rather suspect that the issue is at least partly that the interrupt
> numbering is off - the CODEC has 24 interrupts allocated to it in
> crag6410.h which is nowhere near enough and the PMICs have 32 each
> rather than the 58 they need.  This is broken for the existing code too
> so we should get a fix to make that right in before anything else.  A
> trivial change to fix that doesn't seem to have helped though but I
> probably just miscounted or something.

Ok guys very sorry about the massive delay in looking at this
again, I have been a bit swamped lately. I think I see what is
going on here.

The fix from Arnd there definitely helped, but still doesn't
quite work and those defines you are talking about there are
actually for the GPIOs so they are a bit of a red herring. There
are two PMICs as you mention one of which is given a fixed IRQ
base and the other which allocates it own. The problem appears to
be that the one which allocates its own IRQ base takes the space
that is specified as the fixed base for the other PMIC. Which
then fails to allocate its IRQs.

So adding a bit of an offset into the PMIC with the fixed IRQ
base fixes the problem. Although I am not sure if it would be
better to move both PMICs onto a fixed IRQ base so there is no
chance of the clashing. Any thoughts?

Thanks,
Charles

Applying this diff, on top of Arnd's fixup, gets everything
working for me:

diff --git a/arch/arm/mach-s3c64xx/crag6410.h
b/arch/arm/mach-s3c64xx/crag6410.h
index 7bc6668..59c5f44 100644
--- a/arch/arm/mach-s3c64xx/crag6410.h
+++ b/arch/arm/mach-s3c64xx/crag6410.h
@@ -13,7 +13,7 @@

 #include <mach/gpio-samsung.h>

-#define GLENFARCLAS_PMIC_IRQ_BASE      IRQ_BOARD_START
+#define GLENFARCLAS_PMIC_IRQ_BASE      IRQ_BOARD_START + 256
