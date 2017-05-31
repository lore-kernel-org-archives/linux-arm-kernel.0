From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 31 May 2017 11:51:04 +0000
Subject: [RFC PATCH v3 3/4] arm64: neon: Remove support for nested or
 hardirq kernel-mode NEON
In-Reply-To: <1495736721-20985-4-git-send-email-Dave.Martin@arm.com>
References: <1495736721-20985-1-git-send-email-Dave.Martin@arm.com>
 <1495736721-20985-4-git-send-email-Dave.Martin@arm.com>
Message-ID: <CAKv+Gu8wTphnAwi+=FoeXdDoqL7LEQ9ihrQndnnNoJKwQKKPmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 May 2017 at 18:25, Dave Martin <Dave.Martin@arm.com> wrote:
> Support for kernel-mode NEON to be nested and/or used in hardirq
> context adds significant complexity, and the benefits may be
> marginal.  In practice, kernel-mode NEON is not used in hardirq
> context, and is rarely used in softirq context (by certain mac80211
> drivers).
>

To clarify: it is actually the core mac80211 code that invokes the AES
crypto routines, but only if the crypto is not performed by the
hardware.

> This patch implements an arm64 may_use_simd() function to allow
> clients to check whether kernel-mode NEON is usable in the current
> context, and simplifies kernel_neon_{begin,end}() to handle only
> saving of the task FPSIMD state (if any).  Without nesting, there
> is no other state to save.
>
> The partial fpsimd save/restore functions become redundant as a
> result of these changes, so they are removed too.
>
> The save/restore model is changed to operate directly on
> task_struct without additional percpu storage.  This simplifies the
> code and saves a bit of memory, but means that softirqs must now be
> disabled when manipulating the task fpsimd state from task context:
> correspondingly, preempt_{en,dis}sable() calls are upgraded to
> local_bh_{en,dis}able() as appropriate.

I don't think the latter implies the former: please look at the
difference between SOFTIRQ_DISABLE_OFFSET and SOFTIRQ_LOCK_OFFSET

>  fpsimd_thread_switch()
> already runs with hardirqs disabled and so is already protected
> from softirqs.
>
> These changes should make it easier to support kernel-mode NEON in
> the presence of the Scalable Vector extension in the future.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/include/asm/fpsimd.h       |  14 -----
>  arch/arm64/include/asm/fpsimdmacros.h |  56 -----------------
>  arch/arm64/include/asm/neon.h         |   4 +-
>  arch/arm64/include/asm/simd.h         |  56 +++++++++++++++++
>  arch/arm64/kernel/entry-fpsimd.S      |  24 -------
>  arch/arm64/kernel/fpsimd.c            | 115 +++++++++++++++++++++++-----------
>  6 files changed, 136 insertions(+), 133 deletions(-)
>  create mode 100644 arch/arm64/include/asm/simd.h
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
> index 5368bd0..fb9d137 100644
> --- a/arch/arm64/include/asm/neon.h
> +++ b/arch/arm64/include/asm/neon.h
> @@ -16,9 +16,7 @@
>
>  #define cpu_has_neon()         system_supports_fpsimd()
>
> -#define kernel_neon_begin()    kernel_neon_begin_partial(32)
> -
> -void kernel_neon_begin_partial(u32 num_regs);
> +void kernel_neon_begin(void);
>  void kernel_neon_end(void);
>
>  #endif /* ! __ASM_NEON_H */
> diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> new file mode 100644
> index 0000000..bbfc68f
> --- /dev/null
> +++ b/arch/arm64/include/asm/simd.h
> @@ -0,0 +1,56 @@
> +/*
> + * Copyright (C) 2017  ARM Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef __ASM_SIMD_H
> +#define __ASM_SIMD_H
> +
> +#include <linux/percpu.h>
> +#include <linux/preempt.h>
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_KERNEL_MODE_NEON
> +
> +DECLARE_PER_CPU(bool, kernel_neon_busy);
> +
> +/*
> + * Returns true if and only if it is safe to call kernel_neon_begin().
> + * Callers must not assume that the result remains true beyond the next
> + * preempt_enable() or return from softirq context.
> + */
> +static inline bool may_use_simd(void)
> +{
> +       /*
> +        * The raw_cpu_read() is racy if called with preemption enabled.
> +        * This is not a bug: kernel_neon_busy is only set when
> +        * preemption is disabled, so we cannot migrate to another CPU
> +        * while it is set, nor can we migrate to a CPU where it is set.
> +        * So, if we find it clear on some CPU then we're guaranteed to
> +        * find it clear on any CPU we could migrate to.
> +        *
> +        * If we are in between kernel_neon_begin()...kernel_neon_end(),
> +        * the flag will be set, but preemption is also disabled, so we
> +        * can't migrate to another CPU and spuriously see it become
> +        * false.
> +        */
> +       return !in_irq() && !in_nmi() && !raw_cpu_read(kernel_neon_busy);
> +}
> +
> +#else /* ! CONFIG_KERNEL_MODE_NEON */
> +
> +static inline bool may_use_simd(void) { return false; }
> +
> +#endif /* ! CONFIG_KERNEL_MODE_NEON */
> +
> +#endif /* ! __ASM_SIMD_H */
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
> index d7e5f8a..14329d6 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -17,16 +17,18 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>
> +#include <linux/bottom_half.h>
>  #include <linux/cpu.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/percpu.h>
>  #include <linux/sched/signal.h>
>  #include <linux/signal.h>
> -#include <linux/hardirq.h>
>
>  #include <asm/fpsimd.h>
>  #include <asm/cputype.h>
> +#include <asm/simd.h>
>
>  #define FPEXC_IOF      (1 << 0)
>  #define FPEXC_DZF      (1 << 1)
> @@ -62,6 +64,13 @@
>   * CPU currently contain the most recent userland FPSIMD state of the current
>   * task.
>   *
> + * In order to allow softirq handlers to use FPSIMD, kernel_neon_begin() may
> + * save the task's FPSIMD context back to task_struct from softirq context.
> + * To prevent this from racing with the manipulation of the task's FPSIMD state
> + * from task context and thereby corrupting the state, it is necessary to
> + * protect any manipulation of a task's fpsimd_state or TIF_FOREIGN_FPSTATE
> + * flag with local_bh_disable() unless softirqs are already masked.
> + *
>   * For a certain task, the sequence may look something like this:
>   * - the task gets scheduled in; if both the task's fpsimd_state.cpu field
>   *   contains the id of the current CPU, and the CPU's fpsimd_last_state per-cpu
> @@ -161,9 +170,14 @@ void fpsimd_flush_thread(void)
>  {
>         if (!system_supports_fpsimd())
>                 return;
> +
> +       local_bh_disable();
> +
>         memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
>         fpsimd_flush_task_state(current);
>         set_thread_flag(TIF_FOREIGN_FPSTATE);
> +
> +       local_bh_enable();
>  }
>
>  /*
> @@ -174,10 +188,13 @@ void fpsimd_preserve_current_state(void)
>  {
>         if (!system_supports_fpsimd())
>                 return;
> -       preempt_disable();
> +
> +       local_bh_disable();
> +
>         if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
>                 fpsimd_save_state(&current->thread.fpsimd_state);
> -       preempt_enable();
> +
> +       local_bh_enable();
>  }
>
>  /*
> @@ -189,7 +206,9 @@ void fpsimd_restore_current_state(void)
>  {
>         if (!system_supports_fpsimd())
>                 return;
> -       preempt_disable();
> +
> +       local_bh_disable();
> +
>         if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
>                 struct fpsimd_state *st = &current->thread.fpsimd_state;
>
> @@ -197,7 +216,8 @@ void fpsimd_restore_current_state(void)
>                 __this_cpu_write(fpsimd_last_state, st);
>                 st->cpu = smp_processor_id();
>         }
> -       preempt_enable();
> +
> +       local_bh_enable();
>  }
>
>  /*
> @@ -209,7 +229,9 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
>  {
>         if (!system_supports_fpsimd())
>                 return;
> -       preempt_disable();
> +
> +       local_bh_disable();
> +
>         fpsimd_load_state(state);
>         if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
>                 struct fpsimd_state *st = &current->thread.fpsimd_state;
> @@ -217,7 +239,8 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
>                 __this_cpu_write(fpsimd_last_state, st);
>                 st->cpu = smp_processor_id();
>         }
> -       preempt_enable();
> +
> +       local_bh_enable();
>  }
>
>  /*
> @@ -230,49 +253,69 @@ void fpsimd_flush_task_state(struct task_struct *t)
>
>  #ifdef CONFIG_KERNEL_MODE_NEON
>
> -static DEFINE_PER_CPU(struct fpsimd_partial_state, hardirq_fpsimdstate);
> -static DEFINE_PER_CPU(struct fpsimd_partial_state, softirq_fpsimdstate);
> +DEFINE_PER_CPU(bool, kernel_neon_busy);
>
>  /*
>   * Kernel-side NEON support functions
>   */
> -void kernel_neon_begin_partial(u32 num_regs)
> +
> +/*
> + * kernel_neon_begin(): obtain the CPU FPSIMD registers for use by the calling
> + * context
> + *
> + * Must not be called unless may_use_simd() returns true.
> + * Task context in the FPSIMD registers is saved back to memory as necessary.
> + *
> + * A matching call to kernel_neon_end() must be made before returning from the
> + * calling context.
> + *
> + * The caller may freely use the FPSIMD registers until kernel_neon_end() is
> + * called.
> + */
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
> -               this_cpu_write(fpsimd_last_state, NULL);
> -       }
> +       BUG_ON(!may_use_simd());
> +
> +       local_bh_disable();
> +
> +       __this_cpu_write(kernel_neon_busy, true);
> +
> +       /* Save unsaved task fpsimd state, if any: */
> +       if (current->mm && !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
> +               fpsimd_save_state(&current->thread.fpsimd_state);
> +
> +       /* Invalidate any task state remaining in the fpsimd regs: */
> +       __this_cpu_write(fpsimd_last_state, NULL);
> +
> +       preempt_disable();
> +
> +       local_bh_enable();
>  }
> -EXPORT_SYMBOL(kernel_neon_begin_partial);
> +EXPORT_SYMBOL(kernel_neon_begin);
>
> +/*
> + * kernel_neon_end(): give the CPU FPSIMD registers back to the current task
> + *
> + * Must be called from a context in which kernel_neon_begin() was previously
> + * called, with no call to kernel_neon_end() in the meantime.
> + *
> + * The caller must not use the FPSIMD registers after this function is called,
> + * unless kernel_neon_begin() is called again in the meantime.
> + */
>  void kernel_neon_end(void)
>  {
> +       bool busy;
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
> +       busy = __this_cpu_xchg(kernel_neon_busy, false);
> +       WARN_ON(!busy); /* No matching kernel_neon_begin()? */
> +
> +       preempt_enable();
>  }
>  EXPORT_SYMBOL(kernel_neon_end);
>
> --
> 2.1.4
>
