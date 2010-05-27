From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 27 May 2010 17:13:28 +0200
Subject: SPARSEMEM support for Atmel AT91SAM9G45 and M10
In-Reply-To: <4BFE2A3F.2010606@visionsystems.de>
References: <AANLkTin3-rqG2o0t4rbggpCE2cFAV6GWeH0v7UjC1tnQ@mail.gmail.com>
	<201005261610.32937.marek.vasut@gmail.com>
	<4BFE2A3F.2010606@visionsystems.de>
Message-ID: <201005271713.28491.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 27. kv?tna 2010 10:15:59 Yegor Yefremov napsal(a):
> Marek Vasut schrieb:
> > Dne St 26. kv?tna 2010 15:46:21 Yegor Yefremov napsal(a):
> >>>     I'm resurrecting an old thread
> >>> 
> >>> (http://lists.arm.linux.org.uk/lurker/message/20090914.072902.97115112.
> >>> en .html) about using the two memory banks available
> >>> on Atmel AT91SAM9G45/M10. I managed to make it work on 2.6.30 by
> >>> following Russell King advice on how to configure SPARSEMEM.
> >>> 
> >>>     I submitted a working patch for 2.6.34 here:
> >>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6143/1
> >>> 
> >>> The problem is that I'm unsure how to get rid of the #define that
> >>> forces high_memory value in mm/init.c, should I add a fixup function
> >>> to board-sam9m10g45ek.c to provide meminfo information ?
> >> 
> >> I've already tested the patch on 2.6.33 and it is working properly.
> >> Concerning high_memory value problem I think the cause is how
> >> find_node_limits() in arch/arm/m/init.c is implemented. We have two
> >> memory banks one starting at 0x70000000 and another at 0x200000000. The
> >> virtual mapping looks like this:
> >> 
> >> 0x70000000 -> 0xc0000000
> >> 0x20000000 -> 0xc8000000
> >> 
> >> However find_node_limits() routine is working with physical addresses so
> >> the upper limit is 0x70000000 and not 0x20000000 as it should be. As a
> >> result max_low is pointing to 0x70000000 and that's why only first bank
> >> will be mapped correctly.
> >> 
> >> How can find_node_limits() be changed to work with virtual addresses?
> >> 
> >> Regards,
> >> Yegor
> > 
> > Hey, try searching for "[PATCH 1/5] pxa/vpac270: Enable SparseMEM for 256
> > MB of RAM" ... The device has also one memory bank mapped under the
> > primary one. Maybe that can help. Cheers
> 
> Marek, I've looked at patch and apart from defining HIGH_MEMORY_VIRT it
> does the same. Nevertheless if I don't define HIGH_MEMORY_VIRT I get the
> following crash (I've added debug string showing calculated high_memory.
> It should be 0xd0000000 and not 0xc8000000):
> 
> Linux version 2.6.33.2 (OpenRISC at VScom) (gcc version 4.3.2
> (crosstool-NG-1.3.2) ) #30 Thu May 27 10:06:42 CEST 2010
> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
> CPU: VIVT data cache, VIVT instruction cache
> Machine: Atmel AT91SAM9G45-EKES
> Memory policy: ECC disabled, Data cache writeback
> DBG: high_memory 0xc8000000
> Clocks: CPU 400 MHz, master 133 MHz, main 12.000 MHz
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 62720
> Kernel command line: console=ttyS0,115200 root=/dev/mtdblock2 rootwait
> PID hash table entries: 1024 (order: 0, 4096 bytes)
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 128MB 128MB = 256MB total
> Memory: 255036KB available (3944K code, 303K data, 140K init, 0K highmem)
> Hierarchical RCU implementation.
> NR_IRQS:192
> AT91: 160 gpio irqs in 5 banks
> Console: colour dummy device 80x30
> console [ttyS0] enabled
> Calibrating delay loop... 199.47 BogoMIPS (lpj=997376)
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency:
> ------------[ cut here ]------------
> WARNING: at mm/vmalloc.c:107 vmap_page_range_noflush+0x128/0x1d8()
> Modules linked in:
> [<c0031894>] (unwind_backtrace+0x0/0xdc) from [<c0043c34>]
> (warn_slowpath_common+0x4c/0x80) [<c0043c34>]
> (warn_slowpath_common+0x4c/0x80) from [<c008df9c>]
> (vmap_page_range_noflush+0x128/0x1d8) [<c008df9c>]
> (vmap_page_range_noflush+0x128/0x1d8) from [<c008e074>]
> (map_vm_area+0x28/0x50) [<c008e074>] (map_vm_area+0x28/0x50) from
> [<c008e4f8>] (vmap+0x48/0x6c) [<c008e4f8>] (vmap+0x48/0x6c) from
> [<c000cf60>] (check_writebuffer_bugs+0x5c/0x134) [<c000cf60>]
> (check_writebuffer_bugs+0x5c/0x134) from [<c0008b9c>]
> (start_kernel+0x31c/0x388) [<c0008b9c>] (start_kernel+0x31c/0x388) from
> [<70008034>] (0x70008034) ---[ end trace 1b75b31a2719ed1c ]---
> ------------[ cut here ]------------
> WARNING: at mm/vmalloc.c:107 vmap_page_range_noflush+0x128/0x1d8()
> Modules linked in:
> [<c0031894>] (unwind_backtrace+0x0/0xdc) from [<c0043c34>]
> (warn_slowpath_common+0x4c/0x80) [<c0043c34>]
> (warn_slowpath_common+0x4c/0x80) from [<c008df9c>]
> (vmap_page_range_noflush+0x128/0x1d8) [<c008df9c>]
> (vmap_page_range_noflush+0x128/0x1d8) from [<c008e074>]
> (map_vm_area+0x28/0x50) [<c008e074>] (map_vm_area+0x28/0x50) from
> [<c008e4f8>] (vmap+0x48/0x6c) [<c008e4f8>] (vmap+0x48/0x6c) from
> [<c000cf78>] (check_writebuffer_bugs+0x74/0x134) [<c000cf78>]
> (check_writebuffer_bugs+0x74/0x134) from [<c0008b9c>]
> (start_kernel+0x31c/0x388) [<c0008b9c>] (start_kernel+0x31c/0x388) from
> [<70008034>] (0x70008034) ---[ end trace 1b75b31a2719ed1d ]---
> failed, unable to map memory
> 
> Any ideas?
> 
> Yegor

Do you have CONFIG_HIGHMEM enabled ? If so, why ?
