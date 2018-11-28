From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 28 Nov 2018 16:35:42 +0100
Subject: [PATCH 2/2] arm64: preempt: Provide our own implementation of
 asm/preempt.h
In-Reply-To: <1543347902-21170-3-git-send-email-will.deacon@arm.com>
References: <1543347902-21170-1-git-send-email-will.deacon@arm.com>
 <1543347902-21170-3-git-send-email-will.deacon@arm.com>
Message-ID: <CAKv+Gu9s-=M-mU+249-X1jQ7_Z60vWO1cXK1AP0CwKCmaQQSdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Nov 2018 at 20:44, Will Deacon <will.deacon@arm.com> wrote:
>
> The asm-generic/preempt.h implementation doesn't make use of the
> PREEMPT_NEED_RESCHED flag, since this can interact badly with load/store
> architectures which rely on the preempt_count word being unchanged across
> an interrupt.
>
> However, since we're a 64-bit architecture and the preempt count is
> only 32 bits wide, we can simply pack it next to the resched flag and
> load the whole thing in one go, so that a dec-and-test operation doesn't
> need to load twice.
>

Since the actual preempt count is a lot narrower than 32 bits, x86
just uses bit 31.

So what is the reason for using two different words?


> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/Kbuild        |  1 -
>  arch/arm64/include/asm/preempt.h     | 78 ++++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/thread_info.h | 13 +++++-
>  3 files changed, 90 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/include/asm/preempt.h
>
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index 6cd5d77b6b44..33498f900390 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -14,7 +14,6 @@ generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
>  generic-y += msi.h
> -generic-y += preempt.h
>  generic-y += qrwlock.h
>  generic-y += qspinlock.h
>  generic-y += rwsem.h
> diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
> new file mode 100644
> index 000000000000..832227d5ebc0
> --- /dev/null
> +++ b/arch/arm64/include/asm/preempt.h
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_PREEMPT_H
> +#define __ASM_PREEMPT_H
> +
> +#include <linux/thread_info.h>
> +
> +#define PREEMPT_NEED_RESCHED   BIT(32)
> +#define PREEMPT_ENABLED        (PREEMPT_NEED_RESCHED)
> +
> +static inline int preempt_count(void)
> +{
> +       return READ_ONCE(current_thread_info()->preempt.count);
> +}
> +
> +static inline void preempt_count_set(u64 pc)
> +{
> +       /* Preserve existing value of PREEMPT_NEED_RESCHED */
> +       WRITE_ONCE(current_thread_info()->preempt.count, pc);
> +}
> +
> +#define init_task_preempt_count(p) do { \
> +       task_thread_info(p)->preempt_count = FORK_PREEMPT_COUNT; \
> +} while (0)
> +
> +#define init_idle_preempt_count(p, cpu) do { \
> +       task_thread_info(p)->preempt_count = PREEMPT_ENABLED; \
> +} while (0)
> +
> +static inline void set_preempt_need_resched(void)
> +{
> +       current_thread_info()->preempt.need_resched = 0;
> +}
> +
> +static inline void clear_preempt_need_resched(void)
> +{
> +       current_thread_info()->preempt.need_resched = 1;
> +}
> +
> +static inline bool test_preempt_need_resched(void)
> +{
> +       return !current_thread_info()->preempt.need_resched;
> +}
> +
> +static inline void __preempt_count_add(int val)
> +{
> +       u32 pc = READ_ONCE(current_thread_info()->preempt.count);
> +       pc += val;
> +       WRITE_ONCE(current_thread_info()->preempt.count, pc);
> +}
> +
> +static inline void __preempt_count_sub(int val)
> +{
> +       u32 pc = READ_ONCE(current_thread_info()->preempt.count);
> +       pc -= val;
> +       WRITE_ONCE(current_thread_info()->preempt.count, pc);
> +}
> +
> +static inline bool __preempt_count_dec_and_test(void)
> +{
> +       u64 pc = READ_ONCE(current_thread_info()->preempt_count);
> +       WRITE_ONCE(current_thread_info()->preempt.count, --pc);
> +       return !pc;
> +}
> +
> +static inline bool should_resched(int preempt_offset)
> +{
> +       u64 pc = READ_ONCE(current_thread_info()->preempt_count);
> +       return pc == preempt_offset;
> +}
> +
> +#ifdef CONFIG_PREEMPT
> +void preempt_schedule(void);
> +#define __preempt_schedule() preempt_schedule()
> +void preempt_schedule_notrace(void);
> +#define __preempt_schedule_notrace() preempt_schedule_notrace()
> +#endif /* CONFIG_PREEMPT */
> +
> +#endif /* __ASM_PREEMPT_H */
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index cb2c10a8f0a8..bbca68b54732 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -42,7 +42,18 @@ struct thread_info {
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>         u64                     ttbr0;          /* saved TTBR0_EL1 */
>  #endif
> -       int                     preempt_count;  /* 0 => preemptable, <0 => bug */
> +       union {
> +               u64             preempt_count;  /* 0 => preemptible, <0 => bug */
> +               struct {
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +                       u32     need_resched;
> +                       u32     count;
> +#else
> +                       u32     count;
> +                       u32     need_resched;
> +#endif
> +               } preempt;
> +       };
>  };
>
>  #define thread_saved_pc(tsk)   \
> --
> 2.1.4
>
