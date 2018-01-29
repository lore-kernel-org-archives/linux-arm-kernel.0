From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Jan 2018 15:38:39 +0000
Subject: [PATCH 1/2] arm64: Remove unimplemented syscall log message
In-Reply-To: <20180122212026.26262-2-michael.weiser@gmx.de>
References: <20180122131851.GA28638@arm.com>
 <20180122212026.26262-2-michael.weiser@gmx.de>
Message-ID: <20180129153839.GB24444@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 10:20:25PM +0100, Michael Weiser wrote:
> Stop printing a (ratelimited) kernel message for each instance of an
> unimplemented syscall being called. Userland making an unimplemented
> syscall is not necessarily misbehaviour and to be expected with a
> current userland running on an older kernel. Also, the current message
> looks scary to users but does not actually indicate a real problem nor
> help them narrow down the cause. Just rely on sys_ni_syscall() to return
> -ENOSYS.
> 
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
> ---
>  arch/arm64/kernel/traps.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index bbb0fde2780e..0ef28b7f6aa7 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -526,14 +526,6 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
>  	}
>  #endif
>  
> -	if (show_unhandled_signals_ratelimited()) {
> -		pr_info("%s[%d]: syscall %d\n", current->comm,
> -			task_pid_nr(current), regs->syscallno);
> -		dump_instr("", regs);
> -		if (user_mode(regs))
> -			__show_regs(regs);
> -	}
> -
>  	return sys_ni_syscall();
>  }

Acked-by: Will Deacon <will.deacon@arm.com>

I'm also strongly inclined to change the default value of
show_unhandled_signals to be zero. I find it odd that it defaults to 1
when it can be changed via proc anyway, although this is consistent with
other architectures.

Will
