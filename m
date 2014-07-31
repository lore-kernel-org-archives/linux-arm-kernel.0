From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Jul 2014 15:53:54 +0100
Subject: Bad Page dump (help)
In-Reply-To: <20140729201750.GO17808@saruman.home>
References: <20140729190700.GN17808@saruman.home>
 <20140729195547.GE30282@n2100.arm.linux.org.uk>
 <20140729201750.GO17808@saruman.home>
Message-ID: <20140731145354.GM30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 03:17:50PM -0500, Felipe Balbi wrote:
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.16.0-rc7-next-20140729-00002-g4169dc8-dirty (balbi at saruman) (gcc version 4.8.2 20130902 (prerelease) (crosstool-NG linaro-1.13.1-4.8-2013.09 - Linaro GCC 2013.09) ) #590 SMP Tue Jul 29 15:13:32 CDT 2014
> [    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] Machine model: TI AM437x Industrial Development Kit
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] memblock_reserve: [0x00000080008340-0x0000008118240f] flags 0x0 arm_memblock_init+0x20/0x1a0
> [    0.000000] memblock_reserve: [0x00000080004000-0x00000080007fff] flags 0x0 arm_memblock_init+0x11c/0x1a0
> [    0.000000] memblock_reserve: [0x0000008fff5000-0x0000008fffcfff] flags 0x0 early_init_fdt_scan_reserved_mem+0x30/0x8c
> [    0.000000] memblock_reserve: [0x000000ae800000-0x000000af7fffff] flags 0x0 memblock_alloc_range_nid+0x38/0x5c
> [    0.000000] cma: Reserved 16 MiB at ae800000
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0x40000000 reserved size = 0x21860d0
> [    0.000000]  memory.cnt  = 0x1
> [    0.000000]  memory[0x0]	[0x00000080000000-0x000000bfffffff], 0x40000000 bytes flags: 0x0

So that's your available RAM.

> [    0.000000]  reserved.cnt  = 0x4
> [    0.000000]  reserved[0x0]	[0x00000080004000-0x00000080007fff], 0x4000 bytes flags: 0x0

The swapper page dir.

> [    0.000000]  reserved[0x1]	[0x00000080008340-0x0000008118240f], 0x117a0d0 bytes flags: 0x0

The kernel.

> [    0.000000]  reserved[0x2]	[0x0000008fff5000-0x0000008fffcfff], 0x8000 bytes flags: 0x0

The device tree blob.

> [    0.000000]  reserved[0x3]	[0x000000ae800000-0x000000af7fffff], 0x1000000 bytes flags: 0x0

Some 16MB reservation.

...

> [    0.000000] memblock_virt_alloc_try_nid_nopanic: 9437184 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 alloc_node_mem_map.constprop.68+0x68/0x94
> [    0.000000] memblock_reserve: [0x000000adef1000-0x000000ae7f0fff] flags 0x0 memblock_virt_alloc_internal+0x100/0x16c
> [    0.000000] free_area_init_node: node 0, pgdat c08e7e40, node_mem_map edef1000

So, this time the node 0 mem_map starts at 0xedef1000.

> [    0.000000] BUG: Bad page state in process swapper  pfn:811db
> [    0.000000] page:edf192cc count:0 mapcount:-3407872 mapping:  (null) index:0x0

Your struct page appears to have grown by 4 bytes to 36 bytes.  In your
previous example, I think it was 32 bytes.

mapcount here is 0xffcc0000.

mapcount is stored at an offset of 12 bytes from the start, and shares
its location with...
	counter
	active
and a slub data structure - frozen in bit 31, objects in 30-16, and inuse
for bits 15-0.  The count is stored at offset 16.  Mapping is at offset
4, and index at 8.

mapcount is slightly weird in that the code to access it is:

static inline void page_mapcount_reset(struct page *page)
{
        atomic_set(&(page)->_mapcount, -1);
}

static inline int page_mapcount(struct page *page)
{
        return atomic_read(&(page)->_mapcount) + 1;
}

So there's an offset of one on the mapcount values which we have to
compensate for.  Hence, we can build up a picture of memory here:

0xedf192cc:	unknown
0xedf192d0:	0
0xedf192d4:	0
0xedf192d8:	0xffcbffff
0xedf192dc:	0

So, the locations surrounding the mapcount seem to be zero.  This pattern
is repeated for every entry in the table - except with different values
for the mapcount.

The values include:

0xfffbffff
0xffcbffff
0xffebffff
0xff4affff
0xff42ffff

If I include the values from your previous message, which were with
a sizeof(struct page) == 32, we have these:

0xff4fffff
0xff6bffff
0xff6fffff
0xffcfffff

This looks rather suspicious.  As the surrounding bytes are zero, I
don't think I'd blame it on uninitialised data, and I don't think it's
slub somehow making use of the page array before it's been loaded up
with free pages.

Looking closer at the bit patterns of byte 3:

1111 1011
1100 1011
1110 1011
0100 1010
0100 0010
---------
0100 1111
0110 1011
0110 1111
1100 1111

makes me wonder a bit... why is bit 6 and 1 always set, but bit 2 is
always clear amongst this data set.


> [    0.000000] Memory: 274804K/1048576K available (5769K kernel code, 654K rwdata, 2220K rodata, 458K init, 8786K bss, 44608K reserved, 270336K highmem)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
> [    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc07d58e4   (7991 kB)
> [    0.000000]       .init : 0xc07d6000 - 0xc0848800   ( 458 kB)
> [    0.000000]       .data : 0xc084a000 - 0xc08ed8f0   ( 655 kB)
> [    0.000000]        .bss : 0xc08ed8f0 - 0xc1182410   (8787 kB)
> [    0.000000] page:ee128024 count:0 mapcount:-1048576 mapping:  (null) index:0x0
> [    0.000000] page flags: 0x0()
> [    0.000000] page dumped because: VM_BUG_ON_PAGE((*(volatile int *)&(&page->_mapcount)->counter) != -1)
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] Kernel BUG at c00f2a78 [verbose debug info unavailable]
> [    0.000000] Internal error: Oops - BUG: 0 [#1] SMP ARM
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G    B   W      3.16.0-rc7-next-20140729-00002-g4169dc8-dirty #590
> [    0.000000] task: c0855dc0 ti: c084a000 task.ti: c084a000
> [    0.000000] PC is at __rmqueue+0x618/0x644
> [    0.000000] LR is at dump_page_badflags+0x6c/0x98
> [    0.000000] pc : [<c00f2a78>]    lr : [<c00f0644>]    psr: 600001d3
> [    0.000000] sp : c084bd78  ip : c084a000  fp : 00000009
> [    0.000000] r10: 00000000  r9 : c08e7e40  r8 : 00000000
> [    0.000000] r7 : 00000002  r6 : c08e7f24  r5 : c08e7f10  r4 : ee128024
> [    0.000000] r3 : 00000000  r2 : 00000000  r1 : c084bcd0  r0 : 0000005a

Unfortunately, by this time we've lost the value of _mapcount in the
registers.  I'm willing to bet that some bits in 23:16 are clear in
this.

I'm wondering why it's always that byte - as you say in your initial
message, this is a new board.  Has it ever worked before?  What is
the hardware RAM organisation?  Is the full 1GB provided by a single
32-bit or 64-bit chip covering the whole range, or is it two separate
chips covering part of the range?

I'm suspecting that you either have badly a routed data bus connection
on bits 23:16, or you have a bad RAM chip which corrupts those bits.

It may be worth trying a simple assembly-level RAM test which pokes
all locations with alternating 0xffffffff, 0x00000000 and verifies
them.  By that I mean odd word addresses set to one value, even set
to the other, verify, reverse them, try again.

Alternatively, if there's a proper ARM memory checker around, I think
it would be well worth running it on this board to check the integrity
of the hardware.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
