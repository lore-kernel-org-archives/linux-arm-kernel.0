From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 28 Jan 2015 22:00:04 +0000
Subject: [PATCH] ARM: teach __asmeq that r12 and ip are the same register
In-Reply-To: <alpine.LFD.2.11.1501281636170.1322@knanqh.ubzr>
References: <1422480618-25371-1-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.LFD.2.11.1501281636170.1322@knanqh.ubzr>
Message-ID: <CAKv+Gu_zXwLdREs1NogW4GaoYiXQz-d4HqJ6KsEPV0q-gPrVTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 January 2015 at 21:46, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Wed, 28 Jan 2015, Ard Biesheuvel wrote:
>
>> The __asmeq macro is used inside inline asm statements to ensure that
>> register asm variables that explicitly specify a register are mapped
>> correctly onto those registers when used in inline asm input and output
>> constraints. However, the string based matching fails to take into account
>> that 'ip' may also be referred to as 'r12', (e.g., by clang), causing false
>> negatives.
>>
>> Fix this by making __asmeq consider the ("ip","r12") and ("r12","ip")
>> cases specifically.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> gcc is likely to do the same substitution with r10 ("sl") and r11
> ("fp").  Might as well add them right away for completeness.
>

I just checked with my 4.8 gcc toolchain: r11 indeed gets emitted as
fp when used in inline asm, but r10 is just r10.
So I should update the patch to include fp as well.

> Then, does clang call sp, lr, pc as r13, r14 and r15? I guess not as
> this is probably against the latest ARM assembly conventions.
>

@Behan, could you answer this one?

>> ---
>> Even though clang shouldn't be susceptible to the same bug, there is still
>> value in retaining these assertions there, so instead of just turning
>> __asmeq into a nop if __clang__ is defined, let's make it work correctly.
>>
>>  arch/arm/include/asm/compiler.h | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/compiler.h b/arch/arm/include/asm/compiler.h
>> index 8155db2f7fa1..c3a316a59710 100644
>> --- a/arch/arm/include/asm/compiler.h
>> +++ b/arch/arm/include/asm/compiler.h
>> @@ -8,8 +8,11 @@
>>   * This string is meant to be concatenated with the inline asm string and
>>   * will cause compilation to stop on mismatch.
>>   * (for details, see gcc PR 15089)
>> + * For compatibility with clang, we have to explicitly take the equivalence
>> + * of 'r12' and 'ip into account as well.
>>   */
>> -#define __asmeq(x, y)  ".ifnc " x "," y " ; .err ; .endif\n\t"
>> +#define __asmeq(x, y)  ".ifnc " x "," y " ; .ifnc " x y ",ipr12 ; " \
>> +     ".ifnc " x y ",r12ip ; .err ; .endif ; .endif ; .endif\n\t"
>>
>>
>>  #endif /* __ASM_ARM_COMPILER_H */
>> --
>> 1.8.3.2
>>
>>
