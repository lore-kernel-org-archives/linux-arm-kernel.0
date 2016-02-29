From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Feb 2016 19:08:33 +0000
Subject: [PATCHv3] arm64: Rework valid_user_regs
In-Reply-To: <20160216182005.GN14509@arm.com>
References: <1455646517-22903-1-git-send-email-mark.rutland@arm.com>
 <20160216182005.GN14509@arm.com>
Message-ID: <20160229190832.GH14848@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Tue, Feb 16, 2016 at 06:20:05PM +0000, Will Deacon wrote:
> On Tue, Feb 16, 2016 at 06:15:17PM +0000, Mark Rutland wrote:
> > We validate pstate using PSR_MODE32_BIT, which is part of the
> > user-provided pstate (and cannot be trusted). Also, we conflate
> > validation of AArch32 and AArch64 pstate values, making the code
> > difficult to reason about.
> > 
> > Instead, validate the pstate value based on the associated task. The
> > task may or may not be current (e.g. when using ptrace), so this must be
> > passed explicitly by callers. To avoid circular header dependencies via
> > sched.h, is_compat_task is pulled out of asm/ptrace.h.
> > 
> > To make the code possible to reason about, the AArch64 and AArch32
> > validation is split into separate functions. Software must respect the
> > RES0 policy for SPSR bits, and thus the kernel mirrors the hardware
> > policy (RAZ/WI) for bits as-yet unallocated. When these acquire an
> > architected meaning writes may be permitted (potentially with additional
> > validation).
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Dave Martin <dave.martin@arm.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Will Deacon <will.deacon@arm.com>

[...]

> > +static int valid_compat_regs(struct user_pt_regs *regs)
> > +{
> > +	regs->pstate &= ~SPSR_EL1_AARCH32_RES0_BITS;
> > +
> > +	if (!system_supports_mixed_endian_el0()) {
> > +		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> > +			regs->pstate |= COMPAT_PSR_E_BIT;
> > +		else
> > +			regs->pstate &= ~COMPAT_PSR_E_BIT;
> > +	}
> > +
> > +	if (user_mode(regs) && (regs->pstate & PSR_MODE32_BIT) &&
> > +	    (regs->pstate & COMPAT_PSR_A_BIT) == 0 &&
> > +	    (regs->pstate & COMPAT_PSR_I_BIT) == 0 &&
> > +	    (regs->pstate & COMPAT_PSR_F_BIT) == 0) {
> > +		return 1;
> > +	}
> > +
> > +	/* Force PSR to a valid 32-bit EL0t */
> > +	regs->pstate &= COMPAT_PSR_N_BIT | COMPAT_PSR_Z_BIT |
> > +			COMPAT_PSR_C_BIT | COMPAT_PSR_V_BIT |
> > +			COMPAT_PSR_Q_BIT | COMPAT_PSR_IT_MASK |
> > +			COMPAT_PSR_GE_MASK | COMPAT_PSR_E_BIT |
> > +			COMPAT_PSR_T_BIT;
> > +	regs->pstate |= PSR_MODE32_BIT;
> 
> Might be worth an explicit comment to say that we're mirroring arch/arm/
> behaviour here.
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int valid_native_regs(struct user_pt_regs *regs)
> > +{
> > +	regs->pstate &= ~SPSR_EL1_AARCH64_RES0_BITS;
> > +
> > +	if (user_mode(regs) && !(regs->pstate & PSR_MODE32_BIT) &&
> > +	    (regs->pstate & PSR_D_BIT) == 0 &&
> > +	    (regs->pstate & PSR_A_BIT) == 0 &&
> > +	    (regs->pstate & PSR_I_BIT) == 0 &&
> > +	    (regs->pstate & PSR_F_BIT) == 0) {
> > +		return 1;
> > +	}
> > +
> > +	/* Force PSR to a valid 64-bit EL0t */
> > +	regs->pstate &= PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT;
> 
> Can we not just zap the pstate to PSR_MODE_EL0t and be done with it?

Are you planning to respin this patch?

Will
