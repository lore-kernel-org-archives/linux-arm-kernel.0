From: anurag19aggarwal@gmail.com (Anurag Aggarwal)
Date: Fri, 2 May 2014 20:35:35 +0530
Subject: [PATCH] ARM: unwinder: Fix thread_saved_fp aka "enable backtrace
 on THUMB2"
In-Reply-To: <1398790923-24406-1-git-send-email-Nikolay.Borisov@arm.com>
References: <1398790923-24406-1-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <CAPoNrttU=jRMZw+WCVubnay9xxJG89w1sRMi6g=FVgEQxWjwQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nikolay,

I have one suggestion to you, As there is already some handling
present for Thumb-2 kernels.

The handling does not seem to be complete.
In below code segment :

In arch/arm/kernel/unwind.c :

void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk)
{
        struct stackframe frame;
        register unsigned long current_sp asm ("sp");

        pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);

        if (!tsk)
        tsk = current;

        if (regs) {
                frame.fp = regs->ARM_fp;
                frame.sp = regs->ARM_sp;
                frame.lr = regs->ARM_lr;


Similar changes need to be made as ARM_fp is nothing else but R11.
This may create future issues.


On Tue, Apr 29, 2014 at 10:32 PM, Nikolay Borisov
<Nikolay.Borisov@arm.com> wrote:
> The thread_save_fp macro has been defined so that it always reads the fp member
> of the cpu_context_save struct. However, in the case of THUMB2 the fp is saved
> not in the fp (r11) member but rather in r7.
>
> This patch changes the way the macro is defined such that FP is read from the
> correct place depending on whether we are a THUMB2 kernel or not. This enables
> the backtrace in sitaution such as "echo t > /proc/sysrq-trigger" or the
> function in which a process sleeping when "ps -Al" is invoked.
>
> Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
> Tested-by: Nikolay Borisov <Nikolay.Borisov@arm.com>
> ---
>  arch/arm/include/asm/thread_info.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
> index f989d7c..e4e4208 100644
> --- a/arch/arm/include/asm/thread_info.h
> +++ b/arch/arm/include/asm/thread_info.h
> @@ -114,8 +114,14 @@ static inline struct thread_info *current_thread_info(void)
>         ((unsigned long)(task_thread_info(tsk)->cpu_context.pc))
>  #define thread_saved_sp(tsk)   \
>         ((unsigned long)(task_thread_info(tsk)->cpu_context.sp))
> +
> +#ifndef CONFIG_THUMB2_KERNEL
>  #define thread_saved_fp(tsk)   \
>         ((unsigned long)(task_thread_info(tsk)->cpu_context.fp))
> +#else
> +#define thread_saved_fp(tsk)   \
> +       ((unsigned long)(task_thread_info(tsk)->cpu_context.r7))
> +#endif
>
>  extern void crunch_task_disable(struct thread_info *);
>  extern void crunch_task_copy(struct thread_info *, void *);
> --
> 1.8.1.5
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Anurag Aggarwal
