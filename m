From: Peter.Chen@freescale.com (Peter Chen)
Date: Tue, 4 Nov 2014 12:21:55 +0000
Subject: [PATCH] ARM: imx: refactor mxc_iomux_mode()
In-Reply-To: <20141027142054.GB14033@voytthpd>
References: <1413902151-20255-1-git-send-email-voytikd@gmail.com>
 <20141027142054.GB14033@voytthpd>
Message-ID: <54dc2a9edf554125b2158a1f9edd8adb@BN1PR0301MB0772.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 
> On Tue, Oct 21, 2014 at 06:35:51PM +0400, Dmitry Voytik wrote:
> > Refactor mxc_iomux_mode():
> >  - since it always returns 0 make it to return void
> >  - remove unnecessary ret variable
> >  - declare variables according to the kernel coding style
> >
> > Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
> > ---
> >  arch/arm/mach-imx/iomux-imx31.c | 8 ++++----
> >  arch/arm/mach-imx/iomux-mx3.h   | 2 +-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-imx/iomux-imx31.c
> > b/arch/arm/mach-imx/iomux-imx31.c index 1657fe6..d6a3075 100644
> > --- a/arch/arm/mach-imx/iomux-imx31.c
> > +++ b/arch/arm/mach-imx/iomux-imx31.c
> > @@ -44,9 +44,11 @@ static unsigned long mxc_pin_alloc_map[NB_PORTS *
> > 32 / BITS_PER_LONG];
> >  /*
> >   * set the mode for a IOMUX pin.
> >   */
> > -int mxc_iomux_mode(unsigned int pin_mode)
> > +void mxc_iomux_mode(unsigned int pin_mode)
> >  {
> > -	u32 field, l, mode, ret = 0;
> > +	u32 field;
> > +	u32 l;
> > +	u32 mode;
> >  	void __iomem *reg;
> >

Why you use three lines to define it, it makes the function longer.
Besides, Shawn's email changes to : <shawn.guo@linaro.org>

Peter

> >  	reg = IOMUXSW_MUX_CTL + (pin_mode & IOMUX_REG_MASK); @@ -
> 61,8 +63,6
> > @@ int mxc_iomux_mode(unsigned int pin_mode)
> >  	__raw_writel(l, reg);
> >
> >  	spin_unlock(&gpio_mux_lock);
> > -
> > -	return ret;
> >  }
> >
> >  /*
> > diff --git a/arch/arm/mach-imx/iomux-mx3.h
> > b/arch/arm/mach-imx/iomux-mx3.h index f79f78a..0a5adba 100644
> > --- a/arch/arm/mach-imx/iomux-mx3.h
> > +++ b/arch/arm/mach-imx/iomux-mx3.h
> > @@ -144,7 +144,7 @@ void mxc_iomux_set_gpr(enum iomux_gp_func, bool
> en);
> >   * It is called by the setup functions and should not be called directly
> anymore.
> >   * It is here visible for backward compatibility
> >   */
> > -int mxc_iomux_mode(unsigned int pin_mode);
> > +void mxc_iomux_mode(unsigned int pin_mode);
> >
> >  #define IOMUX_PADNUM_MASK	0x1ff
> >  #define IOMUX_GPIONUM_SHIFT	9
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
