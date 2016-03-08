From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 8 Mar 2016 12:09:43 -0800
Subject: [PATCH] Revert "arm64: vmemmap: use virtual projection of linear
 region"
In-Reply-To: <56DF274A.4070802@redhat.com>
References: <1457463792-6852-1-git-send-email-ddaney.cavm@gmail.com>
 <56DF274A.4070802@redhat.com>
Message-ID: <56DF3187.7010901@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2016 11:26 AM, Laura Abbott wrote:
> On 03/08/2016 11:03 AM, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> This reverts commit dfd55ad85e4a7fbaa82df12467515ac3c81e8a3e.
>>
>> Commit dfd55ad85e4a ("arm64: vmemmap: use virtual projection of linear
>> region") causes this failure on Cavium Thunder systems:
>>
[...]
>
> See http://article.gmane.org/gmane.linux.ports.arm.kernel/484866 for a
> proposed fix.
>

Yes, that patch fixes it for me.  I withdraw my patch to revert.

Thanks,
David Daney

>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   arch/arm64/include/asm/pgtable.h | 7 +++----
>>   arch/arm64/mm/init.c             | 4 ++--
>>   2 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h
>> b/arch/arm64/include/asm/pgtable.h
>> index f506086..bf464de 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -34,13 +34,13 @@
>>   /*
>>    * VMALLOC and SPARSEMEM_VMEMMAP ranges.
>>    *
>> - * VMEMAP_SIZE: allows the whole linear region to be covered by a
>> struct page array
>> + * VMEMAP_SIZE: allows the whole VA space to be covered by a struct
>> page array
>>    *    (rounded up to PUD_SIZE).
>>    * VMALLOC_START: beginning of the kernel VA space
>>    * VMALLOC_END: extends to the available space below vmmemmap, PCI
>> I/O space,
>>    *    fixed mappings and modules
>>    */
>> -#define VMEMMAP_SIZE        ALIGN((1UL << (VA_BITS - PAGE_SHIFT - 1))
>> * sizeof(struct page), PUD_SIZE)
>> +#define VMEMMAP_SIZE        ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) *
>> sizeof(struct page), PUD_SIZE)
>>
>>   #ifndef CONFIG_KASAN
>>   #define VMALLOC_START        (VA_START)
>> @@ -51,8 +51,7 @@
>>
>>   #define VMALLOC_END        (PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE -
>> SZ_64K)
>>
>> -#define VMEMMAP_START        (VMALLOC_END + SZ_64K)
>> -#define vmemmap            ((struct page *)VMEMMAP_START -
>> (memstart_addr >> PAGE_SHIFT))
>> +#define vmemmap            ((struct page *)(VMALLOC_END + SZ_64K))
>>
>>   #define FIRST_USER_ADDRESS    0UL
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 7802f21..f3b061e 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -319,8 +319,8 @@ void __init mem_init(void)
>>   #endif
>>             MLG(VMALLOC_START, VMALLOC_END),
>>   #ifdef CONFIG_SPARSEMEM_VMEMMAP
>> -          MLG(VMEMMAP_START,
>> -              VMEMMAP_START + VMEMMAP_SIZE),
>> +          MLG((unsigned long)vmemmap,
>> +              (unsigned long)vmemmap + VMEMMAP_SIZE),
>>             MLM((unsigned long)virt_to_page(PAGE_OFFSET),
>>                 (unsigned long)virt_to_page(high_memory)),
>>   #endif
>>
>
