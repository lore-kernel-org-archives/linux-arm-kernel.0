From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 5 Jun 2017 12:35:35 +0000
Subject: [PATCH] mm: vmalloc: make vmalloc_to_page() deal with PMD/PUD
 mappings
In-Reply-To: <97a535d8-f9d5-57b2-4b9c-23a0e6df7cc8@intel.com>
References: <20170602112720.28948-1-ard.biesheuvel@linaro.org>
 <e98368d8-b1bc-5804-2115-370ec7109e9b@intel.com>
 <CAKv+Gu964bDsV52gZ7QCJf26kXVaWgmuwXZSm0qWxa-34Eqttw@mail.gmail.com>
 <747b71d8-86a7-3b96-cf90-60d6c2ce0171@intel.com>
 <CAKv+Gu_0cQDyRP0urZEF6OAn7cOEVH3WXL2UpDgg6wKUrWcRYA@mail.gmail.com>
 <97a535d8-f9d5-57b2-4b9c-23a0e6df7cc8@intel.com>
Message-ID: <CAKv+Gu9CR3N4C6Xuc9aTtSbgSgMHXtPEKeEnkxssk3NmffqgTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 June 2017 at 18:18, Dave Hansen <dave.hansen@intel.com> wrote:
> On 06/02/2017 09:21 AM, Ard Biesheuvel wrote:
>>> First of all, this math isn't guaranteed to work.  We don't guarantee
>>> virtual contiguity for all mem_map[]s.  I think you need to go to a pfn
>>> or paddr first, add the pud offset, then convert to a 'struct page'.
>>
>> OK, so you are saying the slice of the struct page array covering the
>> range could be discontiguous even though the physical range it
>> describes is contiguous? (which is guaranteed due to the nature of a
>> PMD mapping IIUC) In that case,
>
> Yes.
>
>>> But, what *is* the right thing to return here?  Do the users here want
>>> the head page or the tail page?
>>
>> Hmm, I see what you mean. The vread() code that I am trying to fix
>> simply kmaps the returned page, copies from it and unmaps it, so it is
>> after the tail page. But I guess code that is aware of compound pages
>> is after the head page instead.
>
> Yeah, and some operations happen on tail pages while others get
> redirected to the head page.
>

OK. So given that vmalloc() never allocates compound pages, and vmap()
does not deal with them at all, we should be able to safely assume
that vmalloc_to_page() callers are interested in the tail page only.

>>> BTW, _are_ your huge vmalloc pages compound?
>>
>> Not in the case that I am trying to solve, no. They are simply VM_MAP
>> mappings of sequences of pages that are occupied by the kernel itself,
>> and not allocated by the page allocator.
>
> Huh, so what are they?  Are they system RAM that was bootmem allocated
> or something?
>

They are static mappings of vmlinux segments. I.e., on my system I have

vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
  .text : 0xffff2125f4ce0000 - 0xffff2125f5670000   (  9792 KB)
.rodata : 0xffff2125f5670000 - 0xffff2125f5a30000   (  3840 KB)
  .init : 0xffff2125f5a30000 - 0xffff2125f5e50000   (  4224 KB)
  .data : 0xffff2125f5e50000 - 0xffff2125f5f8ba00   (  1263 KB)
   .bss : 0xffff2125f5f8ba00 - 0xffff2125f609692c   (  1068 KB)

where KASLR may place these segments anywhere in the VMALLOC region.
Mark has suggested that these regions should not intersect, but in my
opinion, given that the VMALLOC region already contains executable
code and associated data (for kernel modules), and may already contain
huge mappings (for HUGE_VMAP), it is reasonable to expect shared code
to at least tolerate such mappings.

As Mark pointed out, pmd_huge()/pud_huge() may not work as expected
depending on the kernel configuration, so I will respin the patch to
take HUGE_VMAP into account for those definitions as well.

-- 
Ard.



>>>>>> +#else
>>>>>> +     VIRTUAL_BUG_ON(1);
>>>>>> +#endif
>>>>>> +     return page;
>>>>>> +}
>>>>> So if somebody manages to call this function on a huge page table entry,
>>>>> but doesn't have hugetlbfs configured on, we kill the machine?
>>>> Yes. But only if you have CONFIG_DEBUG_VIRTUAL defined, in which case
>>>> it seems appropriate to signal a failure rather than proceed with
>>>> dereferencing the huge PMD entry as if it were a table entry.
>>>
>>> Why kill the machine rather than just warning and returning NULL?
>>
>> I know this is generally a bad thing, but in this case, when a debug
>> option has been enabled exactly for this purpose, I think it is not
>> inappropriate to BUG() when encountering such a mapping. But I am
>> happy to relax it to a WARN() and return NULL instead, but in that
>> case, it should be unconditional imo and not based on
>> CONFIG_DEBUG_VIRTUAL or the likes.
>
> Sounds sane to me.
