From: dan.j.williams@intel.com (Dan Williams)
Date: Sun, 1 Nov 2015 12:51:09 -0800
Subject: [GIT PULL] memremap fix for 4.3 (v2)
In-Reply-To: <20151101203656.GR8644@n2100.arm.linux.org.uk>
References: <1446409463.10982.4.camel@intel.com>
 <20151101203656.GR8644@n2100.arm.linux.org.uk>
Message-ID: <CAPcyv4gyJJ0TuuTfLscByLz-z8dS=Z+VbBP302KuYucg7E-5_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 1, 2015 at 12:36 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Nov 01, 2015 at 08:24:25PM +0000, Williams, Dan J wrote:
>> diff --git a/kernel/memremap.c b/kernel/memremap.c
>> index 72b0c66628b6..9d6b55587eaa 100644
>> --- a/kernel/memremap.c
>> +++ b/kernel/memremap.c
>> @@ -24,6 +24,16 @@ __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
>>  }
>>  #endif
>>
>> +static void *try_ram_remap(resource_size_t offset, size_t size)
>> +{
>> +     struct page *page = pfn_to_page(offset >> PAGE_SHIFT);
>> +
>> +     /* In the simple case just return the existing linear address */
>> +     if (!PageHighMem(page))
>> +             return __va(offset);
>> +     return NULL; /* fallback to ioremap_cache */
>
> Right, so a highmem page results in this returning NULL, which will...
>
>> @@ -66,8 +76,8 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
>>                * the requested range is potentially in "System RAM"
>>                */
>>               if (is_ram == REGION_INTERSECTS)
>> -                     addr = __va(offset);
>> -             else
>> +                     addr = try_ram_remap(offset, size);
>> +             if (!addr)
>>                       addr = ioremap_cache(offset, size);
>
> cause ioremap_cache() to be called.  That falls through on ARM to:
>
>         __arm_ioremap_pfn_caller()
>
> and we will hit this (as I've mentioned before through explanation
> rather than quoting code):
>
>         /*
>          * Don't allow RAM to be mapped - this causes problems with ARMv6+
>          */
>         if (WARN_ON(pfn_valid(pfn)))
>                 return NULL;
>

Right, which means the caller is broken and shouldn't be using
memremap, same as misuse of ioremap_cache today.
