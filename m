From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Mar 2015 00:02:34 +0000
Subject: [PATCH 05/10] ARM: s3c64xx: enable sparse IRQ support
In-Reply-To: <6643361.dhtMagqMYZ@wuerfel>
References: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
 <1425299763-4066822-6-git-send-email-arnd@arndb.de>
 <20150306174316.GA26692@opensource.wolfsonmicro.com>
 <6643361.dhtMagqMYZ@wuerfel>
Message-ID: <20150318000234.GU28806@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 08, 2015 at 10:42:59PM +0100, Arnd Bergmann wrote:
> On Friday 06 March 2015 17:43:16 Charles Keepax wrote:

> > This one appears to cause some problems with the IRQs on
> > Cragganmore, I need to look into it a bit more but it looks like
> > one of the PMICs can't allocate its IRQs:

> > [    0.961455] wm831x 1-0034: WM8311 revision C
> > [    0.965066] wm831x 1-0034: Failed to allocate IRQs: -17

> > And the CODEC can't request its IRQ:

> > [    4.252735] arizona spi0.1: WM5102 revision C
> > [    4.269763] arizona spi0.1: Failed to request primary IRQ 263: -22

> > Hopefully I can look into this a little more next week.

> My interpretation is that I mistakenly set the .nr_irqs value for
> craggamore to include all irqs that the board has, while the
> wm831x tries to allocate the irq descriptors itself and fails if
> they are already allocated. If that is the only problem here, it
> would get fixed by this change:

> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
> index f395a5617142..cbe353a5450e 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -855,7 +855,7 @@ static void __init crag6410_machine_init(void)
>  MACHINE_START(WLF_CRAGG_6410, "Wolfson Cragganmore 6410")
>  	/* Maintainer: Mark Brown <broonie@opensource.wolfsonmicro.com> */
>  	.atag_offset	= 0x100,
> -	.nr_irqs	= S3C64XX_NR_IRQS + 160,
> +	.nr_irqs	= S3C64XX_NR_IRQS,
>  	.init_irq	= s3c6410_init_irq,
>  	.map_io		= crag6410_map_io,
>  	.init_machine	= crag6410_machine_init,

> The samsung-gpio driver does not allocate irq descriptors for itself
> though, otherwise we could make the S3C64XX_NR_IRQS number smaller.

That's not the only thing, I'm still seeing an issue even with the
change above.  The VICs are also complaining about preallocated
descriptors, but they just assume the descriptors were preallocated and
carry on happily.  I'd also expect this to be affecting both wm831xs but
it's only affecting the WM8311 on the base board, not the primary
WM8312, so this seems to be a red herring.

I rather suspect that the issue is at least partly that the interrupt
numbering is off - the CODEC has 24 interrupts allocated to it in
crag6410.h which is nowhere near enough and the PMICs have 32 each
rather than the 58 they need.  This is broken for the existing code too
so we should get a fix to make that right in before anything else.  A
trivial change to fix that doesn't seem to have helped though but I
probably just miscounted or something.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/b2825b0a/attachment.sig>
