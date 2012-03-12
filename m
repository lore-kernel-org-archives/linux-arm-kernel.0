From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Mar 2012 23:59:51 +0000
Subject: Conflict between Versatile Express DT conversion and local
 timer updates
In-Reply-To: <20120312231016.GC10830@n2100.arm.linux.org.uk>
References: <20120312231016.GC10830@n2100.arm.linux.org.uk>
Message-ID: <20120312235951.GA31601@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 11:10:16PM +0000, Russell King - ARM Linux wrote:
> Marc, Pawel,
> 
> Your changes are conflicting badly.  Seriously badly.  So badly that I'm
> not bothering to fix the conflicts because I can't work out what the fix
> should be.
> 
> You both work for the same frigging organization and yet you seem to
> work completely independently (I really don't care if you work in
> different departments - the fact of the matter is you're touching the
> same code in completely different ways with zero coordination between
> yourselves.  That's simply broken workflow.)
> 
> For example, Marc's deleting arch/arm/plat-versatile/localtimer.c, but
> Pawel is modifying it to add DT support for Versatile Express.  The
> correct solution?  Hell knows.  And I don't want a solution to the merge
> conflict.  I want the merge conflict to go away (because I'm not frigging
> around applying the same git-rerere immune fixes to a tree I'm regenerating
> each night for the kernel autobuilder.)
> 
> I'm getting conflicts in arch/arm/mach-vexpress/ct-ca9x4.c and
> arch/arm/mach-ux500/timer.c as well, which I'm not going to bother trying
> to sort out - the obvious solution for ux500/timer.c doesn't look right.
> 
> I've a mind to drop the localtimer changes on the floor until after this
> merge window, but unfortunately they're part of devel-stable so I can't.

Correction: I haven't been pushing out my devel-stable branch for
apparantly two months (according to gitweb, and no one noticed?), so I
_could_ drop the merge of Marc's tree until the conflicts can be sanely
resolved.

> 
> How do we fix this?
> 
> (In the mean time, I've had to reset the kernel autobuilder back to last
> nights tree, which is -rc6 based.)
> 
> diff --cc arch/arm/mach-ux500/timer.c
> index cadf982,fd00024..0000000
> --- a/arch/arm/mach-ux500/timer.c
> +++ b/arch/arm/mach-ux500/timer.c
> @@@ -15,38 -15,22 +15,52 @@@
>   #include <mach/setup.h>
>   #include <mach/hardware.h>
>   
>  +#ifdef CONFIG_HAVE_ARM_TWD
>  +static DEFINE_TWD_LOCAL_TIMER(u5500_twd_local_timer,
>  +			      U5500_TWD_BASE, IRQ_LOCALTIMER);
>  +static DEFINE_TWD_LOCAL_TIMER(u8500_twd_local_timer,
>  +			      U8500_TWD_BASE, IRQ_LOCALTIMER);
>  +
>  +static void __init ux500_twd_init(void)
>  +{
>  +	struct twd_local_timer *twd_local_timer;
>  +	int err;
>  +
>  +	twd_local_timer = cpu_is_u5500() ? &u5500_twd_local_timer :
>  +					   &u8500_twd_local_timer;
>  +
>  +	err = twd_local_timer_register(twd_local_timer);
>  +	if (err)
>  +		pr_err("twd_local_timer_register failed %d\n", err);
>  +}
>  +#else
>  +#define ux500_twd_init()	do { } while(0)
>  +#endif
>  +
>   static void __init ux500_timer_init(void)
>   {
> + 	void __iomem *mtu_timer_base;
>   	void __iomem *prcmu_timer_base;
>  +	int err;
>   
>   	if (cpu_is_u5500()) {
> ++<<<<<<< HEAD
>  +		mtu_base = __io_address(U5500_MTU0_BASE);
>  +		prcmu_timer_base = __io_address(U5500_PRCMU_TIMER_3_BASE);
>  +	} else if (cpu_is_u8500()) {
>  +		mtu_base = __io_address(U8500_MTU0_BASE);
> ++=======
> + #ifdef CONFIG_LOCAL_TIMERS
> + 		twd_base = __io_address(U5500_TWD_BASE);
> + #endif
> + 		mtu_timer_base = __io_address(U5500_MTU0_BASE);
> + 		prcmu_timer_base = __io_address(U5500_PRCMU_TIMER_3_BASE);
> + 	} else if (cpu_is_u8500()) {
> + #ifdef CONFIG_LOCAL_TIMERS
> + 		twd_base = __io_address(U8500_TWD_BASE);
> + #endif
> + 		mtu_timer_base = __io_address(U8500_MTU0_BASE);
> ++>>>>>>> arm-soc
>   		prcmu_timer_base = __io_address(U8500_PRCMU_TIMER_4_BASE);
>   	} else {
>   		ux500_unknown_soc();
> @@@ -69,9 -53,8 +83,9 @@@
>   	 *
>   	 */
>   
> - 	nmdk_timer_init();
> + 	nmdk_timer_init(mtu_timer_base);
>   	clksrc_dbx500_prcmu_init(prcmu_timer_base);
>  +	ux500_twd_init();
>   }
>   
>   static void ux500_timer_reset(void)
> diff --cc arch/arm/mach-vexpress/ct-ca9x4.c
> index b391538,73791f0..0000000
> --- a/arch/arm/mach-vexpress/ct-ca9x4.c
> +++ b/arch/arm/mach-vexpress/ct-ca9x4.c
> @@@ -54,44 -42,17 +42,50 @@@ static struct map_desc ct_ca9x4_io_desc
>   static void __init ct_ca9x4_map_io(void)
>   {
>   	iotable_init(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
> ++<<<<<<< HEAD
> ++=======
> + #ifdef CONFIG_LOCAL_TIMERS
> + 	twd_base = ioremap(A9_MPCORE_TWD, SZ_32);
> + #endif
> ++>>>>>>> arm-soc
>   }
>   
>  +#ifdef CONFIG_HAVE_ARM_TWD
>  +static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, A9_MPCORE_TWD, IRQ_LOCALTIMER);
>  +
>  +static void __init ca9x4_twd_init(void)
>  +{
>  +	int err = twd_local_timer_register(&twd_local_timer);
>  +	if (err)
>  +		pr_err("twd_local_timer_register failed %d\n", err);
>  +}
>  +#else
>  +#define ca9x4_twd_init()	do {} while(0)
>  +#endif
>  +
>   static void __init ct_ca9x4_init_irq(void)
>   {
> ++<<<<<<< HEAD
>  +	gic_init(0, 29, MMIO_P2V(A9_MPCORE_GIC_DIST),
>  +		 MMIO_P2V(A9_MPCORE_GIC_CPU));
>  +	ca9x4_twd_init();
>  +}
>  +
>  +#if 0
>  +static void __init ct_ca9x4_timer_init(void)
>  +{
>  +	writel(0, MMIO_P2V(CT_CA9X4_TIMER0) + TIMER_CTRL);
>  +	writel(0, MMIO_P2V(CT_CA9X4_TIMER1) + TIMER_CTRL);
>  +
>  +	sp804_clocksource_init(MMIO_P2V(CT_CA9X4_TIMER1), "ct-timer1");
>  +	sp804_clockevents_init(MMIO_P2V(CT_CA9X4_TIMER0), IRQ_CT_CA9X4_TIMER0,
>  +		"ct-timer0");
> ++=======
> + 	gic_init(0, 29, ioremap(A9_MPCORE_GIC_DIST, SZ_4K),
> + 		 ioremap(A9_MPCORE_GIC_CPU, SZ_256));
> ++>>>>>>> arm-soc
>   }
>   
> - static struct sys_timer ct_ca9x4_timer = {
> - 	.init	= ct_ca9x4_timer_init,
> - };
> - #endif
> - 
>   static void ct_ca9x4_clcd_enable(struct clcd_fb *fb)
>   {
>   	v2m_cfg_write(SYS_CFG_MUXFPGA | SYS_CFG_SITE_DB1, 0);
> 
