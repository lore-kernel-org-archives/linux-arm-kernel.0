From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Sat, 09 Nov 2013 11:55:03 -0500
Subject: [PATCH 14/24] mm/lib/swiotlb: Use memblock apis for early memory
 allocations
In-Reply-To: <1383954120-24368-15-git-send-email-santosh.shilimkar@ti.com>
References: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com>
 <1383954120-24368-15-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <6314f039-a40e-4250-9d62-6bb6ac7c6bec@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>Switch to memblock interfaces for early memory allocator instead of
>bootmem allocator. No functional change in beahvior than what it is
>in current code from bootmem users points of view.
>
>Archs already converted to NO_BOOTMEM now directly use memblock
>interfaces instead of bootmem wrappers build on top of memblock. And
>the
>archs which still uses bootmem, these new apis just fallback to exiting
>bootmem APIs.
>
>Cc: Yinghai Lu <yinghai@kernel.org>
>Cc: Tejun Heo <tj@kernel.org>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>
>Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>---
> lib/swiotlb.c |   36 +++++++++++++++++++++---------------
> 1 file changed, 21 insertions(+), 15 deletions(-)
>
>diff --git a/lib/swiotlb.c b/lib/swiotlb.c
>index 4e8686c..78ac01a 100644
>--- a/lib/swiotlb.c
>+++ b/lib/swiotlb.c
>@@ -169,8 +169,9 @@ int __init swiotlb_init_with_tbl(char *tlb,
>unsigned long nslabs, int verbose)
> 	/*
> 	 * Get the overflow emergency buffer
> 	 */
>-	v_overflow_buffer = alloc_bootmem_low_pages_nopanic(
>-						PAGE_ALIGN(io_tlb_overflow));
>+	v_overflow_buffer = memblock_virt_alloc_align_nopanic(
>+						PAGE_ALIGN(io_tlb_overflow),
>+						PAGE_SIZE);

Does this guarantee that the pages will be allocated below 4GB?

> 	if (!v_overflow_buffer)
> 		return -ENOMEM;
> 
>@@ -181,11 +182,15 @@ int __init swiotlb_init_with_tbl(char *tlb,
>unsigned long nslabs, int verbose)
>	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
> 	 * between io_tlb_start and io_tlb_end.
> 	 */
>-	io_tlb_list = alloc_bootmem_pages(PAGE_ALIGN(io_tlb_nslabs *
>sizeof(int)));
>+	io_tlb_list = memblock_virt_alloc_align(
>+				PAGE_ALIGN(io_tlb_nslabs * sizeof(int)),
>+				PAGE_SIZE);
> 	for (i = 0; i < io_tlb_nslabs; i++)
>  		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
> 	io_tlb_index = 0;
>-	io_tlb_orig_addr = alloc_bootmem_pages(PAGE_ALIGN(io_tlb_nslabs *
>sizeof(phys_addr_t)));
>+	io_tlb_orig_addr = memblock_virt_alloc_align(
>+				PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)),
>+				PAGE_SIZE);
> 
> 	if (verbose)
> 		swiotlb_print_info();
>@@ -212,13 +217,14 @@ swiotlb_init(int verbose)
> 	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> 
> 	/* Get IO TLB memory from the low pages */
>-	vstart = alloc_bootmem_low_pages_nopanic(PAGE_ALIGN(bytes));
>+	vstart = memblock_virt_alloc_align_nopanic(PAGE_ALIGN(bytes),
>+						   PAGE_SIZE);

Ditto?
> 	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
> 		return;
> 
> 	if (io_tlb_start)
>-		free_bootmem(io_tlb_start,
>-				 PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
>+		memblock_free_early(io_tlb_start,
>+				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
> 	pr_warn("Cannot allocate SWIOTLB buffer");
> 	no_iotlb_memory = true;
> }
>@@ -354,14 +360,14 @@ void __init swiotlb_free(void)
> 		free_pages((unsigned long)phys_to_virt(io_tlb_start),
> 			   get_order(io_tlb_nslabs << IO_TLB_SHIFT));
> 	} else {
>-		free_bootmem_late(io_tlb_overflow_buffer,
>-				  PAGE_ALIGN(io_tlb_overflow));
>-		free_bootmem_late(__pa(io_tlb_orig_addr),
>-				  PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)));
>-		free_bootmem_late(__pa(io_tlb_list),
>-				  PAGE_ALIGN(io_tlb_nslabs * sizeof(int)));
>-		free_bootmem_late(io_tlb_start,
>-				  PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
>+		memblock_free_late(io_tlb_overflow_buffer,
>+				   PAGE_ALIGN(io_tlb_overflow));
>+		memblock_free_late(__pa(io_tlb_orig_addr),
>+				   PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)));
>+		memblock_free_late(__pa(io_tlb_list),
>+				   PAGE_ALIGN(io_tlb_nslabs * sizeof(int)));
>+		memblock_free_late(io_tlb_start,
>+				   PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
> 	}
> 	io_tlb_nslabs = 0;
> }
