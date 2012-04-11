From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 11 Apr 2012 14:05:21 +0200
Subject: [PATCHv8 04/10] ARM: dma-mapping: remove offset parameter to
 prepare for generic dma_ops
In-Reply-To: <201204101143.27915.arnd@arndb.de>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <1334055852-19500-5-git-send-email-m.szyprowski@samsung.com>
 <201204101143.27915.arnd@arndb.de>
Message-ID: <012e01cd17db$5f165c30$1d431490$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tuesday, April 10, 2012 1:43 PM Arnd Bergmann wrote:

> On Tuesday 10 April 2012, Marek Szyprowski wrote:
> > This patch removes the need for offset parameter in dma bounce
> > functions. This is required to let dma-mapping framework on ARM
> > architecture use common, generic dma-mapping helpers.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> This one worries me a little. I always thought that the range sync
> functions were specifically needed for the dmabounce code. At the
> very least, I would expect the changeset comment to have an explanation
> of why this was initially done this way and why it's now safe to do
> do it otherwise.

Well, range sync functions are available from the early days of the dma 
mapping api (at least that's what I've found reading the change log and
old patches). They are the correct way of doing a partial syncs on the 
buffer (usually used by the network device drivers). This patch changes
only the internal implementation of the dma bounce functions to let 
them tunnel through dma_map_ops structure. The driver api stays
unchanged, so driver are obliged to call dma_*_range_* functions to
keep code clean and easy to understand. 

The only drawback I can see from this patch is reduced detection of
the dma api abuse. Let us consider the following code:

dma_addr = dma_map_single(dev, ptr, 64, DMA_TO_DEVICE);
dma_sync_single_range_for_cpu(dev, dma_addr+16, 0, 32, DMA_TO_DEVICE);

Without the patch such code fails, because dma bounce code is unable
to find the bounce buffer for the given dma_address. After the patch
the sync call will be equivalent to: 

	dma_sync_single_range_for_cpu(dev, dma_addr, 16, 32, DMA_TO_DEVICE);

which succeeds.

I don't consider this as a real problem. DMA API abuse should be caught
by debug_dma_* function family, so we can simplify the internal low-level
implementation without losing anything.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
