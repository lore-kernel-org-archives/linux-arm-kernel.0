From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 23 Mar 2017 11:24:05 +0000
Subject: [RFC PATCH v2 21/41] arm64/sve: Enable SVE on demand for userspace
In-Reply-To: <20170322164809.GC19950@leverpostej>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <1490194274-30569-22-git-send-email-Dave.Martin@arm.com>
 <20170322164809.GC19950@leverpostej>
Message-ID: <20170323112404.GC3750@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 04:48:10PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Wed, Mar 22, 2017 at 02:50:51PM +0000, Dave Martin wrote:
> > This patch tracks whether a task has ever attempted to use the
> > Scalable Vector Extension.  If and only if SVE is in use by a task,
> > it will be enabled for userspace when scheduling the task in.  For
> > other tasks, SVE is disabled when scheduling in.
> 
> >  #define TIF_SYSCALL_AUDIT	9
> >  #define TIF_SYSCALL_TRACEPOINT	10
> >  #define TIF_SECCOMP		11
> > +#define TIF_SVE			17	/* Scalable Vector Extension in use */
> 
> Please don't skip ahead to bit 17. I see why you're doing that, but I
> don't think that's a good idea. More on that below.

Well, a comment here to explain the dependency would have been a good
idea, but I agree it's better to drop this trickery...

> > +void do_sve_acc(unsigned int esr, struct pt_regs *regs)
> > +{
> > +	unsigned long tmp;
> > +
> > +	if (test_and_set_thread_flag(TIF_SVE))
> > +		BUG();
> > +
> > +	asm ("mrs %0, cpacr_el1" : "=r" (tmp));
> > +	asm volatile ("msr cpacr_el1, %0" :: "r" (tmp | (1 << 17)));
> 
> Please de-magic the number, e.g. with something like:
> 
> #define CPACR_SVE_EN	(1 << 17)
> 
> ... in <asm/sysreg.h>.
> 
> Please also use {read,write}_sysreg(), e.g.

TBH, I was confused about the status of these macros at the time I
wrote this code.

The naming clash with the cpufeature functions is unfortunate.  In my
head these names all became associated with "do something behind the
scenes that may or may not really read the underlying system reg".

Would it be reasonable to rename read_system_reg() to something more
different, like read_kernel_sysreg(), read_system_id(),
read_sanitised_id_reg(), etc.?

The purpose of these functions is very different: in the
read_system_reg() case we aren't reading an architectural system reg,
but something invented by Linux that is derived from, but semantically
different from, what the architecture specifies.

Happy to propose a patch (though I'll decouple it from this series).


For this code, I'm not a strong believer in hiding asms just for the
sake of it.

But in this case I agree that read_sysreg() would make the code more
readable and get rid of some cruft.  The code I wrote here, and the
TIF_SVE encoding trick, are needlessly obscure and could certainly use a
cleanup, so

> 
> 	val = read_sysreg(cpacr_el1);
> 	tmp |= CPACR_SVE_EN;
> 	write_sysreg(tmp, cpacr_el1);
> 
> [...]
> 
> > +		if (IS_ENABLED(CONFIG_ARM64_SVE)) {
> > +			/*
> > +			 * Flip SVE enable for userspace if it doesn't
> > +			 * match the current_task.
> > +			 */
> > +			asm ("mrs %0, cpacr_el1" : "=r" (tmp));
> > +			flags = current_thread_info()->flags;
> > +			if ((tmp ^ (unsigned long)flags) & (1 << 17)) {
> > +				tmp ^= 1 << 17;
> > +				asm volatile ("msr cpacr_el1, %0" :: "r" (tmp));
> > +			}
> 
> I think it's a bad idea to rely on the TIF flag and CPACR bit to have
> the same index. It makes this painful to read, and it leaves us fragile
> if the TIF bits are reorganised.
> 
> How about:
> 
> 	unsigned long cpacr = read_sysreg(cpacr_el1);
> 	bool hw_enabled = !!(cpacr & CPACR_SVE_EN);
> 	bool sw_enabled = test_thread_flag(TIF_SVE);
> 
> 	/*
> 	 * Flip SVE enable for userspace if it doesn't
> 	 * match the current_task.
> 	 */
> 	if (hw_enabled != sw_enabled) {
> 		cpacr ^= CPACR_SVE_EN;
> 		write_sysreg(cpacr, cpacr_el1);
> 	}

... I'm happy to clean things up along these lines.

I will probably ditch the ^ here (another obscurism) too in favour of
|.  CPACR_EL1_ZEN_EL0EN clear is a precondition for this code, without
which we won't take the trap, and it needs to be _set_ on return, not
just different from the initial value.

Cheers
---Dave
