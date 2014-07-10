From: dave.hansen@intel.com (Dave Hansen)
Date: Thu, 10 Jul 2014 13:04:53 -0700
Subject: [RFC/PATCH RESEND -next 01/21] Add kernel address sanitizer
 infrastructure.
In-Reply-To: <CAPAsAGwYZ9AVUoOMipZEe8jdmJfd=aULR+yoVH5FqzW1Qa75AQ@mail.gmail.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>	<1404905415-9046-2-git-send-email-a.ryabinin@samsung.com>	<53BDA568.5030607@intel.com>	<53BE8333.6060404@samsung.com>	<53BEB77A.6020003@intel.com>
 <CAPAsAGwYZ9AVUoOMipZEe8jdmJfd=aULR+yoVH5FqzW1Qa75AQ@mail.gmail.com>
Message-ID: <53BEF1E5.2000502@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2014 12:48 PM, Andrey Ryabinin wrote:
>>>> How does this interact with vmalloc() addresses or those from a kmap()?
>>>>
>>> It's used only for lowmem:
>>>
>>> static inline bool addr_is_in_mem(unsigned long addr)
>>> {
>>>       return likely(addr >= PAGE_OFFSET && addr < (unsigned long)high_memory);
>>> }
>>
>> That's fine, and definitely covers the common cases.  Could you make
>> sure to call this out explicitly?  Also, there's nothing to _keep_ this
>> approach working for things out of the direct map, right?  It would just
>> be a matter of updating the shadow memory to have entries for the other
>> virtual address ranges.
> 
> Why do you want shadow for things out of the direct map? If you want
> to catch use-after-free in vmalloc than DEBUG_PAGEALLOC will be
> enough. If you want catch out-of-bounds in vmalloc you don't need
> anything, because vmalloc allocates guarding hole in the end. Or do
> you want something else?

That's all true for page-size accesses.  Address sanitizer's biggest
advantage over using the page tables is that it can do checks at
sub-page granularity.  But, we don't have any APIs that I can think of
that _care_ about <PAGE_SIZE outside of the direct map (maybe zsmalloc,
but that's pretty obscure).

So I guess it doesn't matter.
