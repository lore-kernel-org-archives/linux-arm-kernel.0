From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Jul 2014 12:59:38 +0100
Subject: [PATCH] arm64: audit: Fix build for audit changes
In-Reply-To: <1405596402-23844-1-git-send-email-broonie@kernel.org>
References: <1405596402-23844-1-git-send-email-broonie@kernel.org>
Message-ID: <20140717115937.GF18203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 12:26:42PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Commit 3efe33f5d2 (audit: x86: drop arch from __audit_syscall_entry()
> interface) removed the arch parameter from __audit_syscall_entry() and
> updated the only current user in mainline but this breaks the ARMv8 audit
> code that has been added in -next. Fix this by making the equivalent
> update to ARMv8.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm64/kernel/ptrace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 70526cfda056..310842e3d477 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -1115,8 +1115,8 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
>  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>  		trace_sys_enter(regs, regs->syscallno);
>  
> -	audit_syscall_entry(syscall_get_arch(), regs->syscallno,
> -		regs->orig_x0, regs->regs[1], regs->regs[2], regs->regs[3]);
> +	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
> +			    regs->regs[2], regs->regs[3]);
>  
>  	return regs->syscallno;
>  }

Thanks. This will have to be applied after 3.17-rc1 since commit
3efe33f5d2 does not seem to be in mainline yet (nor the arm64 audit
patches).

-- 
Catalin
