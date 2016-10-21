From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Oct 2016 18:27:05 +0100
Subject: [PATCH 10/10] arm64: split thread_info from task stack
In-Reply-To: <20161021155701.GA17287@leverpostej>
References: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
 <1476904234-9511-11-git-send-email-mark.rutland@arm.com>
 <580A2B3A.7000300@arm.com> <20161021155701.GA17287@leverpostej>
Message-ID: <20161021172705.GC17287@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 04:59:02PM +0100, Mark Rutland wrote:
> On Fri, Oct 21, 2016 at 03:50:34PM +0100, James Morse wrote:
 
> > So now tsk is current instead of current_thread_info(), but we still access it
> > with TI_* offsets:

> I'll need to double-check, but IIRC I can't update asm-offsets to base
> the TI_* offsets on task_struct without introducing a potential
> circular include dependency.

I was mistaken; asm-offsets.c already includes <linux/sched.h>. I've
given TSK_ prefixes to everything using tsk as a base.

> > The 're-entered irq stack' check is going to need re-thinking:
> > entry.S:195
> > > 	/*
> > > 	 * Compare sp with the current thread_info, if the top
> > > 	 * ~(THREAD_SIZE - 1) bits match, we are on a task stack, and
> > > 	 * should switch to the irq stack.
> > > 	 */
> > > 	and	x25, x19, #~(THREAD_SIZE - 1)
> > > 	cmp	x25, tsk
> > > 	b.ne	9998f
> > 
> > It was done like this as the irq stack isn't naturally aligned, so this check
> > implicitly assumes tsk is on the stack. I will try and come up with an alternative.

I've changed this to:

	/*
	 * Compare sp with the task stack base. If the top ~(THREAD_SIZE - 1)
	 * bits match, we are on a task stack, and should switch to the irq
	 * stack.
	 */
	ldr	x25, [tsk, TSK_STACK]
	eor	x25, x19
	and	x25, x25, #~(THREAD_SIZE - 1)
	cbnz	x25, 9998f

Where TSK_STACK is generated with asm-offsets.c:

	DEFINE(TSK_STACK,	offsetof(struct task_struct, stack));

[...]

> > Nit-territory: Something we should remember is that __entry_task isn't written
> > on secondary startup, so its stale (CPU0s idle task) until the first
> > __switch_to(). This isn't a problem as its only read on entry from EL0.
> 
> Good point. I think I can initialise this in the hotplug path, if
> nothing else but to save us any surprises when debugging.

... thinking about it some more, that requires defining __entry_task in
a header, and spreading it around. Instead, I've made the comment more
explicit regarding the __switch_to() requirement.

Thanks,
Mark.
