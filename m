From: james.morse@arm.com (James Morse)
Date: Thu, 01 Dec 2016 17:26:55 +0000
Subject: [PATCH v2] arm64: mm: Fix memmap to be initialized for the entire
 section
In-Reply-To: <20161201164538.GB1236@arm.com>
References: <1480530091-1092-1-git-send-email-rrichter@cavium.com>
 <20161201164538.GB1236@arm.com>
Message-ID: <58405D5F.90805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert, Will,

On 01/12/16 16:45, Will Deacon wrote:
> On Wed, Nov 30, 2016 at 07:21:31PM +0100, Robert Richter wrote:
>> On ThunderX systems with certain memory configurations we see the
>> following BUG_ON():
>>
>>  kernel BUG at mm/page_alloc.c:1848!
>>
>> This happens for some configs with 64k page size enabled. The BUG_ON()
>> checks if start and end page of a memmap range belongs to the same
>> zone.
>>
>> The BUG_ON() check fails if a memory zone contains NOMAP regions. In
>> this case the node information of those pages is not initialized. This
>> causes an inconsistency of the page links with wrong zone and node
>> information for that pages. NOMAP pages from node 1 still point to the
>> mem zone from node 0 and have the wrong nid assigned.
>>
>> The reason for the mis-configuration is a change in pfn_valid() which
>> reports pages marked NOMAP as invalid:
>>
>>  68709f45385a arm64: only consider memblocks with NOMAP cleared for linear mapping
>>
>> This causes pages marked as nomap being no long reassigned to the new
>> zone in memmap_init_zone() by calling __init_single_pfn().
>>
>> Fixing this by restoring the old behavior of pfn_valid() to use
>> memblock_is_memory(). Also changing users of pfn_valid() in arm64 code
>> to use memblock_is_map_memory() where necessary. This only affects
>> code in ioremap.c. The code in mmu.c still can use the new version of
>> pfn_valid().
>>
>> As a consequence, pfn_valid() can not be used to check if a physical
>> page is RAM. It just checks if there is an underlying memmap with a
>> valid struct page. Moreover, for performance reasons the whole memmap
>> (with pageblock_nr_pages number of pages) has valid pfns (SPARSEMEM
>> config). The memory range is extended to fit the alignment of the
>> memmap. Thus, pfn_valid() may return true for pfns that do not map to
>> physical memory. Those pages are simply not reported to the mm, they
>> are not marked reserved nor added to the list of free pages. Other
>> functions such a page_is_ram() or memblock_is_map_ memory() must be
>> used to check for memory and if the page can be mapped with the linear
>> mapping.

[...]

> Thanks for sending out the new patch. Whilst I'm still a bit worried about
> changing pfn_valid like this, I guess we'll just have to fix up any callers
> which suffer from this change.

Hibernate's core code falls foul of this. This patch causes a panic when copying
memory to build the 'image'[0].
saveable_page() in kernel/power/snapshot.c broadly assumes that pfn_valid()
pages can be accessed.

Fortunately the core code exposes pfn_is_nosave() which we can extend to catch
'nomap' pages, but only if they are also marked as PageReserved().

Are there any side-effects of marking all the nomap regions with
mark_page_reserved()? (it doesn't appear to be the case today).


Patches incoming...


Thanks,

James


[0] panic trace
root at juno-r1:~# echo disk > /sys/power/state
[   56.914184] PM: Syncing filesystems ... [   56.918853] done.
[   56.920826] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   56.930383] PM: Preallocating image memory... done (allocated 97481 pages)
[   60.566084] PM: Allocated 389924 kbytes in 3.62 seconds (107.71 MB/s)
[   60.572576] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   60.604877] PM: freeze of devices complete after 23.146 msecs
[   60.611230] PM: late freeze of devices complete after 0.578 msecs
[   60.618609] PM: noirq freeze of devices complete after 1.247 msecs
[   60.624833] Disabling non-boot CPUs ...
[   60.649112] CPU1: shutdown
[   60.651823] psci: CPU1 killed.
[   60.701055] CPU2: shutdown
[   60.703766] psci: CPU2 killed.
[   60.745002] IRQ11 no longer affine to CPU3
[   60.745043] CPU3: shutdown
[   60.751890] psci: CPU3 killed.
[   60.784966] CPU4: shutdown
[   60.787676] psci: CPU4 killed.
[   60.824916] IRQ8 no longer affine to CPU5
[   60.824920] IRQ9 no longer affine to CPU5
[   60.824927] IRQ18 no longer affine to CPU5
[   60.824931] IRQ20 no longer affine to CPU5
[   60.824951] CPU5: shutdown
[   60.843975] psci: CPU5 killed.
[   60.857989] PM: Creating hibernation image:
[   60.857989] PM: Need to copy 96285 pages
[   60.857989] Unable to handle kernel paging request at virtual address
ffff8000794a0000
[   60.857989] pgd = ffff800975190000
[   60.857989] [ffff8000794a0000] *pgd=0000000000000000[   60.857989]
[   60.857989] Internal error: Oops: 96000007 [#1] PREEMPT SMP
[   60.857989] Modules linked in:
[   60.857989] CPU: 0 PID: 2366 Comm: bash Not tainted
4.9.0-rc7-00001-gecf7c47af54d #6346
[   60.857989] Hardware name: ARM Juno development board (r1) (DT)
[   60.857989] task: ffff8009766d3200 task.stack: ffff800975fec000
[   60.857989] PC is at swsusp_save+0x250/0x2c8
[   60.857989] LR is at swsusp_save+0x214/0x2c8
[   60.857989] pc : [<ffff000008100bd0>] lr : [<ffff000008100b94>] pstate: 200003c5
[   60.857989] sp : ffff800975fefb50
[   60.857989] x29: ffff800975fefb50 x28: ffff800975fec000
[   60.857989] x27: ffff0000088c2000 x26: 0000000000000040
[   60.857989] x25: 00000000000f94a0 x24: ffff000008e437e8
[   60.857989] x23: 000000000001781d x22: ffff000008bee000
[   60.857989] x21: ffff000008e437f8 x20: ffff000008e43878
[   60.857989] x19: ffff7e0000000000 x18: 0000000000000006
[   60.857989] x17: 0000000000000000 x16: 00000000000005d0
[   60.857989] x15: ffff000008e43e95 x14: 00000000000001d9
[   60.857989] x13: 0000000000000001 x12: ffff7e0000000000
[   60.857989] x11: ffff7e0025ffffc0 x10: 0000000025ffffc0
[   60.857989] x9 : 000000000000012f x8 : ffff80096cd04ce0
[   60.857989] x7 : 0000000000978000 x6 : 0000000000000076
[   60.857989] x5 : fffffffffffffff8 x4 : 0000000000080000
[   60.857989] x3 : ffff8000794a0000 x2 : ffff800959d83000
[   60.857989] x1 : 0000000000000000 x0 : ffff7e0001e52800

[   60.857989] Process bash (pid: 2366, stack limit = 0xffff800975fec020)
[   60.857989] Stack: (0xffff800975fefb50 to 0xffff800975ff0000)
[   60.857989] Call trace:
[   60.857989] [<ffff000008100bd0>] swsusp_save+0x250/0x2c8
[   60.857989] [<ffff0000080936ec>] swsusp_arch_suspend+0xb4/0x100
[   60.857989] [<ffff0000080fe670>] hibernation_snapshot+0x278/0x318
[   60.857989] [<ffff0000080fef10>] hibernate+0x1d0/0x268
[   60.857989] [<ffff0000080fc954>] state_store+0xdc/0x100
[   60.857989] [<ffff00000838419c>] kobj_attr_store+0x14/0x28
[   60.857989] [<ffff00000825be68>] sysfs_kf_write+0x48/0x58
[   60.857989] [<ffff00000825b1f8>] kernfs_fop_write+0xb0/0x1d8
[   60.857989] [<ffff0000081e2ddc>] __vfs_write+0x1c/0x110
[   60.857989] [<ffff0000081e3bd8>] vfs_write+0xa0/0x1b8
[   60.857989] [<ffff0000081e4f44>] SyS_write+0x44/0xa0
[   60.857989] [<ffff000008082ef0>] el0_svc_naked+0x24/0x28
[   60.857989] Code: d37ae442 d37ae463 b2514042 b2514063 (f8636820)
[   60.857989] ---[ end trace d0265b757c9dd571 ]---
[   60.857989] ------------[ cut here ]------------
