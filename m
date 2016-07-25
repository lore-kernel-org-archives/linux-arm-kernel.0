From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 25 Jul 2016 15:43:21 +0100
Subject: [PATCH 2/2] arm64: mm: run pgtable_page_ctor() on non-swapper
 translation table pages
In-Reply-To: <26dd79ee-8c0b-6302-85bf-3c6d69cab933@arm.com>
References: <1469208745-6693-1-git-send-email-ard.biesheuvel@linaro.org>
 <1469208745-6693-3-git-send-email-ard.biesheuvel@linaro.org>
 <26dd79ee-8c0b-6302-85bf-3c6d69cab933@arm.com>
Message-ID: <962833c8-0f5d-57bc-786e-9a832ed457d5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/07/16 15:31, Suzuki K Poulose wrote:
> On 22/07/16 18:32, Ard Biesheuvel wrote:
>> The kernel page table creation routines are accessible to other subsystems
>> (e.g., EFI) via the create_pgd_mapping() entry point, which allows mappings
>> to be created that are not covered by init_mm.
>>
>> Since generic code such as apply_to_page_range() may expect translation
>> table pages that are not associated with init_mm to be covered by fully
>> constructed struct pages, add a call to pgtable_page_ctor() in the alloc
>> function used by create_pgd_mapping. Since it is no longer used by
>> create_mapping_late(), also update the name of this function to better
>> reflect its purpose.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/mm/mmu.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 33f36cede02d..51a558195bb9 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -268,10 +268,11 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>>      } while (pgd++, addr = next, addr != end);
>>  }
>>
>> -static phys_addr_t late_pgtable_alloc(void)
>> +static phys_addr_t pgd_pgtable_alloc(void)
>>  {
>>      void *ptr = (void *)__get_free_page(PGALLOC_GFP);
>> -    BUG_ON(!ptr);
>> +    if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
>
> Should we free the page and return NULL when we encounter an error
> in pgtable_page_ctor(), like the rest of the callers ?
>
>
>> +        BUG();
>

Just to clarify, of course with the BUG() retained.

Suzuki
