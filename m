From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 16:09:29 +0200
Subject: [PATCH 6/8] drivers: add Contiguous Memory Allocator
In-Reply-To: <006301cc3be4$daab1850$900148f0$%szyprowski@samsung.com>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<20110705113345.GA8286@n2100.arm.linux.org.uk>
	<006301cc3be4$daab1850$900148f0$%szyprowski@samsung.com>
Message-ID: <201107061609.29996.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011, Marek Szyprowski wrote:
> The only problem that might need to be resolved is GFP_ATOMIC allocation
> (updating page properties probably requires some locking), but it can be
> served from a special area which is created on boot without low-memory
> mapping at all. None sane driver will call dma_alloc_coherent(GFP_ATOMIC)
> for large buffers anyway.

Would it be easier to start with a version that only allocated from memory
without a low-memory mapping at first?

This would be similar to the approach that Russell's fix for the regular
dma_alloc_coherent has taken, except that you need to also allow the memory
to be used as highmem user pages.

Maybe you can simply adapt the default location of the contiguous memory
are like this:
- make CONFIG_CMA depend on CONFIG_HIGHMEM on ARM, at compile time
- if ZONE_HIGHMEM exist during boot, put the CMA area in there
- otherwise, put the CMA area at the top end of lowmem, and change
  the zone sizes so ZONE_HIGHMEM stretches over all of the CMA memory.

	Arnd
