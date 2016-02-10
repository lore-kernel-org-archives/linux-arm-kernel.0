From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Feb 2016 11:58:53 +0000
Subject: [PATCH] arm64: Rework valid_user_regs
In-Reply-To: <1455041501-30018-1-git-send-email-mark.rutland@arm.com>
References: <1455041501-30018-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160210115853.GG1052@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Feb 09, 2016 at 06:11:41PM +0000, Mark Rutland wrote:
> We validate pstate using PSR_MODE32_BIT, which is part of the
> user-provided pstate (and cannot be trusted). Also, we conflate
> validation of AArch32 and AArch64 pstate values, making the code
> difficult to reason about.
> 
> Instead, validate the pstate value based on the associated task. The
> task may or may not be current (e.g. when using ptrace), so this must be
> passed explicitly by callers. To avoid circular header dependencies via
> sched.h, is_compat_task is pulled out of asm/ptrace.h.
> 
> To make the code possible to reason about, the AArch64 and AArch32
> validation is split into separate functions. Software must respect the
> RES0 policy for SPSR bits, and thus the kernel mirrors the hardware
> policy (RAZ/WI) for bits as-yet unallocated. When these acquire an
> architected meaning writes may be permitted (potentially with additional
> validation).

Thanks for doing this. Comments inline.

> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/ptrace.h | 32 ++-------------------
>  arch/arm64/kernel/ptrace.c      | 64 +++++++++++++++++++++++++++++++++++++++--
>  arch/arm64/kernel/signal.c      |  4 +--
>  arch/arm64/kernel/signal32.c    |  2 +-
>  4 files changed, 68 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index e9e5467..0bb538b 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -151,35 +151,9 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
>  	return regs->regs[0];
>  }
>  
> -/*
> - * Are the current registers suitable for user mode? (used to maintain
> - * security in signal handlers)
> - */
> -static inline int valid_user_regs(struct user_pt_regs *regs)
> -{
> -	if (user_mode(regs) && (regs->pstate & PSR_I_BIT) == 0) {
> -		regs->pstate &= ~(PSR_F_BIT | PSR_A_BIT);
> -
> -		/* The T bit is reserved for AArch64 */
> -		if (!(regs->pstate & PSR_MODE32_BIT))
> -			regs->pstate &= ~COMPAT_PSR_T_BIT;
> -
> -		return 1;
> -	}
> -
> -	/*
> -	 * Force PSR to something logical...
> -	 */
> -	regs->pstate &= PSR_f | PSR_s | (PSR_x & ~PSR_A_BIT) | \
> -			COMPAT_PSR_T_BIT | PSR_MODE32_BIT;
> -
> -	if (!(regs->pstate & PSR_MODE32_BIT)) {
> -		regs->pstate &= ~COMPAT_PSR_T_BIT;
> -		regs->pstate |= PSR_MODE_EL0t;
> -	}
> -
> -	return 0;
> -}
> +/* We must avoid circular header include via sched.h */
> +struct task_struct;
> +int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task);
>  
>  #define instruction_pointer(regs)	((unsigned long)(regs)->pc)
>  
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index ff7f132..23c20c2 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -500,7 +500,7 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
>  	if (ret)
>  		return ret;
>  
> -	if (!valid_user_regs(&newregs))
> +	if (!valid_user_regs(&newregs, target))
>  		return -EINVAL;
>  
>  	task_pt_regs(target)->user_regs = newregs;
> @@ -770,7 +770,7 @@ static int compat_gpr_set(struct task_struct *target,
>  
>  	}
>  
> -	if (valid_user_regs(&newregs.user_regs))
> +	if (valid_user_regs(&newregs.user_regs, target))
>  		*task_pt_regs(target) = newregs;
>  	else
>  		ret = -EINVAL;
> @@ -1272,3 +1272,63 @@ asmlinkage void syscall_trace_exit(struct pt_regs *regs)
>  	if (test_thread_flag(TIF_SYSCALL_TRACE))
>  		tracehook_report_syscall(regs, PTRACE_SYSCALL_EXIT);
>  }
> +
> +/*
> + * Bits which are architecturally RES0 per ARM DDI 0487A.h
> + * The kernel matches the HW policy. Userspace cannot use these until they have
> + * an architectural meaning.
> + */
> +#define SPSR_EL1_AARCH64_RES0_BITS \
> +	(GENMASK_ULL(63,32) | GENMASK_ULL(27, 22) | GENMASK_ULL(19, 10) | \
> +	 GENMASK_ULL(5, 5))
> +#define SPSR_EL1_AARCH32_RES0_BITS \
> +	(GENMASK_ULL(63,32) | (GENMASK_ULL(23, 22)))

The J bit (24) is also RES0 and the E bit (9) can be RES0/RES1 depending
on what the CPU supports. It also might be worth negating these in the
definition, rather than on every use.

> +static int valid_aa32_regs(struct user_pt_regs *regs)

valid_compat_user_regs

> +{
> +	regs->pstate &= ~SPSR_EL1_AARCH32_RES0_BITS;
> +
> +	if (user_mode(regs) && (regs->pstate & PSR_MODE32_BIT) &&
> +	    (regs->pstate & COMPAT_PSR_A_BIT) == 0 &&
> +	    (regs->pstate & COMPAT_PSR_I_BIT) == 0 &&
> +	    (regs->pstate & COMPAT_PSR_F_BIT) == 0) {
> +		return 1;
> +	}
> +
> +	/* Force PSR to a valid 32-bit EL0t */
> +	regs->pstate |= PSR_MODE32_BIT;
> +	regs->pstate &= PSR_f | PSR_s | (PSR_x & ~COMPAT_PSR_A_BIT) | \
> +			COMPAT_PSR_T_BIT;
> +
> +	return 0;
> +}
> +
> +static int valid_aa64_regs(struct user_pt_regs *regs)

valid_native_user_regs

> +{
> +	regs->pstate &= ~SPSR_EL1_AARCH64_RES0_BITS;
> +
> +	if (user_mode(regs) && !(regs->pstate & PSR_MODE32_BIT) &&
> +	    (regs->pstate & PSR_D_BIT) == 0 &&
> +	    (regs->pstate & PSR_A_BIT) == 0 &&
> +	    (regs->pstate & PSR_I_BIT) == 0 &&
> +	    (regs->pstate & PSR_F_BIT) == 0) {
> +		return 1;
> +	}

I think we should err on the side of caution and nuke SS and IL for both
native and compat too, although that seems a odds with the PSR_s mask.
I wonder how relevant those PSR groups are in ARMv8...

> +	/* Force PSR to a valid 64-bit EL0t */
> +	regs->pstate &= PSR_f | PSR_s;
> +
> +	return 0;
> +}
> +
> +/*
> + * Are the current registers suitable for user mode? (used to maintain
> + * security in signal handlers)
> + */
> +int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task)
> +{
> +	if (is_compat_thread(task_thread_info(task)))

is_compat_task

Will
