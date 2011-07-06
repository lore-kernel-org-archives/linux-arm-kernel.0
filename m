From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 15:23:45 +0100
Subject: [PATCH 6/8] drivers: add Contiguous Memory Allocator
In-Reply-To: <201107061609.29996.arnd@arndb.de>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<20110705113345.GA8286@n2100.arm.linux.org.uk>
	<006301cc3be4$daab1850$900148f0$%szyprowski@samsung.com>
	<201107061609.29996.arnd@arndb.de>
Message-ID: <20110706142345.GC8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 04:09:29PM +0200, Arnd Bergmann wrote:
> Maybe you can simply adapt the default location of the contiguous memory
> are like this:
> - make CONFIG_CMA depend on CONFIG_HIGHMEM on ARM, at compile time
> - if ZONE_HIGHMEM exist during boot, put the CMA area in there
> - otherwise, put the CMA area at the top end of lowmem, and change
>   the zone sizes so ZONE_HIGHMEM stretches over all of the CMA memory.

One of the requirements of the allocator is that the returned memory
should be zero'd (because it can be exposed to userspace via ALSA
and frame buffers.)

Zeroing the memory from all the contexts which dma_alloc_coherent
is called from is a trivial matter if its in lowmem, but highmem is
harder.

Another issue is that when a platform has restricted DMA regions,
they typically don't fall into the highmem zone.  As the dmabounce
code allocates from the DMA coherent allocator to provide it with
guaranteed DMA-able memory, that would be rather inconvenient.
