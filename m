From: pavel@denx.de (Pavel Machek)
Date: Wed, 27 Jun 2012 20:05:16 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <20120627162014.1494cdd7@skate>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
 <20120627162014.1494cdd7@skate>
Message-ID: <20120627180516.GA17393@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Below a few comments from my modest experience on the mach-mvebu SoC
> support.
> 
> Le Wed, 27 Jun 2012 08:50:06 -0500,
> <dinguyen@altera.com> a ?crit :
> 
> > +config ARCH_SOCFPGA
> 
> Is SOCFPGA a good name? It seems like a very generic name. Shouldn't it
> be ARCH_ALTERA_SOCFPGA a better name? I suspect other vendors will
> provide a SoC together with a FPGA.

I guess for config option name, ALTERA_SOCFPGA is okay, but for
directory name it would be a little bit long. Would that work?

> > +choice
> > +	prompt "Altera SOCFPGA Platform"
> > +	default MACH_SOCFPGA_CYCLONE5
> > +	depends on ARCH_SOCFPGA
> > +	help
> > +		Select SOCFPGA platform type
> > +
> > +config MACH_SOCFPGA_CYCLONE5
> > +	bool "SOCFPGA Cyclone5 platform"
> > +	select HAVE_SMP
> > +	select PLAT_SOCFPGA_ETH
> > +	help
> > +	  Include support for the Altera(R) Cyclone5 development platform.
> > +endchoice
> 
> Why do you need a "choice" here? The code should be able to support
> building multiple platforms at once. 

Should be bool, agreed.

> And even more: for a given SoC
> variant, we now generally only want one config options, the board-level
> details being abstracted out by the device tree.

Will look into that later.

> > index 0000000..7a1f3c0
> > --- /dev/null
> > +++ b/arch/arm/mach-socfpga/Makefile.boot
> > @@ -0,0 +1,3 @@
> > +zreladdr-y	:= 0x00008000
> > +params_phys-y	:= 0x00000100
> > +initrd_phys-y	:= 0x00800000
> 
> With the device tree, the params_phys-y and initrd_phys-y variables are
> useless.

Ok.

> > +/*
> > + * SOCFPGA interrupt sources
> > + */
> > +#define IRQ_SOCFPGA_CPU0_PARITY	(IRQ_SOCFPGA_GIC_START + 0)		/* CPU0 parity */
> > +#define IRQ_SOCFPGA_CPU0_PARITY_BTAG	(IRQ_SOCFPGA_GIC_START + 1)		/* CPU0 parity BTAG		*/
...
> > +#define SOFTIRQ_SOCFPGA_GPIO_2_27	(IRQ_SOCFPGA_GIC_START + 268)
> > +#define SOFTIRQ_SOCFPGA_GPIO_2_28	(IRQ_SOCFPGA_GIC_START + 269)
> > +#define SOFTIRQ_SOCFPGA_GPIO_2_29	(IRQ_SOCFPGA_GIC_START + 270)
> 
> Those huge lists of IRQs are no longer useful with the device tree, you
> can get rid of them.

Ok.

arch/arm/mach-socfpga/socfpga_cyclone5.c:119: error:
'IRQ_SOCFPGA_L4_OSC1_TIMER0' undeclared (first use in this function)

Looks like we'll meed a bit more of dt :-).

> > +#define NR_IRQS			512
> 
> You should be looking at using SPARSE_IRQ to avoid having a maximum
> number of irqs. See for example mach-highbank/.

Is maximum number of interrupts a problem? 512 does not seem
excessive.

> > +static inline void arch_idle(void)
> > +{
> > +	/*
> > +	 * This should do all the clock switching
> > +	 * and wait for interrupt tricks
> > +	 */
> > +	cpu_do_idle();
> > +}
> > +
> > +#endif
> 
> This isn't used anywhere, and the system.h header is being removed
> from sub-architectures, if I understood correctly.

Ok.

> > index 101b968..2f9a81e 100644
> > --- a/arch/arm/mm/Kconfig
> > +++ b/arch/arm/mm/Kconfig
> > @@ -381,7 +381,7 @@ config CPU_V6K
> >  
> >  # ARMv7
> >  config CPU_V7
> > -	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
> > +	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_SOCFPGA
> >  	select CPU_32v6K
> >  	select CPU_32v7
> >  	select CPU_ABRT_EV7
> 
> Apparently, your SoC is ARMv7 only at the moment, so you don't need to
> do this. Just keep the "select CPU_V7" in your ARCH_SOCFPGA option.

Will take a look.

Thanks,
										Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
