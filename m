From: gdavis@mvista.com (George G. Davis)
Date: Tue, 18 Oct 2011 19:29:37 -0400
Subject: [RFC/PATCH v4 7/7] ARM: ARM11 MPCore: cpu_v6_set_pte_ext is not
	preempt safe
In-Reply-To: <alpine.LFD.2.02.1110181732100.17040@xanadu.home>
References: <1318004800-6525-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-8-git-send-email-gdavis@mvista.com>
	<alpine.LFD.2.02.1110181732100.17040@xanadu.home>
Message-ID: <20111018232937.GB237@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 05:52:37PM -0400, Nicolas Pitre wrote:
> On Tue, 18 Oct 2011, gdavis at mvista.com wrote:
> 
> > @@ -122,7 +122,22 @@ ENTRY(cpu_v6_switch_mm)
> >  
> >  ENTRY(cpu_v6_set_pte_ext)
> >  #ifdef CONFIG_MMU
> > +#if	defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
> > +	stmdb	sp!, {r4, r5}
> > +	get_thread_info r5
> > +	ldr	r4, [r5, #TI_PREEMPT]	@ get preempt count
> > +	add	r3, r4, #1		@ increment it
> > +	str	r3, [r5, #TI_PREEMPT]	@ disable preempt
> > +#endif
> >  	armv6_set_pte_ext cpu_v6
> > +#if	defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
> > +	str	r4, [r5, #TI_PREEMPT]	@ restore preempt count
> > +	teq	r4, #0			@ preempt count == 0?
> > +	ldreq	r4, [r5, #TI_FLAGS]	@ load flags if yes
> > +	tst	r4, #_TIF_NEED_RESCHED	@ need resched?
> > +	ldmia	sp!, {r4, r5}
> > +	bne	preempt_schedule	@ ret via preempt_schedule
> > +#endif
> 
> Same issue as previous patch.

Same mistake, I second guessed myself and removed the movne r4, #0
before submitting.  : /

> Wouldn't it be better if you disabled interrupts around the small 
> critical region within armv6_set_pte_ext instead?  That would certainly 
> be a lighter solution.  Something like:
> 
> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index 307a4def8d..9bc2dbfe4e 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -167,8 +167,11 @@
>  	tstne	r1, #L_PTE_PRESENT
>  	moveq	r3, #0
>  
> +	mrs	r2, cpsr
> +	cpsid	i
>  	str	r3, [r0]
>  	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
> +	msr	cpsr_c, r2
>  	.endm

I do like this better, less overhead than the preempt_{disable,enable}
case.

Thanks!

--
Regards,
George

> 
> 
> Nicolas
