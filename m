From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 19 May 2017 13:34:37 +0100
Subject: [RFC PATCH] arm64: neon: Remove support for nested or hardirq
 kernel-mode NEON
In-Reply-To: <1495193199-1291-1-git-send-email-Dave.Martin@arm.com>
References: <1495193199-1291-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <CAKv+Gu8KKuD6Rgbq++kzJayHN8X-Kb7vrS-aj=N_kymqSnfVdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 May 2017 at 12:26, Dave Martin <Dave.Martin@arm.com> wrote:
> The benefits of nested kernel-mode NEON may be marginal.  Likewise,
> use of kernel-mode NEON in hardirq context is rare to nonexistent.
>

The only use case for kernel mode NEON outside of process context is
the mac80211 subsystem which performs crypto on the packets in softirq
context.

> Removing support for these eliminates signifcant cost and complexity.
>

typo: significant

> This patch implements a kernel_neon_allowed() function to allow
> clients to check whether kernel-mode NEON is usable in the current
> context, and simplifies kernel_neon_{begin,end}() to handle only
> saving of the task FPSIMD state (if any).  Without nesting, there
> is no other state to save.
>
> The partial fpsimd save/restore functions become redundant as a
> result of these changes, so they are removed too.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>
> ---
>
> This patch requires drivers to be ported to cope with conditional
> availability of kernel-mode NEON: [1] should be close, since Ard
> was already working on this.
>
> I've build-tested this only for now: no runtime testing, no
> benchmarking.
>
> This patch is broken without some conversion of preempt_disable()/
>
> enable() to local_bh_disable()/enable() around some of the context
> handling code in fpsimd.c, in order to be robust against the task's
> FPSIMD context being unexpectedly saved by a preempting softirq.
>

Yes, this is basically the issue we originally discussed in the
context of SVE support.

> [1] git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git kernel-mode-neon
>
>
>  arch/arm64/include/asm/fpsimd.h       | 14 ---------
>  arch/arm64/include/asm/fpsimdmacros.h | 56 -----------------------------------
>  arch/arm64/include/asm/neon.h         | 44 +++++++++++++++++++++++++--
>  arch/arm64/kernel/entry-fpsimd.S      | 24 ---------------
>  arch/arm64/kernel/fpsimd.c            | 50 ++++++++++++++-----------------
>  5 files changed, 64 insertions(+), 124 deletions(-)
>
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index 50f559f..ff2f6cd 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -41,16 +41,6 @@ struct fpsimd_state {
>         unsigned int cpu;
>  };
>
> -/*
> - * Struct for stacking the bottom 'n' FP/SIMD registers.
> - */
> -struct fpsimd_partial_state {
> -       u32             fpsr;
> -       u32             fpcr;
> -       u32             num_regs;
> -       __uint128_t     vregs[32];
> -};
> -
>
>  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
>  /* Masks for extracting the FPSR and FPCR from the FPSCR */
> @@ -77,10 +67,6 @@ extern void fpsimd_update_current_state(struct fpsimd_state *state);
>
>  extern void fpsimd_flush_task_state(struct task_struct *target);
>
> -extern void fpsimd_save_partial_state(struct fpsimd_partial_state *state,
> -                                     u32 num_regs);
> -extern void fpsimd_load_partial_state(struct fpsimd_partial_state *state);
> -
>  #endif
>
>  #endif
> diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
> index a2daf12..0f5fdd3 100644
> --- a/arch/arm64/include/asm/fpsimdmacros.h
> +++ b/arch/arm64/include/asm/fpsimdmacros.h
> @@ -75,59 +75,3 @@
>         ldr     w\tmpnr, [\state, #16 * 2 + 4]
>         fpsimd_restore_fpcr x\tmpnr, \state
>  .endm
> -
> -.macro fpsimd_save_partial state, numnr, tmpnr1, tmpnr2
> -       mrs     x\tmpnr1, fpsr
> -       str     w\numnr, [\state, #8]
> -       mrs     x\tmpnr2, fpcr
> -       stp     w\tmpnr1, w\tmpnr2, [\state]
> -       adr     x\tmpnr1, 0f
> -       add     \state, \state, x\numnr, lsl #4
> -       sub     x\tmpnr1, x\tmpnr1, x\numnr, lsl #1
> -       br      x\tmpnr1
> -       stp     q30, q31, [\state, #-16 * 30 - 16]
> -       stp     q28, q29, [\state, #-16 * 28 - 16]
> -       stp     q26, q27, [\state, #-16 * 26 - 16]
> -       stp     q24, q25, [\state, #-16 * 24 - 16]
> -       stp     q22, q23, [\state, #-16 * 22 - 16]
> -       stp     q20, q21, [\state, #-16 * 20 - 16]
> -       stp     q18, q19, [\state, #-16 * 18 - 16]
> -       stp     q16, q17, [\state, #-16 * 16 - 16]
> -       stp     q14, q15, [\state, #-16 * 14 - 16]
> -       stp     q12, q13, [\state, #-16 * 12 - 16]
> -       stp     q10, q11, [\state, #-16 * 10 - 16]
> -       stp     q8, q9, [\state, #-16 * 8 - 16]
> -       stp     q6, q7, [\state, #-16 * 6 - 16]
> -       stp     q4, q5, [\state, #-16 * 4 - 16]
> -       stp     q2, q3, [\state, #-16 * 2 - 16]
> -       stp     q0, q1, [\state, #-16 * 0 - 16]
> -0:
> -.endm
> -
> -.macro fpsimd_restore_partial state, tmpnr1, tmpnr2
> -       ldp     w\tmpnr1, w\tmpnr2, [\state]
> -       msr     fpsr, x\tmpnr1
> -       fpsimd_restore_fpcr x\tmpnr2, x\tmpnr1
> -       adr     x\tmpnr1, 0f
> -       ldr     w\tmpnr2, [\state, #8]
> -       add     \state, \state, x\tmpnr2, lsl #4
> -       sub     x\tmpnr1, x\tmpnr1, x\tmpnr2, lsl #1
> -       br      x\tmpnr1
> -       ldp     q30, q31, [\state, #-16 * 30 - 16]
> -       ldp     q28, q29, [\state, #-16 * 28 - 16]
> -       ldp     q26, q27, [\state, #-16 * 26 - 16]
> -       ldp     q24, q25, [\state, #-16 * 24 - 16]
> -       ldp     q22, q23, [\state, #-16 * 22 - 16]
> -       ldp     q20, q21, [\state, #-16 * 20 - 16]
> -       ldp     q18, q19, [\state, #-16 * 18 - 16]
> -       ldp     q16, q17, [\state, #-16 * 16 - 16]
> -       ldp     q14, q15, [\state, #-16 * 14 - 16]
> -       ldp     q12, q13, [\state, #-16 * 12 - 16]
> -       ldp     q10, q11, [\state, #-16 * 10 - 16]
> -       ldp     q8, q9, [\state, #-16 * 8 - 16]
> -       ldp     q6, q7, [\state, #-16 * 6 - 16]
> -       ldp     q4, q5, [\state, #-16 * 4 - 16]
> -       ldp     q2, q3, [\state, #-16 * 2 - 16]
> -       ldp     q0, q1, [\state, #-16 * 0 - 16]
> -0:
> -.endm
> diff --git a/arch/arm64/include/asm/neon.h b/arch/arm64/include/asm/neon.h
> index ad4cdc9..2269322 100644
> --- a/arch/arm64/include/asm/neon.h
> +++ b/arch/arm64/include/asm/neon.h
> @@ -8,12 +8,50 @@
>   * published by the Free Software Foundation.
>   */
>
> +#include <linux/compiler.h>
> +#include <linux/percpu.h>
> +#include <linux/preempt.h>
>  #include <linux/types.h>
>  #include <asm/fpsimd.h>
> +#include <asm/local.h>
>
>  #define cpu_has_neon()         system_supports_fpsimd()
>
> -#define kernel_neon_begin()    kernel_neon_begin_partial(32)
> -
> -void kernel_neon_begin_partial(u32 num_regs);
> +void kernel_neon_begin(void);
>  void kernel_neon_end(void);
> +
> +/* FIXME: Backwards compatibility only, should go away: */
> +#define kernel_neon_begin_partial(num_regs) kernel_neon_begin()
> +
> +#ifdef CONFIG_KERNEL_MODE_NEON
> +
> +extern DEFINE_PER_CPU(local_t, kernel_neon_busy);

DECLARE_PER_CPU

> +
> +/*
> + * Returns true if and only if it is safe to call kernel_neon_begin().
> + * Callers must not assume that the result remains true beyond the next
> + * preempt_enable() or return from softirq context.
> + */
> +static bool __maybe_unused kernel_neon_allowed(void)

If you make it static inline, you don't need the __maybe_unused

> +{
> +       /*
> +        * The per_cpu_ptr() is racy if called with preemption enabled.
> +        * This is not a bug:  per_cpu(kernel_neon_busy) is only set
> +        * when preemption is disabled, so we cannot migrate to another
> +        * CPU while it is set, nor can we migrate to a CPU where it is set.
> +        * So, if we find it clear on some CPU then we're guaranteed to find it
> +        * clear on any CPU we could migrate to.
> +        *
> +        * If we are in between kernel_neon_begin()...kernel_neon_end(), the
> +        * flag will be set, but preemption is also disabled, so we can't
> +        * migrate to another CPU and spuriously see it become false.
> +        */
> +       return !(in_irq() || in_nmi()) &&
> +               !local_read(this_cpu_ptr(&kernel_neon_busy));

For readability, could we change this to '!x && !y && !z' instead?

> +}
> +
> +#else /* ! CONFIG_KERNEL_MODE_NEON */
> +
> +static bool __maybe_unused kernel_neon_allowed(void) { return false; }

static inline here as well

> +
> +#endif /* ! CONFIG_KERNEL_MODE_NEON */
> diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
> index c44a82f..6a27cd6 100644
> --- a/arch/arm64/kernel/entry-fpsimd.S
> +++ b/arch/arm64/kernel/entry-fpsimd.S
> @@ -41,27 +41,3 @@ ENTRY(fpsimd_load_state)
>         fpsimd_restore x0, 8
>         ret
>  ENDPROC(fpsimd_load_state)
> -
> -#ifdef CONFIG_KERNEL_MODE_NEON
> -
> -/*
> - * Save the bottom n FP registers.
> - *
> - * x0 - pointer to struct fpsimd_partial_state
> - */
> -ENTRY(fpsimd_save_partial_state)
> -       fpsimd_save_partial x0, 1, 8, 9
> -       ret
> -ENDPROC(fpsimd_save_partial_state)
> -
> -/*
> - * Load the bottom n FP registers.
> - *
> - * x0 - pointer to struct fpsimd_partial_state
> - */
> -ENTRY(fpsimd_load_partial_state)
> -       fpsimd_restore_partial x0, 8, 9
> -       ret
> -ENDPROC(fpsimd_load_partial_state)
> -
> -#endif
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 06da8ea..22cb8e8 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -21,12 +21,14 @@
>  #include <linux/cpu_pm.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/percpu.h>
>  #include <linux/sched/signal.h>
>  #include <linux/signal.h>
>  #include <linux/hardirq.h>
>
>  #include <asm/fpsimd.h>
>  #include <asm/cputype.h>
> +#include <asm/local.h>
>
>  #define FPEXC_IOF      (1 << 0)
>  #define FPEXC_DZF      (1 << 1)
> @@ -230,49 +232,43 @@ void fpsimd_flush_task_state(struct task_struct *t)
>
>  #ifdef CONFIG_KERNEL_MODE_NEON
>
> -static DEFINE_PER_CPU(struct fpsimd_partial_state, hardirq_fpsimdstate);
> -static DEFINE_PER_CPU(struct fpsimd_partial_state, softirq_fpsimdstate);
> +DEFINE_PER_CPU(local_t, kernel_neon_busy);
>
>  /*
>   * Kernel-side NEON support functions
>   */
> -void kernel_neon_begin_partial(u32 num_regs)
> +void kernel_neon_begin(void)
>  {
>         if (WARN_ON(!system_supports_fpsimd()))
>                 return;
> -       if (in_interrupt()) {
> -               struct fpsimd_partial_state *s = this_cpu_ptr(
> -                       in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
>
> -               BUG_ON(num_regs > 32);
> -               fpsimd_save_partial_state(s, roundup(num_regs, 2));
> -       } else {
> -               /*
> -                * Save the userland FPSIMD state if we have one and if we
> -                * haven't done so already. Clear fpsimd_last_state to indicate
> -                * that there is no longer userland FPSIMD state in the
> -                * registers.
> -                */
> -               preempt_disable();
> -               if (current->mm &&
> -                   !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
> -                       fpsimd_save_state(&current->thread.fpsimd_state);
> +       BUG_ON(!kernel_neon_allowed());
> +
> +       preempt_disable();
> +       local_set(this_cpu_ptr(&kernel_neon_busy), 1);
> +
> +       /*
> +        * If there is unsaved task fpsimd state in the CPU, save it
> +        * and invalidate the copy stored in the fpsimd regs:
> +        */
> +       if (current->mm && !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE)) {
> +               fpsimd_save_state(&current->thread.fpsimd_state);
>                 this_cpu_write(fpsimd_last_state, NULL);
>         }
>  }
> -EXPORT_SYMBOL(kernel_neon_begin_partial);
> +EXPORT_SYMBOL(kernel_neon_begin);
>
>  void kernel_neon_end(void)
>  {
> +       long busy;
> +
>         if (!system_supports_fpsimd())
>                 return;
> -       if (in_interrupt()) {
> -               struct fpsimd_partial_state *s = this_cpu_ptr(
> -                       in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
> -               fpsimd_load_partial_state(s);
> -       } else {
> -               preempt_enable();
> -       }
> +
> +       busy = local_xchg(this_cpu_ptr(&kernel_neon_busy), 0);
> +       WARN_ON(!busy); /* No matching kernel_neon_begin()? */
> +
> +       preempt_enable();
>  }
>  EXPORT_SYMBOL(kernel_neon_end);
>
> --
> 2.1.4
>

I think the general approach is sound. I still think we could call
kernel_neon_allowed() may_use_simd(), and let it override the
asm-generic version in asm/simd.h. In any case, given this is a prereq
for SVE support which is still far out, we should probably phase this
change by migrating KMN users to kernel_neon_allowed/may_use_simd
first (and add a 'return true' version for the former if needed), so
that the crypto changes can be queued for v4.13
