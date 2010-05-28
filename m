From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 May 2010 20:45:01 +0100
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <alpine.LFD.2.00.1005281503260.24526@xanadu.home>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
	<1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1003261144020.694@xanadu.home>
	<alpine.LFD.2.00.1004111033010.7232@xanadu.home>
	<20100528185604.GB5189@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1005281503260.24526@xanadu.home>
Message-ID: <20100528194501.GC5189@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 28, 2010 at 03:26:21PM -0400, Nicolas Pitre wrote:
> On Fri, 28 May 2010, Russell King - ARM Linux wrote:
> 
> > FYI, I'm considering reverting this patch; this patch is one of two
> > responsible for causing a stability regression of Versatile Express
> > platform - a highmem+Cortex A9 MPCore system with VIPT non-aliasing
> > caches.
> 
> Two questions:
> 
> 1) Do you actually have CONFIG_HIGHMEM enabled?

Yes - and here's the messages to prove it.

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.34 (rmk at rmk-PC) (gcc version 4.3.2 (GCC) ) #165 SMP Fri May 28 19:38:08 BST 2010
CPU: ARMv7 Processor [410fc091] revision 1 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: ARM-Versatile Express CA9x4
Memory policy: ECC disabled, Data cache writealloc
PERCPU: Embedded 8 pages/cpu @c0c87000 s8768 r8192 d15808 u65536
pcpu-alloc: s8768 r8192 d15808 u65536 alloc=16*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
Kernel command line: root=/dev/mmcblk0p1 ro mem=1024M console=ttyAMA0 vmalloc=256M rootdelay=5
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 640MB 384MB = 1024MB total
Memory: 1034868k/1034868k available, 13708k reserved, 393216K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xe8800000 - 0xf8000000   ( 248 MB)
    lowmem  : 0xc0000000 - 0xe8000000   ( 640 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .init : 0xc0008000 - 0xc002a000   ( 136 kB)
      .text : 0xc002a000 - 0xc03c4000   (3688 kB)
      .data : 0xc03c4000 - 0xc03f19b0   ( 183 kB)
SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Hierarchical RCU implementation.
        RCU-based detection of stalled CPUs is disabled.
        Verbose stalled-CPUs detection is disabled.
NR_IRQS:128
Console: colour dummy device 80x30
Calibrating delay loop... 797.90 BogoMIPS (lpj=3989504)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
CPU1: Booted secondary processor
CPU2: Booted secondary processor
CPU3: Booted secondary processor
Brought up 4 CPUs
SMP: Total of 4 processors activated (3196.51 BogoMIPS).
NET: Registered protocol family 16
L310 cache controller enabled
l2x0: 8 ways, CACHE_ID 0x410000c3, AUX_CTRL 0x02060000
...

> 2) If no, does the reversal of this patch really make a difference?
>    If yes, are you sure highmem actually works reliably without it?

With this patch, userspace sometimes doesn't even make it to printing
the first "INIT: version" line, other times it does and the next line
you see is "INIT: entering runlevel 5".  Other times, you get segfaults
or illegal instructions reported by the shell.

Revert this patch, and I have a much more stable system, resulting in
most (but not all) of things like udev, dbus, hal, networkmanager
starting.

Revert the other patch, and everything comes up.  Restore your patch,
everything falls apart completely again.

> But if you do have CONFIG_HIGHMEM turned on without this patch then you 
> should get memory corruption pretty fast simply by booting on a block 
> device with a driver that uses DMA.  That was confirmed on both a TI 
> OMAP board and on a Marvell Dove board.

The MMCI primecell is currently PIO only.

> > The two commits responsible for making Versatile Express userspace
> > completely unstable are:
> > 
> > b8349b569aae661dea9d59d7d2ee587ccea3336c
> > ARM: 6112/1: Use the Inner Shareable I-cache and BTB ops on ARMv7 SMP
> > 
> > 7e5a69e83ba7a0d5917ad830f417cba8b8d6aa72
> > ARM: 6007/1: fix highmem with VIPT cache and DMA
> > 
> > Most of the instability is from the second (this) patch, but reverting
> > just one patch doesn't fully restore userspace stability.
> 
> And that includes reverting only b8349b56, right?

Correct.  I've tried all four combinations.  Most of the instability is
down to 7e5a.  Reverting b834 on its own has no visible difference.
Reverting 7e5a has a very noticable difference but is not completely back
to normal without b834 too.

> > The instability seen consists of completely random SIGSEGVs and SIGILLs,
> > sometimes early enough to kill init, sometimes init is the only thing
> > able to run - so it's very severe.
> 
> That is exactly the observed behavior on OMAP and Dove when this patch 
> is _not_ applied.

I'm about to test this on my OMAP4 board, which will be a DMA-based test,
which will be using the same filesystem.

This will be an interesting test because both systems have the same
revision and patch level of the Cortex A9 MPCore hardware.
