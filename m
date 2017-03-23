From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 23 Mar 2017 11:59:40 +0000
Subject: [RFC PATCH v2 24/41] arm64/sve: Discard SVE state on system call
In-Reply-To: <20170322170330.GE19950@leverpostej>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <1490194274-30569-25-git-send-email-Dave.Martin@arm.com>
 <20170322170330.GE19950@leverpostej>
Message-ID: <20170323115939.GE3750@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 05:03:30PM +0000, Mark Rutland wrote:
> On Wed, Mar 22, 2017 at 02:50:54PM +0000, Dave Martin wrote:
> > The base procedure call standard for the Scalable Vector Extension
> > defines all of the SVE programmer's model state (Z0-31, P0-15, FFR)
> > as caller-save, except for that subset of the state that aliases
> > FPSIMD state.
> > 
> > System calls from userspace will almost always be made through C
> > library wrappers -- as a consequence of the PCS there will thus
> > rarely if ever be any live SVE state at syscall entry in practice.
> > 
> > This gives us an opportinity to make SVE explicitly caller-save
> > around SVC and so stop carrying around the SVE state for tasks that
> > use SVE only occasionally (say, by calling a library).
> > 
> > Note that FPSIMD state will still be preserved around SVC.
> > 
> > As a crude heuristic to avoid pathological cases where a thread
> > that uses SVE frequently has to fault back into the kernel again to
> > re-enable SVE after a syscall, we switch the thread back to
> > FPSIMD-only context tracking only if the context is actually
> > switched out before returning to userspace.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/kernel/fpsimd.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > index 5fb5585..8c18384 100644
> > --- a/arch/arm64/kernel/fpsimd.c
> > +++ b/arch/arm64/kernel/fpsimd.c
> > @@ -250,6 +250,23 @@ static void task_fpsimd_save(struct task_struct *task)
> >  	BUG_ON(task != current);
> >  
> >  	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
> > +	    task_pt_regs(task)->syscallno != ~0UL &&

^ I may add a helper for this occult check (since it duplicated
elsewhere), but...

> > +	    test_tsk_thread_flag(task, TIF_SVE)) {
> > +		unsigned long tmp;
> > +
> > +		clear_tsk_thread_flag(task, TIF_SVE);
> > +
> > +		/* Trap if the task tries to use SVE again: */
> > +		asm volatile (
> > +			"mrs	%[tmp], cpacr_el1\n\t"
> > +			"bic	%[tmp], %[tmp], %[mask]\n\t"
> > +			"msr	cpacr_el1, %[tmp]"
> > +			: [tmp] "=r" (tmp)
> > +			: [mask] "i" (CPACR_EL1_ZEN_EL0EN)
> > +		);
> 
> Given we're poking this bit in a few places, I think it would make more
> sense to add enable/disable helpers. Those can also subsume the lazy
> writeback used for the context switch, e.g.
> 
> static inline void sve_el0_enable(void)
> }
> 	unsigned long cpacr = read_sysreg(cpacr_el1);
> 	if ((cpacr & CPACR_EL1_ZEN_EL0EN)
> 		return;
> 
> 	cpacr |= CPACR_EL1_ZEN_EL0EN;
> 	write_sysreg(cpacr, cpacr_el1);
> }
> 
> static inline void sve_el0_disable(void)
> {
> 	unsigned long cpacr = read_sysreg(cpacr_el1);
> 	if (!(cpacr & CPACR_EL1_ZEN_EL0EN)
> 		return;
> 
> 	cpacr &= ~CPACR_EL1_ZEN_EL0EN;
> 	write_sysreg(cpacr, cpacr_el1);
> }

... although this makes sense and I did consider it, instead I ended up
consolidating this in one place in task_fpsimd_load().   ret_to_user is
the only time we care about what EL0EN is set to, and task_fpsimd_load
is only used on that path.

With it in one place, abstraction seemed less necessary -- but I'll
still clean up the asm hacks as you suggest.

Cheers
---Dave
