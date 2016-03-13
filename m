From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 13 Mar 2016 12:09:03 +0000
Subject: [PATCH v11 4/9] arm64: add conditional instruction simulation
 support
In-Reply-To: <1457501543-24197-5-git-send-email-dave.long@linaro.org>
References: <1457501543-24197-1-git-send-email-dave.long@linaro.org>
 <1457501543-24197-5-git-send-email-dave.long@linaro.org>
Message-ID: <20160313120903.54b0c8f2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  9 Mar 2016 00:32:18 -0500
David Long <dave.long@linaro.org> wrote:

> From: "David A. Long" <dave.long@linaro.org>
> 
> Cease using the arm32 arm_check_condition() function and replace it with
> a local version for use in deprecated instruction support on arm64. Also
> make the function table used by this available for future use by kprobes
> and/or uprobes.
> 
> This function is dervied from code written by Sandeepa Prabhu.
> 
> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  arch/arm64/include/asm/insn.h        |  3 ++
>  arch/arm64/kernel/Makefile           |  3 +-
>  arch/arm64/kernel/armv8_deprecated.c | 19 +++++++-
>  arch/arm64/kernel/insn.c             | 94 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 115 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index 662b42a..72dda48 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -405,6 +405,9 @@ u32 aarch64_extract_system_register(u32 insn);
>  u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
>  u32 aarch32_insn_mcr_extract_opc2(u32 insn);
>  u32 aarch32_insn_mcr_extract_crm(u32 insn);
> +
> +typedef bool (pstate_check_t)(unsigned long);
> +extern pstate_check_t * const opcode_condition_checks[16];
>  #endif /* __ASSEMBLY__ */
>  
>  #endif	/* __ASM_INSN_H */
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 83cd7e6..fd5f163 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -26,8 +26,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
>  	$(call if_changed,objcopy)
>  
>  arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
> -					   sys_compat.o entry32.o		\
> -					   ../../arm/kernel/opcodes.o
> +					   sys_compat.o entry32.o
>  arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
>  arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
>  arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> index 3e01207..c655259 100644
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -369,6 +369,21 @@ static int emulate_swpX(unsigned int address, unsigned int *data,
>  	return res;
>  }
>  
> +#define	ARM_OPCODE_CONDITION_UNCOND	0xf
> +
> +static unsigned int __kprobes arm32_check_condition(u32 opcode, u32 psr)
> +{
> +	u32 cc_bits  = opcode >> 28;
> +
> +	if (cc_bits != ARM_OPCODE_CONDITION_UNCOND) {
> +		if ((*opcode_condition_checks[cc_bits])(psr))
> +			return ARM_OPCODE_CONDTEST_PASS;
> +		else
> +			return ARM_OPCODE_CONDTEST_FAIL;
> +	}
> +	return ARM_OPCODE_CONDTEST_UNCOND;
> +}
> +
>  /*
>   * swp_handler logs the id of calling process, dissects the instruction, sanity
>   * checks the memory location, calls emulate_swpX for the actual operation and
> @@ -383,7 +398,7 @@ static int swp_handler(struct pt_regs *regs, u32 instr)
>  
>  	type = instr & TYPE_SWPB;
>  
> -	switch (arm_check_condition(instr, regs->pstate)) {
> +	switch (arm32_check_condition(instr, regs->pstate)) {
>  	case ARM_OPCODE_CONDTEST_PASS:
>  		break;
>  	case ARM_OPCODE_CONDTEST_FAIL:
> @@ -464,7 +479,7 @@ static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
>  {
>  	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, regs->pc);
>  
> -	switch (arm_check_condition(instr, regs->pstate)) {
> +	switch (arm32_check_condition(instr, regs->pstate)) {
>  	case ARM_OPCODE_CONDTEST_PASS:
>  		break;
>  	case ARM_OPCODE_CONDTEST_FAIL:
> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> index 60c1c71..9f15ceb 100644
> --- a/arch/arm64/kernel/insn.c
> +++ b/arch/arm64/kernel/insn.c
> @@ -1234,3 +1234,97 @@ u32 aarch32_insn_mcr_extract_crm(u32 insn)
>  {
>  	return insn & CRM_MASK;
>  }
> +
> +static bool __kprobes __check_eq(unsigned long pstate)
> +{
> +	return (pstate & PSR_Z_BIT) != 0;
> +}
> +
> +static bool __kprobes __check_ne(unsigned long pstate)
> +{
> +	return (pstate & PSR_Z_BIT) == 0;
> +}
> +
> +static bool __kprobes __check_cs(unsigned long pstate)
> +{
> +	return (pstate & PSR_C_BIT) != 0;
> +}
> +
> +static bool __kprobes __check_cc(unsigned long pstate)
> +{
> +	return (pstate & PSR_C_BIT) == 0;
> +}
> +
> +static bool __kprobes __check_mi(unsigned long pstate)
> +{
> +	return (pstate & PSR_N_BIT) != 0;
> +}
> +
> +static bool __kprobes __check_pl(unsigned long pstate)
> +{
> +	return (pstate & PSR_N_BIT) == 0;
> +}
> +
> +static bool __kprobes __check_vs(unsigned long pstate)
> +{
> +	return (pstate & PSR_V_BIT) != 0;
> +}
> +
> +static bool __kprobes __check_vc(unsigned long pstate)
> +{
> +	return (pstate & PSR_V_BIT) == 0;
> +}
> +
> +static bool __kprobes __check_hi(unsigned long pstate)
> +{
> +	pstate &= ~(pstate >> 1);	/* PSR_C_BIT &= ~PSR_Z_BIT */
> +	return (pstate & PSR_C_BIT) != 0;
> +}
> +
> +static bool __kprobes __check_ls(unsigned long pstate)
> +{
> +	pstate &= ~(pstate >> 1);	/* PSR_C_BIT &= ~PSR_Z_BIT */
> +	return (pstate & PSR_C_BIT) == 0;
> +}
> +
> +static bool __kprobes __check_ge(unsigned long pstate)
> +{
> +	pstate ^= (pstate << 3);	/* PSR_N_BIT ^= PSR_V_BIT */
> +	return (pstate & PSR_N_BIT) == 0;
> +}
> +
> +static bool __kprobes __check_lt(unsigned long pstate)
> +{
> +	pstate ^= (pstate << 3);	/* PSR_N_BIT ^= PSR_V_BIT */
> +	return (pstate & PSR_N_BIT) != 0;
> +}
> +
> +static bool __kprobes __check_gt(unsigned long pstate)
> +{
> +	/*PSR_N_BIT ^= PSR_V_BIT */
> +	unsigned long temp = pstate ^ (pstate << 3);
> +
> +	temp |= (pstate << 1);	/*PSR_N_BIT |= PSR_Z_BIT */
> +	return (temp & PSR_N_BIT) == 0;
> +}
> +
> +static bool __kprobes __check_le(unsigned long pstate)
> +{
> +	/*PSR_N_BIT ^= PSR_V_BIT */
> +	unsigned long temp = pstate ^ (pstate << 3);
> +
> +	temp |= (pstate << 1);	/*PSR_N_BIT |= PSR_Z_BIT */
> +	return (temp & PSR_N_BIT) != 0;
> +}
> +
> +static bool __kprobes __check_al(unsigned long pstate)
> +{
> +	return true;
> +}
> +
> +pstate_check_t * const opcode_condition_checks[16] = {
> +	__check_eq, __check_ne, __check_cs, __check_cc,
> +	__check_mi, __check_pl, __check_vs, __check_vc,
> +	__check_hi, __check_ls, __check_ge, __check_lt,
> +	__check_gt, __check_le, __check_al, __check_al

The very last entry seems wrong, or is at least the opposite of what
the current code has. It should be something called __check_nv(), and
always return false (condition code NEVER).

> +};

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
