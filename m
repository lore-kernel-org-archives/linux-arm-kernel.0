From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 19 May 2010 06:58:44 +0100
Subject: [PATCH 10/11] ARM: S5PC100: use common plat-s5p external
	interrupt code
In-Reply-To: <011d01caf714$40ceed30$c26cc790$%szyprowski@samsung.com>
References: <1274179129-14659-1-git-send-email-m.szyprowski@samsung.com>
	<1274179129-14659-11-git-send-email-m.szyprowski@samsung.com>
	<20100519040212.GP26401@trinity.fluff.org>
	<011d01caf714$40ceed30$c26cc790$%szyprowski@samsung.com>
Message-ID: <20100519055844.GT26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 19, 2010 at 07:29:24AM +0200, Marek Szyprowski wrote:
> Hello,
> 
> On Wednesday, May 19, 2010 6:02 AM Ben Dooks wrote:
> 
> > On Tue, May 18, 2010 at 12:38:48PM +0200, Marek Szyprowski wrote:
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > ---
> > >  arch/arm/mach-s5pc100/Kconfig                  |    1 +
> > >  arch/arm/mach-s5pc100/gpiolib.c                |    3 +-
> > >  arch/arm/mach-s5pc100/include/mach/irqs.h      |   15 ++++++++--
> > >  arch/arm/mach-s5pc100/include/mach/regs-gpio.h |   36 ++++++++++++++----
> > -----
> > >  4 files changed, 36 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-
> > s5pc100/Kconfig
> > > index fe1216b..2eb9497 100644
> > > --- a/arch/arm/mach-s5pc100/Kconfig
> > > +++ b/arch/arm/mach-s5pc100/Kconfig
> > > @@ -10,6 +10,7 @@ if ARCH_S5PC100
> > >  config CPU_S5PC100
> > >  	bool
> > >  	select PLAT_S5P
> > > +	select S5P_EXT_INT
> > >  	help
> > >  	  Enable S5PC100 CPU support
> > >
> > > diff --git a/arch/arm/mach-s5pc100/gpiolib.c b/arch/arm/mach-
> > s5pc100/gpiolib.c
> > > index 88dd913..0fab7f2 100644
> > > --- a/arch/arm/mach-s5pc100/gpiolib.c
> > > +++ b/arch/arm/mach-s5pc100/gpiolib.c
> > > @@ -61,7 +61,6 @@
> > >   * L3	8	4Bit	None
> > >   */
> > >
> > > -#if 0
> > >  static int s5pc100_gpiolib_to_irq(struct gpio_chip *chip, unsigned int
> > offset)
> > >  {
> > >  	return S3C_IRQ_GPIO(chip->base + offset);
> > > @@ -85,7 +84,7 @@ static int s5pc100_gpiolib_to_eint(struct gpio_chip
> > *chip, unsigned int offset)
> > >  		return IRQ_EINT(24 + offset);
> > >  	return -EINVAL;
> > >  }
> > > -#endif
> > > +
> > >  static struct s3c_gpio_cfg gpio_cfg = {
> > >  	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
> > >  	.set_pull	= s3c_gpio_setpull_updown,
> > > diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/mach-
> > s5pc100/include/mach/irqs.h
> > > index 84c74ac..f26c4d9 100644
> > > --- a/arch/arm/mach-s5pc100/include/mach/irqs.h
> > > +++ b/arch/arm/mach-s5pc100/include/mach/irqs.h
> > > @@ -97,10 +97,19 @@
> > >  #define IRQ_SDMFIQ		S5P_IRQ_VIC2(31)
> > >  #define IRQ_VIC_END		S5P_IRQ_VIC2(31)
> > >
> > > -#define S5P_IRQ_EINT_BASE	(IRQ_VIC_END + 1)
> > > +#define S5P_EINT_16_31_BASE	(IRQ_VIC_END + 1)
> > >
> > > -#define IRQ_EINT(x)             ((x) < 16 ? S5P_IRQ_VIC0(x) : \
> > > -					(S5P_IRQ_EINT_BASE + (x)-16))
> > > +#define S3C_IRQ_EINT_BASE	(IRQ_VIC_END + 1)
> > 
> > we seem to have this and S5P_EINT_16_31_BASE? Let's use just the one.
> > 
> > > +#define EINT_MODE		S3C_GPIO_SFN(0x2)
> > > +
> > > +#define IRQ_EINT(x)		((x) < 16 ? ((x) + S5P_IRQ_VIC0(0)) \
> > > +					: ((x) + S5P_EINT_16_31_BASE))
> > 
> > ok, could we put this in arch/arm/plat-s5p/include/plat/irqs.h and
> > just have the per-platform files defining the base?
> 
> I'm not sure if this is a good idea. Although this code works for s5pc100
> and s5pv210, there might be problems with s5p6440, which has external
> interrupts designed like s3c6410. But I'm not sure if this would cause
> the problems. If so then we can always just move it from plat/irqs.h to
> mach/irqs.h again.

Hmm, you're right that the s5p6440 is a bit of a problem here... Maybe
we should have a common file for these elsewhere.
 
> > 
> > > +#define EINT_GPIO_0(x)		S5PC100_GPH0(x)
> > > +#define EINT_GPIO_1(x)		S5PC100_GPH1(x)
> > > +#define EINT_GPIO_2(x)		S5PC100_GPH2(x)
> > > +#define EINT_GPIO_3(x)		S5PC100_GPH3(x)
> > >
> > >  #define S3C_IRQ_GPIO_BASE	(IRQ_EINT(31) + 1)
> > >  #define S3C_IRQ_GPIO(x)		(S3C_IRQ_GPIO_BASE + (x))
> 
> What about moving these to mach/gpio.h? IMHO mach/irqs.h is not the
> best place for them.

Hmm, maybe they could go there, since we have to include the gpio
numbering to get the S5PC100_GPH3() definitions.
 
> > ...
> 
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
