From: saeed.bishara@gmail.com (saeed bishara)
Date: Mon, 23 Nov 2009 17:25:06 +0200
Subject: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <E1NCZ7p-0002A0-Ib@rmk-PC.arm.linux.org.uk>
References: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
	<E1NCZ7p-0002A0-Ib@rmk-PC.arm.linux.org.uk>
Message-ID: <c70ff3ad0911230725h6d688c09k8576b66d012f29f0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> + ? ? ? if (dir == DMA_FROM_DEVICE) {
> + ? ? ? ? ? ? ? outer_inv_range(paddr, paddr + size);
> + ? ? ? ? ? ? ? dmac_inv_range(kaddr, kaddr + size);
it's not clear why outer cache invalidated before inner cache, and, I
think that it may be incorrect, how can you be sure that a dirty line
that is in inner cache can't be moved down to outer cache?
> + ? ? ? } else {
> + ? ? ? ? ? ? ? dmac_clean_range(kaddr, kaddr + size);
> + ? ? ? ? ? ? ? outer_clean_range(paddr, paddr + size);
> ? ? ? ?}
> +}
> +EXPORT_SYMBOL(___dma_single_cpu_to_dev);
>
> - ? ? ? inner_op(start, start + size);
> - ? ? ? outer_op(__pa(start), __pa(start) + size);
> +void ___dma_single_dev_to_cpu(const void *kaddr, size_t size,
> + ? ? ? enum dma_data_direction dir)
> +{
> + ? ? ? BUG_ON(!virt_addr_valid(kaddr) || !virt_addr_valid(kaddr + size - 1));
> +
> + ? ? ? /* don't bother invalidating if DMA to device */
> + ? ? ? if (dir != DMA_TO_DEVICE) {
> + ? ? ? ? ? ? ? unsigned long paddr = __pa(kaddr);
> + ? ? ? ? ? ? ? outer_inv_range(paddr, paddr + size);
> + ? ? ? ? ? ? ? dmac_inv_range(kaddr, kaddr + size);
> + ? ? ? }
that code implies that cache invalidate will be applied also for CPU's
that doesn't suffer from speculative prefetch issue, right?
> ?}
> -EXPORT_SYMBOL(dma_cache_maint);
> +EXPORT_SYMBOL(___dma_single_dev_to_cpu);
>
> ?static void dma_cache_maint_contiguous(struct page *page, unsigned long offset,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?size_t size, int direction)
> + ? ? ? ? ? ? ? ? ? ? ?size_t size, void (*op)(const void *, const void *))
> ?{
> ? ? ? ?void *vaddr;
> - ? ? ? unsigned long paddr;
> - ? ? ? void (*inner_op)(const void *, const void *);
> - ? ? ? void (*outer_op)(unsigned long, unsigned long);
> -
> - ? ? ? switch (direction) {
> - ? ? ? case DMA_FROM_DEVICE: ? ? ? ? ? /* invalidate only */
> - ? ? ? ? ? ? ? inner_op = dmac_inv_range;
> - ? ? ? ? ? ? ? outer_op = outer_inv_range;
> - ? ? ? ? ? ? ? break;
> - ? ? ? case DMA_TO_DEVICE: ? ? ? ? ? ? /* writeback only */
> - ? ? ? ? ? ? ? inner_op = dmac_clean_range;
> - ? ? ? ? ? ? ? outer_op = outer_clean_range;
> - ? ? ? ? ? ? ? break;
> - ? ? ? case DMA_BIDIRECTIONAL: ? ? ? ? /* writeback and invalidate */
> - ? ? ? ? ? ? ? inner_op = dmac_flush_range;
> - ? ? ? ? ? ? ? outer_op = outer_flush_range;
> - ? ? ? ? ? ? ? break;
> - ? ? ? default:
> - ? ? ? ? ? ? ? BUG();
> - ? ? ? }
>
> ? ? ? ?if (!PageHighMem(page)) {
> ? ? ? ? ? ? ? ?vaddr = page_address(page) + offset;
> - ? ? ? ? ? ? ? inner_op(vaddr, vaddr + size);
> + ? ? ? ? ? ? ? op(vaddr, vaddr + size);
> ? ? ? ?} else {
> ? ? ? ? ? ? ? ?vaddr = kmap_high_get(page);
> ? ? ? ? ? ? ? ?if (vaddr) {
> ? ? ? ? ? ? ? ? ? ? ? ?vaddr += offset;
> - ? ? ? ? ? ? ? ? ? ? ? inner_op(vaddr, vaddr + size);
> + ? ? ? ? ? ? ? ? ? ? ? op(vaddr, vaddr + size);
> ? ? ? ? ? ? ? ? ? ? ? ?kunmap_high(page);
> ? ? ? ? ? ? ? ?}
> ? ? ? ?}
> -
> - ? ? ? paddr = page_to_phys(page) + offset;
> - ? ? ? outer_op(paddr, paddr + size);
> ?}
>
> -void dma_cache_maint_page(struct page *page, unsigned long offset,
> - ? ? ? ? ? ? ? ? ? ? ? ? size_t size, int dir)
> +void __dma_cache_maint_page(struct page *page, unsigned long offset,
> + ? ? ? size_t size, void (*op)(const void *, const void *))
> ?{
> ? ? ? ?/*
> ? ? ? ? * A single sg entry may refer to multiple physically contiguous
> @@ -628,13 +608,40 @@ void dma_cache_maint_page(struct page *page, unsigned long offset,
> ? ? ? ? ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ? ? ? ? ?len = PAGE_SIZE - offset;
> ? ? ? ? ? ? ? ?}
> - ? ? ? ? ? ? ? dma_cache_maint_contiguous(page, offset, len, dir);
> + ? ? ? ? ? ? ? dma_cache_maint_contiguous(page, offset, len, op);
> ? ? ? ? ? ? ? ?offset = 0;
> ? ? ? ? ? ? ? ?page++;
> ? ? ? ? ? ? ? ?left -= len;
> ? ? ? ?} while (left);
> ?}
> -EXPORT_SYMBOL(dma_cache_maint_page);
> +
> +void ___dma_page_cpu_to_dev(struct page *page, unsigned long off,
> + ? ? ? size_t size, enum dma_data_direction dir)
> +{
> + ? ? ? unsigned long paddr = page_to_phys(page) + offset;
> +
> + ? ? ? if (dir == DMA_FROM_DEVICE) {
> + ? ? ? ? ? ? ? outer_inv_range(paddr, paddr + size);
> + ? ? ? ? ? ? ? __dma_cache_maint_page(page, off, size, dmac_inv_range);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? __dma_cache_maint_page(page, off, size, dmac_clean_range);
> + ? ? ? ? ? ? ? outer_clean_range(paddr, paddr + size);
> + ? ? ? }
> +}
> +EXPORT_SYMBOL(___dma_page_cpu_to_dev);
> +
> +void ___dma_page_dev_to_cpu(struct page *page, unsigned long off,
> + ? ? ? size_t size, enum dma_data_direction dir)
> +{
> + ? ? ? unsigned long paddr = page_to_phys(page) + offset;
> +
> + ? ? ? /* don't bother invalidating if DMA to device */
> + ? ? ? if (dir != DMA_TO_DEVICE) {
> + ? ? ? ? ? ? ? outer_inv_range(paddr, paddr + size);
> + ? ? ? ? ? ? ? __dma_cache_maint_page(page, off, size, dmac_inv_range);
> + ? ? ? }
> +}
> +EXPORT_SYMBOL(___dma_page_dev_to_cpu);
>
> ?/**
> ?* dma_map_sg - map a set of SG buffers for streaming mode DMA
> --
> 1.6.2.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
