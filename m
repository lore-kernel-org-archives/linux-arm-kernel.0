From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 1 Oct 2015 21:39:02 +0530
Subject: [PATCH] arm64: Fix THP protection change logic
In-Reply-To: <20151001140755.GF6963@e104818-lin.cambridge.arm.com>
References: <1443701167-10816-1-git-send-email-steve.capper@linaro.org>
 <20151001140755.GF6963@e104818-lin.cambridge.arm.com>
Message-ID: <CAFpQJXVssNN46+fQmqYiiA0hQ0uCMtVHFQKPUeK39dmM1Pxcvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Steve.
this patch fixes the issue i was facing when running applications
(which forms thp) with auto numa enabled.

Tested-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>

On Thu, Oct 1, 2015 at 7:37 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Oct 01, 2015 at 01:06:07PM +0100, Steve Capper wrote:
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 56283f8..cf73194 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -80,7 +80,7 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
>>  #define PAGE_S2                      __pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY)
>>  #define PAGE_S2_DEVICE               __pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_UXN)
>>
>> -#define PAGE_NONE            __pgprot(((_PAGE_DEFAULT) & ~PTE_TYPE_MASK) | PTE_PROT_NONE | PTE_PXN | PTE_UXN)
>> +#define PAGE_NONE            __pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_PXN | PTE_UXN)
>>  #define PAGE_SHARED          __pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
>>  #define PAGE_SHARED_EXEC     __pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_WRITE)
>>  #define PAGE_COPY            __pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN)
>> @@ -460,7 +460,7 @@ static inline pud_t *pud_offset(pgd_t *pgd, unsigned long addr)
>>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>  {
>>       const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
>> -                           PTE_PROT_NONE | PTE_WRITE | PTE_TYPE_MASK;
>> +                           PTE_PROT_NONE | PTE_VALID | PTE_WRITE;
>>       pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
>>       return pte;
>>  }
>
> Thanks for looking into this. So for ptes, we need the type bits to be:
>
> 0b?0: unmapped/PAGE_NONE
> 0b11: mapped
>
> With pmd block (huge page), we want:
>
> 0b?0: unmapped/PAGE_NONE
> 0b01: mapped
>
> With your fix, bit 1 is no longer touched by pte_modify(). It looks fine
> to me. Another option would have been a separate pmd_modify() function
> with its own mask but I think it's cleaner this way.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
> Let's see if it fixes the issue for Ganapatrao and Will or I will send
> it upstream.
>
> --
> Catalin
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

thanks
Ganapat
