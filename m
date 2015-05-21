From: anders.roxell@gmail.com (Anders Roxell)
Date: Thu, 21 May 2015 15:50:07 +0200
Subject: [PATCH] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
In-Reply-To: <CAPyr0yJSGqvxkUWLtNKe0q5mNanBczAfAVx0tPKuzYeDG+eJ=Q@mail.gmail.com>
References: <CAPyr0yJSGqvxkUWLtNKe0q5mNanBczAfAVx0tPKuzYeDG+eJ=Q@mail.gmail.com>
Message-ID: <20150521135007.GC3983@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-01 20:59, Ayyappa Ch wrote:
> Floating point operations in arm64 should not disable preempt .
> Activating realtime features with below code.

I've talked with an engineer who worked on fpsimd and I was told that
replacing preempt_disable with migrate_disable would leave fpsimd open
to corruption.

The kernel won't save the state of the simd registers when it is
preempted so if another task runs on the same CPU and also uses simd, it
clobbers the registers of the first task, and migrate_disable() does not
prevent that.

If we want to use SIMD with preemption enabled, we need to update the
context switch code to do a full SIMD register state save&restore if
necessary. However, this can have a noticeable cost in all task switch
latencies.

Cheers,
Anders

> 
> From e6a5fce9b3b55f48656240036a9354a0997c2907 Mon Sep 17 00:00:00 2001
> From: Ayyappa Ch <ayyappa.chandolu@amd.com>
> Date: Tue, 28 Apr 2015 11:53:00 +0530
> Subject: [PATCH ] floating point realtime fix
> 
> ---
>  arch/arm64/kernel/fpsimd.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 2438497..3dca156 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -166,10 +166,10 @@ void fpsimd_flush_thread(void)
>   */
>  void fpsimd_preserve_current_state(void)
>  {
> - preempt_disable();
> + migrate_disable();
>   if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
>   fpsimd_save_state(&current->thread.fpsimd_state);
> - preempt_enable();
> + migrate_enable();
>  }
> 
>  /*
> @@ -179,7 +179,7 @@ void fpsimd_preserve_current_state(void)
>   */
>  void fpsimd_restore_current_state(void)
>  {
> - preempt_disable();
> + migrate_disable();
>   if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
>   struct fpsimd_state *st = &current->thread.fpsimd_state;
> 
> @@ -187,7 +187,7 @@ void fpsimd_restore_current_state(void)
>   this_cpu_write(fpsimd_last_state, st);
>   st->cpu = smp_processor_id();
>   }
> - preempt_enable();
> + migrate_enable();
>  }
> 
>  /*
> @@ -197,7 +197,7 @@ void fpsimd_restore_current_state(void)
>   */
>  void fpsimd_update_current_state(struct fpsimd_state *state)
>  {
> - preempt_disable();
> + migrate_disable();
>   fpsimd_load_state(state);
>   if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
>   struct fpsimd_state *st = &current->thread.fpsimd_state;
> @@ -205,7 +205,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
>   this_cpu_write(fpsimd_last_state, st);
>   st->cpu = smp_processor_id();
>   }
> - preempt_enable();
> + migrate_enable();
>  }
> 
>  /*
> @@ -239,7 +239,7 @@ void kernel_neon_begin_partial(u32 num_regs)
>   * that there is no longer userland FPSIMD state in the
>   * registers.
>   */
> - preempt_disable();
> + migrate_disable();
>   if (current->mm &&
>      !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
>   fpsimd_save_state(&current->thread.fpsimd_state);
> @@ -255,7 +255,7 @@ void kernel_neon_end(void)
>   in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
>   fpsimd_load_partial_state(s);
>   } else {
> - preempt_enable();
> + migrate_enable();
>   }
>  }
>  EXPORT_SYMBOL(kernel_neon_end);
> 
> On Fri, May 1, 2015 at 1:03 PM, Ayyappa Ch <ayyappa.ch.linux@gmail.com> wrote:
> > Following Anders Roxell  patch on "Enable PREEMPT_RT_FULL" , observed
> > one issue with Cyclic test while running floating point operations. So
> > , modified below changes for that.
> >
> > From e6a5fce9b3b55f48656240036a9354a0997c2907 Mon Sep 17 00:00:00 2001
> > From: Ayyappa Ch <ayyappa.chandolu@amd.com>
> > Date: Tue, 28 Apr 2015 11:53:00 +0530
> > Subject: [PATCH ] floating point realtime fix
> >
> > ---
> >  arch/arm64/kernel/fpsimd.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > index 2438497..3dca156 100644
> > --- a/arch/arm64/kernel/fpsimd.c
> > +++ b/arch/arm64/kernel/fpsimd.c
> > @@ -166,10 +166,10 @@ void fpsimd_flush_thread(void)
> >   */
> >  void fpsimd_preserve_current_state(void)
> >  {
> > - preempt_disable();
> > + migrate_disable();
> >   if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
> >   fpsimd_save_state(&current->thread.fpsimd_state);
> > - preempt_enable();
> > + migrate_enable();
> >  }
> >
> >  /*
> > @@ -179,7 +179,7 @@ void fpsimd_preserve_current_state(void)
> >   */
> >  void fpsimd_restore_current_state(void)
> >  {
> > - preempt_disable();
> > + migrate_disable();
> >   if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
> >   struct fpsimd_state *st = &current->thread.fpsimd_state;
> >
> > @@ -187,7 +187,7 @@ void fpsimd_restore_current_state(void)
> >   this_cpu_write(fpsimd_last_state, st);
> >   st->cpu = smp_processor_id();
> >   }
> > - preempt_enable();
> > + migrate_enable();
> >  }
> >
> >  /*
> > @@ -197,7 +197,7 @@ void fpsimd_restore_current_state(void)
> >   */
> >  void fpsimd_update_current_state(struct fpsimd_state *state)
> >  {
> > - preempt_disable();
> > + migrate_disable();
> >   fpsimd_load_state(state);
> >   if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
> >   struct fpsimd_state *st = &current->thread.fpsimd_state;
> > @@ -205,7 +205,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
> >   this_cpu_write(fpsimd_last_state, st);
> >   st->cpu = smp_processor_id();
> >   }
> > - preempt_enable();
> > + migrate_enable();
> >  }
> >
> >  /*
> > @@ -239,7 +239,7 @@ void kernel_neon_begin_partial(u32 num_regs)
> >   * that there is no longer userland FPSIMD state in the
> >   * registers.
> >   */
> > - preempt_disable();
> > + migrate_disable();
> >   if (current->mm &&
> >      !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
> >   fpsimd_save_state(&current->thread.fpsimd_state);
> > @@ -255,7 +255,7 @@ void kernel_neon_end(void)
> >   in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
> >   fpsimd_load_partial_state(s);
> >   } else {
> > - preempt_enable();
> > + migrate_enable();
> >   }
> >  }
> >  EXPORT_SYMBOL(kernel_neon_end);
> > --
> > 1.9.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Anders Roxell
0708 22 71 05
