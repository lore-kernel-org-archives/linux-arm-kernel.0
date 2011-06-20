From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 20 Jun 2011 17:15:43 +0200
Subject: [PATCH 2/8] ARM: dma-mapping: implement dma_map_single on top of
	dma_map_page
In-Reply-To: <20110620143911.GD26089@n2100.arm.linux.org.uk>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-3-git-send-email-m.szyprowski@samsung.com>
	<20110620143911.GD26089@n2100.arm.linux.org.uk>
Message-ID: <000101cc2f5c$ec21da40$c4658ec0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, June 20, 2011 4:39 PM Russell King - ARM Linux wrote:

> On Mon, Jun 20, 2011 at 09:50:07AM +0200, Marek Szyprowski wrote:
> > This patch consolidates dma_map_single and dma_map_page calls. This is
> > required to let dma-mapping framework on ARM architecture use common,
> > generic dma-mapping helpers.
> 
> This breaks DMA API debugging, which requires that dma_map_page and
> dma_unmap_page are paired separately from dma_map_single and
> dma_unmap_single().

Ok, right. This can be fixed by creating appropriate static inline functions
in dma-mapping.h and moving dma_debug_* calls there. These function will be
later removed by using dma_map_ops and include/asm-generic/dma-mapping-common.h
inlines, which do all the dma_debug_* calls correctly anyway. 

> This also breaks dmabounce when used with a highmem-enabled system -
> dmabounce refuses the dma_map_page() API but allows the dma_map_single()
> API.

I really not sure how this change will break dma bounce code. 

Does it mean that it is allowed to call dma_map_single() on kmapped HIGH_MEM 
page?

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
