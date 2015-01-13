From: keescook@chromium.org (Kees Cook)
Date: Tue, 13 Jan 2015 12:08:48 -0800
Subject: [PATCH 2/2] ARM: entry-common,
 ptrace: do not pass scno to syscall_trace_enter
In-Reply-To: <1420986751-30364-3-git-send-email-r.peniaev@gmail.com>
References: <1420986751-30364-1-git-send-email-r.peniaev@gmail.com>
 <1420986751-30364-3-git-send-email-r.peniaev@gmail.com>
Message-ID: <CAGXu5jLi=6QTzF_z9pFAeXQqLZPfSCcwZc+q-a7b-tKwwBo4vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 11, 2015 at 6:32 AM, Roman Pen <r.peniaev@gmail.com> wrote:
> In previous patch current_thread_info()->syscall is set with
> corresponding syscall number prior to further calls, thus there
> is no any need to pass 'scno'.
>
> Also, add explicit comment why do we have to reread 'scno' local
> variable.
>
> Signed-off-by: Roman Pen <r.peniaev@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Eric Paris <eparis@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/kernel/entry-common.S | 1 -
>  arch/arm/kernel/ptrace.c       | 6 ++++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 89452ff..3d12eb5 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -228,7 +228,6 @@ ENDPROC(vector_swi)
>          * context switches, and waiting for our parent to respond.
>          */
>  __sys_trace:
> -       mov     r1, scno
>         add     r0, sp, #S_OFF
>         bl      syscall_trace_enter
>
> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index ef9119f..1238787 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -928,9 +928,9 @@ static void tracehook_report_syscall(struct pt_regs *regs,
>         regs->ARM_ip = ip;
>  }
>
> -asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
> +asmlinkage int syscall_trace_enter(struct pt_regs *regs)
>  {
> -       current_thread_info()->syscall = scno;
> +       int scno = current_thread_info()->syscall;

Was this assignment of current_thread_info()->syscall redundant? If
so, this looks fine. If not, what will now be setting the thread_info?

-Kees

>
>         /* Do the secure computing check first; failures should be fast. */
>  #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
> @@ -944,6 +944,8 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
>         if (test_thread_flag(TIF_SYSCALL_TRACE))
>                 tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
>
> +       /* Syscall can be aborted (-1 can be set) or even changed
> +        * by the tracer and subsequent PTRACE_SET_SYSCALL request */
>         scno = current_thread_info()->syscall;
>
>         if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> --
> 2.1.3
>



-- 
Kees Cook
Chrome OS Security
