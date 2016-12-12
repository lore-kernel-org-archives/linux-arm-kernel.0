From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 12 Dec 2016 10:35:14 +0000
Subject: [PATCH v4] arm64: fpsimd: improve stacking logic in
 non-interruptible context
In-Reply-To: <CAKv+Gu_VPA81H2-Kr_dyUWMmgqc_DevBYwr4adh+L2nBBqY5yA@mail.gmail.com>
References: <1481301992-2344-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161209182155.GB21051@e104818-lin.cambridge.arm.com>
 <20161209192932.GD1574@e103592.cambridge.arm.com>
 <CAKv+Gu_VPA81H2-Kr_dyUWMmgqc_DevBYwr4adh+L2nBBqY5yA@mail.gmail.com>
Message-ID: <20161212103512.GE1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 08:57:20PM +0000, Ard Biesheuvel wrote:
> On 9 December 2016 at 19:29, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Fri, Dec 09, 2016 at 06:21:55PM +0000, Catalin Marinas wrote:
> >> On Fri, Dec 09, 2016 at 04:46:32PM +0000, Ard Biesheuvel wrote:
> >> >  void kernel_neon_begin_partial(u32 num_regs)
> >> >  {
> >> > -   if (in_interrupt()) {
> >> > -           struct fpsimd_partial_state *s = this_cpu_ptr(
> >> > -                   in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
> >> > +   struct fpsimd_partial_state *s;
> >> > +   int level;
> >> > +
> >> > +   preempt_disable();
> >> > +
> >> > +   level = this_cpu_inc_return(kernel_neon_nesting_level);
> >> > +   BUG_ON(level > 3);
> >> > +
> >> > +   if (level > 1) {
> >> > +           s = this_cpu_ptr(nested_fpsimdstate);
> >> >
> >> > -           BUG_ON(num_regs > 32);
> >> > -           fpsimd_save_partial_state(s, roundup(num_regs, 2));
> >> > +           WARN_ON_ONCE(num_regs > 32);
> >> > +           num_regs = min(roundup(num_regs, 2), 32U);
> >> > +
> >> > +           fpsimd_save_partial_state(&s[level - 2], num_regs);
> >> >     } else {
> >> >             /*
> >> >              * Save the userland FPSIMD state if we have one and if we
> >> > @@ -241,7 +256,6 @@ void kernel_neon_begin_partial(u32 num_regs)
> >> >              * that there is no longer userland FPSIMD state in the
> >> >              * registers.
> >> >              */
> >> > -           preempt_disable();
> >> >             if (current->mm &&
> >> >                 !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
> >> >                     fpsimd_save_state(&current->thread.fpsimd_state);
> >>
> >> I wonder whether we could actually do this saving and flag/level setting
> >> in reverse to simplify the races. Something like your previous patch but
> >> only set TIF_FOREIGN_FPSTATE after saving:
> >>
> >>       level = this_cpu_read(kernel_neon_nesting_level);
> >>       if (level > 0) {
> >>               ...
> >>               fpsimd_save_partial_state();
> >>       } else {
> >>               if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
> >>                       fpsimd_save_state();
> >>               set_thread_flag(TIF_FOREIGN_FPSTATE);
> >>       }
> >>       this_cpu_inc(kernel_neon_nesting_level);
> >>
> >> There is a risk of extra saving if we get an interrupt after
> >> test_thread_flag() and before set_thread_flag() but I don't think this
> >> would corrupt any state, just writing things twice.
> >
> > I would worry that we can save two states over the same buffer and then
> > restore an uninitialised buffer in this case unless we are careful.
> > Because the level-dependent code is now misbracketed by the inc/dec,
> > a preempting call races with the outer call and use the same value.
> >
> > I guess we could do
> >
> > if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
> >         fpsimd_save_state();
> > clear_thread_flag(TIF_FOREIGN_FPSTATE);
> >
> > at the start unconditionally, before the _inc_return().
> >
> > The task state may then get saved in the middle of being saved, but
> > as you say it shouldn't have changed in the meantime.
> 
> It /will/ have changed in the meantime: when the interrupted context
> is resumed, it will happily proceed with saving the state where it
> left off, but now the register file contains whatever was left after
> the interrupt handler is done with the NEON.

Hmmm, true.  The NEON regs will have been restored by kernel_neon_end()
in the inner context, but the extra SVE bits won't have been.

> 
> > The nested
> > save code may then do a partial save of the same state on top of that
> > which could get restored at the inner kernel_neon_end() call.
> >
> 
> I'm afraid the only way to deal with this correctly is to treat the
> whole sequence as a critical section, which means execute it with
> interrupts disabled.

Or we make the KERNEL_MODE_NEON code SVE-aware, which is where I started
off.  In that case, we do SVE (partial) save/restore whenever
kernel_mode_neon() is called with live SVE state.  The change here is
that would we consider that there is always live SVE state until the
fpsimd_save_state() actually finishes at the outer level.  We may want
to delay setting of TIF_FOREIGN_FPSTATE for that purpose.

This means you do take an additional latency hit if you want to use NEON
in an interrupting context and there happens to be live SVE state.  It's
a consequence of the architecture though -- I don't think there's any
way to get around it.  We can still scale the cost by implementing
sve_save_partial_state() or something equivalent.

You original inc()+save() ... restore()+dec() seems sound enough if
viewed this way.  Unless I'm missing something?

Cheers
---Dave
