From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 9 Aug 2016 17:39:42 +0800
Subject: [PATCH 1/1] irqchip: irq-gic: forward SGI to itself for
 cortex-a7 single core
In-Reply-To: <57A99A4A.6010301@arm.com>
References: <20160808130754.GB12649@leverpostej>
 <20160808132847.GB17680@shlinux2>
 <20160808134842.GE12649@leverpostej>
 <20160808145916.0924e868@arm.com> <20160809034613.GB31105@shlinux2>
 <20160809063401.3117dc94@arm.com> <20160809055701.GC31105@shlinux2>
 <20160809075930.529f98ca@arm.com> <20160809071821.GD31105@shlinux2>
 <57A99A4A.6010301@arm.com>
Message-ID: <20160809093942.GA10803@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 09:54:34AM +0100, Marc Zyngier wrote:
> On 09/08/16 08:18, Peter Chen wrote:
> > On Tue, Aug 09, 2016 at 07:59:30AM +0100, Marc Zyngier wrote:
> >> On Tue, 9 Aug 2016 13:57:01 +0800
> >> Peter Chen <hzpeterchen@gmail.com> wrote:
> >>
> >>> On Tue, Aug 09, 2016 at 06:34:01AM +0100, Marc Zyngier wrote:
> >>>> On Tue, 9 Aug 2016 11:46:13 +0800
> >>>> Peter Chen <hzpeterchen@gmail.com> wrote:
> >>>>   
> >>>>> On Mon, Aug 08, 2016 at 02:59:16PM +0100, Marc Zyngier wrote:  
> >>>>>> On Mon, 8 Aug 2016 14:48:42 +0100
> >>>>>> Mark Rutland <mark.rutland@arm.com> wrote:
> >>>>>>     
> >>>>>>> On Mon, Aug 08, 2016 at 09:28:47PM +0800, Peter Chen wrote:    
> >>>>>>>> On Mon, Aug 08, 2016 at 02:07:54PM +0100, Mark Rutland wrote:      
> >>>>>>>>> I see that for arm64 we have:
> >>>>>>>>>
> >>>>>>>>> static inline bool arch_irq_work_has_interrupt(void)
> >>>>>>>>> {
> >>>>>>>>> 	return !!__smp_cross_call;
> >>>>>>>>> }
> >>>>>>>>>
> >>>>>>>>> Could we do similarly for ARM, and ony register gic_raise_softirq if
> >>>>>>>>> we have non-zero SGI targets?
> >>>>>>>>>
> >>>>>>>>> If I've understood correctly, that would make things behave as they do
> >>>>>>>>> for UP on you system.      
> >>>>>>>
> >>>>>>> [...]
> >>>>>>>     
> >>>>>>>>> If self-IPI is necessary, then this would be up to the GIC code to
> >>>>>>>>> solve.
> >>>>>>>>>
> >>>>>>>>> For that case, it would be nicer if we could detect whether this was
> >>>>>>>>> necessary based on the GIC registers alone. That way we handle the
> >>>>>>>>> various ways this can be integrated, aren't totally relient on the DT,
> >>>>>>>>> work in VMs, etc.      
> >>>>>>>>
> >>>>>>>> How we can detect IPI capabilities based on GIC register?      
> >>>>>>>
> >>>>>>> Check the mask associated with SGIs, as we do for gic_get_cpumask(). If
> >>>>>>> this is zero, we have a non-multiprocessor GIC (or one that's otherwise
> >>>>>>> broken), and can't do SGI in the usual way.
> >>>>>>>
> >>>>>>> However, it only makes sense to do this if self-IPI is truly a
> >>>>>>> necessity. Given there are other interrupt controllers that can't do
> >>>>>>> self-IPI, avoiding self-IPI in general would be a better strategy,
> >>>>>>> avoiding churn in each and every driver...    
> >>>>>>
> >>>>>> Indeed. And I won't take such a patch until all other avenues have been
> >>>>>> explored, including fixing core code if required...
> >>>>>>     
> >>>>>
> >>>>> Ok, it seems both you and Mark agree with disable IPI for GIC who has only
> >>>>> self-IPI capability (GICD_ITARGETSR0 to GICD_ITARGETSR7 are all
> >>>>> zero), right?  
> >>>>
> >>>> Not necessarily. This can be seen a latency improvement, compared to
> >>>> the timer method which should be the fallback.
> >>>>   
> >>>
> >>> Why? Your below patch (I tried too) just fixes NULL pointer issue for
> >>
> >> And that's the first issue to solve.
> >>
> >>> without define smp_cross_call function. But imx6ul is a SMP platform
> >>
> >> It is *not* an SMP platform. It may have a SMP-capable core, but that's
> >> about it.
> >>
> > 
> > Well. That's what I thought at the beginning, but the kernel
> > takes it is. At __fixup_smp (arch/arm/kernel/head.S), it only checks
> > MPIDR, for MPcore, it is 0x80000000, it means it is Multiprocessing
> > Extensions and Processor is part of a multiprocessor system.
> 
> If it is a multi-processor system, please show me the second core.
> If you can't, this is a UP system, end of story. It may have the MP
> extensions (there is no such thing as a non-MP A7), but that doesn't
> make it an SMP system. Please don't confuse the two things.
> 

> 
> Again, you're confusing MP-capable with SMP. Yes, the kernel tends to 
> confuse the two as well because it is not always easy to tell them 
> apart (as you just found). That doesn't mean we can't do a better job 
> separating the two concepts when we have the right level of information
> (i.e. we know the topology of the system).
> 

Thanks, you are right, from hardware level, it is UP system.

> > 
> >>> Besides, if the hardware has IPI capability, but we just disable it
> >>> to align with UP platforms, is it reasonable?
> >>
> >> Again: having a self-IPI on UP is an optimization. Nothing more.
> >>
> >> Now, coming back to your original idea, I'm aiming towards something
> >> like this:
> >>
> > 
> > Your below patch can work (tested), but why not registering an self-IPI
> > smp_cross_call function for single core, it can avoid judging in code
> > for each IPI calls.
> 
> Because it is an unnecessary complication. If you can demonstrate that 
> this single test is an overhead, then I'll consider making this a 
> separate function. Also, we can  move the test out of the lock that protects
> the CPU map as, by definition, there is nothing to protect, making it even
> more lightweight than your own approach:

Your patch can work for my case. Below is objdump for gic_raise_softirq,
the code with your patch seems have more instructions.

- With your patch:
00000c44 <gic_raise_softirq>:
     c44:	e1a0c00d 	mov	ip, sp
     c48:	e92ddbf0 	push	{r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
     c4c:	e24cb004 	sub	fp, ip, #4
     c50:	e59f908c 	ldr	r9, [pc, #140]	; ce4 <gic_raise_softirq+0xa0>
     c54:	e1a06000 	mov	r6, r0
     c58:	e1a07001 	mov	r7, r1
     c5c:	e5993000 	ldr	r3, [r9]
     c60:	e3530001 	cmp	r3, #1
     c64:	0a000019 	beq	cd0 <gic_raise_softirq+0x8c>
     c68:	e59f0078 	ldr	r0, [pc, #120]	; ce8 <gic_raise_softirq+0xa4>
     c6c:	ebfffffe 	bl	0 <_raw_spin_lock_irqsave>
     c70:	e3a04000 	mov	r4, #0
     c74:	e59f5070 	ldr	r5, [pc, #112]	; cec <gic_raise_softirq+0xa8>
     c78:	e1a08000 	mov	r8, r0
     c7c:	e3e00000 	mvn	r0, #0
     c80:	ea000001 	b	c8c <gic_raise_softirq+0x48>
     c84:	e5d236ac 	ldrb	r3, [r2, #1708]	; 0x6ac
     c88:	e1844003 	orr	r4, r4, r3
     c8c:	e2802001 	add	r2, r0, #1
     c90:	e3a01004 	mov	r1, #4
     c94:	e1a00006 	mov	r0, r6
     c98:	ebfffffe 	bl	0 <_find_next_bit_le>
     c9c:	e5993000 	ldr	r3, [r9]
     ca0:	e1530000 	cmp	r3, r0
     ca4:	e0852000 	add	r2, r5, r0
     ca8:	cafffff5 	bgt	c84 <gic_raise_softirq+0x40>
     cac:	e3a03000 	mov	r3, #0
     cb0:	ee073fba 	mcr	15, 0, r3, cr7, cr10, {5}
     cb4:	e1874804 	orr	r4, r7, r4, lsl #16
     cb8:	e5953088 	ldr	r3, [r5, #136]	; 0x88
     cbc:	e5834f00 	str	r4, [r3, #3840]	; 0xf00
     cc0:	e59f0020 	ldr	r0, [pc, #32]	; ce8 <gic_raise_softirq+0xa4>
     cc4:	e1a01008 	mov	r1, r8
     cc8:	ebfffffe 	bl	0 <_raw_spin_unlock_irqrestore>
     ccc:	e89dabf0 	ldm	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
     cd0:	e59f3014 	ldr	r3, [pc, #20]	; cec <gic_raise_softirq+0xa8>
     cd4:	e3817402 	orr	r7, r1, #33554432	; 0x2000000
     cd8:	e5933088 	ldr	r3, [r3, #136]	; 0x88
     cdc:	e5837f00 	str	r7, [r3, #3840]	; 0xf00
     ce0:	e89dabf0 	ldm	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
     ce4:	00000000 	.word	0x00000000
     ce8:	00000004 	.word	0x00000004
     cec:	00000000 	.word	0x00000000

- The current code
00000468 <gic_raise_softirq>:
     468:	e1a0c00d 	mov	ip, sp
     46c:	e92ddbf0 	push	{r4, r5, r6, r7, r8, r9, fp, ip, lr, pc}
     470:	e24cb004 	sub	fp, ip, #4
     474:	e1a06000 	mov	r6, r0
     478:	e59f0068 	ldr	r0, [pc, #104]	; 4e8 <gic_raise_softirq+0x80>
     47c:	e1a07001 	mov	r7, r1
     480:	ebfffffe 	bl	0 <_raw_spin_lock_irqsave>
     484:	e3a04000 	mov	r4, #0
     488:	e59f505c 	ldr	r5, [pc, #92]	; 4ec <gic_raise_softirq+0x84>
     48c:	e59f905c 	ldr	r9, [pc, #92]	; 4f0 <gic_raise_softirq+0x88>
     490:	e1a08000 	mov	r8, r0
     494:	e3e00000 	mvn	r0, #0
     498:	ea000001 	b	4a4 <gic_raise_softirq+0x3c>
     49c:	e5d236ac 	ldrb	r3, [r2, #1708]	; 0x6ac
     4a0:	e1844003 	orr	r4, r4, r3
     4a4:	e2802001 	add	r2, r0, #1
     4a8:	e3a01004 	mov	r1, #4
     4ac:	e1a00006 	mov	r0, r6
     4b0:	ebfffffe 	bl	0 <_find_next_bit_le>
     4b4:	e5993000 	ldr	r3, [r9]
     4b8:	e1500003 	cmp	r0, r3
     4bc:	e0852000 	add	r2, r5, r0
     4c0:	bafffff5 	blt	49c <gic_raise_softirq+0x34>
     4c4:	e3a03000 	mov	r3, #0
     4c8:	ee073fba 	mcr	15, 0, r3, cr7, cr10, {5}
     4cc:	e1874804 	orr	r4, r7, r4, lsl #16
     4d0:	e5953088 	ldr	r3, [r5, #136]	; 0x88
     4d4:	e5834f00 	str	r4, [r3, #3840]	; 0xf00
     4d8:	e59f0008 	ldr	r0, [pc, #8]	; 4e8 <gic_raise_softirq+0x80>
     4dc:	e1a01008 	mov	r1, r8
     4e0:	ebfffffe 	bl	0 <_raw_spin_unlock_irqrestore>
     4e4:	e89dabf0 	ldm	sp, {r4, r5, r6, r7, r8, r9, fp, sp, pc}
     4e8:	00000004 	.word	0x00000004

> 
> From 23ba8b645d219e333a10224d74fb5d8d75d67de2 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <marc.zyngier@arm.com>
> Date: Tue, 9 Aug 2016 07:50:44 +0100
> Subject: [PATCH] irqchip/gic: Allow self-SGIs for SMP on UP configurations
> 
> On systems where a single CPU is present, the GIC may not support
> having SGIs delivered to a target list. In that case, we use the
> self-SGI mechanism to allow the interrupt to be delivered locally.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-gic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index c2cab57..390fac5 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -769,6 +769,13 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  	int cpu;
>  	unsigned long flags, map = 0;
>  
> +	if (unlikely(nr_cpu_ids == 1)) {
> +		/* Only one CPU? let's do a self-IPI... */
> +		writel_relaxed(2 << 24 | irq,
> +			       gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> +		return;
> +	}
> +
>  	raw_spin_lock_irqsave(&irq_controller_lock, flags);
>  
>  	/* Convert our logical CPU mask into a physical one. */
> 
> Also, your patch seems to break the arm64 ACPI support by moving the SMP
> setup to a DT-specific function (I don't see why this should be DT only
> anyway).
> 

Sorry, I don't know the code well.

-- 

Best Regards,
Peter Chen
