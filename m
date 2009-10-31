From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Oct 2009 17:24:15 +0000
Subject: DMA Cache coherency issue on A9 SMP System
In-Reply-To: <d82162470910310613mff28897k68d8794b6fb5b469@mail.gmail.com>
References: <d82162470910310613mff28897k68d8794b6fb5b469@mail.gmail.com>
Message-ID: <20091031172415.GA1835@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 31, 2009 at 06:43:19PM +0530, Rajanikanth H.V wrote:
> I comeacross to see DMA cache coherency problem which is similar to
> what you have stated in one of your previous mails,
> "esp., dma cache coherency issue in the case of DMA_FROM_DEVICE.

Please try this patch - note that I've only build-tested this.
(This patch is the result of several smaller patches, and is supplied
as a single patch for easy testing.)

 arch/arm/common/dmabounce.c                 |   30 ++++++++++----
 arch/arm/include/asm/dma-mapping.h          |   49 +++++++++++++---------
 arch/arm/include/asm/memory.h               |    3 +-
 arch/arm/mach-iop13xx/include/mach/memory.h |    2 +
 arch/arm/mach-ks8695/include/mach/memory.h  |    7 +++
 arch/arm/mm/cache-fa.S                      |    5 --
 arch/arm/mm/cache-v4wb.S                    |    5 --
 arch/arm/mm/cache-v6.S                      |   13 ------
 arch/arm/mm/cache-v7.S                      |    6 ---
 arch/arm/mm/dma-mapping.c                   |   61 ++++++++++----------------
 arch/arm/mm/proc-arm1020.S                  |    8 ----
 arch/arm/mm/proc-arm1020e.S                 |    4 --
 arch/arm/mm/proc-arm1022.S                  |    4 --
 arch/arm/mm/proc-arm1026.S                  |    4 --
 arch/arm/mm/proc-arm920.S                   |    4 --
 arch/arm/mm/proc-arm922.S                   |    4 --
 arch/arm/mm/proc-arm925.S                   |    6 ---
 arch/arm/mm/proc-arm926.S                   |    6 ---
 arch/arm/mm/proc-arm946.S                   |    7 ---
 arch/arm/mm/proc-feroceon.S                 |    4 --
 arch/arm/mm/proc-mohawk.S                   |    4 --
 arch/arm/mm/proc-xsc3.S                     |    4 --
 arch/arm/mm/proc-xscale.S                   |    4 --
 arch/arm/plat-omap/include/mach/memory.h    |    7 +++
 24 files changed, 93 insertions(+), 158 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 734ac91..7f94658 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -277,7 +277,7 @@ static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 		 * We don't need to sync the DMA buffer since
 		 * it was allocated via the coherent allocators.
 		 */
-		dma_cache_maint(ptr, size, dir);
+		__dma_cache_maint(ptr, size, 1);
 	}
 
 	return dma_addr;
@@ -310,15 +310,14 @@ static inline void unmap_single(struct device *dev, dma_addr_t dma_addr,
 			/*
 			 * DMA buffers must have the same cache properties
 			 * as if they were really used for DMA - which means
-			 * data must be written back to RAM.  Note that
-			 * we don't use dmac_flush_range() here for the
-			 * bidirectional case because we know the cache
-			 * lines will be coherent with the data written.
+			 * data must be written back to RAM.
 			 */
 			dmac_clean_range(ptr, ptr + size);
 			outer_clean_range(__pa(ptr), __pa(ptr) + size);
 		}
 		free_safe_buffer(dev->archdata.dmabounce, buf);
+	} else if (dir != DMA_TO_DEVICE) {
+		__dma_cache_maint(dma_to_virt(dev, dma_addr), size, 0);
 	}
 }
 
@@ -342,6 +341,22 @@ dma_addr_t dma_map_single(struct device *dev, void *ptr, size_t size,
 }
 EXPORT_SYMBOL(dma_map_single);
 
+/*
+ * see if a mapped address was really a "safe" buffer and if so, copy
+ * the data from the safe buffer back to the unsafe buffer and free up
+ * the safe buffer.  (basically return things back to the way they
+ * should be)
+ */
+void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+		enum dma_data_direction dir)
+{
+	dev_dbg(dev, "%s(ptr=%p,size=%d,dir=%x)\n",
+		__func__, (void *) dma_addr, size, dir);
+
+	unmap_single(dev, dma_addr, size, dir);
+}
+EXPORT_SYMBOL(dma_unmap_single);
+
 dma_addr_t dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir)
 {
@@ -366,8 +381,7 @@ EXPORT_SYMBOL(dma_map_page);
  * the safe buffer.  (basically return things back to the way they
  * should be)
  */
-
-void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+void dma_unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 		enum dma_data_direction dir)
 {
 	dev_dbg(dev, "%s(ptr=%p,size=%d,dir=%x)\n",
@@ -375,7 +389,7 @@ void dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
 
 	unmap_single(dev, dma_addr, size, dir);
 }
-EXPORT_SYMBOL(dma_unmap_single);
+EXPORT_SYMBOL(dma_unmap_page);
 
 int dmabounce_sync_for_cpu(struct device *dev, dma_addr_t addr,
 		unsigned long off, size_t sz, enum dma_data_direction dir)
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index ff46dfa..7894f37 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -15,20 +15,15 @@
  * must not be used by drivers.
  */
 #ifndef __arch_page_to_dma
-
-#if !defined(CONFIG_HIGHMEM)
 static inline dma_addr_t page_to_dma(struct device *dev, struct page *page)
 {
-	return (dma_addr_t)__virt_to_bus((unsigned long)page_address(page));
+	return (dma_addr_t)__pfn_to_bus(page_to_pfn(page));
 }
-#elif defined(__pfn_to_bus)
-static inline dma_addr_t page_to_dma(struct device *dev, struct page *page)
+
+static inline struct page *dma_to_page(struct device *dev, dma_addr_t addr)
 {
-	return (dma_addr_t)__pfn_to_bus(page_to_pfn(page));
+	return pfn_to_page(__bus_to_pfn(addr));
 }
-#else
-#error "this machine class needs to define __arch_page_to_dma to use HIGHMEM"
-#endif
 
 static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
 {
@@ -45,6 +40,11 @@ static inline dma_addr_t page_to_dma(struct device *dev, struct page *page)
 	return __arch_page_to_dma(dev, page);
 }
 
+static inline struct page *dma_to_page(struct device *dev, dma_addr_t addr)
+{
+	return __arch_dma_to_page(dev, addr);
+}
+
 static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
 {
 	return __arch_dma_to_virt(dev, addr);
@@ -66,9 +66,9 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
  * platforms with CONFIG_DMABOUNCE.
  * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
  */
-extern void dma_cache_maint(const void *kaddr, size_t size, int rw);
-extern void dma_cache_maint_page(struct page *page, unsigned long offset,
-				 size_t size, int rw);
+extern void __dma_cache_maint(const void *kaddr, size_t size, int map);
+extern void __dma_cache_maint_page(struct page *page, unsigned long offset,
+				   size_t size, int map);
 
 /*
  * Return whether the given device DMA address mask can be supported
@@ -257,9 +257,11 @@ extern int dma_needs_bounce(struct device*, dma_addr_t, size_t);
  */
 extern dma_addr_t dma_map_single(struct device *, void *, size_t,
 		enum dma_data_direction);
+extern void dma_unmap_single(struct device *, dma_addr_t, size_t,
+		enum dma_data_direction);
 extern dma_addr_t dma_map_page(struct device *, struct page *,
 		unsigned long, size_t, enum dma_data_direction);
-extern void dma_unmap_single(struct device *, dma_addr_t, size_t,
+extern void dma_unmap_page(struct device *, dma_addr_t, size_t,
 		enum dma_data_direction);
 
 /*
@@ -303,7 +305,7 @@ static inline dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
 	BUG_ON(!valid_dma_direction(dir));
 
 	if (!arch_is_coherent())
-		dma_cache_maint(cpu_addr, size, dir);
+		__dma_cache_maint(cpu_addr, size, 1);
 
 	return virt_to_dma(dev, cpu_addr);
 }
@@ -328,7 +330,7 @@ static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 	BUG_ON(!valid_dma_direction(dir));
 
 	if (!arch_is_coherent())
-		dma_cache_maint_page(page, offset, size, dir);
+		__dma_cache_maint_page(page, offset, size, 1);
 
 	return page_to_dma(dev, page) + offset;
 }
@@ -350,9 +352,9 @@ static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 static inline void dma_unmap_single(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir)
 {
-	/* nothing to do */
+	if (dir != DMA_TO_DEVICE)
+		__dma_cache_maint(dma_to_virt(dev, handle), size, 0);
 }
-#endif /* CONFIG_DMABOUNCE */
 
 /**
  * dma_unmap_page - unmap a buffer previously mapped through dma_map_page()
@@ -371,8 +373,11 @@ static inline void dma_unmap_single(struct device *dev, dma_addr_t handle,
 static inline void dma_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir)
 {
-	dma_unmap_single(dev, handle, size, dir);
+	if (dir != DMA_TO_DEVICE)
+		__dma_cache_maint_page(dma_to_page(dev, handle),
+			handle & ~PAGE_MASK, size, 0);
 }
+#endif /* CONFIG_DMABOUNCE */
 
 /**
  * dma_sync_single_range_for_cpu
@@ -398,7 +403,11 @@ static inline void dma_sync_single_range_for_cpu(struct device *dev,
 {
 	BUG_ON(!valid_dma_direction(dir));
 
-	dmabounce_sync_for_cpu(dev, handle, offset, size, dir);
+	if (!dmabounce_sync_for_cpu(dev, handle, offset, size, dir))
+		return;
+
+	if (dir != DMA_TO_DEVICE)
+		__dma_cache_maint(dma_to_virt(dev, handle) + offset, size, 0);
 }
 
 static inline void dma_sync_single_range_for_device(struct device *dev,
@@ -411,7 +420,7 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
 		return;
 
 	if (!arch_is_coherent())
-		dma_cache_maint(dma_to_virt(dev, handle) + offset, size, dir);
+		__dma_cache_maint(dma_to_virt(dev, handle) + offset, size, 1);
 }
 
 static inline void dma_sync_single_for_cpu(struct device *dev,
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index cefedf0..37aa746 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -194,7 +194,8 @@ static inline void *phys_to_virt(unsigned long x)
 #ifndef __virt_to_bus
 #define __virt_to_bus	__virt_to_phys
 #define __bus_to_virt	__phys_to_virt
-#define __pfn_to_bus(x)	((x) << PAGE_SHIFT)
+#define __pfn_to_bus(x)	__pfn_to_phys(x)
+#define __bus_to_pfn(x)	__phys_to_pfn(x)
 #endif
 
 static inline __deprecated unsigned long virt_to_bus(void *x)
diff --git a/arch/arm/mach-iop13xx/include/mach/memory.h b/arch/arm/mach-iop13xx/include/mach/memory.h
index 42ae29b..25b1da9 100644
--- a/arch/arm/mach-iop13xx/include/mach/memory.h
+++ b/arch/arm/mach-iop13xx/include/mach/memory.h
@@ -64,6 +64,8 @@ static inline unsigned long __lbus_to_virt(dma_addr_t x)
 		(dma_addr_t)page_to_phys(page);				\
 	})
 
+#define __arch_dma_to_page(dev, addr)	phys_to_page(addr)
+
 #endif /* CONFIG_ARCH_IOP13XX */
 #endif /* !ASSEMBLY */
 
diff --git a/arch/arm/mach-ks8695/include/mach/memory.h b/arch/arm/mach-ks8695/include/mach/memory.h
index 76e5308..ffa19aa 100644
--- a/arch/arm/mach-ks8695/include/mach/memory.h
+++ b/arch/arm/mach-ks8695/include/mach/memory.h
@@ -41,6 +41,13 @@ extern struct bus_type platform_bus_type;
 		__dma = __dma - PHYS_OFFSET + KS8695_PCIMEM_PA; \
 	   __dma; })
 
+#define __arch_dma_to_page(dev, x)	\
+	({ dma_addr_t __dma = x;				\
+	   if (!is_lbus_device(dev))				\
+		__dma += PHYS_OFFSET - KS8695_PCIMEM_PA;	\
+	   phys_to_page(__dma);					\
+	})
+
 #endif
 
 #endif
diff --git a/arch/arm/mm/cache-fa.S b/arch/arm/mm/cache-fa.S
index b63a8f7..1711386 100644
--- a/arch/arm/mm/cache-fa.S
+++ b/arch/arm/mm/cache-fa.S
@@ -157,12 +157,7 @@ ENTRY(fa_flush_kern_dcache_page)
  *	- end	 - virtual end address
  */
 ENTRY(fa_dma_inv_range)
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c14, 1		@ clean & invalidate D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	bic	r1, r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/cache-v4wb.S b/arch/arm/mm/cache-v4wb.S
index 2ebc1b3..553931a 100644
--- a/arch/arm/mm/cache-v4wb.S
+++ b/arch/arm/mm/cache-v4wb.S
@@ -173,16 +173,11 @@ ENTRY(v4wb_coherent_user_range)
  *	- end	 - virtual end address
  */
 ENTRY(v4wb_dma_inv_range)
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 295e25d..d1dfd87 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -195,20 +195,7 @@ ENTRY(v6_flush_kern_dcache_page)
  *	- end     - virtual end address of region
  */
 ENTRY(v6_dma_inv_range)
-	tst	r0, #D_CACHE_LINE_SIZE - 1
 	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
-#ifdef HARVARD_CACHE
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D line
-#else
-	mcrne	p15, 0, r0, c7, c11, 1		@ clean unified line
-#endif
-	tst	r1, #D_CACHE_LINE_SIZE - 1
-	bic	r1, r1, #D_CACHE_LINE_SIZE - 1
-#ifdef HARVARD_CACHE
-	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D line
-#else
-	mcrne	p15, 0, r1, c7, c15, 1		@ clean & invalidate unified line
-#endif
 1:
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D line
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index e1bd975..893ee59 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -218,13 +218,7 @@ ENDPROC(v7_flush_kern_dcache_page)
 ENTRY(v7_dma_inv_range)
 	dcache_line_size r2, r3
 	sub	r3, r2, #1
-	tst	r0, r3
 	bic	r0, r0, r3
-	mcrne	p15, 0, r0, c7, c14, 1		@ clean & invalidate D / U line
-
-	tst	r1, r3
-	bic	r1, r1, r3
-	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D / U line
 1:
 	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D / U line
 	add	r0, r0, r2
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b9590a7..ababf83 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -539,58 +539,40 @@ core_initcall(consistent_init);
  * platforms with CONFIG_DMABOUNCE.
  * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
  */
-void dma_cache_maint(const void *start, size_t size, int direction)
+void __dma_cache_maint(const void *start, size_t size, int map)
 {
 	void (*inner_op)(const void *, const void *);
 	void (*outer_op)(unsigned long, unsigned long);
 
 	BUG_ON(!virt_addr_valid(start) || !virt_addr_valid(start + size - 1));
 
-	switch (direction) {
-	case DMA_FROM_DEVICE:		/* invalidate only */
-		inner_op = dmac_inv_range;
-		outer_op = outer_inv_range;
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
+	if (map) {		/* writeback only */
 		inner_op = dmac_clean_range;
 		outer_op = outer_clean_range;
-		break;
-	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
-		inner_op = dmac_flush_range;
-		outer_op = outer_flush_range;
-		break;
-	default:
-		BUG();
+	} else {		/* invalidate only */
+		inner_op = dmac_inv_range;
+		outer_op = outer_inv_range;
 	}
 
 	inner_op(start, start + size);
 	outer_op(__pa(start), __pa(start) + size);
 }
-EXPORT_SYMBOL(dma_cache_maint);
+EXPORT_SYMBOL(__dma_cache_maint);
 
 static void dma_cache_maint_contiguous(struct page *page, unsigned long offset,
-				       size_t size, int direction)
+				       size_t size, int map)
 {
 	void *vaddr;
 	unsigned long paddr;
 	void (*inner_op)(const void *, const void *);
 	void (*outer_op)(unsigned long, unsigned long);
 
-	switch (direction) {
-	case DMA_FROM_DEVICE:		/* invalidate only */
-		inner_op = dmac_inv_range;
-		outer_op = outer_inv_range;
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
+	if (map) {		/* writeback only */
 		inner_op = dmac_clean_range;
 		outer_op = outer_clean_range;
-		break;
-	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
-		inner_op = dmac_flush_range;
-		outer_op = outer_flush_range;
-		break;
-	default:
-		BUG();
+	} else {		/* invalidate only */
+		inner_op = dmac_inv_range;
+		outer_op = outer_inv_range;
 	}
 
 	if (!PageHighMem(page)) {
@@ -609,8 +591,8 @@ static void dma_cache_maint_contiguous(struct page *page, unsigned long offset,
 	outer_op(paddr, paddr + size);
 }
 
-void dma_cache_maint_page(struct page *page, unsigned long offset,
-			  size_t size, int dir)
+void __dma_cache_maint_page(struct page *page, unsigned long offset,
+	size_t size, int map)
 {
 	/*
 	 * A single sg entry may refer to multiple physically contiguous
@@ -628,13 +610,13 @@ void dma_cache_maint_page(struct page *page, unsigned long offset,
 			}
 			len = PAGE_SIZE - offset;
 		}
-		dma_cache_maint_contiguous(page, offset, len, dir);
+		dma_cache_maint_contiguous(page, offset, len, map);
 		offset = 0;
 		page++;
 		left -= len;
 	} while (left);
 }
-EXPORT_SYMBOL(dma_cache_maint_page);
+EXPORT_SYMBOL(__dma_cache_maint_page);
 
 /**
  * dma_map_sg - map a set of SG buffers for streaming mode DMA
@@ -708,8 +690,13 @@ void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
-		dmabounce_sync_for_cpu(dev, sg_dma_address(s), 0,
-					sg_dma_len(s), dir);
+		if (!dmabounce_sync_for_cpu(dev, sg_dma_address(s), 0,
+					    sg_dma_len(s), dir))
+			continue;
+
+		if (!arch_is_coherent() && dir != DMA_TO_DEVICE)
+			__dma_cache_maint_page(sg_page(s), s->offset,
+					       s->length, 0);
 	}
 }
 EXPORT_SYMBOL(dma_sync_sg_for_cpu);
@@ -733,8 +720,8 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 			continue;
 
 		if (!arch_is_coherent())
-			dma_cache_maint_page(sg_page(s), s->offset,
-					     s->length, dir);
+			__dma_cache_maint_page(sg_page(s), s->offset,
+					       s->length, 1);
 	}
 }
 EXPORT_SYMBOL(dma_sync_sg_for_device);
diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index d9fb4b9..7bbf624 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -267,15 +267,7 @@ ENTRY(arm1020_flush_kern_dcache_page)
 ENTRY(arm1020_dma_inv_range)
 	mov	ip, #0
 #ifndef CONFIG_CPU_DCACHE_DISABLE
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, ip, c7, c10, 4
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	mcrne	p15, 0, ip, c7, c10, 4		@ drain WB
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, ip, c7, c10, 4
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
-	mcrne	p15, 0, ip, c7, c10, 4		@ drain WB
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index 7453b75..d379cb7 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -260,11 +260,7 @@ ENTRY(arm1020e_flush_kern_dcache_page)
 ENTRY(arm1020e_dma_inv_range)
 	mov	ip, #0
 #ifndef CONFIG_CPU_DCACHE_DISABLE
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index 8eb72d7..f5a7949 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -249,11 +249,7 @@ ENTRY(arm1022_flush_kern_dcache_page)
 ENTRY(arm1022_dma_inv_range)
 	mov	ip, #0
 #ifndef CONFIG_CPU_DCACHE_DISABLE
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index 3b59f0d..1dc26f8 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -243,11 +243,7 @@ ENTRY(arm1026_flush_kern_dcache_page)
 ENTRY(arm1026_dma_inv_range)
 	mov	ip, #0
 #ifndef CONFIG_CPU_DCACHE_DISABLE
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 2b7c197..078a873 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -239,11 +239,7 @@ ENTRY(arm920_flush_kern_dcache_page)
  * (same as v4wb)
  */
 ENTRY(arm920_dma_inv_range)
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index 06a1aa4..22ca857 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -241,11 +241,7 @@ ENTRY(arm922_flush_kern_dcache_page)
  * (same as v4wb)
  */
 ENTRY(arm922_dma_inv_range)
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index cb53435..ff04299 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -283,12 +283,6 @@ ENTRY(arm925_flush_kern_dcache_page)
  * (same as v4wb)
  */
 ENTRY(arm925_dma_inv_range)
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	tst	r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
-#endif
 	bic	r0, r0, #CACHE_DLINESIZE - 1
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 1c48487..4b4c717 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -246,12 +246,6 @@ ENTRY(arm926_flush_kern_dcache_page)
  * (same as v4wb)
  */
 ENTRY(arm926_dma_inv_range)
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	tst	r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
-#endif
 	bic	r0, r0, #CACHE_DLINESIZE - 1
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index 40c0449..589a61c 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -215,18 +215,11 @@ ENTRY(arm946_flush_kern_dcache_page)
  * (same as arm926)
  */
 ENTRY(arm946_dma_inv_range)
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	tst	r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
-#endif
 	bic	r0, r0, #CACHE_DLINESIZE - 1
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index d0d7795..b2f264e 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -274,11 +274,7 @@ ENTRY(feroceon_range_flush_kern_dcache_page)
  */
 	.align	5
 ENTRY(feroceon_dma_inv_range)
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index 52b5fd7..191ea6d 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -218,10 +218,6 @@ ENTRY(mohawk_flush_kern_dcache_page)
  * (same as v4wb)
  */
 ENTRY(mohawk_dma_inv_range)
-	tst	r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 	bic	r0, r0, #CACHE_DLINESIZE - 1
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index 2028f37..2c1ac69 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -257,11 +257,7 @@ ENTRY(xsc3_flush_kern_dcache_page)
  *	- end	 - virtual end address
  */
 ENTRY(xsc3_dma_inv_range)
-	tst	r0, #CACHELINESIZE - 1
 	bic	r0, r0, #CACHELINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean L1 D line
-	tst	r1, #CACHELINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean L1 D line
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate L1 D line
 	add	r0, r0, #CACHELINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index f056c28..3170348 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -315,11 +315,7 @@ ENTRY(xscale_flush_kern_dcache_page)
  *	- end	 - virtual end address
  */
 ENTRY(xscale_dma_inv_range)
-	tst	r0, #CACHELINESIZE - 1
 	bic	r0, r0, #CACHELINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHELINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHELINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/plat-omap/include/mach/memory.h b/arch/arm/plat-omap/include/mach/memory.h
index 9ad41dc..3325f7b 100644
--- a/arch/arm/plat-omap/include/mach/memory.h
+++ b/arch/arm/plat-omap/include/mach/memory.h
@@ -68,6 +68,13 @@
 		__dma = __dma - PHYS_OFFSET + OMAP1510_LB_OFFSET; \
 	   __dma; })
 
+#define __arch_dma_to_page(dev, addr)	\
+	({ dma_addr_t __dma = addr;				\
+	   if (is_lbus_device(dev))				\
+		__dma += PHYS_OFFSET - OMAP1510_LB_OFFSET;	\
+	   phys_to_page(__dma);					\
+	})
+
 #define __arch_dma_to_virt(dev, addr)	({ (void *) (is_lbus_device(dev) ? \
 						lbus_to_virt(addr) : \
 						__phys_to_virt(addr)); })
