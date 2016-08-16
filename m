From: james.morse@arm.com (James Morse)
Date: Tue, 16 Aug 2016 11:13:45 +0100
Subject: [PATCH v24 5/9] arm64: kdump: add kdump support
In-Reply-To: <20160811100310.GA29357@localhost.localdomain>
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
 <20160809015615.28527-1-takahiro.akashi@linaro.org>
 <20160809015615.28527-3-takahiro.akashi@linaro.org>
 <57AB586D.3080900@arm.com> <20160810181827.GC24137@localhost.localdomain>
 <20160811100310.GA29357@localhost.localdomain>
Message-ID: <57B2E759.201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 11/08/16 11:03, Pratyush Anand wrote:
> On 10/08/2016:11:48:27 PM, Pratyush Anand wrote:
>> On 10/08/2016:05:38:05 PM, James Morse wrote:
>>> =========================%<=========================
>>> diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
>>> index 2dc54d129be1..784d4c30b534 100644
>>> --- a/arch/arm64/kernel/crash_dump.c
>>> +++ b/arch/arm64/kernel/crash_dump.c
>>> @@ -37,6 +37,11 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
>>>         if (!csize)
>>>                 return 0;
>>>
>>> +       if (memblock_is_memory(pfn << PAGE_SHIFT) &&
>>> +           !memblock_is_map_memory(pfn << PAGE_SHIFT))
>>> +               /* skip this nomap memory region, reserved by firmware */
>>> +               return 0;
> 
> This should return 0 or -EINVAL? because, its caller does not care properly
> about 0 return value (when csize is non-zero). So either we need to return
> -EINVAL or we need to fix it's caller so that pread() would know that required
> number of data were not read.

I blindly followed 'number of bytes copied' -> 0. It worked for me, but may not
be correct.

remap_oldmem_pfn_checked() looks like it substitutes the zero page in this (or
at least a similar) case, maybe we should do the same for nomap pages.


> 
>>> +
>>>         vaddr = ioremap_cache(__pfn_to_phys(pfn), PAGE_SIZE);
>>>         if (!vaddr)
>>>                 return -ENOMEM;
>>> =========================%<=========================
>>
>> In any case kernel must not panic, so I think we must have above hunk. However,
>> we also need to look into kexec-tools that why it is asking kernel to copy those
>> unneeded chunks.
>>
>> I will test tomorrow with above hunk.
> 
> After that hunk it did not crash but vmcore-dmesg fails with following message:
> "No program header covering vaddr 0x401ff0found kexec bug?"
> 
> It happened because vmcore-dmesg is sending wrong offset to the pread(), and so
> it did not crash after the above kernel hunk but it still read garbage wrong
> log_buf virtual address pointer.
> 
> vmcore-dmesg is sending wrong offset because page_offset(vp_offset) calculation
> is not perfect for my case, explained here [1].
> 
> So, if I correct page_offset(vp_offset) (as arm64_mem.page_offset = ehdr.e_entry
> - "kernel Code Start PA" + phys_offset), then vmcore-dmesg and vmcore copy
> worked fine, however if I use makedumpfile to copy(compressed) data from
> /proc/vmcore then it still generates "synchronous external abort". I think, it

At a guess makedumpfile is mmap()ing /proc/vmcore so it can use multiple
threads to read (then compress) the data. This bypasses the check added to
copy_oldmem_page(). We probably need to provide a remap_oldmem_pfn_range() that
checks whether the range contains nomap pages.

I will try and send a fixup patch to do this later this week, (unless someone
beats me to it!)


> generated because it would have found garbage data in EFI memory region.

If it was marked as belonging to efi in the efi memory map, the kernel shouldn't
be touching it. If you add 'efi=debug' to your kernel cmdline you get a table of
the addresses and properties.


Thanks,

James
