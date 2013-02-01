From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 1 Feb 2013 12:28:19 -0500 (EST)
Subject: [PATCH v3 07/15] ARM: vexpress: Select the correct SMP operations
 at run-time
In-Reply-To: <510B5584.6020800@ti.com>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-8-git-send-email-nicolas.pitre@linaro.org>
 <510B5584.6020800@ti.com>
Message-ID: <alpine.LFD.2.02.1302011226270.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Feb 2013, Santosh Shilimkar wrote:

> On Tuesday 29 January 2013 01:21 PM, Nicolas Pitre wrote:
> > From: Jon Medhurst <tixy@linaro.org>
> > 
> The patch deserves couple of lines of description here.

Yes, Tixy has split it into 2 patches with proper description which 
should be part of the next round.


> 
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > ---
> >   arch/arm/include/asm/mach/arch.h |  3 +++
> >   arch/arm/kernel/setup.c          |  5 ++++-
> >   arch/arm/mach-vexpress/core.h    |  2 ++
> >   arch/arm/mach-vexpress/platsmp.c | 12 ++++++++++++
> >   arch/arm/mach-vexpress/v2m.c     |  2 +-
> >   5 files changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/mach/arch.h
> > b/arch/arm/include/asm/mach/arch.h
> > index 917d4fcfd9..3d01c6d6c3 100644
> > --- a/arch/arm/include/asm/mach/arch.h
> > +++ b/arch/arm/include/asm/mach/arch.h
> > @@ -17,8 +17,10 @@ struct pt_regs;
> >   struct smp_operations;
> >   #ifdef CONFIG_SMP
> >   #define smp_ops(ops) (&(ops))
> > +#define smp_init_ops(ops) (&(ops))
> >   #else
> >   #define smp_ops(ops) (struct smp_operations *)NULL
> > +#define smp_init_ops(ops) (void (*)(void))NULL
> >   #endif
> > 
> >   struct machine_desc {
> > @@ -42,6 +44,7 @@ struct machine_desc {
> >   	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
> >   	char			restart_mode;	/* default restart mode	*/
> >   	struct smp_operations	*smp;		/* SMP operations	*/
> > +	void			(*smp_init)(void);
> >   	void			(*fixup)(struct tag *, char **,
> >   					 struct meminfo *);
> >   	void			(*reserve)(void);/* reserve mem blocks	*/
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index 3f6cbb2e3e..41edca8582 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -768,7 +768,10 @@ void __init setup_arch(char **cmdline_p)
> >   	arm_dt_init_cpu_maps();
> >   #ifdef CONFIG_SMP
> >   	if (is_smp()) {
> > -		smp_set_ops(mdesc->smp);
> > +		if(mdesc->smp_init)
> > +			(*mdesc->smp_init)();
> > +		else
> > +			smp_set_ops(mdesc->smp);
> >   		smp_init_cpus();
> >   	}
> >   #endif
> > diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
> > index f134cd4a85..3a761fd76c 100644
> > --- a/arch/arm/mach-vexpress/core.h
> > +++ b/arch/arm/mach-vexpress/core.h
> > @@ -6,6 +6,8 @@
> > 
> >   void vexpress_dt_smp_map_io(void);
> > 
> > +void vexpress_smp_init_ops(void);
> > +
> >   extern struct smp_operations	vexpress_smp_ops;
> > 
> >   extern void vexpress_cpu_die(unsigned int cpu);
> > diff --git a/arch/arm/mach-vexpress/platsmp.c
> > b/arch/arm/mach-vexpress/platsmp.c
> > index c5d70de9bb..667344b479 100644
> > --- a/arch/arm/mach-vexpress/platsmp.c
> > +++ b/arch/arm/mach-vexpress/platsmp.c
> > @@ -12,6 +12,7 @@
> >   #include <linux/errno.h>
> >   #include <linux/smp.h>
> >   #include <linux/io.h>
> > +#include <linux/of.h>
> >   #include <linux/of_fdt.h>
> >   #include <linux/vexpress.h>
> > 
> > @@ -206,3 +207,14 @@ struct smp_operations __initdata vexpress_smp_ops = {
> >   	.cpu_die		= vexpress_cpu_die,
> >   #endif
> >   };
> > +
> > +void __init vexpress_smp_init_ops(void)
> > +{
> > +	struct smp_operations *ops = &vexpress_smp_ops;
> > +#ifdef CONFIG_CLUSTER_PM
> See if you can avoid this #ifdef in the middle of function.
> 
> Reviewed-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> 
