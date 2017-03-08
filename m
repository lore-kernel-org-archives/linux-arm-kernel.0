From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 8 Mar 2017 23:06:49 +0100
Subject: Creating kernel mappings for memory initially marked with bootmem
 NOMAP?
In-Reply-To: <91620f16-7c0f-970e-eefb-d92cc948656f@gmail.com>
References: <c17b0a16-fde5-9254-f84a-418972201eae@gmail.com>
 <98B5CAFC-C183-42C5-935A-E9E0C30867E8@linaro.org>
 <91620f16-7c0f-970e-eefb-d92cc948656f@gmail.com>
Message-ID: <CAKv+Gu-407iiKgCZczA-FjxZ9Md=knEvqi=JQNzAR5_7ofP18w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 March 2017 at 20:52, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 03/08/2017 11:14 AM, Ard Biesheuvel wrote:
>>
>>> On 8 Mar 2017, at 20:03, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>
>>> Hi,
>>>
>>> On our platforms (brcmstb) we have an use case where we boot with some
>>> (a lot actually) memory carved out and marked initially with bootmem
>>> NOMAP in order for this memory not to be mapped in the kernel's linear
>>> mapping.
>>>
>>> Now, we have some peripherals that want large chunks of physically and
>>> virtually contiguous memory that belong to these memblock NOMAP ranges.
>>> I have no problems using mmap() against this memory, because the kernel
>>> will do what is necessary for a process to map it for me. The struggle
>>> is for a kernel driver which specifies a range of physical memory and
>>> size, and expects a virtually contiguous mapping in return (not using
>>> DMA-API, because reasons).
>>>
>>> Essentially the problem is that there are no PTEs created for these
>>> memory regions (and pfn_valid() returns 0, since this is NOMAP memory),
>>> so I have been playing with __add_pages() from the memory hotplug code
>>> in an attempt to get proper page references to this memory, but I am
>>> clearly missing something.
>>>
>>> Yes I know it's a terrible idea, but what if I wanted to get that working?
>>>
>>
>> Did you try memremap?
>
> Not yet, because this is done on 4.1 at the moment, but I will
> definitively give this a try, thanks a lot!
>
> Side note: on a kernel that does not have memremap() (such as 4.1),
> would not an ioremap_cache() on the physical range marked as NOMAP
> result in the same behavior anyway? ioremap() won't catch the fact that
> we are mapping RAM, since this is NOMAP, pfn_valid() returns 0.
>
> My understanding of the pfn_valid() check for ioremap() is to avoid
> mapping the same DRAM location twice with potentially conflicting
> attributes, but if it has not been mapped at all, as is the case with
> NOMAP, does not that get me the same results?
>

Yes, it does. But ioremap_cache() is deprecated for mapping normal
memory. There remains a case for ioremap_cache() on ARM for mapping
NOR flash (which is arguably a device) with cacheable attributes, but
for the general case of mapping DRAM, you should not expect new code
using ioremap_cache() to be accepted upstream.
