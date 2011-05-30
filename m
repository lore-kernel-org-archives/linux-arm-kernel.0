From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Mon, 30 May 2011 09:02:46 +0200
Subject: ep93xx: status/future of the sparsemem support
In-Reply-To: <20110529223557.GC5576@n2100.arm.linux.org.uk>
References: <20110529130644.GI16318@ibawizard.net>
	<20110529223557.GC5576@n2100.arm.linux.org.uk>
Message-ID: <20110530070246.GJ16318@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> [2011-05-29 23:35:57]:

> Have you tried enabling highmem?

Yes, it was my first attempt, but it didn't booted, here's the log:

	Memory policy: ECC disabled, Data cache writeback
	bootmem::init_bootmem_core nid=0 start=0 map=77fa end=7800 mapsize=f00
	bootmem::mark_bootmem_node nid=0 start=0 end=800 reserve=0 flags=0
	bootmem::__free nid=0 start=0 end=800
	bootmem::mark_bootmem_node nid=0 start=1000 end=1800 reserve=0 flags=0
	bootmem::__free nid=0 start=1000 end=1800
	bootmem::mark_bootmem_node nid=0 start=2000 end=2800 reserve=0 flags=0
	bootmem::__free nid=0 start=2000 end=2800
	bootmem::mark_bootmem_node nid=0 start=3000 end=3800 reserve=0 flags=0
	bootmem::__free nid=0 start=3000 end=3800
	bootmem::mark_bootmem_node nid=0 start=4000 end=4800 reserve=0 flags=0
	bootmem::__free nid=0 start=4000 end=4800
	bootmem::mark_bootmem_node nid=0 start=5000 end=5800 reserve=0 flags=0
	bootmem::__free nid=0 start=5000 end=5800
	bootmem::mark_bootmem_node nid=0 start=6000 end=6800 reserve=0 flags=0
	bootmem::__free nid=0 start=6000 end=6800
	bootmem::mark_bootmem_node nid=0 start=7000 end=7800 reserve=0 flags=0
	bootmem::__free nid=0 start=7000 end=7800
	bootmem::mark_bootmem_node nid=0 start=4 end=2bd reserve=1 flags=0
	bootmem::__reserve nid=0 start=4 end=2bd flags=0
	bootmem::mark_bootmem_node nid=0 start=77fa end=7800 reserve=1 flags=0
	bootmem::__reserve nid=0 start=77fa end=7800 flags=0
	On node 0 totalpages: 32768
	bootmem::alloc_bootmem_core nid=0 size=1cf0000 [7408 pages] align=20 goal=3fffffff limit=0
	bootmem::alloc_bootmem_core nid=0 size=1cf0000 [7408 pages] align=20 goal=0 limit=0
	free_area_init_node: node 0, pgdat c029ea1c, node_mem_map 00000000
	  Normal zone: 240 pages used for memmap
	  Normal zone: 0 pages reserved
	  Normal zone: 16144 pages, LIFO batch:3
	bootmem::alloc_bootmem_core nid=0 size=c [1 pages] align=20 goal=3fffffff limit=0
	bootmem::__reserve nid=0 start=0 end=1 flags=1
	bootmem::alloc_bootmem_core nid=0 size=400 [1 pages] align=20 goal=3fffffff limit=0
	bootmem::__reserve nid=0 start=1 end=1 flags=1

Tracked the hang today down to set_page_zone() and added panic there also:

	set_page_links() calling set_page_zone: page 0x  (null) zone: 0x0 node: 0x0 pfn: 0x0
	Kernel panic - not syncing: ehm
	Backtrace: 
	[<c0025e78>] (dump_backtrace+0x0/0x10c) from [<c01fbcac>] (dump_stack+0x18/0x1c)
	 r6:00000000 r5:00000000 r4:c029f760 r3:00000000
	[<c01fbc94>] (dump_stack+0x0/0x1c) from [<c01fbd18>] (panic+0x68/0x198)
	[<c01fbcb0>] (panic+0x0/0x198) from [<c001cc38>] (memmap_init_zone+0xac/0xe0)
	 r3:00000000 r2:c028d898 r1:00000000 r0:c025d640
	 r7:00000000
	[<c001cb8c>] (memmap_init_zone+0x0/0xe0) from [<c000f6f8>] (free_area_init_node+0x348/0x400)
	 r7:00000000 r6:00000000 r5:00000000 r4:c029ea1c
	[<c000f3b0>] (free_area_init_node+0x0/0x400) from [<c000a7b8>] (bootmem_init+0x224/0x260)
	[<c000a594>] (bootmem_init+0x0/0x260) from [<c000bcf4>] (paging_init+0x710/0x7a4)
	[<c000b5e4>] (paging_init+0x0/0x7a4) from [<c0009c20>] (setup_arch+0x3a8/0x6ec)
	[<c0009878>] (setup_arch+0x0/0x6ec) from [<c000874c>] (start_kernel+0x78/0x2b8)
	[<c00086d4>] (start_kernel+0x0/0x2b8) from [<0000803c>] (0x803c)
	 r7:c028adec r6:c001e0d0 r5:c0288038 r4:c0007175

Hope it helps. 

> One of the problems with this kind of physical memory layout is that it
> doesn't allow mathematical offsets between physical and virtual address
> spaces.  Consider 0x00000000 phys -> 0xc0000000 virt, so 0xe0000000
> phys -> 0xa0000000 virt which will be in userspace!

Yep, I've seen that overlap also, so that's why I've tried to enable the
highmem.

> So we either have to play stupid games with the translation functions and
> introduce non-linear translations (as per my message which you pointed to),
> or go the highmem route which avoids the issue entirely.

I agree, but according to the log above I've assumed, that simply flatmem will
use just the first 64MB (as it didn't touched the second memory bank), so I've
moved to sparsemem.

-- ynezz
