From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Aug 2016 10:39:01 +0100
Subject: [PATCH 5/8] arm64: alternative: Add support for patching adrp
 instructions
In-Reply-To: <20160822111921.GC14680@arm.com>
References: <1471525832-21209-1-git-send-email-suzuki.poulose@arm.com>
 <1471525832-21209-6-git-send-email-suzuki.poulose@arm.com>
 <20160822111921.GC14680@arm.com>
Message-ID: <74075792-8e10-2b6f-7df2-47c0f9e91fcf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/08/16 12:19, Will Deacon wrote:
> On Thu, Aug 18, 2016 at 02:10:29PM +0100, Suzuki K Poulose wrote:
>> adrp uses PC-relative address offset to a page (of 4K size) of
>> a symbol. If it appears in an alternative code patched in, we
>> should adjust the offset to reflect the address where it will
>> be run from. This patch adds support for fixing the offset
>> for adrp instructions.
>>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Andre Przywara <andre.przywara@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  arch/arm64/kernel/alternative.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
>> index d2ee1b2..71c6962 100644
>> --- a/arch/arm64/kernel/alternative.c
>> +++ b/arch/arm64/kernel/alternative.c
>> @@ -80,6 +80,19 @@ static u32 get_alt_insn(struct alt_instr *alt, u32 *insnptr, u32 *altinsnptr)
>>  			offset = target - (unsigned long)insnptr;
>>  			insn = aarch64_set_branch_offset(insn, offset);
>>  		}
>> +	} else if (aarch64_insn_is_adrp(insn)) {
>> +		s32 orig_offset, new_offset;
>> +		unsigned long target;
>> +
>> +		/*
>> +		 * If we're replacing an adrp instruction, which uses PC-relative
>> +		 * immediate addressing, adjust the offset to reflect the new
>> +		 * PC. adrp operates on 4K aligned addresses.
>> +		 */
>> +		orig_offset  = aarch64_insn_adrp_get_offset(insn);
>> +		target = ((unsigned long)altinsnptr & ~0xfffUL) + orig_offset;
>> +		new_offset = target - ((unsigned long)insnptr & ~0xfffUL);
>
> The masking with ~0xfffUL might be nicer if you write it as
> align_down(ptr, SZ_4K);

Right, that definitely looks better. Will change it.

>
>> +		insn = aarch64_insn_adrp_set_offset(insn, new_offset);
>>  	}
>>
>>  	return insn;
>
> I wonder if we shouldn't have a catch-all for any instructions performing
> PC-relative operations here, because silent corruption of the instruction

Correct, which is what happened initially when I didn't have the adrp handling ;-).

> stream is pretty horrible. What other instructions are there? ADR, LDR
> (literal), ... ?

 From a quick look, all the instructions under "Load register (literal)" :

i.e,
LDR (literal) for GPR/FP_SIMD/32bit/64bit
LDRSW (literal)
PRFM (literal)

and Data processing instructions - immediate group with PC-relative addressing:

ADR, ADRP

I will add a check to catch the unsupported instructions in the alternative code.

Thanks
Suzuki
