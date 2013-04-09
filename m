From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 09 Apr 2013 17:55:02 +0100
Subject: [PATCH v4 14/15] ARM: Enable selection of SMP operations at
 boot time
In-Reply-To: <alpine.LFD.2.03.1304091223200.1171@syhkavp.arg>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-15-git-send-email-nicolas.pitre@linaro.org>
 <alpine.LFD.2.03.1304091223200.1171@syhkavp.arg>
Message-ID: <1365526502.3434.90.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-04-09 at 12:30 -0400, Nicolas Pitre wrote:
> On Tue, 5 Feb 2013, Nicolas Pitre wrote:
> 
> > From: Jon Medhurst <tixy@linaro.org>
> > 
> > Add a new 'smp_init' hook to machine_desc so platforms can specify a
> > function to be used to setup smp ops instead of having a statically
> > defined value.
> > 
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> I've slightly amended this patch to make its usage more flexible, please 
> see below.

Looks good to me.

Reviewed-by: Jon Medhurst <tixy@linaro.org>

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
> > +			(*mdesc->smp_init)();
> > +		else
> > +			smp_set_ops(mdesc->smp);
> >  		smp_init_cpus();
> >  	}
> >  #endif
> 
> I've amended it with the following changes to deal with an issue 
> highlighted by Tixy.  If the runtime hook does not initialize the smp 
> ops, the core may continue with a default.  That should let MCPM, PSCI 
> and Xen play well together.
> 
> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> index c01bf53b85..af8c54c6c6 100644
> --- a/arch/arm/include/asm/mach/arch.h
> +++ b/arch/arm/include/asm/mach/arch.h
> @@ -19,7 +19,7 @@ struct smp_operations;
>  #define smp_init_ops(ops) (&(ops))
>  #else
>  #define smp_ops(ops) (struct smp_operations *)NULL
> -#define smp_init_ops(ops) (void (*)(void))NULL
> +#define smp_init_ops(ops) (bool (*)(void))NULL
>  #endif
>  
>  struct machine_desc {
> @@ -43,7 +43,7 @@ struct machine_desc {
>  	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
>  	char			restart_mode;	/* default restart mode	*/
>  	struct smp_operations	*smp;		/* SMP operations	*/
> -	void			(*smp_init)(void);
> +	bool			(*smp_init)(void);
>  	void			(*fixup)(struct tag *, char **,
>  					 struct meminfo *);
>  	void			(*reserve)(void);/* reserve mem blocks	*/
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index e69c580c6f..cf4b08c0f9 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -768,9 +768,7 @@ void __init setup_arch(char **cmdline_p)
>  	arm_dt_init_cpu_maps();
>  #ifdef CONFIG_SMP
>  	if (is_smp()) {
> -		if (mdesc->smp_init)
> -			mdesc->smp_init();
> -		else
> +		if (!mdesc->smp_init || !mdesc->smp_init())
>  			smp_set_ops(mdesc->smp);
>  		smp_init_cpus();
>  	}
> 
> 
> Nicolas
