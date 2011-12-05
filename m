From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Dec 2011 21:11:36 +0000
Subject: [GIT PULL] ARM perf updates for 3.3
In-Reply-To: <20111203092659.GL9581@n2100.arm.linux.org.uk>
References: <20111202170231.GP5540@mudshark.cambridge.arm.com>
 <20111203092659.GL9581@n2100.arm.linux.org.uk>
Message-ID: <20111205211136.GF14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Can you please treat this with the utmost urgency.  If I don't get a
reply from you within the next two hours, then I'm committing this
merge resolution whether or not it's correct for you - as I have other
stuff which needs to be committed to my tree and I can't wait any
longer for your reply.

Thanks.

On Sat, Dec 03, 2011 at 09:26:59AM +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 02, 2011 at 05:02:31PM +0000, Will Deacon wrote:
> > Hi Russell,
> > 
> > Please pull these updates to the ARM perf code for 3.3. The highlights are
> > probably the CTI stuff (which is in preparation for OMAP4 support coming from
> > Lei Ming, Benoit and Paul) and the cleanup of the event numbers for ARMv7 so
> > that they are easier to follow. I was hoping to add Cortex-A7 support but I
> > haven't got my paws on an FPGA yet.
> > 
> > I've not included my contextidr patch with this pull because it conflicts
> > quite badly with the LPAE patches. I can rework this for 3.4 later on (I
> > already have a fixup).
> 
> While merging this, I get conflicts in gic.c and omap's common.h.  I'm
> intending to resolve them as below - please check this _before_ I commit
> it (which means my tree is frozen until this is resolved.)
> 
> diff --cc arch/arm/common/gic.c
> index a1feb6b,410a546..0000000
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@@ -696,12 -582,16 +697,14 @@@ void __init gic_init_bases(unsigned in
>   	 * For primary GICs, skip over SGIs.
>   	 * For secondary GICs, skip over PPIs, too.
>   	 */
> + 	domain->hwirq_base = 32;
>   	if (gic_nr == 0) {
> - 		domain->hwirq_base = 16;
> - 		if (irq_start > 0)
> - 			irq_start = (irq_start & ~31) + 16;
> - 	} else
> - 		domain->hwirq_base = 32;
>  -		gic_cpu_base_addr = cpu_base;
>  -
> + 		if ((irq_start & 31) > 0) {
> + 			domain->hwirq_base = 16;
> + 			if (irq_start != -1)
> + 				irq_start = (irq_start & ~31) + 16;
> + 		}
> + 	}
>   
>   	/*
>   	 * Find out how many interrupts are supported.
> diff --cc arch/arm/plat-omap/include/plat/common.h
> index 346098f,3ff3e36..0000000
> --- a/arch/arm/plat-omap/include/plat/common.h
> +++ b/arch/arm/plat-omap/include/plat/common.h
> @@@ -27,12 -27,97 +27,15 @@@
>   #ifndef __ARCH_ARM_MACH_OMAP_COMMON_H
>   #define __ARCH_ARM_MACH_OMAP_COMMON_H
>   
>  -#include <linux/delay.h>
>  -
>   #include <plat/i2c.h>
> + #include <plat/omap_hwmod.h>
>   
>  -struct sys_timer;
>  -
>  -extern void omap_map_common_io(void);
>  -extern struct sys_timer omap1_timer;
>  -extern struct sys_timer omap2_timer;
>  -extern struct sys_timer omap3_timer;
>  -extern struct sys_timer omap3_secure_timer;
>  -extern struct sys_timer omap4_timer;
>  -extern bool omap_32k_timer_init(void);
>   extern int __init omap_init_clocksource_32k(void);
>   extern unsigned long long notrace omap_32k_sched_clock(void);
>   
>   extern void omap_reserve(void);
>  -
>  -void omap2420_init_early(void);
>  -void omap2430_init_early(void);
>  -void omap3430_init_early(void);
>  -void omap35xx_init_early(void);
>  -void omap3630_init_early(void);
>  -void omap3_init_early(void);	/* Do not use this one */
>  -void am35xx_init_early(void);
>  -void ti816x_init_early(void);
>  -void omap4430_init_early(void);
>  -
> + extern int omap_dss_reset(struct omap_hwmod *);
> + 
>   void omap_sram_init(void);
>   
>  -/*
>  - * IO bases for various OMAP processors
>  - * Except the tap base, rest all the io bases
>  - * listed are physical addresses.
>  - */
>  -struct omap_globals {
>  -	u32		class;		/* OMAP class to detect */
>  -	void __iomem	*tap;		/* Control module ID code */
>  -	void __iomem	*sdrc;           /* SDRAM Controller */
>  -	void __iomem	*sms;            /* SDRAM Memory Scheduler */
>  -	void __iomem	*ctrl;           /* System Control Module */
>  -	void __iomem	*ctrl_pad;	/* PAD Control Module */
>  -	void __iomem	*prm;            /* Power and Reset Management */
>  -	void __iomem	*cm;             /* Clock Management */
>  -	void __iomem	*cm2;
>  -};
>  -
>  -void omap2_set_globals_242x(void);
>  -void omap2_set_globals_243x(void);
>  -void omap2_set_globals_3xxx(void);
>  -void omap2_set_globals_443x(void);
>  -void omap2_set_globals_ti816x(void);
>  -
>  -/* These get called from omap2_set_globals_xxxx(), do not call these */
>  -void omap2_set_globals_tap(struct omap_globals *);
>  -void omap2_set_globals_sdrc(struct omap_globals *);
>  -void omap2_set_globals_control(struct omap_globals *);
>  -void omap2_set_globals_prcm(struct omap_globals *);
>  -
>  -void omap242x_map_io(void);
>  -void omap243x_map_io(void);
>  -void omap3_map_io(void);
>  -void omap4_map_io(void);
>  -
>  -
>  -/**
>  - * omap_test_timeout - busy-loop, testing a condition
>  - * @cond: condition to test until it evaluates to true
>  - * @timeout: maximum number of microseconds in the timeout
>  - * @index: loop index (integer)
>  - *
>  - * Loop waiting for @cond to become true or until at least @timeout
>  - * microseconds have passed.  To use, define some integer @index in the
>  - * calling code.  After running, if @index == @timeout, then the loop has
>  - * timed out.
>  - */
>  -#define omap_test_timeout(cond, timeout, index)			\
>  -({								\
>  -	for (index = 0; index < timeout; index++) {		\
>  -		if (cond)					\
>  -			break;					\
>  -		udelay(1);					\
>  -	}							\
>  -})
>  -
>  -extern struct device *omap2_get_mpuss_device(void);
>  -extern struct device *omap2_get_iva_device(void);
>  -extern struct device *omap2_get_l3_device(void);
>  -extern struct device *omap4_get_dsp_device(void);
>  -
>   #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
