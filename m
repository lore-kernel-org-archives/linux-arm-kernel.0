From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Thu, 22 Nov 2018 18:07:51 +0300
Subject: [RFC PATCH v3 01/17] ARM: add CONFIG_ARCH_SUNXI_V7 for
 differentiate ARMv5/v7 Allwinner SoCs
In-Reply-To: <20181122082635.br5n33owxxpenv62@flea>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <267ffcf3b91930a82f20d93e1fad1fceaf8b9b0e.1542824904.git.mesihkilinc@gmail.com>
 <20181122082635.br5n33owxxpenv62@flea>
Message-ID: <20181122150751.n26pvywmvnuglly5@ThinkPad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/11/22 09:26, Maxime Ripard wrote:
> On Wed, Nov 21, 2018 at 09:30:34PM +0300, Mesih Kilinc wrote:
> > Allwinner also has some ARMv5 SoCs.
> > 
> > In order to add support for them, add a CONFIG_ARCH_SUNXI_V7 bool config
> > which is selected when a ARMv7 soc is selected, and make CONFIG_ARCH_SUNXI
> > a common option which is selected by both V7 and V5 sunxi option.
> > 
> > Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> > ---
> >  arch/arm/mach-sunxi/Kconfig | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> > index d9c8ecf..7e5f173 100644
> > --- a/arch/arm/mach-sunxi/Kconfig
> > +++ b/arch/arm/mach-sunxi/Kconfig
> > @@ -6,31 +6,38 @@ menuconfig ARCH_SUNXI
> >  	select GENERIC_IRQ_CHIP
> >  	select GPIOLIB
> >  	select PINCTRL
> > -	select PM_OPP
> >  	select SUN4I_TIMER
> >  	select RESET_CONTROLLER
> > +	help
> > +	  Support for Allwinner ARM-based family of processors
> >  
> >  if ARCH_SUNXI
> >  
> > +if ARCH_MULTI_V7
> > +
> > +config ARCH_SUNXI_V7
> > +	bool
> > +	select PM_OPP
> > +
> 
> Actually, thinking more about this, I don't see why the PM_OPP config
> option should be made specific to the ARMv7 sunxi SoCs, you will have
> things cpufreq enabled at some point as well on the armv5 support.
> 
OK. I was basing this code to the first patch series. 
So there will be no need for ARCH_SUNXI_VX configs. Should I drop them
and differantiate IC's by only ARCH_MULTI_VX?

> >  config MACH_SUN4I
> >  	bool "Allwinner A10 (sun4i) SoCs support"
> > -	default ARCH_SUNXI
> > +	select ARCH_SUNXI_V7
> 
> The option is still changed from being on by default to being off by
> default. This breaks all the defconfig, and we really shouldn't change
> that.

OK. I will fix it.

Mesih Veysi K?l?n?
