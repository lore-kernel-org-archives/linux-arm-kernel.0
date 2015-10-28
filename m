From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 27 Oct 2015 21:39:45 -0400
Subject: [for 4.4 PATCH] memremap: fix highmem support
Message-ID: <20151028013557.31764.66161.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently memremap checks if the range is "System RAM" and returns the
kernel linear address.  This is broken for highmem platforms where a
range may be "System RAM", but is not part of the kernel linear mapping.
Similar to acpi_map(), use kmap() for PAGE_SIZE memremap() requests for
highmem, and fall back to ioremap_cache() otherwise.

The impact of this bug is low for now since the pmem driver is the only
user of memremap(), but this is important to fix before more conversions
to memremap arrive in 4.4.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Russell,

I question whether the kmap fallback is needed.  This is borrowed from
the current implementation of acpi_map(), and I added it since arm
ioremap warns if passed pfn_valid() addresses.

 include/linux/highmem.h |   12 ++++++++++++
 kernel/memremap.c       |   28 +++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6aefcd0031a6..c20cf24c76dd 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -41,6 +41,13 @@ void kmap_flush_unused(void);
 
 struct page *kmap_to_page(void *addr);
 
+static inline bool is_kmap_addr(const void *x)
+{
+	unsigned long addr = (unsigned long) x;
+
+	return addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP);
+}
+
 #else /* CONFIG_HIGHMEM */
 
 static inline unsigned int nr_free_highpages(void) { return 0; }
@@ -50,6 +57,11 @@ static inline struct page *kmap_to_page(void *addr)
 	return virt_to_page(addr);
 }
 
+static inline bool is_kmap_addr(const void *x)
+{
+	return false;
+}
+
 #define totalhigh_pages 0UL
 
 #ifndef ARCH_HAS_KMAP
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 72b0c66628b6..901d7ec3583a 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -10,6 +10,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
  */
+#include <linux/highmem.h>
 #include <linux/device.h>
 #include <linux/types.h>
 #include <linux/io.h>
@@ -24,6 +25,25 @@ __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
 }
 #endif
 
+static void *try_ram_remap(resource_size_t offset, size_t size)
+{
+	struct page *page = pfn_to_page(offset >> PAGE_SHIFT);
+	unsigned int pg_off = offset & ~PAGE_MASK;
+
+	/* In the simple case just return the existing linear address */
+	if (!PageHighMem(page))
+		return __va(offset);
+
+	/*
+	 * Try kmap first since some arch ioremap implementations fail when
+	 * being passed a ram address.
+	 */
+	if (pg_off + size <= PAGE_SIZE)
+		return kmap(page) + pg_off;
+
+	return NULL;
+}
+
 /**
  * memremap() - remap an iomem_resource as cacheable memory
  * @offset: iomem resource start address
@@ -66,8 +86,8 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 		 * the requested range is potentially in "System RAM"
 		 */
 		if (is_ram == REGION_INTERSECTS)
-			addr = __va(offset);
-		else
+			addr = try_ram_remap(offset, size);
+		if (!addr)
 			addr = ioremap_cache(offset, size);
 	}
 
@@ -94,7 +114,9 @@ EXPORT_SYMBOL(memremap);
 
 void memunmap(void *addr)
 {
-	if (is_vmalloc_addr(addr))
+	if (is_kmap_addr(addr))
+		kunmap(addr);
+	else if (is_vmalloc_addr(addr))
 		iounmap((void __iomem *) addr);
 }
 EXPORT_SYMBOL(memunmap);
