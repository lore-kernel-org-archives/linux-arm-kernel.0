From: james.morse@arm.com (James Morse)
Date: Fri, 02 Dec 2016 14:48:48 +0000
Subject: [PATCH v2] arm64: mm: Fix memmap to be initialized for the entire
 section
In-Reply-To: <20161202071157.GQ2213@rric.localdomain>
References: <1480530091-1092-1-git-send-email-rrichter@cavium.com>
 <20161201164538.GB1236@arm.com> <58405D5F.90805@arm.com>
 <20161202071157.GQ2213@rric.localdomain>
Message-ID: <584189D0.2060907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 02/12/16 07:11, Robert Richter wrote:
> On 01.12.16 17:26:55, James Morse wrote:
>> On 01/12/16 16:45, Will Deacon wrote:
>>> Thanks for sending out the new patch. Whilst I'm still a bit worried about
>>> changing pfn_valid like this, I guess we'll just have to fix up any callers
>>> which suffer from this change.
>>
>> Hibernate's core code falls foul of this. This patch causes a panic when copying
>> memory to build the 'image'[0].
>> saveable_page() in kernel/power/snapshot.c broadly assumes that pfn_valid()
>> pages can be accessed.
>>
>> Fortunately the core code exposes pfn_is_nosave() which we can extend to catch
>> 'nomap' pages, but only if they are also marked as PageReserved().
>>
>> Are there any side-effects of marking all the nomap regions with
>> mark_page_reserved()? (it doesn't appear to be the case today).
> 
> Reserving the page adds it to the memory management which is what we
> would like to avoid for NOMAP pages. I don't believe we should do
> this. Since NOMAP is to some degree now core functionality I would
> rather implement pfn_is_nomap() that defaults to pfn_is_valid() but
> calls memblock_is_nomap() for arm64 or does something equivalent.

I thought the adjust_managed_page_count() code was just fiddling with some
counters. I will change it to call SetPageReserved() directly which will just
set the bit in struct page's flags. I will post these shortly as the 'fixes' way
of solving the hibernate fallout.


I guess any arch that uses memblock nomap needs core code to take account of it,
but at the moment that is just arm/arm64. If we are adding new pfn_is_ calls, we
could try and clean up pfn_valid() users to use pfn_is_memory(), pfn_is_mapped()
or pfn_has_memmap(). Part of the problem is 'valid' means different things to
different people.


> The question arises what to do with that mem at all. There could be
> mappings by the kernel, e.g. of acpi tables. We can't assume the mem
> regions still come out the same from the BIOS during resume.

Unfortunately we have to assume this. If the firmware reserved regions move
around in memory we can't resume from hibernate. Other OS also require this not
to happen. ([0] 'firmware memory requirements')

Hibernate core code checks the number of pages of kernel memory is the same
before trying to resume. If you just move the allocations around this will panic
during resume as the resume kernel will have surprising holes in its linear map.
x86 recently grew an MD5sum check of the e820 memory map, I intend to do the
same for memblock.

The theory is this would only happen if you change the hardware in some way, and
that otherwise the firmware is entirely deterministic...


> Do we
> need to save the mem? I can't answer that as I don't know much about
> hibernation yet.

Hibernate only save/restores the linear map and CPU state. We expect firmware to
put equivalent data in the same places for its nomap regions. If the region
belongs to a device, its up to the device driver to tidy up. (It has
freeze/thaw/resume callbacks to do this).


Thanks,

James

[0]
https://msdn.microsoft.com/en-gb/windows/hardware/commercialize/manufacture/desktop/uefi-requirements-boot-time-runtime-hibernation-state--s4
