From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Aug 2016 10:16:55 +0100
Subject: [PATCH 5/8] arm64: alternative: Add support for patching adrp
 instructions
In-Reply-To: <CAKv+Gu8XAny8hun=O2Wahpz7p6pSb_tXdv8WHyD3HB52_wBsnQ@mail.gmail.com>
References: <1471525832-21209-1-git-send-email-suzuki.poulose@arm.com>
 <1471525832-21209-6-git-send-email-suzuki.poulose@arm.com>
 <CAKv+Gu8XAny8hun=O2Wahpz7p6pSb_tXdv8WHyD3HB52_wBsnQ@mail.gmail.com>
Message-ID: <3c727d40-0ea8-fb2d-7d51-3d47b96e96c4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/08/16 12:45, Ard Biesheuvel wrote:
> On 18 August 2016 at 15:10, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
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
>>                         offset = target - (unsigned long)insnptr;
>>                         insn = aarch64_set_branch_offset(insn, offset);
>>                 }
>> +       } else if (aarch64_insn_is_adrp(insn)) {
>> +               s32 orig_offset, new_offset;
>> +               unsigned long target;
>> +
>> +               /*
>> +                * If we're replacing an adrp instruction, which uses PC-relative
>> +                * immediate addressing, adjust the offset to reflect the new
>> +                * PC. adrp operates on 4K aligned addresses.
>> +                */
>> +               orig_offset  = aarch64_insn_adrp_get_offset(insn);
>> +               target = ((unsigned long)altinsnptr & ~0xfffUL) + orig_offset;
>> +               new_offset = target - ((unsigned long)insnptr & ~0xfffUL);
>> +               insn = aarch64_insn_adrp_set_offset(insn, new_offset);
>
> Are orig_offset and new_offset guaranteed to be equal modulo 4 KB?
> Otherwise, you will have to track down and patch the associated :lo12:
> add/ldr instruction as well.

We are modifying the alternative instruction to accommodate for the new PC,
where this instruction will be executed from, while the referenced symbol
remains the same. Hence the associated :lo12: doesn't change. Does that
address your concern ? Or did I miss something ?

Suzuki
