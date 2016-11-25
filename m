From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 25 Nov 2016 17:01:01 +0000
Subject: [PATCH] arm64: mm: Fix memmap to be initialized for the entire
 section
In-Reply-To: <CAKv+Gu9h2YWJd8-+FhSYSftUsddj1f-HTA2D-6nC=8Wk6U1iAg@mail.gmail.com>
References: <CAKv+Gu8aWpz5vXSWdKHwL5Xk2aWyQBOoR1WHOnVPaWZOwqojBQ@mail.gmail.com>
 <20161124134238.GI10776@rric.localdomain>
 <CAKv+Gu_Ug3XOD6jy5xziy1pS7WV=TC0RLD4j3DT6nytujQDzRQ@mail.gmail.com>
 <20161124135151.GJ10776@rric.localdomain>
 <CAKv+Gu9qB7P2epMGdwFJ3vJR3vt-bBxU0nKwmKdpaOpTKdqzzA@mail.gmail.com>
 <20161124141149.GE2213@rric.localdomain>
 <CAKv+Gu-SXX_Vv1Wi1Nm=5vdaXSS0MBp20QBpQVacSKPLfdH0-A@mail.gmail.com>
 <20161124150918.GF2213@rric.localdomain>
 <20161124192659.GH2213@rric.localdomain>
 <CAKv+Gu_C_17RtAiw2U0OOzVik3G7KkwUTo5eiGK-HDo-maQ-bA@mail.gmail.com>
 <20161125112914.GI2213@rric.localdomain>
 <CAKv+Gu9h2YWJd8-+FhSYSftUsddj1f-HTA2D-6nC=8Wk6U1iAg@mail.gmail.com>
Message-ID: <CAKv+Gu8Hbf1sY4zMGoosYjGa1esApqP8a4Zs2Zqj4nNZ8AdtSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 November 2016 at 12:28, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 25 November 2016 at 11:29, Robert Richter <robert.richter@cavium.com> wrote:
>> On 24.11.16 19:42:47, Ard Biesheuvel wrote:
>>> On 24 November 2016 at 19:26, Robert Richter <robert.richter@cavium.com> wrote:
>>
>>> > I revisited the code and it is working well already since:
>>> >
>>> >  e7cd190385d1 arm64: mark reserved memblock regions explicitly in iomem
>>> >
>>> > Now, try_ram_remap() is only called if the region to be mapped is
>>> > entirely in IORESOURCE_SYSTEM_RAM. This is only true for normal mem
>>> > ranges and not NOMAP mem. region_intersects() then returns
>>> > REGION_INTERSECTS and calls try_ram_remap(). For the NOMAP memory case
>>> > REGION_DISJOINT would be returned and thus arch_memremap_wb() being
>>> > called directly. Before the e7cd190385d1 change try_ram_remap() was
>>> > called also for nomap regions.
>>> >
>>> > So we can leave memremap() as it is and just apply this patch
>>> > unmodified. What do you think?
>>>
>>> I agree. The pfn_valid() check in try_ram_remap() is still appropriate
>>> simply because the PageHighmem check requires a valid struct page. But
>>> if we don't enter that code path anymore for NOMAP regions, I think
>>> we're ok.
>>>
>>> > Please ack.
>>> >
>>>
>>> I still don't fully understand how it is guaranteed that *all* memory
>>> (i.e., all regions for which memblock_is_memory() returns true) is
>>> covered by a struct page, but marked as reserved. Are we relying on
>>> the fact that NOMAP memory is also memblock_reserve()'d?
>>
>> See free_low_memory_core_early():
>>
>> ----
>>         for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end,
>>                                 NULL)
>>                 count += __free_memory_core(start, end);
>> ----
>>
>> Only mem with the MEMBLOCK_NONE flag is added. And NOMAP pages are
>> also *not* marked reserved. So nothing at all from NOMAP mem is
>> reported to mm, it is not present (see below for a mem config, note
>> flags: 0x4 mem regions).
>>
>
> OK, thanks for clearing that up. But that still does not explain how
> we can be certain that NOMAP regions are guaranteed to be covered by a
> struct page, does it? Because that is ultimately what pfn_valid()
> means, that it is safe to, e.g., look at the page flags.
>

Answering to self: arm64_memory_present() registers all memory as
present, which means that sparse_init() will allocate struct page
backing for all of memory, including NOMAP regions.

We could ask ourselves whether it makes sense to disregard NOMAP
memory here, but that probably buys us very little (but I do wonder
how it affects the occurrence of the bug).

In any case, it looks to me like your patch is safe, i.e., calling
pfn_valid() on NOMAP pages is safe, although I still find it debatable
whether the kernel should be tracking memory it does not own. However,
for performance reasons, it probably makes sense to apply your patch,
and if anyone ever comes up with a use case where this is problematic
(e.g., gigabytes of NOMAP memory), we can look into it then.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
