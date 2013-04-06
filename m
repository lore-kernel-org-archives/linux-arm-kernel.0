From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 6 Apr 2013 09:43:26 -0400 (EDT)
Subject: [PATCH v4 14/15] ARM: Enable selection of SMP operations at boot
 time
In-Reply-To: <20130405224348.GA14308@quad.lixom.net>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-15-git-send-email-nicolas.pitre@linaro.org>
 <20130405224348.GA14308@quad.lixom.net>
Message-ID: <alpine.LFD.2.03.1304060942340.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Apr 2013, Olof Johansson wrote:

> On Tue, Feb 05, 2013 at 12:22:11AM -0500, Nicolas Pitre wrote:
> > From: Jon Medhurst <tixy@linaro.org>
> > 
> > Add a new 'smp_init' hook to machine_desc so platforms can specify a
> > function to be used to setup smp ops instead of having a statically
> > defined value.
> > 
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/include/asm/mach/arch.h | 3 +++
> >  arch/arm/kernel/setup.c          | 5 ++++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> > index 917d4fcfd9..3d01c6d6c3 100644
> > --- a/arch/arm/include/asm/mach/arch.h
> > +++ b/arch/arm/include/asm/mach/arch.h
> > @@ -17,8 +17,10 @@ struct pt_regs;
> >  struct smp_operations;
> >  #ifdef CONFIG_SMP
> >  #define smp_ops(ops) (&(ops))
> > +#define smp_init_ops(ops) (&(ops))
> >  #else
> >  #define smp_ops(ops) (struct smp_operations *)NULL
> > +#define smp_init_ops(ops) (void (*)(void))NULL
> >  #endif
> >  
> >  struct machine_desc {
> > @@ -42,6 +44,7 @@ struct machine_desc {
> >  	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
> >  	char			restart_mode;	/* default restart mode	*/
> >  	struct smp_operations	*smp;		/* SMP operations	*/
> > +	void			(*smp_init)(void);
> >  	void			(*fixup)(struct tag *, char **,
> >  					 struct meminfo *);
> >  	void			(*reserve)(void);/* reserve mem blocks	*/
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index 3f6cbb2e3e..41edca8582 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -768,7 +768,10 @@ void __init setup_arch(char **cmdline_p)
> >  	arm_dt_init_cpu_maps();
> >  #ifdef CONFIG_SMP
> >  	if (is_smp()) {
> > -		smp_set_ops(mdesc->smp);
> > +		if(mdesc->smp_init)
> 
> This will fail checkpatch: if() instead of if ().

Indeed.

> > +			(*mdesc->smp_init)();
> 
> This is different calling style than init_early() below, which uses
> mdesc->init_early(). Please be consistent.

Fixed in my tree now.

Thanks.


Nicolas
