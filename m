From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 9 Aug 2016 13:57:01 +0800
Subject: [PATCH 1/1] irqchip: irq-gic: forward SGI to itself for
 cortex-a7 single core
In-Reply-To: <20160809063401.3117dc94@arm.com>
References: <1470642594-30455-1-git-send-email-peter.chen@nxp.com>
 <20160808105026.GA12649@leverpostej>
 <HE1PR04MB1450C6BE844A31C95CEE3BE18B1B0@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <20160808130754.GB12649@leverpostej>
 <20160808132847.GB17680@shlinux2>
 <20160808134842.GE12649@leverpostej>
 <20160808145916.0924e868@arm.com> <20160809034613.GB31105@shlinux2>
 <20160809063401.3117dc94@arm.com>
Message-ID: <20160809055701.GC31105@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 06:34:01AM +0100, Marc Zyngier wrote:
> On Tue, 9 Aug 2016 11:46:13 +0800
> Peter Chen <hzpeterchen@gmail.com> wrote:
> 
> > On Mon, Aug 08, 2016 at 02:59:16PM +0100, Marc Zyngier wrote:
> > > On Mon, 8 Aug 2016 14:48:42 +0100
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > >   
> > > > On Mon, Aug 08, 2016 at 09:28:47PM +0800, Peter Chen wrote:  
> > > > > On Mon, Aug 08, 2016 at 02:07:54PM +0100, Mark Rutland wrote:    
> > > > > > I see that for arm64 we have:
> > > > > > 
> > > > > > static inline bool arch_irq_work_has_interrupt(void)
> > > > > > {
> > > > > > 	return !!__smp_cross_call;
> > > > > > }
> > > > > > 
> > > > > > Could we do similarly for ARM, and ony register gic_raise_softirq if
> > > > > > we have non-zero SGI targets?
> > > > > > 
> > > > > > If I've understood correctly, that would make things behave as they do
> > > > > > for UP on you system.    
> > > > 
> > > > [...]
> > > >   
> > > > > > If self-IPI is necessary, then this would be up to the GIC code to
> > > > > > solve.
> > > > > > 
> > > > > > For that case, it would be nicer if we could detect whether this was
> > > > > > necessary based on the GIC registers alone. That way we handle the
> > > > > > various ways this can be integrated, aren't totally relient on the DT,
> > > > > > work in VMs, etc.    
> > > > > 
> > > > > How we can detect IPI capabilities based on GIC register?    
> > > > 
> > > > Check the mask associated with SGIs, as we do for gic_get_cpumask(). If
> > > > this is zero, we have a non-multiprocessor GIC (or one that's otherwise
> > > > broken), and can't do SGI in the usual way.
> > > > 
> > > > However, it only makes sense to do this if self-IPI is truly a
> > > > necessity. Given there are other interrupt controllers that can't do
> > > > self-IPI, avoiding self-IPI in general would be a better strategy,
> > > > avoiding churn in each and every driver...  
> > > 
> > > Indeed. And I won't take such a patch until all other avenues have been
> > > explored, including fixing core code if required...
> > >   
> > 
> > Ok, it seems both you and Mark agree with disable IPI for GIC who has only
> > self-IPI capability (GICD_ITARGETSR0 to GICD_ITARGETSR7 are all
> > zero), right?
> 
> Not necessarily. This can be seen a latency improvement, compared to
> the timer method which should be the fallback.
> 

Why? Your below patch (I tried too) just fixes NULL pointer issue for
without define smp_cross_call function. But imx6ul is a SMP platform
(all imx6/7 uses the same configuration with both CONFIG_SMP and
 CONFIG_SMP_ON_UP are defined), it still defines smp_cross_call.
We still need the changes at gic code.

Besides, if the hardware has IPI capability, but we just disable it
to align with UP platforms, is it reasonable?

Peter
> > 
> > But even we do that, we still have problem that the callers for
> > smp_cross_call don't know well if the platform has IPI capability. Eg,
> > IRQ work considers the SMP system has IPI capability, but it is not a
> > must in this case (Cortex-A7 MPcore version, but cpu number is one).
> > It will cause NULL pointer dereference problem as __smp_cross_call is
> > NULL, and we need to make below change to let it work:
> > 
> > diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> > index 937c892..276bd94 100644
> > --- a/arch/arm/kernel/smp.c
> > +++ b/arch/arm/kernel/smp.c
> > @@ -487,7 +487,8 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
> >  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
> >  {
> >  	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
> > -	__smp_cross_call(target, ipinr);
> > +	if (__smp_cross_call)
> > +		__smp_cross_call(target, ipinr);
> >  }
> 
> I came up with a slightly different approach, which is to have
> arch_irq_work_has_interrupt() to check for an IPI-capable system:
> 
> From 9be5fc16f10e4d32a8ad3d70db50d2dfb96f70a1 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <marc.zyngier@arm.com>
> Date: Tue, 9 Aug 2016 06:04:12 +0100
> Subject: [PATCH] ARM: irq_work: Do not attempt to IPI on non IPI-capable HW
> 
> Not all of the ARM HW is IPI capable (i.e. most of the non-SMP
> systems). Unfortunately, some systems do advertise being SMP
> capable, even if they have a single core and do not define
> a cross call method. In this case, irq_work_queue dies
> as arch_irq_work_has_interrupt() fails to detect this
> particular case.
> 
> Let's redefine arch_irq_work_has_interrupt() to actually check
> if we're IPI capable instead of simply being SMP. This sidesteps
> the issue entierely.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/irq_work.h | 2 +-
>  arch/arm/include/asm/smp_plat.h | 2 ++
>  arch/arm/kernel/smp.c           | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/irq_work.h b/arch/arm/include/asm/irq_work.h
> index 712d03e..025420b 100644
> --- a/arch/arm/include/asm/irq_work.h
> +++ b/arch/arm/include/asm/irq_work.h
> @@ -5,7 +5,7 @@
>  
>  static inline bool arch_irq_work_has_interrupt(void)
>  {
> -	return is_smp();
> +	return !!__smp_cross_call;
>  }
>  
>  #endif /* _ASM_ARM_IRQ_WORK_H */
> diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
> index f908071..ffee073 100644
> --- a/arch/arm/include/asm/smp_plat.h
> +++ b/arch/arm/include/asm/smp_plat.h
> @@ -26,6 +26,8 @@ static inline bool is_smp(void)
>  #endif
>  }
>  
> +extern void (*__smp_cross_call)(const struct cpumask *, unsigned int);
> +
>  /**
>   * smp_cpuid_part() - return part id for a given cpu
>   * @cpu:	logical cpu id.
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 8615216..f9d771f 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -465,7 +465,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	}
>  }
>  
> -static void (*__smp_cross_call)(const struct cpumask *, unsigned int);
> +void (*__smp_cross_call)(const struct cpumask *, unsigned int);
>  
>  void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
>  {
> -- 
> 2.8.1
> 
> Does it work for you? We could then add self-IPI as a further
> optimization.
> 
> Thanks,
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny.

-- 

Best Regards,
Peter Chen
