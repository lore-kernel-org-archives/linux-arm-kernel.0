From: bryanp35@comcast.net (B. J.)
Date: Mon, 19 Sep 2011 15:26:54 -0700
Subject: alloc_safe_buffer/map_single problem related to ath9k on ARM
Message-ID: <769353EF-E030-494A-B1FE-7D6614B2C1AF@comcast.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've been fighting with a DMA problem on my ARM system, and have reached the point of crying out for a bit of help.  Hopefully someone has some ideas on what I can do to get past this...

The platform in question is an IXP43x-based processor with an ath9k WiFi on the PCI bus, running a late 2.6.3x kernel (have been experimenting with different versions to no avail).

The original problem is that, under network load over the WiFi, I get these messages:

ath9k 0000:00:02.0: alloc_safe_buffer: could not alloc dma memory (size=87)
ath9k 0000:00:02.0: map_single: unable to map unsafe buffer cf733828!
ath9k 0000:00:02.0: alloc_safe_buffer: could not alloc dma memory (size=174)
ath9k 0000:00:02.0: map_single: unable to map unsafe buffer c7ea4c5e!
ath9k 0000:00:02.0: alloc_safe_buffer: could not alloc dma memory (size=1484)
ath9k 0000:00:02.0: map_single: unable to map unsafe buffer cf734028!

and eventually the system runs out of kernel memory and the OOM killer kicks in (yeah, so there's multiple problems here).

I've been experimenting with various DMA/bounce-buffer patches, HIGHMEM configuration, and changing CONSISTENT_DMA_SIZE from 2M to 4M, but none of the changes resolve this problem, and the latter just causes a kernel assertion failure.

My understanding of what's causing this is that there is a really tiny amount of DMA-able memory available - 2MB - and I'm overrunning that while beating on the WiFi.  I'm not knowledgeable enough about the particulars of this platform to understand if it really is limited to 2MB of DMA memory (that seems crazily tiny!) or if this is a problem in the ath9k driver itself.

Here are some details:

Linux 2.6.35.12 armv5teb
...
CPU: XScale-IXP43x Family [69054041] revision 1 (ARMv5TE), cr=000039ff
...
free_area_init_node: node 0, pgdat c03dc890, node_mem_map c4000000
  DMA zone: 128 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 16256 pages, LIFO batch:3
  Normal zone: 384 pages used for memmap
  Normal zone: 48768 pages, LIFO batch:15
...
Memory: 256MB = 256MB total
Memory: 255756k/255756k available, 6388k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .init : 0xc0008000 - 0xc0023000   ( 108 kB)
      .text : 0xc0023000 - 0xc03b6000   (3660 kB)
      .data : 0xc03b6000 - 0xc03de260   ( 161 kB)

# cat /sys/devices/pci0000\:00/0000\:00\:02.0/pools 
poolinfo - 0.1
large_dmabounce_pool    0    0 4096  0
small_dmabounce_pool   21   50 2048 25
# cat /sys/devices/pci0000\:00/0000\:00\:02.0/dmabounce_stats
1113 0 0 1113 28292 1092
# 

Any advice appreciated!

--
-bp
