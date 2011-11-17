From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 17 Nov 2011 19:00:08 +0100
Subject: [PATCH 6/7] ARM: restart: only perform setup for restart when
 soft-restarting
In-Reply-To: <20111117174247.GF9581@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6b9-0001NG-NS@rmk-PC.arm.linux.org.uk>
 <20111117174247.GF9581@n2100.arm.linux.org.uk>
Message-ID: <20111117180008.GP27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 05:42:47PM +0000, Russell King - ARM Linux wrote:
> Ack?
> 
> (If you're in the To: list I'm expecting a reply because this patch is
> touching something you're responsible for.  Thanks.)

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> 
> On Sun, Nov 06, 2011 at 05:33:35PM +0000, Russell King - ARM Linux wrote:
> > We only need to set the system up for a soft-restart if we're going to
> > be doing a soft-restart.  Provide a new function (soft_restart()) which
> > does the setup and final call for this, and make platforms use it.
> > Eliminate the call to setup_restart() from the default handler.
> > 
> > This means that platforms arch_reset() function is no longer called with
> > the page tables prepared for a soft-restart, and caches will still be
> > enabled.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/include/asm/system.h                     |    1 +
> >  arch/arm/kernel/process.c                         |   13 +++++++++++--
> >  arch/arm/mach-clps711x/include/mach/system.h      |    2 +-
> >  arch/arm/mach-ebsa110/include/mach/system.h       |    2 +-
> >  arch/arm/mach-footbridge/include/mach/system.h    |    2 +-
> >  arch/arm/mach-iop32x/include/mach/system.h        |    2 +-
> >  arch/arm/mach-iop33x/include/mach/system.h        |    2 +-
> >  arch/arm/mach-ixp4xx/include/mach/system.h        |    2 +-
> >  arch/arm/mach-ks8695/include/mach/system.h        |    2 +-
> >  arch/arm/mach-mmp/include/mach/system.h           |    4 ++--
> >  arch/arm/mach-mxs/system.c                        |    2 +-
> >  arch/arm/mach-pnx4008/include/mach/system.h       |    2 +-
> >  arch/arm/mach-pxa/reset.c                         |    2 +-
> >  arch/arm/mach-rpc/include/mach/system.h           |    2 +-
> >  arch/arm/mach-s3c2410/include/mach/system-reset.h |    4 ++--
> >  arch/arm/mach-s3c64xx/include/mach/system.h       |    2 +-
> >  arch/arm/mach-sa1100/include/mach/system.h        |    2 +-
> >  arch/arm/mach-shmobile/include/mach/system.h      |    2 +-
> >  arch/arm/mach-w90x900/include/mach/system.h       |    2 +-
> >  arch/arm/plat-mxc/system.c                        |    2 +-
> >  arch/arm/plat-spear/include/plat/system.h         |    2 +-
> >  21 files changed, 33 insertions(+), 23 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> > index 984014b..fe7de75 100644
> > --- a/arch/arm/include/asm/system.h
> > +++ b/arch/arm/include/asm/system.h
> > @@ -101,6 +101,7 @@ extern int __pure cpu_architecture(void);
> >  extern void cpu_init(void);
> >  
> >  void arm_machine_restart(char mode, const char *cmd);
> > +void soft_restart(unsigned long);
> >  extern void (*arm_pm_restart)(char str, const char *cmd);
> >  
> >  #define UDBG_UNDEFINED	(1 << 0)
> > diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> > index dca7971..52b4306 100644
> > --- a/arch/arm/kernel/process.c
> > +++ b/arch/arm/kernel/process.c
> > @@ -92,7 +92,7 @@ static int __init hlt_setup(char *__unused)
> >  __setup("nohlt", nohlt_setup);
> >  __setup("hlt", hlt_setup);
> >  
> > -void arm_machine_restart(char mode, const char *cmd)
> > +void soft_restart(unsigned long addr)
> >  {
> >  	/* Disable interrupts first */
> >  	local_irq_disable();
> > @@ -114,7 +114,16 @@ void arm_machine_restart(char mode, const char *cmd)
> >  	/* Push out any further dirty data, and ensure cache is empty */
> >  	flush_cache_all();
> >  
> > -	/* Now call the architecture specific reboot code. */
> > +	cpu_reset(addr);
> > +}
> > +
> > +void arm_machine_restart(char mode, const char *cmd)
> > +{
> > +	/* Disable interrupts first */
> > +	local_irq_disable();
> > +	local_fiq_disable();
> > +
> > +	/* Call the architecture specific reboot code. */
> >  	arch_reset(mode, cmd);
> >  }
> >  
> > diff --git a/arch/arm/mach-clps711x/include/mach/system.h b/arch/arm/mach-clps711x/include/mach/system.h
> > index f916cd7..6c11993 100644
> > --- a/arch/arm/mach-clps711x/include/mach/system.h
> > +++ b/arch/arm/mach-clps711x/include/mach/system.h
> > @@ -34,7 +34,7 @@ static inline void arch_idle(void)
> >  
> >  static inline void arch_reset(char mode, const char *cmd)
> >  {
> > -	cpu_reset(0);
> > +	soft_restart(0);
> >  }
> >  
> >  #endif
> > diff --git a/arch/arm/mach-ebsa110/include/mach/system.h b/arch/arm/mach-ebsa110/include/mach/system.h
> > index 9a26245..0d5df72 100644
> > --- a/arch/arm/mach-ebsa110/include/mach/system.h
> > +++ b/arch/arm/mach-ebsa110/include/mach/system.h
> > @@ -34,6 +34,6 @@ static inline void arch_idle(void)
> >  	asm volatile ("mcr p15, 0, ip, c15, c1, 2" : : : "cc");
> >  }
> >  
> > -#define arch_reset(mode, cmd)	cpu_reset(0x80000000)
> > +#define arch_reset(mode, cmd)	soft_restart(0x80000000)
> >  
> >  #endif
> > diff --git a/arch/arm/mach-footbridge/include/mach/system.h b/arch/arm/mach-footbridge/include/mach/system.h
> > index 0b29315..249f895 100644
> > --- a/arch/arm/mach-footbridge/include/mach/system.h
> > +++ b/arch/arm/mach-footbridge/include/mach/system.h
> > @@ -24,7 +24,7 @@ static inline void arch_reset(char mode, const char *cmd)
> >  		/*
> >  		 * Jump into the ROM
> >  		 */
> > -		cpu_reset(0x41000000);
> > +		soft_restart(0x41000000);
> >  	} else {
> >  		if (machine_is_netwinder()) {
> >  			/* open up the SuperIO chip
> > diff --git a/arch/arm/mach-iop32x/include/mach/system.h b/arch/arm/mach-iop32x/include/mach/system.h
> > index a4b808f..4865a9b 100644
> > --- a/arch/arm/mach-iop32x/include/mach/system.h
> > +++ b/arch/arm/mach-iop32x/include/mach/system.h
> > @@ -30,5 +30,5 @@ static inline void arch_reset(char mode, const char *cmd)
> >  	*IOP3XX_PCSR = 0x30;
> >  
> >  	/* Jump into ROM at address 0 */
> > -	cpu_reset(0);
> > +	soft_restart(0);
> >  }
> > diff --git a/arch/arm/mach-iop33x/include/mach/system.h b/arch/arm/mach-iop33x/include/mach/system.h
> > index f192a34..86d1b20 100644
> > --- a/arch/arm/mach-iop33x/include/mach/system.h
> > +++ b/arch/arm/mach-iop33x/include/mach/system.h
> > @@ -19,5 +19,5 @@ static inline void arch_reset(char mode, const char *cmd)
> >  	*IOP3XX_PCSR = 0x30;
> >  
> >  	/* Jump into ROM at address 0 */
> > -	cpu_reset(0);
> > +	soft_restart(0);
> >  }
> > diff --git a/arch/arm/mach-ixp4xx/include/mach/system.h b/arch/arm/mach-ixp4xx/include/mach/system.h
> > index 54c0af7..24337d9 100644
> > --- a/arch/arm/mach-ixp4xx/include/mach/system.h
> > +++ b/arch/arm/mach-ixp4xx/include/mach/system.h
> > @@ -26,7 +26,7 @@ static inline void arch_reset(char mode, const char *cmd)
> >  {
> >  	if ( 1 && mode == 's') {
> >  		/* Jump into ROM at address 0 */
> > -		cpu_reset(0);
> > +		soft_restart(0);
> >  	} else {
> >  		/* Use on-chip reset capability */
> >  
> > diff --git a/arch/arm/mach-ks8695/include/mach/system.h b/arch/arm/mach-ks8695/include/mach/system.h
> > index fb1dda9..ceb19c9 100644
> > --- a/arch/arm/mach-ks8695/include/mach/system.h
> > +++ b/arch/arm/mach-ks8695/include/mach/system.h
> > @@ -32,7 +32,7 @@ static void arch_reset(char mode, const char *cmd)
> >  	unsigned int reg;
> >  
> >  	if (mode == 's')
> > -		cpu_reset(0);
> > +		soft_restart(0);
> >  
> >  	/* disable timer0 */
> >  	reg = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
> > diff --git a/arch/arm/mach-mmp/include/mach/system.h b/arch/arm/mach-mmp/include/mach/system.h
> > index 1a8a25e..cb06379 100644
> > --- a/arch/arm/mach-mmp/include/mach/system.h
> > +++ b/arch/arm/mach-mmp/include/mach/system.h
> > @@ -19,8 +19,8 @@ static inline void arch_idle(void)
> >  static inline void arch_reset(char mode, const char *cmd)
> >  {
> >  	if (cpu_is_pxa168())
> > -		cpu_reset(0xffff0000);
> > +		soft_restart(0xffff0000);
> >  	else
> > -		cpu_reset(0);
> > +		soft_restart(0);
> >  }
> >  #endif /* __ASM_MACH_SYSTEM_H */
> > diff --git a/arch/arm/mach-mxs/system.c b/arch/arm/mach-mxs/system.c
> > index 20ec3bd..cab8836 100644
> > --- a/arch/arm/mach-mxs/system.c
> > +++ b/arch/arm/mach-mxs/system.c
> > @@ -53,7 +53,7 @@ void arch_reset(char mode, const char *cmd)
> >  	mdelay(50);
> >  
> >  	/* We'll take a jump through zero as a poor second */
> > -	cpu_reset(0);
> > +	soft_restart(0);
> >  }
> >  
> >  static int __init mxs_arch_reset_init(void)
> > diff --git a/arch/arm/mach-pnx4008/include/mach/system.h b/arch/arm/mach-pnx4008/include/mach/system.h
> > index 5dda2bb..5d6384a 100644
> > --- a/arch/arm/mach-pnx4008/include/mach/system.h
> > +++ b/arch/arm/mach-pnx4008/include/mach/system.h
> > @@ -32,7 +32,7 @@ static void arch_idle(void)
> >  
> >  static inline void arch_reset(char mode, const char *cmd)
> >  {
> > -	cpu_reset(0);
> > +	soft_restart(0);
> >  }
> >  
> >  #endif
> > diff --git a/arch/arm/mach-pxa/reset.c b/arch/arm/mach-pxa/reset.c
> > index 01e9d64..b8bcda1 100644
> > --- a/arch/arm/mach-pxa/reset.c
> > +++ b/arch/arm/mach-pxa/reset.c
> > @@ -88,7 +88,7 @@ void arch_reset(char mode, const char *cmd)
> >  	switch (mode) {
> >  	case 's':
> >  		/* Jump into ROM at address 0 */
> > -		cpu_reset(0);
> > +		soft_restart(0);
> >  		break;
> >  	case 'g':
> >  		do_gpio_reset();
> > diff --git a/arch/arm/mach-rpc/include/mach/system.h b/arch/arm/mach-rpc/include/mach/system.h
> > index 45c7b93..a354f4d 100644
> > --- a/arch/arm/mach-rpc/include/mach/system.h
> > +++ b/arch/arm/mach-rpc/include/mach/system.h
> > @@ -23,5 +23,5 @@ static inline void arch_reset(char mode, const char *cmd)
> >  	/*
> >  	 * Jump into the ROM
> >  	 */
> > -	cpu_reset(0);
> > +	soft_restart(0);
> >  }
> > diff --git a/arch/arm/mach-s3c2410/include/mach/system-reset.h b/arch/arm/mach-s3c2410/include/mach/system-reset.h
> > index 6faadce..913893d 100644
> > --- a/arch/arm/mach-s3c2410/include/mach/system-reset.h
> > +++ b/arch/arm/mach-s3c2410/include/mach/system-reset.h
> > @@ -19,7 +19,7 @@ static void
> >  arch_reset(char mode, const char *cmd)
> >  {
> >  	if (mode == 's') {
> > -		cpu_reset(0);
> > +		soft_restart(0);
> >  	}
> >  
> >  	if (s3c24xx_reset_hook)
> > @@ -28,5 +28,5 @@ arch_reset(char mode, const char *cmd)
> >  	arch_wdt_reset();
> >  
> >  	/* we'll take a jump through zero as a poor second */
> > -	cpu_reset(0);
> > +	soft_restart(0);
> >  }
> > diff --git a/arch/arm/mach-s3c64xx/include/mach/system.h b/arch/arm/mach-s3c64xx/include/mach/system.h
> > index 2e58cb7..d8ca578 100644
> > --- a/arch/arm/mach-s3c64xx/include/mach/system.h
> > +++ b/arch/arm/mach-s3c64xx/include/mach/system.h
> > @@ -24,7 +24,7 @@ static void arch_reset(char mode, const char *cmd)
> >  		arch_wdt_reset();
> >  
> >  	/* if all else fails, or mode was for soft, jump to 0 */
> > -	cpu_reset(0);
> > +	soft_restart(0);
> >  }
> >  
> >  #endif /* __ASM_ARCH_IRQ_H */
> > diff --git a/arch/arm/mach-sa1100/include/mach/system.h b/arch/arm/mach-sa1100/include/mach/system.h
> > index ba9da9f..345d35b 100644
> > --- a/arch/arm/mach-sa1100/include/mach/system.h
> > +++ b/arch/arm/mach-sa1100/include/mach/system.h
> > @@ -14,7 +14,7 @@ static inline void arch_reset(char mode, const char *cmd)
> >  {
> >  	if (mode == 's') {
> >  		/* Jump into ROM at address 0 */
> > -		cpu_reset(0);
> > +		soft_restart(0);
> >  	} else {
> >  		/* Use on-chip reset capability */
> >  		RSRR = RSRR_SWR;
> > diff --git a/arch/arm/mach-shmobile/include/mach/system.h b/arch/arm/mach-shmobile/include/mach/system.h
> > index 76a687e..956ac18 100644
> > --- a/arch/arm/mach-shmobile/include/mach/system.h
> > +++ b/arch/arm/mach-shmobile/include/mach/system.h
> > @@ -8,7 +8,7 @@ static inline void arch_idle(void)
> >  
> >  static inline void arch_reset(char mode, const char *cmd)
> >  {
> > -	cpu_reset(0);
> > +	soft_restart(0);
> >  }
> >  
> >  #endif
> > diff --git a/arch/arm/mach-w90x900/include/mach/system.h b/arch/arm/mach-w90x900/include/mach/system.h
> > index ce228bd..68875a1 100644
> > --- a/arch/arm/mach-w90x900/include/mach/system.h
> > +++ b/arch/arm/mach-w90x900/include/mach/system.h
> > @@ -33,7 +33,7 @@ static void arch_reset(char mode, const char *cmd)
> >  {
> >  	if (mode == 's') {
> >  		/* Jump into ROM at address 0 */
> > -		cpu_reset(0);
> > +		soft_restart(0);
> >  	} else {
> >  		__raw_writel(WTE | WTRE | WTCLK, WTCR);
> >  	}
> > diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
> > index 9dad8dc..b1cfc6a 100644
> > --- a/arch/arm/plat-mxc/system.c
> > +++ b/arch/arm/plat-mxc/system.c
> > @@ -70,7 +70,7 @@ void arch_reset(char mode, const char *cmd)
> >  	mdelay(50);
> >  
> >  	/* we'll take a jump through zero as a poor second */
> > -	cpu_reset(0);
> > +	soft_restart(0);
> >  }
> >  
> >  void mxc_arch_reset_init(void __iomem *base)
> > diff --git a/arch/arm/plat-spear/include/plat/system.h b/arch/arm/plat-spear/include/plat/system.h
> > index a235fa0..1171f22 100644
> > --- a/arch/arm/plat-spear/include/plat/system.h
> > +++ b/arch/arm/plat-spear/include/plat/system.h
> > @@ -31,7 +31,7 @@ static inline void arch_reset(char mode, const char *cmd)
> >  {
> >  	if (mode == 's') {
> >  		/* software reset, Jump into ROM at address 0 */
> > -		cpu_reset(0);
> > +		soft_restart(0);
> >  	} else {
> >  		/* hardware reset, Use on-chip reset capability */
> >  		sysctl_soft_reset((void __iomem *)VA_SPEAR_SYS_CTRL_BASE);
> > -- 
> > 1.7.4.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
