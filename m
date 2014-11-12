From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 12 Nov 2014 11:31:04 +0000
Subject: [PATCHv3 5/5] arm64: Trace emulation of AArch32 legacy
 instructions
In-Reply-To: <20141110182714.GS23942@arm.com> (Will Deacon's message of "Mon,
 10 Nov 2014 18:27:14 +0000")
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
 <1414435207-30240-7-git-send-email-punit.agrawal@arm.com>
 <20141110182714.GS23942@arm.com>
Message-ID: <9hhwq70fyfb.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Thanks for taking a look.

Will Deacon <will.deacon@arm.com> writes:

> On Mon, Oct 27, 2014 at 06:40:07PM +0000, Punit Agrawal wrote:
>> Introduce an event to trace the usage of emulated instructions. The
>> trace event is intended to help identify and encourage the migration
>> of legacy software using the emulation features.
>> 
>> Use this event to trace usage of swp and CP15 barrier emulation.
>> 
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> ---

[...]

>> @@ -260,16 +268,23 @@ static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
>>  		 * dmb - mcr p15, 0, Rt, c7, c10, 5
>>  		 * dsb - mcr p15, 0, Rt, c7, c10, 4
>>  		 */
>> -		if (aarch32_insn_mcr_extract_opc2(instr) == 5)
>> +		if (aarch32_insn_mcr_extract_opc2(instr) == 5) {
>>  			dmb(sy);
>> -		else
>> +			trace_instruction_emulation(
>> +				"mcr p15, 0, Rt, c7, c10, 5", regs->pc);
>> +		} else {
>>  			dsb(sy);
>> +			trace_instruction_emulation(
>> +				"mcr p15, 0, Rt, c7, c10, 4", regs->pc);
>> +		}
>>  		break;
>>  	case 5:
>>  		/*
>>  		 * isb - mcr p15, 0, Rt, c7, c5, 4
>>  		 */
>>  		isb();
>> +		trace_instruction_emulation(
>> +			"mcr p15, 0, Rt, c7, c5, 4", regs->pc);
>
> Any chance you can put the barrier name in here too please? Maybe as an asm
> comment, e.g.:
>
>   "mcr p15, 0, Rt, c7, c5, 4 ; isb"

Good point. I've added the barrier names as assembler comments.

Thanks.

>
> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
