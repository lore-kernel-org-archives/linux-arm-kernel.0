From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 3 Sep 2018 10:54:41 +0100
Subject: [PATCH 5/7] arm64: ssbd: Add support for PSTATE.SSBS rather than
 trapping to EL3
In-Reply-To: <1535645767-9901-6-git-send-email-will.deacon@arm.com>
References: <1535645767-9901-1-git-send-email-will.deacon@arm.com>
 <1535645767-9901-6-git-send-email-will.deacon@arm.com>
Message-ID: <35cfe536-0b79-efeb-dec0-119f2bc169cb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

The patch looks good to me, some comments below.

On 30/08/18 17:16, Will Deacon wrote:
> On CPUs with support for PSTATE.SSBS, the kernel can toggle the SSBD
> state without needing to call into firmware.
> 
> This patch hooks into the existing SSBD infrastructure so that SSBS is
> used on CPUs that support it, but it's all made horribly complicated by
> the very real possibility of big/little systems that don't uniformly
> provide the new capability.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm64/include/asm/processor.h   |  7 ++++++
>   arch/arm64/include/asm/ptrace.h      |  1 +
>   arch/arm64/include/asm/sysreg.h      |  3 +++
>   arch/arm64/include/uapi/asm/ptrace.h |  1 +
>   arch/arm64/kernel/cpu_errata.c       | 26 +++++++++++++++++++--
>   arch/arm64/kernel/cpufeature.c       | 45 ++++++++++++++++++++++++++++++++++++
>   arch/arm64/kernel/process.c          |  4 ++++
>   arch/arm64/kernel/ssbd.c             | 21 +++++++++++++++++
>   8 files changed, 106 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 79657ad91397..f6835374ed9f 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -174,6 +174,10 @@ static inline void start_thread(struct pt_regs *regs, unsigned long pc,
>   {
>   	start_thread_common(regs, pc);
>   	regs->pstate = PSR_MODE_EL0t;
> +
> +	if (arm64_get_ssbd_state() != ARM64_SSBD_FORCE_ENABLE)
> +		regs->pstate |= PSR_SSBS_BIT;
> +
>   	regs->sp = sp;
>   }
>   
> @@ -190,6 +194,9 @@ static inline void compat_start_thread(struct pt_regs *regs, unsigned long pc,
>   	regs->pstate |= PSR_AA32_E_BIT;
>   #endif
>   
> +	if (arm64_get_ssbd_state() != ARM64_SSBD_FORCE_ENABLE)
> +		regs->pstate |= PSR_AA32_SSBS_BIT;
> +
>   	regs->compat_sp = sp;
>   }
>   #endif
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index 177b851ca6d9..6bc43889d11e 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -50,6 +50,7 @@
>   #define PSR_AA32_I_BIT		0x00000080
>   #define PSR_AA32_A_BIT		0x00000100
>   #define PSR_AA32_E_BIT		0x00000200
> +#define PSR_AA32_SSBS_BIT	0x00800000
>   #define PSR_AA32_DIT_BIT	0x01000000
>   #define PSR_AA32_Q_BIT		0x08000000
>   #define PSR_AA32_V_BIT		0x10000000
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 2fc6242baf11..3091ae5975a3 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -86,11 +86,14 @@
>   
>   #define REG_PSTATE_PAN_IMM		sys_reg(0, 0, 4, 0, 4)
>   #define REG_PSTATE_UAO_IMM		sys_reg(0, 0, 4, 0, 3)
> +#define REG_PSTATE_SSBS_IMM		sys_reg(0, 3, 4, 0, 1)

nit: This is not about the patch, but what we have already established
for the macros above.

It looks like these definitions are a bit confusing if you try to
correlate it with the Arm ARM. For "msr <pstate_field>, #Immediate",
we have :

pstate_field => encoded in Op1:Op2 only
#Immediate => encoded in CRm field.

And Crn = 4, op0 = 0 and they are not specifically part of any standard
encoding for the "fields", but for the instruction access. (e.g, they
don't appear in an ISS for an ESR_ELx unlike the other sys regs).

So, using the sys_reg() definitions above somehow hides these facts and
makes it a bit difficult to verify the code. I am wondering if we should
introduce something like :

#define pstate_field(op1, op2)	(((op1) << Op1_shift) | ((op2) << Op2_shift))
#define PSTATE_Imm_shift	CRm_shift

#define PSTATE_PAN		pstate_field(0, 4)
#define PSTATE_UAO		pstate_field(0, 3)
#define PSTATE_SSBS		pstate_field(3, 1)

#define SET_PSTATE_FIELD(field, val)	\
		__emit_insn(0xd500401f | field | ((val) << PSTATE_Imm_shift))

#define SET_PSTATE_PAN(x)	SET_PSTATE_FIELD(PSTATE_PAN, !!(x))

etc.

Of course this has to be a separate patch which I can send if you think it is
worth pursuing.


Or@least we should replace the '8' below in the __emit_inst with a symbolic
name and use it wherever we need.

>   
>   #define SET_PSTATE_PAN(x) __emit_inst(0xd5000000 | REG_PSTATE_PAN_IMM |	\
>   				      (!!x)<<8 | 0x1f)
>   #define SET_PSTATE_UAO(x) __emit_inst(0xd5000000 | REG_PSTATE_UAO_IMM |	\
>   				      (!!x)<<8 | 0x1f)
> +#define SET_PSTATE_SSBS(x) __emit_inst(0xd5000000 | REG_PSTATE_SSBS_IMM | \
> +				       (!!x)<<8 | 0x1f)
>   
>   #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
>   #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index 98c4ce55d9c3..a36227fdb084 100644
> --- a/arch/arm64/include/uapi/asm/ptrace.h
> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> @@ -46,6 +46,7 @@
>   #define PSR_I_BIT	0x00000080
>   #define PSR_A_BIT	0x00000100
>   #define PSR_D_BIT	0x00000200
> +#define PSR_SSBS_BIT	0x00001000
>   #define PSR_PAN_BIT	0x00400000
>   #define PSR_UAO_BIT	0x00800000
>   #define PSR_V_BIT	0x10000000
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index dec10898d688..c063490d7b51 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -312,6 +312,14 @@ void __init arm64_enable_wa2_handling(struct alt_instr *alt,
>   
>   void arm64_set_ssbd_mitigation(bool state)
>   {
> +	if (this_cpu_has_cap(ARM64_SSBS)) {

nit: This will take a longer time as it iterates over the entire *arm64_features* and *arm64_errata*
list until it finds the "cap" requested to run the check. If we tend to use this function a lot
more and expect it to do it quickly, we may simply make the direct call to the matches or add
a wrapper to do the same.

> +		if (state)
> +			asm volatile(SET_PSTATE_SSBS(0));
> +		else
> +			asm volatile(SET_PSTATE_SSBS(1));
> +		return;
> +	}
> +
>   	switch (psci_ops.conduit) {
>   	case PSCI_CONDUIT_HVC:
>   		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_2, state, NULL);
> @@ -336,6 +344,11 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>   
>   	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
>   
> +	if (this_cpu_has_cap(ARM64_SSBS)) {
> +		required = false;
> +		goto out_printmsg;
> +	}
> +
>   	if (psci_ops.smccc_version == SMCCC_VERSION_1_0) {
>   		ssbd_state = ARM64_SSBD_UNKNOWN;
>   		return false;
> @@ -384,7 +397,6 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>   
>   	switch (ssbd_state) {
>   	case ARM64_SSBD_FORCE_DISABLE:
> -		pr_info_once("%s disabled from command-line\n", entry->desc);
>   		arm64_set_ssbd_mitigation(false);
>   		required = false;
>   		break;
> @@ -397,7 +409,6 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>   		break;
>   
>   	case ARM64_SSBD_FORCE_ENABLE:
> -		pr_info_once("%s forced from command-line\n", entry->desc);
>   		arm64_set_ssbd_mitigation(true);
>   		required = true;
>   		break;
> @@ -407,6 +418,17 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>   		break;
>   	}
>   
> +out_printmsg:
> +	switch (ssbd_state) {
> +	case ARM64_SSBD_FORCE_DISABLE:
> +		pr_info_once("%s disabled from command-line\n", entry->desc);
> +		break;
> +
> +	case ARM64_SSBD_FORCE_ENABLE:
> +		pr_info_once("%s forced from command-line\n", entry->desc);
> +		break;
> +	}
> +
>   	return required;
>   }
>   #endif	/* CONFIG_ARM64_SSBD */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index fac844ee1e24..ada72b9f2718 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1039,6 +1039,48 @@ static void cpu_has_fwb(const struct arm64_cpu_capabilities *__unused)
>   	WARN_ON(val & (7 << 27 | 7 << 21));
>   }
>   
> +#ifdef CONFIG_ARM64_SSBD
> +static int ssbs_emulation_handler(struct pt_regs *regs, u32 instr)
> +{
> +	if (user_mode(regs))
> +		return 1;
> +
> +	if (instr & BIT(CRm_shift))
> +		regs->pstate |= PSR_SSBS_BIT;
> +	else
> +		regs->pstate &= ~PSR_SSBS_BIT;
> +
> +	arm64_skip_faulting_instruction(regs, 4);
> +	return 0;
> +}
> +
> +static struct undef_hook ssbs_emulation_hook = {
> +	.instr_mask	= ~(1U << CRm_shift),

These lines above triggered the above detailed "nit" part.

> +	.instr_val	= 0xd500001f | REG_PSTATE_SSBS_IMM,
> +	.fn		= ssbs_emulation_handler,
> +};
> +

Suzuki
