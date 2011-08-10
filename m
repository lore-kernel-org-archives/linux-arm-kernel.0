From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 10 Aug 2011 16:39:47 +0100
Subject: PB1176 broken in -rc1
In-Reply-To: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
References: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
Message-ID: <20110810153947.GK2680@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wed, Aug 10, 2011 at 04:24:00PM +0100, Will Deacon wrote:
> Hi Linus,
> 
> My PB1176 platform appears to lock up as soon as it hits userspace when
> running a 3.1-rc1 kernel. If I revert the commit:
> 
> f022e4e4 ("ARM: 6986/1: mach-realview: add TCM support for PB1176")
> 
> Then things start working again.
> 
> My dmesg contains:
> 
> [    0.000000] CPU: found DTCM0 4k @ 00000000, not enabled
> [    0.000000] CPU: moved DTCM0 4k to fffe8000, enabled
> [    0.000000] CPU: found DTCM1 4k @ 00000000, not enabled
> [    0.000000] CPU: moved DTCM1 4k to fffe9000, enabled
> [    0.000000] CPU: found ITCM0 4k @ 00000000, not enabled
> [    0.000000] CPU: moved ITCM0 4k to fffe0000, enabled
> [    0.000000] CPU: found ITCM1 4k @ 00000000, not enabled
> [    0.000000] CPU: moved ITCM1 4k to fffe1000, enabled
> [    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
> [    0.000000] Kernel command line: root=/dev/nfs ip=dhcp console=ttyAMA0 nfsroot=10.1.69.60:/export/debian,tcp rw
> [    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
> [    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> [    0.000000] Memory: 128MB = 128MB total
> [    0.000000] Memory: 123692k/123692k available, 7380k reserved, 0K highmem
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     DTCM    : 0xfffe8000 - 0xfffea000   (   8 kB)
> [    0.000000]     ITCM    : 0xfffe0000 - 0xfffe2000   (   8 kB)
> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
> [    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
> [    0.000000]     vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc05670d4   (5501 kB)
> [    0.000000]       .init : 0xc0568000 - 0xc059e000   ( 216 kB)
> [    0.000000]       .data : 0xc059e000 - 0xc05c8ac8   ( 171 kB)
> [    0.000000]        .bss : 0xc05c9024 - 0xc0610578   ( 286 kB)
> 
> But then later hangs at:
> 
> [    6.581778] VFS: Mounted root (nfs filesystem) on device 0:12.
> 
> 
> Any thoughts on how to debug this? The NULL addresses in the dmesg look
> strange to me, but I'm not familiar with the TCMs.

This may be to do with poisoning of the init mem.  The patch below 
(which is in next as ARM: 7010/1: mm: fix invalid loop for 
poison_init_mem) might resolve the issue.

Jamie

8<------

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 2fee782..91bca35 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -441,7 +441,7 @@ static inline int free_area(unsigned long pfn, unsigned long end, char *s)
 static inline void poison_init_mem(void *s, size_t count)
 {
 	u32 *p = (u32 *)s;
-	while ((count = count - 4))
+	for (; count != 0; count -= 4)
 		*p++ = 0xe7fddef0;
 }
 
