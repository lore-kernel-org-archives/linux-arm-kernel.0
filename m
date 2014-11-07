From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 07 Nov 2014 13:03:12 +0000
Subject: [PATCHv3 4/5] arm64: Emulate CP15 Barrier instructions
In-Reply-To: <20141105145116.GJ32700@e104818-lin.cambridge.arm.com> (Catalin
 Marinas's message of "Wed, 5 Nov 2014 14:51:17 +0000")
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
 <1414435207-30240-6-git-send-email-punit.agrawal@arm.com>
 <20141105145116.GJ32700@e104818-lin.cambridge.arm.com>
Message-ID: <9hhmw83qi27.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Oct 27, 2014 at 06:40:06PM +0000, Punit Agrawal wrote:
>> +static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
>> +{
>> +	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, regs->pc);
>> +
>> +	switch (arm_check_condition(instr, regs->pstate)) {
>> +	case ARM_OPCODE_CONDTEST_PASS:
>> +		break;
>> +	case ARM_OPCODE_CONDTEST_FAIL:
>> +		/* Condition failed - return to next instruction */
>> +		goto ret;
>> +	case ARM_OPCODE_CONDTEST_UNCOND:
>> +		/* If unconditional encoding - not a barrier instruction */
>> +		return -EFAULT;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	switch (aarch32_insn_mcr_extract_crm(instr)) {
>> +	case 10:
>> +		/*
>> +		 * dmb - mcr p15, 0, Rt, c7, c10, 5
>> +		 * dsb - mcr p15, 0, Rt, c7, c10, 4
>> +		 */
>> +		if (aarch32_insn_mcr_extract_opc2(instr) == 5)
>> +			dmb(sy);
>> +		else
>> +			dsb(sy);
>> +		break;
>> +	case 5:
>> +		/*
>> +		 * isb - mcr p15, 0, Rt, c7, c5, 4
>> +		 */
>> +		isb();
>> +		break;
>> +	}
>
> IIRC we concluded that an isb() isn't needed here as taking an exception
> or returning from one would act as an instruction barrier.

I don't remember what the conclusion was - the isb was introduced to err
on the side of caution. I've removed it now.

Thanks.
