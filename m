From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 11 Oct 2018 14:21:17 -0600
Subject: [PATCH 5/5] RISC-V: Implement sparsemem
In-Reply-To: <83cfd2d7-b840-b0c6-594e-8b39be8177c1@deltatee.com>
References: <20181005161642.2462-1-logang@deltatee.com>
 <20181005161642.2462-6-logang@deltatee.com> <20181011133730.GB7276@lst.de>
 <8cea5ffa-5fbf-8ea2-b673-20e2d09a910d@deltatee.com>
 <83cfd2d7-b840-b0c6-594e-8b39be8177c1@deltatee.com>
Message-ID: <cfb2af87-7e47-539c-d149-2599f23b663a@deltatee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018-10-11 12:45 p.m., Logan Gunthorpe wrote:
> Ok, I spoke too soon...
> 
> Having this define next to the struct page definition works great for
> riscv. However, making that happen in arm64 seems to be a nightmare. The
> include chain in arm64 is tangled up so much that including mm_types
> where this is needed seems to be extremely difficult.

Sorry for all the unnecessary churn but I've figured it out. Just had to
realize we only need mm_types.h to be included where
STRUCT_PAGE_MAX_SHIFT is finally expanded. Thus we only need it in one
more spot (fixmap.h). See below.

Thanks,

Logan

--


diff --git a/arch/arm64/include/asm/memory.h
b/arch/arm64/include/asm/memory.h
index b96442960aea..f0a5c9531e8b 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -34,15 +34,6 @@
  */
 #define PCI_IO_SIZE            SZ_16M

-/*
- * Log2 of the upper bound of the size of a struct page. Used for sizing
- * the vmemmap region only, does not affect actual memory footprint.
- * We don't use sizeof(struct page) directly since taking its size here
- * requires its definition to be available at this point in the inclusion
- * chain, and it may not be a power of 2 in the first place.
- */
-#define STRUCT_PAGE_MAX_SHIFT  6
-
 /*
  * VMEMMAP_SIZE - allows the whole linear region to be covered by
  *                a struct page array
diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 827e4d3bbc7a..8cc7b09c1bc7 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -16,6 +16,7 @@
 #define __ASM_GENERIC_FIXMAP_H

 #include <linux/bug.h>
+#include <linux/mm_types.h>

 #define __fix_to_virt(x)       (FIXADDR_TOP - ((x) << PAGE_SHIFT))
 #define __virt_to_fix(x)       ((FIXADDR_TOP - ((x)&PAGE_MASK)) >>
PAGE_SHIFT)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5ed8f6292a53..d1c3cde8c201 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -206,6 +206,11 @@ struct page {
 #endif
 } _struct_page_alignment;

+/*
+ * Used for sizing the vmemmap region on some architectures.
+ */
+#define STRUCT_PAGE_MAX_SHIFT  ilog2(roundup_pow_of_two(sizeof(struct
page)))
+
 #define PAGE_FRAG_CACHE_MAX_SIZE       __ALIGN_MASK(32768, ~PAGE_MASK)
 #define PAGE_FRAG_CACHE_MAX_ORDER      get_order(PAGE_FRAG_CACHE_MAX_SIZE)
