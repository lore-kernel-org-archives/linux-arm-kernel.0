From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 10 Feb 2016 12:31:10 +0000
Subject: [PATCH] arm64: Rework valid_user_regs
In-Reply-To: <20160210115853.GG1052@arm.com>
References: <1455041501-30018-1-git-send-email-mark.rutland@arm.com>
 <20160210115853.GG1052@arm.com>
Message-ID: <20160210123110.GD2632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 11:58:53AM +0000, Will Deacon wrote:
> Hi Mark,
> 
> On Tue, Feb 09, 2016 at 06:11:41PM +0000, Mark Rutland wrote:
> > +/*
> > + * Bits which are architecturally RES0 per ARM DDI 0487A.h
> > + * The kernel matches the HW policy. Userspace cannot use these until they have
> > + * an architectural meaning.
> > + */
> > +#define SPSR_EL1_AARCH64_RES0_BITS \
> > +	(GENMASK_ULL(63,32) | GENMASK_ULL(27, 22) | GENMASK_ULL(19, 10) | \
> > +	 GENMASK_ULL(5, 5))
> > +#define SPSR_EL1_AARCH32_RES0_BITS \
> > +	(GENMASK_ULL(63,32) | (GENMASK_ULL(23, 22)))
> 
> The J bit (24) is also RES0 and the E bit (9) can be RES0/RES1 depending
> on what the CPU supports.

>From a quick look, J is always RES0 for ARMv8. I'll add that to the
mask.

E is a bit more complex; I'll see about handling that dynamically in
valid_compat_user_regs.

> It also might be worth negating these in the definition, rather than
> on every use.

Does that make anything clearer? They're constants which get used once
each, and SPSR_EL1_AARCH*_MASK wouldn't make it clear what the bits
actually are.

If you have a better suggestion for a name I'm happy to change it.

> > +static int valid_aa32_regs(struct user_pt_regs *regs)
> 
> valid_compat_user_regs

Ok

> > +static int valid_aa64_regs(struct user_pt_regs *regs)
> 
> valid_native_user_regs

Ok.

> > +{
> > +	regs->pstate &= ~SPSR_EL1_AARCH64_RES0_BITS;
> > +
> > +	if (user_mode(regs) && !(regs->pstate & PSR_MODE32_BIT) &&
> > +	    (regs->pstate & PSR_D_BIT) == 0 &&
> > +	    (regs->pstate & PSR_A_BIT) == 0 &&
> > +	    (regs->pstate & PSR_I_BIT) == 0 &&
> > +	    (regs->pstate & PSR_F_BIT) == 0) {
> > +		return 1;
> > +	}
> 
> I think we should err on the side of caution and nuke SS and IL for both
> native and compat too, although that seems a odds with the PSR_s mask.
> I wonder how relevant those PSR groups are in ARMv8...

Ok.

I couldn't spot anything in the ARM ARM regarding PSR bit groups,; I was
cargo-culting from the existing code. I'm more than happy to make the
PSR_* groups an aarch32/compat thing.

> > +int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task)
> > +{
> > +	if (is_compat_thread(task_thread_info(task)))
> 
> is_compat_task

Can't do; is_compat_task() takes no task_struct and assumes we're asking
about current (which doesn't work for the ptrace cases).

We could add a new helper for this, but I think that should be future
cleanup as we'd want to alter the other uses:

[mark at leverpostej:~/src/linux]% git grep is_compat_thread origin/master
origin/master:arch/arm64/include/asm/compat.h:static inline int is_compat_thread(struct thread_info *thread)
origin/master:arch/arm64/include/asm/compat.h:static inline int is_compat_thread(struct thread_info *thread)
origin/master:arch/arm64/include/asm/processor.h:       if (is_compat_thread(task_thread_info(t)))                      \
origin/master:arch/arm64/kernel/hw_breakpoint.c:        return tsk && is_compat_thread(task_thread_info(tsk));
origin/master:arch/arm64/kernel/perf_regs.c:    if (is_compat_thread(task_thread_info(task)))
origin/master:arch/arm64/kernel/process.c:                      if (is_compat_thread(task_thread_info(p)))
origin/master:arch/arm64/kernel/process.c:      tpidrro = is_compat_thread(task_thread_info(next)) ?
origin/master:arch/arm64/kernel/ptrace.c:       else if (is_compat_thread(task_thread_info(task)))

I'm happy to look at cleaning that up as a later patch/series.

Thanks,
Mark.
