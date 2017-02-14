From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 14 Feb 2017 11:32:41 +0300
Subject: [bug report] mm: wire up GFP flag passing in dma_alloc_from_contiguous
Message-ID: <20170214083241.GA20170@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lucas Stach,

The patch 179d4caa7d17: "mm: wire up GFP flag passing in
dma_alloc_from_contiguous" from Feb 8, 2017, leads to the following
static checker warning:

	arch/arm/mm/dma-mapping.c:615 __alloc_from_contiguous()
	warn: use 'gfp' here instead of GFP_XXX?

arch/arm/mm/dma-mapping.c
   595  static void *__alloc_from_contiguous(struct device *dev, size_t size,
   596                                       pgprot_t prot, struct page **ret_page,
   597                                       const void *caller, bool want_vaddr,
   598                                       int coherent_flag, gfp_t gfp)
   599  {
   600          unsigned long order = get_order(size);
   601          size_t count = size >> PAGE_SHIFT;
   602          struct page *page;
   603          void *ptr = NULL;
   604  
   605          page = dma_alloc_from_contiguous(dev, count, order, gfp);
   606          if (!page)
   607                  return NULL;
   608  
   609          __dma_clear_buffer(page, size, coherent_flag);
   610  
   611          if (!want_vaddr)
   612                  goto out;
   613  
   614          if (PageHighMem(page)) {
   615                  ptr = __dma_alloc_remap(page, size, GFP_KERNEL, prot, caller);
                                                            ^^^^^^^^^^
Use "gfp" here as well?  I don't know...

   616                  if (!ptr) {
   617                          dma_release_from_contiguous(dev, page, count);
   618                          return NULL;
   619                  }
   620          } else {
   621                  __dma_remap(page, size, prot);
   622                  ptr = page_address(page);
   623          }
   624  
   625   out:
   626          *ret_page = page;
   627          return ptr;
   628  }

regards,
dan carpenter
