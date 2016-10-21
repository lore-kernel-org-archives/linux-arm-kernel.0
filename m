From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Oct 2016 16:59:02 +0100
Subject: [PATCH 10/10] arm64: split thread_info from task stack
In-Reply-To: <580A2B3A.7000300@arm.com>
References: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
 <1476904234-9511-11-git-send-email-mark.rutland@arm.com>
 <580A2B3A.7000300@arm.com>
Message-ID: <20161021155701.GA17287@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Fri, Oct 21, 2016 at 03:50:34PM +0100, James Morse wrote:
> >  arch/arm64/kernel/entry.S            |  4 ++--
> 
> 4? That was too easy...

Indeed... ;)

> > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > index 2d4c83b..e781391 100644
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -123,6 +123,7 @@
> >  	 * Set sp_el0 to current thread_info.
> >  	 */
> >  	.if	\el == 0
> > +	ldr_this_cpu	tsk, __entry_task, x21
> >  	msr	sp_el0, tsk
> >  	.endif
> >  
> > @@ -674,8 +675,7 @@ ENTRY(cpu_switch_to)
> >  	ldp	x29, x9, [x8], #16
> >  	ldr	lr, [x8]
> >  	mov	sp, x9
> > -	and	x9, x9, #~(THREAD_SIZE - 1)
> > -	msr	sp_el0, x9
> > +	msr	sp_el0, x1
> >  	ret
> >  ENDPROC(cpu_switch_to)
> >  
> 
> So now tsk is current instead of current_thread_info(), but we still access it
> with TI_* offsets:

Yes; luckily thread_info is the first member of task_struct, so this
works (as offsetof(struct task_struct, thread_info) == 0). The core code
also relies on this, e.g. in <linux/thread_info.h>:

	#ifdef CONFIG_THREAD_INFO_IN_TASK
	#define current_thread_info() ((struct thread_info *)current)
	#endif

... regardless, I should have commented that, mentioned it in the commit
message, and perhaps put a BUILD_BUG_ON()-style assert somewhere. I'll
need to double-check, but IIRC I can't update asm-offsets to base the
TI_* offsets on task_struct without introducing a potential circular
include dependency.

I could at least s/TI_/TSK_/, with a comment.

> The 're-entered irq stack' check is going to need re-thinking:
> entry.S:195
> > 	/*
> > 	 * Compare sp with the current thread_info, if the top
> > 	 * ~(THREAD_SIZE - 1) bits match, we are on a task stack, and
> > 	 * should switch to the irq stack.
> > 	 */
> > 	and	x25, x19, #~(THREAD_SIZE - 1)
> > 	cmp	x25, tsk
> > 	b.ne	9998f
> 
> It was done like this as the irq stack isn't naturally aligned, so this check
> implicitly assumes tsk is on the stack. I will try and come up with an alternative.

Ouch; I clearly didn't vet this thoroughly enough.

If we can corrupt another register here, we can load task_struct::stack
to compare against instead.

> And there are a few other things like this:
> entry.S:431
> > 	ldr	w24, [tsk, #TI_PREEMPT]		// get preempt count
> > 	cbnz	w24, 1f				// preempt count != 0
> > 	ldr	x0, [tsk, #TI_FLAGS]		// get flags
> > 	tbz	x0, #TIF_NEED_RESCHED, 1f	// needs rescheduling?
> > 	bl	el1_preempt
> 
> (It may be worth renaming the register alias 'tsk' as it isn't really a
>  struct_task. This would catch any missed users at build time, including
>  any patches in flight...)

Entertainingly, with these patches 'tsk' *is* task_struct, whereas
before it wasn't. 

> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 2679722..cde25f4 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -149,6 +149,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
> >  	 * We need to tell the secondary core where to find its stack and the
> >  	 * page tables.
> >  	 */
> > +	secondary_data.task = idle;
> >  	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
> >  	update_cpu_boot_status(CPU_MMU_OFF);
> >  	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
> > @@ -173,6 +174,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
> >  		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
> >  	}
> >  
> > +	secondary_data.task = NULL;
> >  	secondary_data.stack = NULL;
> >  	status = READ_ONCE(secondary_data.status);
> >  	if (ret && status) {
> > 
> 
> Nit-territory: Something we should remember is that __entry_task isn't written
> on secondary startup, so its stale (CPU0s idle task) until the first
> __switch_to(). This isn't a problem as its only read on entry from EL0.

Good point. I think I can initialise this in the hotplug path, if
nothing else but to save us any surprises when debugging.

Thanks,
Mark.
