From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 4 Jan 2016 18:33:03 +0100
Subject: [PATCH] arm64: fix relocation of movz instruction with negative
 immediate
In-Reply-To: <20160104171749.GA4436@e103592.cambridge.arm.com>
References: <1451923762-8387-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160104171749.GA4436@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu_T8PUZszv3RpC+nHrjKV_3gdqO1UjxizLQOYqBUQU5hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 January 2016 at 18:21, Dave Martin <Dave.Martin@arm.com> wrote:
> On Mon, Jan 04, 2016 at 05:09:22PM +0100, Ard Biesheuvel wrote:
>> The test whether a movz instruction with a signed immediate should be
>> turned into a movn instruction (i.e., when the immediate is negative)
>> is flawed, since the value of imm is always positive. So check sval
>> instead.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/kernel/module.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
>> index f4bc779e62e8..39e4a29cab50 100644
>> --- a/arch/arm64/kernel/module.c
>> +++ b/arch/arm64/kernel/module.c
>> @@ -128,7 +128,7 @@ static int reloc_insn_movw(enum aarch64_reloc_op op, void *place, u64 val,
>
> #define AARCH64_INSN_IMM_MOVNZ          AARCH64_INSN_IMM_MAX
> #define AARCH64_INSN_IMM_MOVK           AARCH64_INSN_IMM_16
>
> /* ... */
>
>         if (imm_type == AARCH64_INSN_IMM_MOVNZ) {
>
> /* ... */
>
>>                * immediate is less than zero.
>>                */
>>               insn &= ~(3 << 29);
>> -             if ((s64)imm >= 0) {
>> +             if (sval >= 0) {
>>                       /* >=0: Set the instruction to MOVZ (opcode 10b). */
>>                       insn |= 2 << 29;
>>               } else {
>
> I _think_ this may be correct, but...
>
>                 }
>                 imm_type = AARCH64_INSN_IMM_MOVK;
>         }
>
>         /* Update the instruction with the new encoding. */
>         insn = aarch64_insn_encode_immediate(imm_type, insn, imm);
>
> /* ... */
>
> leaves imm_type as either AARCH64_INSN_IMM_16 or AARCH64_INSN_IMM_MOVK.
>
> But because AARCH64_INSN_IMM_16 == AARCH64_INSN_IMM_MOVK (required for , the negative
> overflow fudge is never applied, no?
>
>         if (imm_type != AARCH64_INSN_IMM_16) {
>                 sval++;
>                 limit++;
>         }
>
>
> I'm wondering whether there is a less confusing way to do all this...
>

I hadn't spotted that AARCH64_INSN_IMM_16 == AARCH64_INSN_IMM_MOVK, so
you are correct that my single change is not sufficient to fix this
code.

Let me try to come up with something better ..
