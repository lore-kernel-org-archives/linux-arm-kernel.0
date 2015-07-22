From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Wed, 22 Jul 2015 17:44:42 +0300
Subject: [PATCH v3 1/5] mm: kasan: introduce generic
 kasan_populate_zero_shadow()
In-Reply-To: <CALW4P++z9oJhWNCLLOV0xChdbNVuqokEBmzut08XKfQe1viknw@mail.gmail.com>
References: <1437561037-31995-1-git-send-email-a.ryabinin@samsung.com>
 <1437561037-31995-2-git-send-email-a.ryabinin@samsung.com>
 <CALW4P++z9oJhWNCLLOV0xChdbNVuqokEBmzut08XKfQe1viknw@mail.gmail.com>
Message-ID: <55AFAC5A.5010507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2015 05:25 PM, Alexey Klimov wrote:
> Hi Andrey,
> 
> Could you please check minor comments below?
> 
> On Wed, Jul 22, 2015 at 1:30 PM, Andrey Ryabinin <a.ryabinin@samsung.com> wrote:
>> Introduce generic kasan_populate_zero_shadow(start, end).
>> This function maps kasan_zero_page to the [start, end] addresses.
>>
>> In follow on patches it will be used for ARMv8 (and maybe other
>> architectures) and will replace x86_64 specific populate_zero_shadow().
>>
>> Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
>> ---
>>  arch/x86/mm/kasan_init_64.c |   8 +--
>>  include/linux/kasan.h       |   8 +++
>>  mm/kasan/Makefile           |   2 +-
>>  mm/kasan/kasan_init.c       | 142 ++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 155 insertions(+), 5 deletions(-)
>>  create mode 100644 mm/kasan/kasan_init.c
>>
> 
> [..]
> 
>> diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
>> new file mode 100644
>> index 0000000..37fb46a
>> --- /dev/null
>> +++ b/mm/kasan/kasan_init.c
>> @@ -0,0 +1,142 @@
>> +#include <linux/bootmem.h>
>> +#include <linux/init.h>
>> +#include <linux/kasan.h>
>> +#include <linux/kernel.h>
>> +#include <linux/memblock.h>
>> +#include <linux/pfn.h>
>> +
>> +#include <asm/page.h>
>> +#include <asm/pgalloc.h>
>> +
> 
> Are you releasing code under GPL?
> Shouldn't there be any license header in such new file?
> 

Sure, will do.

...

>> +
>> +               if (pgd_none(*pgd)) {
>> +                       void *p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
>> +                       if (!p)
>> +                               return -ENOMEM;
>> +                       pgd_populate(&init_mm, pgd, p);
>> +               }
>> +               zero_pud_populate(pgd, addr, next);
> 
> But you're not checking return value after zero_pud_populate() and
> zero_pmd_populate() that might fail with ENOMEM.
> Is it critical here on init or can they be converted to return void?
> 
I think it's better to convert these functions to void.
BTW, this check after early_alloc() is pointless because early_alloc() will panic
if allocation failed.


> 
>> +/**
>> + * kasan_populate_zero_shadow - populate shadow memory region with
>> + *                               kasan_zero_page
>> + * @start - start of the memory range to populate
>> + * @end   - end of the memory range to populate
>> + */
>> +void __init kasan_populate_zero_shadow(const void *start, const void *end)
>> +{
>> +       if (zero_pgd_populate((unsigned long)start, (unsigned long)end))
>> +               panic("kasan: unable to map zero shadow!");
>> +}
>> --
>> 2.4.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> 
