From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon, 20 Jun 2011 23:45:41 +0900
Subject: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent
	method to more generic alloc/free_attrs
In-Reply-To: <1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <BANLkTikFdrOuXsLCfvyA_V+p7S_fd72dyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

On Mon, Jun 20, 2011 at 4:50 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> ?struct dma_map_ops {
> - ? ? ? void* (*alloc_coherent)(struct device *dev, size_t size,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dma_addr_t *dma_handle, gfp_t gfp);
> - ? ? ? void (*free_coherent)(struct device *dev, size_t size,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? void *vaddr, dma_addr_t dma_handle);
> + ? ? ? void* (*alloc)(struct device *dev, size_t size,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dma_addr_t *dma_handle, gfp_t gfp,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct dma_attrs *attrs);
> + ? ? ? void (*free)(struct device *dev, size_t size,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? void *vaddr, dma_addr_t dma_handle,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct dma_attrs *attrs);
> + ? ? ? int (*mmap)(struct device *, struct vm_area_struct *,
> + ? ? ? ? ? ? ? ? ? ? ? ? void *, dma_addr_t, size_t, struct dma_attrs *attrs);
> +
> ? ? ? ?dma_addr_t (*map_page)(struct device *dev, struct page *page,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned long offset, size_t size,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? enum dma_data_direction dir,

I still don't agree with your idea that change alloc_coherent() with alloc().
As I said before, we actually do not need dma_alloc_writecombine() anymore
because it is not different from dma_alloc_coherent() in ARM.
Most of other architectures do not have dma_alloc_writecombine().
If you want dma_alloc_coherent() to allocate user virtual address,
I believe that it is also available with mmap() you introduced.

Regards,
Cho KyongHo.
