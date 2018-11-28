From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 28 Nov 2018 10:01:46 +0100
Subject: [PATCH 0/2] arm64: Only call into preempt_schedule() if
 need_resched()
In-Reply-To: <20181128085640.GX2131@hirez.programming.kicks-ass.net>
References: <1543347902-21170-1-git-send-email-will.deacon@arm.com>
 <20181128085640.GX2131@hirez.programming.kicks-ass.net>
Message-ID: <20181128090146.GF2149@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 09:56:40AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 27, 2018 at 07:45:00PM +0000, Will Deacon wrote:
> > Hi all,
> > 
> > This pair of patches improves our preempt_enable() implementation slightly
> > on arm64 by making the resulting call to preempt_schedule() conditional
> > on need_resched(), which is tracked in bit 32 of the preempt count. The
> > logic is inverted so that we can detect the preempt count going to zero
> > and need_resched being set with a single CBZ instruction.
> 
> >   40:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
> >   44:   910003fd        mov     x29, sp
> >   48:   d5384101        mrs     x1, sp_el0
> >   4c:   f9400820        ldr     x0, [x1, #16]
> 
> We load x0 which is a u64, right?
> 
> >   50:   d1000400        sub     x0, x0, #0x1
> >   54:   b9001020        str     w0, [x1, #16]
> 
> But we store w0, which is the low u32, such as to not touch the high
> word which contains the preempt bit.
> 
> >   58:   b4000060        cbz     x0, 64 <will+0x24>
> >   5c:   a8c17bfd        ldp     x29, x30, [sp], #16
> >   60:   d65f03c0        ret
> >   64:   94000000        bl      0 <preempt_schedule>
> >   68:   a8c17bfd        ldp     x29, x30, [sp], #16
> >   6c:   d65f03c0        ret
> 
> Why not?
> 
>    58:   b4000060        cbnz    x0, 60 <will+0x24>
>    5c:   94000000        bl      0 <preempt_schedule>
>    60:   a8c17bfd        ldp     x29, x30, [sp], #16
>    64:   d65f03c0        ret
> 
> which seems shorter.
> 
> 
> So it's still early, and I haven't finished (or really even started) my
> pot 'o tea, but what about:
> 
> 
> 	ldr x0, [x1, #16]	// seees the high bit set -- no preempt needed
> 	sub x0, x0, #1
> 
> 	<interrupt>
> 	  ...
> 	  resched_curr()
> 	    set_tsk_need_resched();
> 	    set_preempt_need_resched();
> 	</interrupt> // sees preempt_count != 0, does not preempt
> 
> 	str w0, [x1, #16] // stores preempt_count == 0
> 	cbnz x0, 1f // taken, we still observe the high word from before
> 
> 1:	ret
> 
> 
> Which then ends with preempt_count==0, need_resched==0 and no actual
> preemption afaict.
> 
> Can you use mis-matched ll x0 / sc w0 to do this same thing and detector
> the intermediate write on the high word?

That is, something along these here lines:

1:	ldxr x0, [x1, #16]
	sub  x0, x0, #1
	stxr w1, w0, [x1, #16]
	cbnz w1, 1b

	cbnz x0, 2f
	bl   preempt_schedule
2:	ret

can that work?
