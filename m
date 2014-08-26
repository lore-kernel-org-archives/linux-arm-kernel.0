From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Aug 2014 14:16:30 +0100
Subject: [PATCH 6/6] arm64: Emulate CP15 Barrier instructions
In-Reply-To: <1409048930-21598-7-git-send-email-punit.agrawal@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
 <1409048930-21598-7-git-send-email-punit.agrawal@arm.com>
Message-ID: <20140826131630.GP23445@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 11:28:50AM +0100, Punit Agrawal wrote:
> The CP15 barrier instructions (CP15ISB, CP15DSB and CP15DMB) are
> deprecated in the ARMv7 architecture, superseded by ISB, DSB and DMB
> instructions respectively. Some implementations may provide support
> for these instructions which can then be enabled by setting the
> CP15BEN bit in the SCTLR in ARMv7 or SCTLR_EL1 in ARMv8. If not
> enabled, the encodings for these instructions become undefined.
> 
> To support legacy software that uses these instructions, this patch
> emulates the barrier instructions by installing an undefined
> instruction handler. The patch also adds a debugfs entry to track
> the occurrence of the deprecated barrier instructions. It is possible
> to runtime disable them from debugfs.

[...]

> diff --git a/arch/arm64/kernel/v7_obsolete.c b/arch/arm64/kernel/v7_obsolete.c
> index e9427cb..ed77889 100644
> --- a/arch/arm64/kernel/v7_obsolete.c
> +++ b/arch/arm64/kernel/v7_obsolete.c
> @@ -227,6 +227,94 @@ static void __init swp_emulation_init(void)
>  		pr_notice("Registered SWP/SWPB emulation handler\n");
>  }
>  
> +static atomic_t cp15_barrier_count;
> +static u32 cp15_barrier_enabled = 1;

Stupid question, but how this variable get updated?

> +
> +static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
> +{
> +	if (!cp15_barrier_enabled)
> +		return -EFAULT;
> +
> +	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, regs->pc);
> +
> +	switch (arm_check_condition(instr, regs->pstate)) {
> +	case ARM_OPCODE_CONDTEST_PASS:
> +		break;
> +	case ARM_OPCODE_CONDTEST_FAIL:
> +		/* Condition failed - return to next instruction */
> +		goto ret;
> +	case ARM_OPCODE_CONDTEST_UNCOND:
> +		/* If unconditional encoding - not a barrier instruction */
> +		return -EFAULT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch(aarch32_insn_mcr_extract_crm(instr)) {
> +	case 10:
> +		/*
> +		 * dmb - mcr p15, 0, Rt, c7, c10, 5
> +		 * dsb - mcr p15, 0, Rt, c7, c10, 4
> +		 */
> +		if (aarch32_insn_mcr_extract_opc2(instr) == 5)
> +			dmb();
> +		else
> +			dsb();

It would be cleaner to check for the value 4 here.

> +		break;
> +	case 5:
> +		/*
> +		 * isb - mcr p15, 0, Rt, c7, c5, 4
> +		 */
> +		isb();

You don't need this isb() -- it is implicit in the exception return. A
comment to that effect will suffice.

Will
