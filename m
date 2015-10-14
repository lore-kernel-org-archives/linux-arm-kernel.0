From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 14 Oct 2015 14:21:24 +0100
Subject: [PATCHv3 02/11] arm64: Handle section maps for swapper/idmap
In-Reply-To: <20151014120618.GB2150@leverpostej>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-3-git-send-email-suzuki.poulose@arm.com>
 <20151014120618.GB2150@leverpostej>
Message-ID: <561E56D4.40506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/15 13:06, Mark Rutland wrote:
> On Wed, Oct 14, 2015 at 12:20:25PM +0100, Suzuki K. Poulose wrote:
>> We use section maps with 4K page size to create the swapper/idmaps.
>> So far we have used !64K or 4K checks to handle the case where we
>> use the section maps.
>> This patch adds a new symbol, ARM64_SWAPPER_USES_SECTION_MAPS, to
>> handle cases where we use section maps, instead of using the page size
>> symbols.
>>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/kernel-pgtable.h |   31 ++++++++-----
>>   arch/arm64/mm/mmu.c                     |   72 ++++++++++++++-----------------
>>   2 files changed, 52 insertions(+), 51 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
>> index 622929d..5876a36 100644
>> --- a/arch/arm64/include/asm/kernel-pgtable.h
>> +++ b/arch/arm64/include/asm/kernel-pgtable.h
>> @@ -19,6 +19,13 @@
>>   #ifndef __ASM_KERNEL_PGTABLE_H
>>   #define __ASM_KERNEL_PGTABLE_H
>>
>> +/* With 4K pages, we use section maps. */
>> +#ifdef CONFIG_ARM64_4K_PAGES
>> +#define ARM64_SWAPPER_USES_SECTION_MAPS 1
>> +#else
>> +#define ARM64_SWAPPER_USES_SECTION_MAPS 0
>> +#endif
>
> The comment is somewhat redunant. It would be better to state why we do
> this for 4K and not 64K (or 16K).

Something like :

/*
  * ARM64 kernel is guaranteed to be loaded at 2M aligned
  * address (as per booting requirements). Hence we can use
  * section mapping with 4K (section size = 2M) and not with
  * 16K(section size = 32M) or 64K (section size = 512M).
  */

>> +	 * us PUD_SIZE (with SECTION maps, i.e, 4K) or PMD_SIZE (without
>> +	 * SECTION maps, i.e, 64K pages) memory starting from PHYS_OFFSET
>> +	 * (which must be aligned to 2MB as per Documentation/arm64/booting.txt).
>
> This didn't seem to get updated for 16K later in the series, unless I
> missed something.
>
> Perhaps drop the mention of 4K / 64K entirely here?

You are right, I missed it. We can drop the pagesize info entirely.

>
>> @@ -551,7 +552,7 @@ int kern_addr_valid(unsigned long addr)
>>   	return pfn_valid(pte_pfn(*pte));
>>   }
>>   #ifdef CONFIG_SPARSEMEM_VMEMMAP
>> -#ifdef CONFIG_ARM64_64K_PAGES
>> +#if !ARM64_SWAPPER_USES_SECTION_MAPS
>
> This leaves the comments on the #else and #endif stale. Please update
> those too.

Done.

Thanks
Suzuki
