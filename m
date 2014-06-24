From: keescook@chromium.org (Kees Cook)
Date: Tue, 24 Jun 2014 07:18:04 -0700
Subject: [PATCH] ARM: ptrace: reload syscall number after
 secure_computing() check
In-Reply-To: <1403600096-26088-1-git-send-email-will.deacon@arm.com>
References: <1403600096-26088-1-git-send-email-will.deacon@arm.com>
Message-ID: <CAGXu5jLTB0JeFk4cPC7p_9Fu3ZvW55m0Xnvz4CJY-Tt8F6F6cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 1:54 AM, Will Deacon <will.deacon@arm.com> wrote:
> On the syscall tracing path, we call out to secure_computing() to allow
> seccomp to check the syscall number being attempted. As part of this, a
> SIGTRAP may be sent to the tracer and the syscall could be re-written by
> a subsequent SET_SYSCALL ptrace request. Unfortunately, this new syscall
> is ignored by the current code unless TIF_SYSCALL_TRACE is also set on
> the current thread.
>
> This patch slightly reworks the enter path of the syscall tracing code
> so that we always reload the syscall number from
> current_thread_info()->syscall after the potential ptrace traps.
>
> Tested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

> ---
>  arch/arm/kernel/ptrace.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index 0dd3b79b15c3..0c27ed6f3f23 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -908,7 +908,7 @@ enum ptrace_syscall_dir {
>         PTRACE_SYSCALL_EXIT,
>  };
>
> -static int tracehook_report_syscall(struct pt_regs *regs,
> +static void tracehook_report_syscall(struct pt_regs *regs,
>                                     enum ptrace_syscall_dir dir)
>  {
>         unsigned long ip;
> @@ -926,7 +926,6 @@ static int tracehook_report_syscall(struct pt_regs *regs,
>                 current_thread_info()->syscall = -1;
>
>         regs->ARM_ip = ip;
> -       return current_thread_info()->syscall;
>  }
>
>  asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
> @@ -938,7 +937,9 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
>                 return -1;
>
>         if (test_thread_flag(TIF_SYSCALL_TRACE))
> -               scno = tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
> +               tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
> +
> +       scno = current_thread_info()->syscall;
>
>         if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>                 trace_sys_enter(regs, scno);
> --
> 2.0.0
>



-- 
Kees Cook
Chrome OS Security
