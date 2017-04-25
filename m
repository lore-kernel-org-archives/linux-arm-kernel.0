From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Apr 2017 19:05:26 +0100
Subject: [RFC PATCH] drivers: dma-mapping: Do not attempt to create a
 scatterlist for from_coherent buffers
In-Reply-To: <1493143059-2113-1-git-send-email-catalin.marinas@arm.com>
References: <1493143059-2113-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20170425180525.GT17774@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 06:57:39PM +0100, Catalin Marinas wrote:
> Memory returned by dma_alloc_from_coherent() is not backed by struct
> page and creating a scatterlist would use invalid page pointers. The
> patch introduces the dma_vaddr_from_coherent() function and the
> corresponding check in dma_get_sgtable_attrs().
> 
> Fixes: d2b7428eb0ca ("common: dma-mapping: introduce dma_get_sgtable() function")
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> 
> In a recent discussion around the iommu DMA ops on arm64, Russell
> pointed out that dma_get_sgtable is not safe since the coherent DMA
> memory is not always backed by struct page. Russell has queued an
> arm-specific patch checking for pfn_valid() but I thought I'd make a
> more generic fix. This patch aims to bring the dma_get_sgtable() API in
> line with the dma_alloc/mmap/free with respect to the from_coherent
> memory.

Sorry, I don't think this is the correct approach.

You're assuming that 'vaddr' will always be a valid lowmem address.
That isn't always the case - some dma coherent allocations provide
remapped memory.

The reason for dma_get_sgtable() existing is to coerce the DMA
coherent memory into a scatterlist so that it can be passed through
the dma_buf API - that's where the problem lies.  The dma_buf API
needs fixing so that coherent memory can be sanely passed, and
dma_get_sgtable() needs to be put out of its misery.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
