From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Mon, 09 Dec 2013 19:29:57 -0500
Subject: [PATCH 3/3] swiotlb: Add support for CMA allocations
In-Reply-To: <1386634334-31139-4-git-send-email-lauraa@codeaurora.org>
References: <1386634334-31139-1-git-send-email-lauraa@codeaurora.org>
 <1386634334-31139-4-git-send-email-lauraa@codeaurora.org>
Message-ID: <1da8f502-0e34-4b54-929e-bcbe40b20b7f@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Laura Abbott <lauraa@codeaurora.org> wrote:
>Some architectures may implement the CMA APIs to allow allocation
>of larger contiguous blocks of memory. Add support in the swiotlb
>alloc/free functions to allocate from the CMA APIs instead of the
>basic page allocator.
>
>Cc: Will Deacon <will.deacon@arm.com>
>Cc: Catalin Marinas <catalin.marinas@arm.com>
>Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>---
>lib/swiotlb.c |   92
>+++++++++++++++++++++++++++++++++++++++++++++++++++++----
> 1 files changed, 86 insertions(+), 6 deletions(-)
>
>diff --git a/lib/swiotlb.c b/lib/swiotlb.c
>index e4399fa..77b4b17 100644
>--- a/lib/swiotlb.c
>+++ b/lib/swiotlb.c
>@@ -29,6 +29,9 @@
> #include <linux/ctype.h>
> #include <linux/highmem.h>
> #include <linux/gfp.h>
>+#include <linux/dma-contiguous.h>
>+#include <linux/io.h>
>+#include <linux/vmalloc.h>
> 
> #include <asm/io.h>
> #include <asm/dma.h>
>@@ -610,6 +613,66 @@ void swiotlb_tbl_sync_single(struct device *hwdev,
>phys_addr_t tlb_addr,
> }
> EXPORT_SYMBOL_GPL(swiotlb_tbl_sync_single);
> 
>+static void * __alloc_from_contiguous(struct device *hwdev, size_t
>size,
>+					struct page **ret_page)
>+{
>+	unsigned long order = get_order(size);
>+	size_t count = size >> PAGE_SHIFT;
>+	struct page *page;
>+	void *ptr = NULL;
>+
>+	page = dma_alloc_from_contiguous(hwdev, count, order);
>+	if (!page)
>+		return NULL;
>+
>+	if (PageHighMem(page)) {
>+		struct vm_struct *area;
>+		unsigned long addr;
>+
>+		/*
>+		 * DMA allocation can be mapped to user space, so lets
>+		 * set VM_USERMAP flags too.
>+		 */
>+		area = get_vm_area(size, VM_USERMAP);
>+		if (!area)
>+			goto err;
>+		addr = (unsigned long)area->addr;
>+		area->phys_addr = __pfn_to_phys(page_to_pfn(page));
>+
>+		if (ioremap_page_range(addr, addr + size, area->phys_addr,
>+		    PAGE_KERNEL)) {
>+			vunmap((void *)addr);
>+			goto err;
>+		}
>+		ptr = area->addr;
>+	} else {
>+		ptr = page_address(page);
>+	}
>+
>+	*ret_page = page;
>+	return ptr;
>+
>+err:
>+	dma_release_from_contiguous(hwdev, page, count);
>+	return NULL;
>+}
>+
>+static void __free_from_contiguous(struct device *hwdev, struct page
>*page,
>+				void *cpu_addr, size_t size)
>+{
>+	if (PageHighMem(page)) {
>+		struct vm_struct *area = find_vm_area(cpu_addr);
>+		if (!area) {
>+			WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
>+			return;
>+		}
>+		unmap_kernel_range((unsigned long)cpu_addr, size);
>+		vunmap(cpu_addr);
>+	}
>+	dma_release_from_contiguous(hwdev, page, size >> PAGE_SHIFT);
>+}
>+
>+
> void *
> swiotlb_alloc_coherent(struct device *hwdev, size_t size,
> 		       dma_addr_t *dma_handle, gfp_t flags)
>@@ -618,18 +681,27 @@ swiotlb_alloc_coherent(struct device *hwdev,
>size_t size,
> 	void *ret;
> 	int order = get_order(size);
> 	u64 dma_mask = DMA_BIT_MASK(32);
>+	struct page *page;
> 
> 	if (hwdev && hwdev->coherent_dma_mask)
> 		dma_mask = hwdev->coherent_dma_mask;
> 
>-	ret = (void *)__get_free_pages(flags, order);
>-	if (ret) {
>+	if (IS_ENABLED(CONFIG_DMA_CMA)) {
>+		ret = __alloc_from_contiguous(hwdev, size, &page);
>+		dev_addr = phys_to_dma(hwdev, page_to_phys(page));
>+	} else {
>+		ret = (void *)__get_free_pages(flags, order);
> 		dev_addr = swiotlb_virt_to_bus(hwdev, ret);
>+	}
>+	if (ret) {
> 		if (dev_addr + size - 1 > dma_mask) {
> 			/*
> 			 * The allocated memory isn't reachable by the device.
> 			 */
>-			free_pages((unsigned long) ret, order);
>+			if(IS_ENABLED(CONFIG_DMA_CMA))
>+				__free_from_contiguous(hwdev, page, ret, size);
>+			else
>+				free_pages((unsigned long) ret, order);
> 			ret = NULL;
> 		}
> 	}
>@@ -673,11 +745,19 @@ swiotlb_free_coherent(struct device *hwdev,
>size_t size, void *vaddr,
> 	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
> 
> 	WARN_ON(irqs_disabled());
>-	if (!is_swiotlb_buffer(paddr))
>-		free_pages((unsigned long)vaddr, get_order(size));
>-	else
>+	if (!is_swiotlb_buffer(paddr)) {
>+		if (IS_ENABLED(CONFIG_DMA_CMA)) {
>+			__free_from_contiguous(hwdev,
>+				pfn_to_page(paddr >> PAGE_SHIFT),
>+				vaddr,
>+				size);
>+		} else {
>+			free_pages((unsigned long)vaddr, get_order(size));
>+		}
>+	} else {
> 		/* DMA_TO_DEVICE to avoid memcpy in swiotlb_tbl_unmap_single */
> 		swiotlb_tbl_unmap_single(hwdev, paddr, size, DMA_TO_DEVICE);
>+	}
> }
> EXPORT_SYMBOL(swiotlb_free_coherent);
> 

Can this be done in the platform dma_ops functions instead?
