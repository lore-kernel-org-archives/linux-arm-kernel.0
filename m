From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Apr 2012 12:18:39 +0000
Subject: [PATCHv8 04/10] ARM: dma-mapping: remove offset parameter to
 prepare for generic dma_ops
In-Reply-To: <012e01cd17db$5f165c30$1d431490$%szyprowski@samsung.com>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <201204101143.27915.arnd@arndb.de>
 <012e01cd17db$5f165c30$1d431490$%szyprowski@samsung.com>
Message-ID: <201204111218.39800.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 April 2012, Marek Szyprowski wrote:
> Well, range sync functions are available from the early days of the dma 
> mapping api (at least that's what I've found reading the change log and
> old patches). They are the correct way of doing a partial syncs on the 
> buffer (usually used by the network device drivers). This patch changes
> only the internal implementation of the dma bounce functions to let 
> them tunnel through dma_map_ops structure. The driver api stays
> unchanged, so driver are obliged to call dma_*_range_* functions to
> keep code clean and easy to understand. 
> 
> The only drawback I can see from this patch is reduced detection of
> the dma api abuse. Let us consider the following code:
> 
> dma_addr = dma_map_single(dev, ptr, 64, DMA_TO_DEVICE);
> dma_sync_single_range_for_cpu(dev, dma_addr+16, 0, 32, DMA_TO_DEVICE);
> 
> Without the patch such code fails, because dma bounce code is unable
> to find the bounce buffer for the given dma_address. After the patch
> the sync call will be equivalent to: 
> 
>         dma_sync_single_range_for_cpu(dev, dma_addr, 16, 32, DMA_TO_DEVICE);
> 
> which succeeds.
> 
> I don't consider this as a real problem. DMA API abuse should be caught
> by debug_dma_* function family, so we can simplify the internal low-level
> implementation without losing anything.
> 

Ok, fair enough. Can you put the above text into the changelog?

	Arnd
