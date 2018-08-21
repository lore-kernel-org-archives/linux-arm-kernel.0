From: james.morse@arm.com (James Morse)
Date: Tue, 21 Aug 2018 13:58:38 +0100
Subject: A crash on ARM64 in move_freepages_block due to uninitialized
 pages in reserved memory
In-Reply-To: <20180821104418.GA16611@dhcp22.suse.cz>
References: <alpine.LRH.2.02.1808171527220.2385@file01.intranet.prod.int.rdu2.redhat.com>
 <20180821104418.GA16611@dhcp22.suse.cz>
Message-ID: <e35b7c14-c7ea-412d-2763-c961b74576f3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On 08/21/2018 11:44 AM, Michal Hocko wrote:
> On Fri 17-08-18 15:44:27, Mikulas Patocka wrote:
>> I report this crash on ARM64 on the kernel 4.17.11. The reason is that the
>> function move_freepages_block accesses contiguous runs of
>> pageblock_nr_pages. The ARM64 firmware sets holes of reserved memory there
>> and when move_freepages_block stumbles over this hole, it accesses
>> uninitialized page structures and crashes.

Any idea if this is nomap (so a hole in the linear map), or a missing struct page?


>> 00000000-03ffffff : System RAM
>>    00080000-007bffff : Kernel code
>>    00820000-00aa3fff : Kernel data
>> 04200000-bf80ffff : System RAM
>> bf810000-bfbeffff : reserved
>> bfbf0000-bfc8ffff : System RAM
>> bfc90000-bffdffff : reserved
>> bffe0000-bfffffff : System RAM
>> c0000000-dfffffff : MEM
>>    c0000000-c00fffff : PCI Bus 0000:01
>>      c0000000-c0003fff : 0000:01:00.0
>>        c0000000-c0003fff : nvme
To test Laura's bounds-of-zone theory [0], could you put some empty space between the 
nvme and the System RAM? (It sounds like this is a KVM guest). Reducing the amount of 
memory is probably easiest.


>> The bug was already reported here for x86:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1598462
>>
>> For x86, it was fixed in the kernel 4.17.7 - but I observed it in the
>> kernel 4.17.11 on ARM64. I also observed it on 4.18-rc kernels running in
>> KVM virtual machine on ARM when I compiled the guest kernel with 64kB page
>> size.

I'm not sure this is the same bug.

[1] reports hitting a VM_BUG, this is a dereference of -ENOENT:
>> Unable to handle kernel paging request at virtual address fffffffffffffffe

Does your kernel have HOLES_IN_ZONE enabled? (It looks like it depends on NUMA)
Could you reproduce this with CONIG_DEBUG_VM enabled?

move_freepages() uses pfn_valid_within(), so it should handle missing struct pages in 
this range.


>> CPU: 3 PID: 14823 Comm: updatedb.mlocat Not tainted 4.17.11 #16
>> Hardware name: Marvell Armada 8040 MacchiatoBin/Armada 8040 MacchiatoBin, BIOS EDK II Jul 30 2018
>> pstate: 00000085 (nzcv daIf -PAN -UAO)
>> pc : move_freepages_block+0xb4/0x160
>> lr : steal_suitable_fallback+0xe4/0x188

Any chance you could addr2line these?


>> Call trace:
>>   move_freepages_block+0xb4/0x160
>>   get_page_from_freelist+0xad8/0xea8
>>   __alloc_pages_nodemask+0xac/0x970
>>   new_slab+0xc0/0x348
>>   ___slab_alloc.constprop.32+0x2cc/0x350
>>   __slab_alloc.isra.26.constprop.31+0x24/0x38
>>   kmem_cache_alloc+0x168/0x198
>>   spadfs_alloc_inode+0x2c/0x88
>>   alloc_inode+0x20/0xa0
>>   iget5_locked+0xf8/0x1c0

>>   spadfs_iget+0x44/0x4c8
>>   spadfs_lookup+0x70/0x108

Hmmm. What's this?


Thanks,

James


[0] https://www.spinics.net/lists/linux-mm/msg157223.html
[1] https://www.spinics.net/lists/linux-mm/msg156764.html
