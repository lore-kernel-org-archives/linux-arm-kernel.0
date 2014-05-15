From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 15 May 2014 13:26:24 -0700
Subject: [review] ARM: dma-mapping: Add support DMA allocate memory without
 mapping
In-Reply-To: <14325562.oAPLH1PRKP@wuerfel>
References: <53746A80.8070900@gmail.com> <14325562.oAPLH1PRKP@wuerfel>
Message-ID: <537522F0.3060008@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/15/2014 12:42 PM, Arnd Bergmann wrote:
> On Thursday 15 May 2014 15:19:28 albuer wrote:
>> Dear all:
>>
>> ARM: dma-mapping: Add support DMA allocate memory without mapping
>>
>> reserved DMA(CMA) regions may be large than 512MB for devices, placed it
>> in the highmem zone is appropriate, but according to the existing
>> mechanism, memory allocation with mapping will cause vmalloc area not
>> enough.
>>
>> Now we don't do mapping if the DMA_ATTR_NO_KERNEL_MAPPING is set.
>>
>> the DMA(CMA) region used for VPU/VOP/Camera/RGA etc, my screen
>> resolution: 2560*1600, we need CMA memory large than 768MB.
>>
> 
> Please follow the normal submission procedure as documented in
> Documentation/SubmittingPatches, and put the patch inline rather
> than an attachment.
> 
> I've pasted the patch below for review.
> 
>  
>> +static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t
>> prot); +
> 
> Style: better move the inline function here to avoid the forward declaration.
> 
>>  static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t
>>  gfp,
>>
>> -				 pgprot_t prot, struct page **ret_page,
>> +				 struct dma_attrs *attrs, struct page **ret_page,
>>
>>  				 const void *caller)
>>  
>>  {
>>  
>>  	struct page *page;
>>  	void *ptr;
>>
>> +	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
>>
>>  	page = __dma_alloc_buffer(dev, size, gfp);
>>  	if (!page)
>>  	
>>  		return NULL;
>>
>> +	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
>> +		return (*ret_page=page);
>> +
>>
>>  	ptr = __dma_alloc_remap(page, size, gfp, prot, caller);
>>  	if (!ptr) {
>>  	
>>  		__dma_free_buffer(page, size);
>>
> 
> Hmm, so if we don't want a mapping, the function returns a pointer
> to the struct page rather than to the virtual address?
> 
> This sounds like it will do the right thing, but it's also a
> very confusing interface. Maybe somebody can think of a better
> return value.
> 
> We do have a similarly confusing case for the existing __iommu_get_pages
> function:
> 
> static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
> {
>         struct vm_struct *area;
> 
>         if (__in_atomic_pool(cpu_addr, PAGE_SIZE))
>                 return __atomic_get_pages(cpu_addr);
> 
>         if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
>                 return cpu_addr;
> 
>         area = find_vm_area(cpu_addr);
>         if (area && (area->flags & VM_ARM_DMA_CONSISTENT))
>                 return area->pages;
>         return NULL;
> }
> 
> This either returns 'cpu_addr' directly, or a pointer to the pages. I have
> no idea how this can work right, but I may be missing something subtle.
> 
> 	Arnd

We've had a similar patch to this out of tree for a while now. The big concern
I had was someone allocating with DMA_ATTR_NO_KERNEL_MAPPING and then trying to
dereference the CPU address and corrupting whatever data was there. We took the
heavy handed approach of ensuring that any access to the CPU address should cause
a fault.

Thanks,
Laura

------ 8< -------

>From 8e46e5c626926ea971fdd58cb906b465313b37de Mon Sep 17 00:00:00 2001
From: Laura Abbott <lauraa@codeaurora.org>
Date: Thu, 15 May 2014 13:13:35 -0700
Subject: [PATCH] ARM: dma-mapping: Allow CMA pages to not have a mapping

CMA buffers can get very large and if the CPU is never going
to write to a buffer anyway there is no need for a kernel mapping.
Allow the CPU side mapping to be removed/skipped if
DMA_ATTR_NO_KERNEL_MAPPING is passed in.

(Rebased based on previous patch)

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/mm/dma-mapping.c | 106 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 75 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6b00be1..0980e3c 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -39,6 +39,7 @@
 
 #include "mm.h"
 
+#define NO_KERNEL_MAPPING_DUMMY		0x2222
 /*
  * The DMA API is built upon the notion of "buffer ownership".  A buffer
  * is either exclusively owned by the CPU (and therefore may be accessed
@@ -286,13 +287,17 @@ static void __dma_free_buffer(struct page *page, size_t size)
 #ifdef CONFIG_MMU
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
-				     pgprot_t prot, struct page **ret_page,
+				     struct dma_attrs *attrs,
+				     struct page **ret_page,
 				     const void *caller);
 
 static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
-				 pgprot_t prot, struct page **ret_page,
+				 struct dma_attrs *attrs,
+				 struct page **ret_page,
 				 const void *caller);
 
+static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot);
+
 static void *
 __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot,
 	const void *caller)
@@ -373,7 +378,6 @@ void __init init_dma_coherent_pool_size(unsigned long size)
 static int __init atomic_pool_init(void)
 {
 	struct dma_pool *pool = &atomic_pool;
-	pgprot_t prot = pgprot_dmacoherent(PAGE_KERNEL);
 	gfp_t gfp = GFP_KERNEL | GFP_DMA;
 	unsigned long nr_pages = pool->size >> PAGE_SHIFT;
 	unsigned long *bitmap;
@@ -391,10 +395,10 @@ static int __init atomic_pool_init(void)
 		goto no_pages;
 
 	if (IS_ENABLED(CONFIG_DMA_CMA))
-		ptr = __alloc_from_contiguous(NULL, pool->size, prot, &page,
+		ptr = __alloc_from_contiguous(NULL, pool->size, NULL, &page,
 					      atomic_pool_init);
 	else
-		ptr = __alloc_remap_buffer(NULL, pool->size, gfp, prot, &page,
+		ptr = __alloc_remap_buffer(NULL, pool->size, gfp, NULL, &page,
 					   atomic_pool_init);
 	if (ptr) {
 		int i;
@@ -481,25 +485,47 @@ static int __dma_update_pte(pte_t *pte, pgtable_t token, unsigned long addr,
 	return 0;
 }
 
-static void __dma_remap(struct page *page, size_t size, pgprot_t prot)
+static int __dma_clear_pte(pte_t *pte, pgtable_t token, unsigned long addr,
+				void *data)
+{
+	pte_clear(&init_mm, addr, pte);
+	return 0;
+}
+
+static void __dma_remap(struct page *page, size_t size, pgprot_t prot,
+			bool no_kernel_map)
 {
 	unsigned long start = (unsigned long) page_address(page);
 	unsigned end = start + size;
+	int (*func)(pte_t *pte, pgtable_t token,
+					unsigned long addr, void *data);
 
-	apply_to_page_range(&init_mm, start, size, __dma_update_pte, &prot);
+	if (no_kernel_map)
+		func = __dma_clear_pte;
+	else
+		func = __dma_update_pte;
+
+	apply_to_page_range(&init_mm, start, size, func, &prot);
 	flush_tlb_kernel_range(start, end);
 }
 
 static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
-				 pgprot_t prot, struct page **ret_page,
+				 struct dma_attrs *attrs,
+				 struct page **ret_page,
 				 const void *caller)
 {
 	struct page *page;
 	void *ptr;
+	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	page = __dma_alloc_buffer(dev, size, gfp);
 	if (!page)
 		return NULL;
 
+	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs)) {
+		*ret_page = page;
+		return NO_KERNEL_MAPPING_DUMMY;
+	}
+
 	ptr = __dma_alloc_remap(page, size, gfp, prot, caller);
 	if (!ptr) {
 		__dma_free_buffer(page, size);
@@ -587,13 +613,16 @@ static int __free_from_pool(void *start, size_t size)
 }
 
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
-				     pgprot_t prot, struct page **ret_page,
+				     struct dma_attrs *attrs,
+				     struct page **ret_page,
 				     const void *caller)
 {
 	unsigned long order = get_order(size);
 	size_t count = size >> PAGE_SHIFT;
 	struct page *page;
 	void *ptr;
+	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
+	bool no_kernel_mapping = false;
 
 	page = dma_alloc_from_contiguous(dev, count, order);
 	if (!page)
@@ -601,14 +630,22 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 
 	__dma_clear_buffer(page, size);
 
+	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
+		no_kernel_mapping = true;
+
 	if (PageHighMem(page)) {
-		ptr = __dma_alloc_remap(page, size, GFP_KERNEL, prot, caller);
-		if (!ptr) {
-			dma_release_from_contiguous(dev, page, count);
-			return NULL;
+		if (no_kernel_mapping) {
+			ptr = (void *)NO_KERNEL_MAPPING_DUMMY;
+		} else {
+			ptr = __dma_alloc_remap(page, size, GFP_KERNEL, prot,
+						caller);
+			if (!ptr) {
+				dma_release_from_contiguous(dev, page, count);
+				return NULL;
+			}
 		}
 	} else {
-		__dma_remap(page, size, prot);
+		__dma_remap(page, size, prot, no_kernel_mapping);
 		ptr = page_address(page);
 	}
 	*ret_page = page;
@@ -616,12 +653,15 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 }
 
 static void __free_from_contiguous(struct device *dev, struct page *page,
-				   void *cpu_addr, size_t size)
+				   void *cpu_addr, size_t size,
+				    struct dma_attrs *attrs)
 {
-	if (PageHighMem(page))
-		__dma_free_remap(cpu_addr, size);
-	else
-		__dma_remap(page, size, PAGE_KERNEL);
+	if (!dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs)) {
+		if (PageHighMem(page))
+			__dma_free_remap(cpu_addr, size);
+		else
+			__dma_remap(page, size, PAGE_KERNEL, false);
+	}
 	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
 }
 
@@ -640,11 +680,11 @@ static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot)
 #define nommu() 1
 
 #define __get_dma_pgprot(attrs, prot)	__pgprot(0)
-#define __alloc_remap_buffer(dev, size, gfp, prot, ret, c)	NULL
+#define __alloc_remap_buffer(dev, size, gfp, attrs, ret, c)	NULL
 #define __alloc_from_pool(size, ret_page)			NULL
-#define __alloc_from_contiguous(dev, size, prot, ret, c)	NULL
+#define __alloc_from_contiguous(dev, size, attrs, ret, c)	NULL
 #define __free_from_pool(cpu_addr, size)			0
-#define __free_from_contiguous(dev, page, cpu_addr, size)	do { } while (0)
+#define __free_from_contiguous(dev, page, cpu_addr, size, attrs)	do { } while (0)
 #define __dma_free_remap(cpu_addr, size)			do { } while (0)
 
 #endif	/* CONFIG_MMU */
@@ -664,7 +704,8 @@ static void *__alloc_simple_buffer(struct device *dev, size_t size, gfp_t gfp,
 
 
 static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-			 gfp_t gfp, pgprot_t prot, bool is_coherent, const void *caller)
+			 gfp_t gfp, struct dma_attrs *attrs, bool is_coherent,
+			 const void *caller)
 {
 	u64 mask = get_coherent_dma_mask(dev);
 	struct page *page = NULL;
@@ -702,9 +743,10 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	else if (!(gfp & __GFP_WAIT))
 		addr = __alloc_from_pool(size, &page);
 	else if (!IS_ENABLED(CONFIG_DMA_CMA))
-		addr = __alloc_remap_buffer(dev, size, gfp, prot, &page, caller);
+		addr = __alloc_remap_buffer(dev, size, gfp, attrs, &page,
+						caller);
 	else
-		addr = __alloc_from_contiguous(dev, size, prot, &page, caller);
+		addr = __alloc_from_contiguous(dev, size, attrs, &page, caller);
 
 	if (addr)
 		*handle = pfn_to_dma(dev, page_to_pfn(page));
@@ -715,30 +757,30 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 /*
  * Allocate DMA-coherent memory space and return both the kernel remapped
  * virtual and bus address for that space.
+ * If the DMA_ATTR_NO_KERNEL_MAPPING is set within attrs, return both
+ * the 'struct page*' and bus address.
  */
 void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		    gfp_t gfp, struct dma_attrs *attrs)
 {
-	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	void *memory;
 
 	if (dma_alloc_from_coherent(dev, size, handle, &memory))
 		return memory;
 
-	return __dma_alloc(dev, size, handle, gfp, prot, false,
+	return __dma_alloc(dev, size, handle, gfp, attrs, false,
 			   __builtin_return_address(0));
 }
 
 static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
 	dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
 {
-	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	void *memory;
 
 	if (dma_alloc_from_coherent(dev, size, handle, &memory))
 		return memory;
 
-	return __dma_alloc(dev, size, handle, gfp, prot, true,
+	return __dma_alloc(dev, size, handle, gfp, attrs, true,
 			   __builtin_return_address(0));
 }
 
@@ -791,14 +833,16 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	} else if (__free_from_pool(cpu_addr, size)) {
 		return;
 	} else if (!IS_ENABLED(CONFIG_DMA_CMA)) {
-		__dma_free_remap(cpu_addr, size);
+		if (!dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
+			__dma_free_remap(cpu_addr, size);
+
 		__dma_free_buffer(page, size);
 	} else {
 		/*
 		 * Non-atomic allocations cannot be freed with IRQs disabled
 		 */
 		WARN_ON(irqs_disabled());
-		__free_from_contiguous(dev, page, cpu_addr, size);
+		__free_from_contiguous(dev, page, cpu_addr, size, attrs);
 	}
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
