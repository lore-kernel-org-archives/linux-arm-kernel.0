From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 Jan 2014 14:56:05 +0000
Subject: [PATCH v2 6/6] arm64: audit: Add audit hook in
 ptrace/syscall_trace
In-Reply-To: <1389946399-4525-7-git-send-email-takahiro.akashi@linaro.org>
References: <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
 <1389946399-4525-7-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140123145605.GG27520@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 08:13:19AM +0000, AKASHI Takahiro wrote:
> @@ -1064,6 +1066,16 @@ asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
>  {
>  	unsigned long saved_reg;
>  
> +#ifdef CONFIG_AUDITSYSCALL
> +	if (dir)
> +		audit_syscall_exit(regs);
> +	else
> +		audit_syscall_entry(syscall_get_arch(current, regs),
> +			(int)regs->syscallno,
> +			regs->orig_x0, regs->regs[1],
> +			regs->regs[2], regs->regs[3]);
> +#endif /* CONFIG_AUDITSYSCALL */

It should work without the #ifdef as audit_syscall_exit/entry are dummy
static inline functions when !CONFIG_AUDITSYSCALL.

-- 
Catalin
