From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 7 Oct 2015 10:51:16 +0100
Subject: [PATCH 03/15] arm64: Introduce helpers for page table levels
In-Reply-To: <20151007082652.GM9011@cbox>
References: <1442331684-28818-1-git-send-email-suzuki.poulose@arm.com>
 <1442331684-28818-4-git-send-email-suzuki.poulose@arm.com>
 <20151007082652.GM9011@cbox>
Message-ID: <5614EB14.9040107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/15 09:26, Christoffer Dall wrote:
> Hi Suzuki,
>
> On Tue, Sep 15, 2015 at 04:41:12PM +0100, Suzuki K. Poulose wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>
>> Introduce helpers for finding the number of page table
>> levels required for a given VA width, shift for a particular
>> page table level.
>>
>> Convert the existing users to the new helpers. More users
>> to follow.
>>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>   arch/arm64/include/asm/pgtable-hwdef.h |   15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>> index 24154b0..ce18389 100644
>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>> @@ -16,13 +16,21 @@
>>   #ifndef __ASM_PGTABLE_HWDEF_H
>>   #define __ASM_PGTABLE_HWDEF_H
>>
>> +/*
>> + * Number of page-table levels required to address 'va_bits' wide
>> + * address, without section mapping
>> + */
>> +#define ARM64_HW_PGTABLE_LEVELS(va_bits) (((va_bits) - 4) / (PAGE_SHIFT - 3))
>
> I don't understand the '(va_bits) - 4' here, can you explain it (and add a
> comment to that effect) ?

As mentioned, I will change it to DIV_ROUND_UP() as suggested by Marc.

>
>> +#define ARM64_HW_PGTABLE_LEVEL_SHIFT(level) \
>> +		((PAGE_SHIFT - 3) * (level) + 3)
>> +
>
> While this change is clearly correct, if you can explain the math here
> in a comment as well, that would be helpful.

Sure, will add a comment to that effect.

Suzuki
