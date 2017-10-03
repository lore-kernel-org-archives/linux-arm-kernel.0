From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 04 Oct 2017 00:45:04 +0100
Subject: [PATCH REPOST 2/3] arm64: Fix single stepping in kernel traps
In-Reply-To: <1507050352-15909-3-git-send-email-julien.thierry@arm.com>
References: <1507050352-15909-1-git-send-email-julien.thierry@arm.com>
 <1507050352-15909-3-git-send-email-julien.thierry@arm.com>
Message-ID: <87wp4byewv.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Julien Thierry <julien.thierry@arm.com> writes:

> Software Step exception is missing after stepping a trapped instruction.
>
> Ensure SPSR.SS gets set to 0 after emulating/skipping a trapped instruction
> before doing ERET.
>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
>
> ---
>  arch/arm64/include/asm/traps.h       |  2 ++
>  arch/arm64/kernel/armv8_deprecated.c |  8 ++++----
>  arch/arm64/kernel/cpufeature.c       |  2 +-
>  arch/arm64/kernel/traps.c            | 21 ++++++++++++++++-----
>  4 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
> index d131501..dd7affb 100644
> --- a/arch/arm64/include/asm/traps.h
> +++ b/arch/arm64/include/asm/traps.h
> @@ -37,6 +37,8 @@ struct undef_hook {
>
>  void arm64_notify_segfault(struct pt_regs *regs, unsigned long addr);
>
> +void arm64_skip_trapped_instr(struct pt_regs *regs, unsigned long size);
> +

Personally I think this is a poor name as it implies there is no effect
from the operation. I suspect arm64_update_regs is a little too generic
through. Naming things as ever is hard....

>  static inline int __in_irqentry_text(unsigned long ptr)
>  {
>  	return ptr >= (unsigned long)&__irqentry_text_start &&
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> index f0e6d71..1f38208 100644
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -431,7 +431,7 @@ static int swp_handler(struct pt_regs *regs, u32 instr)
>  	pr_warn_ratelimited("\"%s\" (%ld) uses obsolete SWP{B} instruction at 0x%llx\n",
>  			current->comm, (unsigned long)current->pid, regs->pc);
>
> -	regs->pc += 4;
> +	arm64_skip_trapped_instr(regs, 4);
>  	return 0;
>
>  fault:
> @@ -512,7 +512,7 @@ static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
>  	pr_warn_ratelimited("\"%s\" (%ld) uses deprecated CP15 Barrier instruction at 0x%llx\n",
>  			current->comm, (unsigned long)current->pid, regs->pc);
>
> -	regs->pc += 4;
> +	arm64_skip_trapped_instr(regs, 4);
>  	return 0;
>  }
>
> @@ -586,14 +586,14 @@ static int compat_setend_handler(struct pt_regs *regs, u32 big_endian)
>  static int a32_setend_handler(struct pt_regs *regs, u32 instr)
>  {
>  	int rc = compat_setend_handler(regs, (instr >> 9) & 1);
> -	regs->pc += 4;
> +	arm64_skip_trapped_instr(regs, 4);
>  	return rc;
>  }

Why didn't we use AARCH64_INSN_SIZE for these here?

>
>  static int t16_setend_handler(struct pt_regs *regs, u32 instr)
>  {
>  	int rc = compat_setend_handler(regs, (instr >> 3) & 1);
> -	regs->pc += 2;
> +	arm64_skip_trapped_instr(regs, 2);
>  	return rc;
>  }

I guess we don't have an equivalent AARCH32_T16_INSN_SIZE?

>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index cd52d36..2956d5a 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1287,7 +1287,7 @@ static int emulate_mrs(struct pt_regs *regs, u32 insn)
>  	if (!rc) {
>  		dst = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
>  		pt_regs_write_reg(regs, dst, val);
> -		regs->pc += 4;
> +		arm64_skip_trapped_instr(regs, AARCH64_INSN_SIZE);
>  	}
>
>  	return rc;
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 5ea4b85..ed9d856 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -293,6 +293,17 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
>  	}
>  }
>
> +void arm64_skip_trapped_instr(struct pt_regs *regs, unsigned long size)
> +{
> +	regs->pc += size;
> +
> +	/*
> +	 * If we were single stepping, we want to get the step exception after
> +	 * we return from the skipped exception
> +	 */
> +	regs->pstate &= ~DBG_SPSR_SS;
> +}
> +
>  static LIST_HEAD(undef_hook);
>  static DEFINE_RAW_SPINLOCK(undef_lock);
>
> @@ -480,7 +491,7 @@ static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
>  	if (ret)
>  		arm64_notify_segfault(regs, address);
>  	else
> -		regs->pc += 4;
> +		arm64_skip_trapped_instr(regs, AARCH64_INSN_SIZE);
>  }
>
>  static void ctr_read_handler(unsigned int esr, struct pt_regs *regs)
> @@ -490,7 +501,7 @@ static void ctr_read_handler(unsigned int esr, struct pt_regs *regs)
>
>  	pt_regs_write_reg(regs, rt, val);
>
> -	regs->pc += 4;
> +	arm64_skip_trapped_instr(regs, AARCH64_INSN_SIZE);
>  }
>
>  static void cntvct_read_handler(unsigned int esr, struct pt_regs *regs)
> @@ -498,7 +509,7 @@ static void cntvct_read_handler(unsigned int esr, struct pt_regs *regs)
>  	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
>
>  	pt_regs_write_reg(regs, rt, arch_counter_get_cntvct());
> -	regs->pc += 4;
> +	arm64_skip_trapped_instr(regs, AARCH64_INSN_SIZE);
>  }
>
>  static void cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
> @@ -506,7 +517,7 @@ static void cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
>  	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
>
>  	pt_regs_write_reg(regs, rt, arch_timer_get_rate());
> -	regs->pc += 4;
> +	arm64_skip_trapped_instr(regs, AARCH64_INSN_SIZE);
>  }
>
>  struct sys64_hook {
> @@ -761,7 +772,7 @@ static int bug_handler(struct pt_regs *regs, unsigned int esr)
>  	}
>
>  	/* If thread survives, skip over the BUG instruction and continue: */
> -	regs->pc += AARCH64_INSN_SIZE;	/* skip BRK and resume */
> +	arm64_skip_trapped_instr(regs, AARCH64_INSN_SIZE);
>  	return DBG_HOOK_HANDLED;
>  }

It would be nice to find a better name but otherwise:

Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

--
Alex Benn?e
