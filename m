From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 4 May 2010 18:13:28 +0200
Subject: [PATCH] ARM: Fix virtual kernel memory printing for sparsemem
In-Reply-To: <1269532886.10064.31.camel@e102109-lin.cambridge.arm.com>
References: <20100325145324.12837.85927.stgit@e102109-lin.cambridge.arm.com>
	<20100325153043.GE6590@n2100.arm.linux.org.uk>
	<1269532886.10064.31.camel@e102109-lin.cambridge.arm.com>
Message-ID: <201005041813.29063.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 25. b?ezna 2010 17:01:26 Catalin Marinas napsal(a):
> On Thu, 2010-03-25 at 15:30 +0000, Russell King - ARM Linux wrote:
> > On Thu, Mar 25, 2010 at 03:24:29PM +0000, Catalin Marinas wrote:
> > > On Thu, 2010-03-25 at 15:10 +0000, Russell King - ARM Linux wrote:
> > > > While this looks fine, I'd like to see a lot of Tested-by's against
> > > > this before it's merged - we've had similar code in show_mem()
> > > > which has proven to be quite problematical to get right for all the
> > > > various different combinations we have.
> > > > 
> > > > However, we also have the same method in show_mem() which we know
> > > > works fine, so I'd also like to see the problem with using it in
> > > > mem_init() fully analysed - rather than a "possibly because".
> > > 
> > > I can remove the "possibly" part :). The page_count() is given a page
> > > with some random flags and it thinks it's a compound page. It than
> > > tries to access page->first which isn't set, hence the error.
> > > 
> > > The original code assumes that for a given node the map is contiguous
> > > and it calculates the page as (map + pfn). This is only true for
> > > flatmem. With sparsemem the page calculation is a bit more complicated
> > > but handled by pfn_to_page().
> > 
> > And show_mem() ?  It seems to suffer from the same problem.
> 
> And that's a patch which fixes both (but as you said, it would be good
> if more people test it on various platforms).
> 
> 
> ARM: Fix kernel memory printing for sparsemem
> 
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> The show_mem() and mem_init() function are assuming that the page map is
> contiguous and calculates the start and end page of a bank using (map +
> pfn). This fails with SPARSEMEM where pfn_to_page() must be used.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <Will.Deacon@arm.com>
> Cc: Andreas Fenkart <andreas.fenkart@streamunlimited.com>

Works perfectly on my machine. I have a PXA270 based device where I have to use 
sparsemem. Thanks, you can add my:

Tested-by: Marek Vasut <marek.vasut@gmail.com>

Russell, the patch looks fine, please apply, the stuff is really broken.

Linux version 2.6.34-rc5 (root at rin) (gcc version 4.4.2 (GCC) ) #98 PREEMPT Tue 
May 4 18:09:29 CEST 2010
CPU: XScale-PXA270 [69054117] revision 7 (ARMv5TE), cr=0000397f
CPU: VIVT data cache, VIVT instruction cache
Machine: Voipac PXA270
Ignoring unrecognised tag 0x54410008
Memory policy: ECC disabled, Data cache writeback
Run Mode clock: 208.00MHz (*16)
Turbo Mode clock: 312.00MHz (*1.5, inactive)
Memory clock: 104.00MHz (/2)
System bus clock: 104.00MHz 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64256
Kernel command line: console=tty0 console=ttyS0,115200
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128MB 128MB = 256MB total
Memory: 256472k/256472k available, 5672k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xc8800000 - 0xe8000000   ( 504 MB)
    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc00b4000   ( 688 kB)
      .text : 0xc00b4000 - 0xc020e000   (1384 kB)
      .data : 0xc0218000 - 0xc022ba80   (  79 kB)
Hierarchical RCU implementation.
NR_IRQS:288
Console: colour dummy device 80x30
console [tty0] enabled
Calibrating delay loop... 207.66 BogoMIPS (lpj=1038336)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
bio: create slab <bio-0> at 0
Switching to clocksource oscr0
NetWinder Floating Point Emulator V0.97 (double precision)
msgmni has been set to 500
io scheduler noop registered (default)
pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq = 22) is a FFUART
console [ttyS0] enabled
pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq = 21) is a BTUART
pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq = 20) is a STUART
mice: PS/2 mouse device common for all mice
XScale iWMMXt coprocessor detected.
Freeing init memory: 688K
