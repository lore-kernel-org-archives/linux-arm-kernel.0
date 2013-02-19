From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 19 Feb 2013 15:45:20 +0530
Subject: EDMA and kernel panic (null pointer) on da830
In-Reply-To: <20130218163940.380e4a42@pcnovotny-t.fit.vutbr.cz>
References: <20130218163940.380e4a42@pcnovotny-t.fit.vutbr.cz>
Message-ID: <512350B8.8020301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ LAKML and Matt

On 2/18/2013 9:09 PM, Tomas Novotny wrote:
> 	Hi all,
> 
> I'm working on custom board based on AM1707, which is quite similar to
> EVM. Board file is derived from board-da830-evm.c.
> 	I'm unable to boot because of null pointer access in edma after
> upgrading linux-davinci to v3.7-davinci1. The DMA was working in 3.3
> on my board.
> 	The pointer is accessed in the arch/arm/mach-davinci/dma.c in
> function edma_alloc_slot on the line 750:
> slot = edma_cc[ctlr]->num_channels;
> 	The problem is, that allocation is performed also with ctlr =
> 1, which shouldn't (?) be done on AM1707, as there is only one channel
> controller.
> 	I can see the problem on v3.7-davinci1 and latest commit
> (c03f8ea25) in the linux-davinci. I don't have EVM now, so I can't
> check untouched v3.7-davinci1. But changes are done only in the board
> file and DMA related code is the same.
> 	Is anybody here, who has similar issue? Or is it working for
> anybody here on the da830?
> 	If you want, I can post more information. For beginning, kernel
> log is attached.
> 	Thanks and best regards,
> 
> 	Stoupa
> 
> DEBUG switched on in dma.c; added own print of pointer in the
> edma_alloc_slot:
> Booting Linux on physical CPU 0x0
> Linux version 3.8.0-rc7-08807-g00c74d8-dirty (tom at pcnovotny-t) (gcc version 4.6.3 (Sourcery CodeBench Lite 2012.03-57) ) #118 PREEM...
> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
> CPU: VIVT data cache, VIVT instruction cache
> Machine: ELKO EP iNELS Central Unit 3
> bootconsole [earlycon0] enabled
> Memory policy: ECC disabled, Data cache writeback
> DaVinci da830/omap-l137 rev2.0 variant 0x9
> On node 0 totalpages: 16384
> free_area_init_node: node 0, pgdat c038e0e0, node_mem_map c03ac000
>   DMA zone: 128 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 16256 pages, LIFO batch:3
> pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> pcpu-alloc: [0] 0 
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
> Kernel command line: console=ttyS1,115200n8 noinitrd rw rootwait rootfstype=jffs2 root=mtd3 mtdparts=davinci_nand.1:128k(u-boot_env)ro...
> PID hash table entries: 256 (order: -2, 1024 bytes)
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> __ex_table already sorted, skipping sort
> Memory: 64MB = 64MB total
> Memory: 61168k/61168k available, 4368k reserved, 0K highmem
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     vmalloc : 0xc4800000 - 0xff000000   ( 936 MB)
>     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
>       .text : 0xc0008000 - 0xc03441c8   (3313 kB)
>       .init : 0xc0345000 - 0xc0365e00   ( 132 kB)
>       .data : 0xc0366000 - 0xc038eb60   ( 163 kB)
>        .bss : 0xc038eb60 - 0xc03ab578   ( 115 kB)
> SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> NR_IRQS:245
> sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
> Calibrating delay loop... 148.88 BogoMIPS (lpj=744448)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> Setting up static identity map for 0xc02af890 - 0xc02af8cc
> DaVinci: 128 gpio irqs
> NET: Registered protocol family 16
> DMA: preallocated 256 KiB pool for atomic coherent allocations
> edma edma: DMA REG BASE ADDR=fec00000
> bio: create slab <bio-0> at 0
> EDMA: edma_alloc_slot: edma_cc[ctlr]: c3847000
> edma-dma-engine edma-dma-engine.0: TI EDMA DMA engine driver
> EDMA: edma_alloc_slot: edma_cc[ctlr]:   (null)
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 5 [#1] PREEMPT ARM
> CPU: 0    Not tainted  (3.8.0-rc7-08807-g00c74d8-dirty #118)
> PC is at edma_alloc_slot+0x8c/0xf4
> LR is at edma_alloc_slot+0x84/0xf4
> pc : [<c0013ac4>]    lr : [<c0013abc>]    psr: 60000053
> sp : c3823e40  ip : 00000001  fp : 00000000
> r10: c034520c  r9 : c0365b9c  r8 : c0383908
> r7 : c038ee54  r6 : c038ee54  r5 : 00000001  r4 : c386af10
> r3 : c3822000  r2 : 00000001  r1 : 00000000  r0 : 00000000                             
> Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel                   
> Control: 0005317f  Table: c0004000  DAC: 00000017                                      
> Process swapper (pid: 1, stack limit = 0xc38221b8)                                     
> Stack: (0xc3823e40 to 0xc3824000)                                                      
> 3e40: 00000000 c386af10 c386af00 c387a010 00000000 c019c2b8 c03a6590 20000053
> 3e60: c386af10 00000000 c0383908 c0365b9c c034520c c01b7520 c01b750c c01b65c4
> 3e80: c386af10 c01b67e0 00000000 00000000 c03a656c c01b5028 c381f068 c385d5d4
> 3ea0: c386af44 c386af10 c386af10 c01b630c c386af10 c0384290 c386af10 c01b5258
> 3ec0: c386af10 c386af18 c03841d0 c01b38bc 00000000 00000000 00000000 c0172c74
> 3ee0: c3823f08 c386af00 c386af10 c386af00 c386af10 00000000 c038eb60 00000043
> 3f00: c0365b9c c034520c 00000000 c01b7c6c 00000000 c386af00 c019c5dc c038eb60
> 3f20: 00000043 c01b80d4 00000000 c03a5b9c 00000000 c019c614 c3823f48 00000000
> 3f40: c019c5dc c03457e4 00000004 00000004 c0376608 c035d070 00000004 c035d074
> 3f60: 00000004 c035d054 c038eb60 00000043 c0365b9c c03459a8 00000004 00000004
> 3f80: c034520c c003e5a0 00000000 c02a9370 00000000 00000000 00000000 00000000
> 3fa0: 00000000 c02a9378 00000000 c00092d0 00000000 00000000 00000000 00000000
> 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 e3d181c2 3474dcfc
> [<c0013ac4>] (edma_alloc_slot+0x8c/0xf4) from [<c019c2b8>] (edma_probe+0x34/0x254)
> [<c019c2b8>] (edma_probe+0x34/0x254) from [<c01b7520>] (platform_drv_probe+0x14/0x18)
> [<c01b7520>] (platform_drv_probe+0x14/0x18) from [<c01b65c4>] (driver_probe_device+0x78/0x204)
> [<c01b65c4>] (driver_probe_device+0x78/0x204) from [<c01b5028>] (bus_for_each_drv+0x60/0x88)
> [<c01b5028>] (bus_for_each_drv+0x60/0x88) from [<c01b630c>] (device_attach+0x80/0x98)
> [<c01b630c>] (device_attach+0x80/0x98) from [<c01b5258>] (bus_probe_device+0x84/0xa8)
> [<c01b5258>] (bus_probe_device+0x84/0xa8) from [<c01b38bc>] (device_add+0x534/0x600)
> [<c01b38bc>] (device_add+0x534/0x600) from [<c01b7c6c>] (platform_device_add+0x100/0x2b4)
> [<c01b7c6c>] (platform_device_add+0x100/0x2b4) from [<c01b80d4>] (platform_device_register_full+0xcc/0xf4)
> [<c01b80d4>] (platform_device_register_full+0xcc/0xf4) from [<c019c614>] (edma_init+0x38/0x88)
> [<c019c614>] (edma_init+0x38/0x88) from [<c03457e4>] (do_one_initcall+0x94/0x16c)
> [<c03457e4>] (do_one_initcall+0x94/0x16c) from [<c03459a8>] (kernel_init_freeable+0xec/0x1b4)
> [<c03459a8>] (kernel_init_freeable+0xec/0x1b4) from [<c02a9378>] (kernel_init+0x8/0xe4)
> [<c02a9378>] (kernel_init+0x8/0xe4) from [<c00092d0>] (ret_from_fork+0x14/0x24)
> Code: e7962105 eb0a5be7 e7960105 e1a07006 (e5904000) 
> ---[ end trace c4da3ea0506c5146 ]---
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

So this seems to be coming because of an incorrect assumption in
drivers/dma/edma.c that all DA8XX devices have two channel controllers
where as only the DA850 has two and DA830 has one. The right fix seems
to be to actually start using platform device probe mechanism for DMA
engine instead of bypassing it.

Matt, can you fix this?

Tomas, You can check that the crash goes away if you define EDMA_CTLRS
to 1 all the time in drivers/dma/edma.c (of course this will break da850).

Thanks,
Sekhar
