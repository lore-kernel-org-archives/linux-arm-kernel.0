From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Jul 2014 20:06:44 +0200
Subject: [PATCHv4 5/5] arm64: Add atomic pool for non-coherent and CMA
 allocations.
In-Reply-To: <1404324218-4743-6-git-send-email-lauraa@codeaurora.org>
References: <1404324218-4743-1-git-send-email-lauraa@codeaurora.org>
 <1404324218-4743-6-git-send-email-lauraa@codeaurora.org>
Message-ID: <201407222006.44666.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 July 2014, Laura Abbott wrote:
> +       pgprot_t prot = __pgprot(PROT_NORMAL_NC);
> +       unsigned long nr_pages = atomic_pool_size >> PAGE_SHIFT;
> +       struct page *page;
> +       void *addr;
> +
> +
> +       if (dev_get_cma_area(NULL))
> +               page = dma_alloc_from_contiguous(NULL, nr_pages,
> +                                       get_order(atomic_pool_size));
> +       else
> +               page = alloc_pages(GFP_KERNEL, get_order(atomic_pool_size));
> +
> +
> +       if (page) {
> +               int ret;
> +
> +               atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
> +               if (!atomic_pool)
> +                       goto free_page;
> +
> +               addr = dma_common_contiguous_remap(page, atomic_pool_size,
> +                                       VM_USERMAP, prot, atomic_pool_init);
> +

I just stumbled over this thread and noticed the code here: When you do
alloc_pages() above, you actually get pages that are already mapped into
the linear kernel mapping as cacheable pages. Your new
dma_common_contiguous_remap tries to map them as noncacheable. This
seems broken because it allows the CPU to treat both mappings as
cacheable, and that won't be coherent with device DMA.

> +               if (!addr)
> +                       goto destroy_genpool;
> +
> +               memset(addr, 0, atomic_pool_size);
> +               __dma_flush_range(addr, addr + atomic_pool_size);

It also seems weird to flush the cache on a virtual address of
an uncacheable mapping. Is that well-defined? In the CMA case, the
original mapping should already be uncached here, so you don't need
to flush it. In the alloc_pages() case, I think you need to unmap
the pages from the linear mapping instead.

	Arnd
