From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Jan 2013 20:26:45 +0000
Subject: [PATCH v2] mm: dmapool: use provided gfp flags for all
 dma_alloc_coherent() calls
In-Reply-To: <50F800EB.6040104@web.de>
References: <20121119144826.f59667b2.akpm@linux-foundation.org>
 <201301171049.30415.arnd@arndb.de> <50F800EB.6040104@web.de>
Message-ID: <201301172026.45514.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 January 2013, Soeren Moch wrote:
> On 17.01.2013 11:49, Arnd Bergmann wrote:
> > On Wednesday 16 January 2013, Soeren Moch wrote:
> >>>> I will see what I can do here. Is there an easy way to track the buffer
> >>>> usage without having to wait for complete exhaustion?
> >>>
> >>> DMA_API_DEBUG
> >>
> >> OK, maybe I can try this.
> >>>
> >
> > Any success with this? It should at least tell you if there is a
> > memory leak in one of the drivers.
> 
> Not yet, sorry. I have to do all the tests in my limited spare time.
> Can you tell me what to search for in the debug output?

Actually now that I've looked closer, you can't immediately see
all the mappings as I thought.

But please try enabling DMA_API_DEBUG in combination with this
one-line patch:

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6b2fb87..3df74ac 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -497,6 +497,7 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
 		pr_err_once("ERROR: %u KiB atomic DMA coherent pool is too small!\n"
 			    "Please increase it with coherent_pool= kernel parameter!\n",
 			    (unsigned)pool->size / 1024);
+		debug_dma_dump_mappings(NULL);
 	}
 	spin_unlock_irqrestore(&pool->lock, flags);
 
That will show every single allocation that is currently active. This lets
you see where all the memory went, and if there is a possible leak or
excessive fragmentation.

	Arnd
