From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 9 Dec 2016 19:29:32 +0000
Subject: [PATCH v4] arm64: fpsimd: improve stacking logic in
 non-interruptible context
In-Reply-To: <20161209182155.GB21051@e104818-lin.cambridge.arm.com>
References: <1481301992-2344-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161209182155.GB21051@e104818-lin.cambridge.arm.com>
Message-ID: <20161209192932.GD1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 06:21:55PM +0000, Catalin Marinas wrote:
> On Fri, Dec 09, 2016 at 04:46:32PM +0000, Ard Biesheuvel wrote:
> >  void kernel_neon_begin_partial(u32 num_regs)
> >  {
> > -	if (in_interrupt()) {
> > -		struct fpsimd_partial_state *s = this_cpu_ptr(
> > -			in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
> > +	struct fpsimd_partial_state *s;
> > +	int level;
> > +
> > +	preempt_disable();
> > +
> > +	level = this_cpu_inc_return(kernel_neon_nesting_level);
> > +	BUG_ON(level > 3);
> > +
> > +	if (level > 1) {
> > +		s = this_cpu_ptr(nested_fpsimdstate);
> >  
> > -		BUG_ON(num_regs > 32);
> > -		fpsimd_save_partial_state(s, roundup(num_regs, 2));
> > +		WARN_ON_ONCE(num_regs > 32);
> > +		num_regs = min(roundup(num_regs, 2), 32U);
> > +
> > +		fpsimd_save_partial_state(&s[level - 2], num_regs);
> >  	} else {
> >  		/*
> >  		 * Save the userland FPSIMD state if we have one and if we
> > @@ -241,7 +256,6 @@ void kernel_neon_begin_partial(u32 num_regs)
> >  		 * that there is no longer userland FPSIMD state in the
> >  		 * registers.
> >  		 */
> > -		preempt_disable();
> >  		if (current->mm &&
> >  		    !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
> >  			fpsimd_save_state(&current->thread.fpsimd_state);
> 
> I wonder whether we could actually do this saving and flag/level setting
> in reverse to simplify the races. Something like your previous patch but
> only set TIF_FOREIGN_FPSTATE after saving:
> 
> 	level = this_cpu_read(kernel_neon_nesting_level);
> 	if (level > 0) {
> 		...
> 		fpsimd_save_partial_state();
> 	} else {
> 		if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
> 			fpsimd_save_state();
> 		set_thread_flag(TIF_FOREIGN_FPSTATE);
> 	}
> 	this_cpu_inc(kernel_neon_nesting_level);
> 
> There is a risk of extra saving if we get an interrupt after
> test_thread_flag() and before set_thread_flag() but I don't think this
> would corrupt any state, just writing things twice.

I would worry that we can save two states over the same buffer and then
restore an uninitialised buffer in this case unless we are careful.
Because the level-dependent code is now misbracketed by the inc/dec,
a preempting call races with the outer call and use the same value.

I guess we could do

if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
	fpsimd_save_state();
clear_thread_flag(TIF_FOREIGN_FPSTATE);

at the start unconditionally, before the _inc_return().

The task state may then get saved in the middle of being saved, but
as you say it shouldn't have changed in the meantime.  The nested
save code may then do a partial save of the same state on top of that
which could get restored at the inner kernel_neon_end() call.

> (disclaimer: I haven't thought of all the possible races and I'm not
> entirely sure about the kernel_neon_end() part)

Cheers
---Dave
