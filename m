From: Per.Hallsmark@windriver.com (Hallsmark, Per)
Date: Thu, 30 Jun 2016 13:58:08 +0000
Subject: [PATCH] arm64: ni_syscall should be similar to other archs
In-Reply-To: <20160418095808.GB18257@e104818-lin.cambridge.arm.com>
References: <1456325699-25849-1-git-send-email-per.hallsmark@windriver.com>,
 <20160418095808.GB18257@e104818-lin.cambridge.arm.com>
Message-ID: <B7B4BB465792624BAF51F33077E990659D7C134D@ALA-MBB.corp.ad.wrs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No problem, I managed to miss this reply with same amount ;-)

The issue was found on a real case, running lttng that tries to make use
of sys_brk before falling back to internal variant. On arm64 this generates
an "ugly" dump on console which dont happen on arm, x86 etc.

Ok, missed that part with SIGILL, so even more to align then.

--
Per Hallsmark                        per.hallsmark at windriver.com
Senior Member Technical Staff        Wind River AB
Mobile: +46733249340                 Office: +46859461127
Torshamnsgatan 27                    164 40 Kista
________________________________________
From: Catalin Marinas [catalin.marinas at arm.com]
Sent: Monday, April 18, 2016 11:58
To: Hallsmark, Per
Cc: linux-arm-kernel at lists.infradead.org; Will Deacon
Subject: Re: [PATCH] arm64: ni_syscall should be similar to other archs

(I forgot about this email, some two months ago)

On Wed, Feb 24, 2016 at 03:54:59PM +0100, per.hallsmark at windriver.com wrote:
> From: Per Hallsmark <per.hallsmark@windriver.com>
>
> Today arm64 have it's own variant when a userspace app is doing a
> non-implemented syscall in that it dumps on console process name,
> registers and such. This makes a different behaviour on arm64 than
> on all other archs.

Are you hitting a real issue with this? Test apps doing random syscalls?

> This patch propose to get inline with other archs.

Well, it's not fully in line, for example on arch/arm we generate a
SIGILL (and I think we should fix the compat path in the arm64
do_ni_syscall() to do the same).

> If we want to have a note on console, syslog or so when doing a
> nonimplemented syscall, it would be better to add a variable
> show_nonimplemented_syscalls and sense on it in the generic
> kernel/sys_ni.c::sys_ni_syscall() which could dump info (and then
> it would be generic for all archs). But that is another discussion
> alltogether, lets first synchronize the archs to behave similar.

Or we could have finer grained show_unhandled_signals variable. The user
visible /proc/sys/debug/exception-trace doesn't say anything about
signals.

> Signed-off-by: Per Hallsmark <per.hallsmark@windriver.com>
> ---
>  arch/arm64/kernel/traps.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index cbedd72..980ff63 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -403,14 +403,6 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
>       }
>  #endif
>
> -     if (show_unhandled_signals_ratelimited()) {
> -             pr_info("%s[%d]: syscall %d\n", current->comm,
> -                     task_pid_nr(current), (int)regs->syscallno);
> -             dump_instr("", regs);
> -             if (user_mode(regs))
> -                     __show_regs(regs);
> -     }
> -
>       return sys_ni_syscall();
>  }

--
Catalin
