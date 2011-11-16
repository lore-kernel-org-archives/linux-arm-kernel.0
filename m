From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:39 -0500
Subject: [PATCH 21/23] ARM: add generic ioremap optimization by reusing static
 mappings
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <1321422521-1138-22-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

Now that we have all the static mappings from iotable_init() located
in the vmalloc area, it is trivial to optimize ioremap by reusing those
static mappings when the requested physical area fits in one of them,
and so in a generic way for all platforms.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mm/ioremap.c |   72 ++++++++++++++++++++++++++++++++----------------
 arch/arm/mm/mm.h      |   14 +++++++++
 arch/arm/mm/mmu.c     |    3 +-
 3 files changed, 64 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index bc7d9bd766..12c7ad215c 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -36,12 +36,6 @@
 #include <asm/mach/map.h>
 #include "mm.h"
 
-/*
- * Used by ioremap() and iounmap() code to mark (super)section-mapped
- * I/O regions in vm_struct->flags field.
- */
-#define VM_ARM_SECTION_MAPPING	0x80000000
-
 int ioremap_page(unsigned long virt, unsigned long phys,
 		 const struct mem_type *mtype)
 {
@@ -201,12 +195,6 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 	if (pfn >= 0x100000 && (__pfn_to_phys(pfn) & ~SUPERSECTION_MASK))
 		return NULL;
 
-	/*
-	 * Don't allow RAM to be mapped - this causes problems with ARMv6+
-	 */
-	if (WARN_ON(pfn_valid(pfn)))
-		return NULL;
-
 	type = get_mem_type(mtype);
 	if (!type)
 		return NULL;
@@ -216,6 +204,34 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 	 */
 	size = PAGE_ALIGN(offset + size);
 
+	/*
+	 * Try to reuse one of the static mapping whenever possible.
+	 */
+	read_lock(&vmlist_lock);
+	for (area = vmlist; area; area = area->next) {
+		if (!size || (sizeof(phys_addr_t) == 4 && pfn >= 0x100000))
+			break;
+		if (!(area->flags & VM_ARM_STATIC_MAPPING))
+			continue;
+		if ((area->flags & VM_ARM_MTYPE_MASK) != VM_ARM_MTYPE(mtype))
+			continue;
+		if (__phys_to_pfn(area->phys_addr) > pfn ||
+		    __pfn_to_phys(pfn) + size-1 > area->phys_addr + area->size-1)
+			continue;
+		/* we can drop the lock here as we know *area is static */
+		read_unlock(&vmlist_lock);
+		addr = (unsigned long)area->addr;
+		addr += __pfn_to_phys(pfn) - area->phys_addr;
+		return (void __iomem *) (offset + addr);
+	}
+	read_unlock(&vmlist_lock);
+
+	/*
+	 * Don't allow RAM to be mapped - this causes problems with ARMv6+
+	 */
+	if (WARN_ON(pfn_valid(pfn)))
+		return NULL;
+
 	area = get_vm_area_caller(size, VM_IOREMAP, caller);
  	if (!area)
  		return NULL;
@@ -313,26 +329,34 @@ __arm_ioremap_exec(unsigned long phys_addr, size_t size, bool cached)
 void __iounmap(volatile void __iomem *io_addr)
 {
 	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
-#ifndef CONFIG_SMP
 	struct vm_struct *vm;
 
-	/*
-	 * If this is a section based mapping we need to handle it
-	 * specially as the VM subsystem does not know how to handle
-	 * such a beast.
-	 */
 	read_lock(&vmlist_lock);
 	for (vm = vmlist; vm; vm = vm->next) {
-		if ((vm->flags & VM_IOREMAP) && (vm->addr == addr)) {
-			if (vm->flags & VM_ARM_SECTION_MAPPING) {
-				unmap_area_sections((unsigned long)vm->addr,
-						    vm->size);
-			}
+		if (vm->addr > addr)
 			break;
+		if (!(vm->flags & VM_IOREMAP))
+			continue;
+		/* If this is a static mapping we must leave it alone */
+		if ((vm->flags & VM_ARM_STATIC_MAPPING) &&
+		    (vm->addr <= addr) && (vm->addr + vm->size > addr)) {
+			read_unlock(&vmlist_lock);
+			return;
 		}
+#ifndef CONFIG_SMP
+		/*
+		 * If this is a section based mapping we need to handle it
+		 * specially as the VM subsystem does not know how to handle
+		 * such a beast.
+		 */
+		if ((vm->addr == addr) &&
+		    (vm->flags & VM_ARM_SECTION_MAPPING)) {
+			unmap_area_sections((unsigned long)vm->addr, vm->size);
+			break;
+		}
+#endif
 	}
 	read_unlock(&vmlist_lock);
-#endif
 
 	vunmap(addr);
 }
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index ad7cce3bc4..70f6d3ea48 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -21,6 +21,20 @@ const struct mem_type *get_mem_type(unsigned int type);
 
 extern void __flush_dcache_page(struct address_space *mapping, struct page *page);
 
+/*
+ * ARM specific vm_struct->flags bits.
+ */
+
+/* (super)section-mapped I/O regions used by ioremap()/iounmap() */
+#define VM_ARM_SECTION_MAPPING	0x80000000
+
+/* permanent static mappings from iotable_init() */
+#define VM_ARM_STATIC_MAPPING	0x40000000
+
+/* mapping type (attributes) for permanent static mappings */
+#define VM_ARM_MTYPE(mt)		((mt) << 20)
+#define VM_ARM_MTYPE_MASK	(0x1f << 20)
+
 #endif
 
 #ifdef CONFIG_ZONE_DMA
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 942ca8f369..acb2c7ec0a 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -746,7 +746,8 @@ void __init iotable_init(struct map_desc *io_desc, int nr)
 		vm->addr = (void *)(md->virtual & PAGE_MASK);
 		vm->size = PAGE_ALIGN(md->length + (md->virtual & ~PAGE_MASK));
 		vm->phys_addr = __pfn_to_phys(md->pfn); 
-		vm->flags = VM_IOREMAP;
+		vm->flags = VM_IOREMAP | VM_ARM_STATIC_MAPPING; 
+		vm->flags |= VM_ARM_MTYPE(md->type);
 		vm->caller = iotable_init;
 		vm_area_add_early(vm++);
 	}
-- 
1.7.7.1.431.g10b2a
