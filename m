From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Tue, 28 Dec 2010 21:29:58 +0000 (UTC)
Subject: [RFC PATCH] Avoid aliasing mappings in DMA coherent allocator
References: <20101224111125.GD20587@n2100.arm.linux.org.uk>
	<20101224112413.GE20587@n2100.arm.linux.org.uk>
Message-ID: <loom.20101228T203522-493@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux <at> arm.linux.org.uk> writes:
> 
> Avoid multiple mappings with DMA coherent/writecombine allocator by pre-
> allocating the mappings, and removing that memory from the system memory
> mapping.  (See previous discussions on linux-arm-kernel as to why this
> is bad.)
> 
> NB1: By default, we preallocate 2MB for DMA coherent, and 2MB for write
> combine memory, rather than 1MB for each in case 1MB is not sufficient
> for existing platform usage.  Platforms have the option of shrinking
> this down to 1MB DMA / 1MB WC (or even 2MB DMA / 0MB WC) if they so wish.
> The DMA memory must be a multiple of 1MB, the write combine memory must
> also be a multiple of 1MB, and the two together must be a multiple of
> 2MB.
> 
> NB2: On ARMv6/7 where we use 'normal uncacheable' memory for both DMA
> and WC, the two pools are combined into one, as was the case with the
> previous implementation.
> 
> The down side to this change is that the memory is permanently set aside
> for DMA purposes, but I believe that to be unavoidable if we are to
> avoid the possibility of the cache getting in the way on VIPT CPUs.
> 
> This removes the last known offender (at this time) from the kernel.
> 
> Signed-off-by: Russell King <rmk+kernel <at> arm.linux.org.uk>

Works fine on OMAP1 based Amstrad Delta, both default 2MB/2MB and shrinked to
1MB/1MB configurations. No need to preallocate dma coherent memory for camera
video buffers on boot. However, in 1MB/1MB configuration it failed to allocate
600kB of writecombined omapfb vram, required for double-buffering, and reserving
up to 4MB of machine's total 32MB seems too expensive.

Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
