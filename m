From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 16 Mar 2017 12:04:26 -0700
Subject: Creating kernel mappings for memory initially marked with bootmem
 NOMAP?
In-Reply-To: <ade0bca0-6547-29cc-ce0c-7520d9292d55@gmail.com>
References: <c17b0a16-fde5-9254-f84a-418972201eae@gmail.com>
 <98B5CAFC-C183-42C5-935A-E9E0C30867E8@linaro.org>
 <91620f16-7c0f-970e-eefb-d92cc948656f@gmail.com>
 <CAKv+Gu-407iiKgCZczA-FjxZ9Md=knEvqi=JQNzAR5_7ofP18w@mail.gmail.com>
 <ade0bca0-6547-29cc-ce0c-7520d9292d55@gmail.com>
Message-ID: <ef89ec74-91da-b519-6520-8772beca2e28@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2017 02:10 PM, Florian Fainelli wrote:
>> Yes, it does. But ioremap_cache() is deprecated for mapping normal
>> memory. There remains a case for ioremap_cache() on ARM for mapping
>> NOR flash (which is arguably a device) with cacheable attributes, but
>> for the general case of mapping DRAM, you should not expect new code
>> using ioremap_cache() to be accepted upstream.
> 
> This is very likely going to remain out of tree, and I will keep an eye
> on migrating this to memremap() when we update to a newer kernel. Thanks!

And now I have another interesting problem, self inflicted of course. We
have this piece of code here in mm/gup.c [1] which is meant to allow
doing O_DIRECT on pages that are now marked as NOMAP.

Our middle-ware does a mmap() of some regions initially marked as NOMAP
such that it can access this memory and do a mapping "on demand" only
when using these physical memory regions. The use case for O_DIRECT is
to playback a file directly from e.g: a local hard drive it provides a
significant enough performance boost we want to keep bypassing the page
cache.

After removing the check in the above mentioned piece of code for
!pfn_valid() and making it a !memblock_is_memory(__pfn_to_phys(pfn)) I
can move on and everything seems to be fine, except that eventually, we
have the following call trace:

ata_qc_issue -> arm_dma_map_sg -> arm_dma_map_page ->
__dma_page_cpu_to_dev -> dma_cache_maint_page

[  170.253148] [00000000] *pgd=07b0e003, *pmd=0bc31003, *pte=00000000
[  170.262157] Internal error: Oops: 207 [#1] SMP ARM
[  170.279088] CPU: 1 PID: 1688 Comm: nx_io_worker0 Tainted: P
O    4.1.20-1.8pre-01028-g970868a93bbc-dirty #6
[  170.289708] Hardware name: Broadcom STB (Flattened Device Tree)
[  170.295635] task: cd16d500 ti: c7340000 task.ti: c7340000
[  170.301048] PC is at dma_cache_maint_page+0x70/0x140
[  170.306019] LR is at __dma_page_cpu_to_dev+0x2c/0xa8
[  170.310989] pc : [<c001cbec>]    lr : [<c001cce8>]    psr: 60010093
[  170.310989] sp : c7341af8  ip : 00000000  fp : c0e3a300
[  170.322479] r10: 00000002  r9 : c00219a4  r8 : c0e6c740
[  170.327709] r7 : 00000000  r6 : 00010000  r5 : feb8cca0  r4 : fff5c665
[  170.334244] r3 : c0e0a4a8  r2 : 0000007f  r1 : 0000fff5  r0 : ce97aca0
[  170.340779] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment user
[  170.348009] Control: 30c5387d  Table: 07c351c0  DAC: 55555555

and that's actually coming from the fact that we have SPARSEMEM
(actually SPARSEMEM && SPARSEMEM_MANUAL && SPARSEMEM_EXTREME) enabled
for this platform and __section_mem_map_addr() de-references
section->section_mem_map and section is NULL here as a result of a call
to __page_to_pfn() and __pfn_to_page().

So I guess my question is: if a process is mapping some physical memory
through /dev/mem, could sparsemem somehow populate that section
corresponding to this PFN? Everything I see seems to occur at boot time
and when memory hotplug is used (maybe I should start using memory hotplug).

Thanks!

[1]:
https://github.com/Broadcom/stblinux-4.1/blob/master/linux/mm/gup.c#L388
-- 
Florian
