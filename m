From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Thu, 7 Dec 2017 12:29:43 +0000
Subject: [RFC 3/9] arm64: handle 52-bit addresses in TTBR
In-Reply-To: <8ebb78d3-68b0-3272-e12b-005c1b524736@arm.com>
References: <1511265485-27163-1-git-send-email-kristina.martsenko@arm.com>
 <1511265485-27163-4-git-send-email-kristina.martsenko@arm.com>
 <8ebb78d3-68b0-3272-e12b-005c1b524736@arm.com>
Message-ID: <42182cdd-be9f-841f-6fda-1486ac2ded2f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/11/17 14:39, Robin Murphy wrote:
> Hi Kristina,
> 
> On 21/11/17 11:57, Kristina Martsenko wrote:
>> The top 4 bits of a 52-bit physical address are positioned at bits 2..5
>> in the TTBR registers. Introduce a couple of macros to move the bits
>> there, and change all TTBR writers to use them.
>>
>> Leave TTBR0 PAN code unchanged, to avoid complicating it. A system with
>> 52-bit PA will have PAN anyway (because it's ARMv8.1 or later), and a
>> system without 52-bit PA can only use up to 48-bit PAs. Add a kconfig
>> dependency to ensure PAN is configured.
>>
>> In addition, when using 52-bit PA there is a special alignment
>> requirement on the top-level table. We don't currently have any VA_BITS
>> configuration that would violate the requirement, but one could be added
>> in the future, so add a compile-time BUG_ON to check for it.
>>
>> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
>> ---

[...]

>> diff --git a/arch/arm64/include/asm/assembler.h
>> b/arch/arm64/include/asm/assembler.h
>> index 04cf94766b78..ba3c796b9fe1 100644
>> --- a/arch/arm64/include/asm/assembler.h
>> +++ b/arch/arm64/include/asm/assembler.h
>> @@ -512,4 +512,21 @@ alternative_else_nop_endif
>> ? #endif
>> ????? .endm
>> ? +/*
>> + * Arrange a physical address in a TTBR register, taking care of 52-bit
>> + * addresses.
>> + *
>> + *???? phys:??? physical address, preserved
>> + *???? ttbr:??? returns the TTBR value
>> + */
>> +??? .macro??? phys_to_ttbr, phys, ttbr
>> +#ifdef CONFIG_ARM64_PA_BITS_52
>> +??? and??? \ttbr, \phys, #(1 << 48) - 1
>> +??? orr??? \ttbr, \ttbr, \phys, lsr #48 - 2
>> +??? bic??? \ttbr, \ttbr, #(1 << 2) - 1
> 
> Is there any reason for masking off each end of the result separately
> like this, or could we just do it more straightforwardly?

I don't recall any reason, maybe just to keep it simple, to avoid having
a separate mask macro.

> #define TTBR_BADDR_MASK ((1 << 46) - 1) << 2
> 
> ????orr??? \ttbr, \phys, \phys, lsr #46
> ????and??? \ttbr, \ttbr, #TTBR_BADDR_MASK
> 
> (and equivalently for phys_to_pte in patch 4)

Ok, I'll rewrite it like this. (Note that mask is 52-bit-specific though.)

> Even better if there's a convenient place to define the mask such that
> it can be shared with KVM's existing VTTBR stuff too.

Do you mean VTTBR_BADDR_MASK? I don't think this would be useful there,
VTTBR_BADDR_MASK checks the alignment of the address that goes into
VTTBR (not the VTTBR value itself), and takes into account specifically
the 40-bit IPA and concatenated page tables.

Kristina

>> +#else
>> +??? mov??? \ttbr, \phys
>> +#endif
>> +??? .endm
>> +
>> ? #endif??? /* __ASM_ASSEMBLER_H */
