From: labbott@redhat.com (Laura Abbott)
Date: Mon,  8 Aug 2016 10:49:33 -0700
Subject: [RFCv2][PATCH 1/5] Documentation: Introduce kernel_force_cache_* APIs
In-Reply-To: <1470678577-14010-1-git-send-email-labbott@redhat.com>
References: <1470678577-14010-1-git-send-email-labbott@redhat.com>
Message-ID: <1470678577-14010-2-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Some frameworks (e.g. Ion) may need to do explicit cache management
to meet performance/correctness requirements. Rather than piggy-back
on another API and hope the semantics don't change, introduce a
set of APIs to force a page to be cleaned/invalidated in the cache.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 Documentation/cachetlb.txt | 18 +++++++++++++++++-
 include/linux/cacheflush.h | 11 +++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/cacheflush.h

diff --git a/Documentation/cachetlb.txt b/Documentation/cachetlb.txt
index 3f9f808..18eec7c 100644
--- a/Documentation/cachetlb.txt
+++ b/Documentation/cachetlb.txt
@@ -378,7 +378,7 @@ maps this page at its virtual address.
 	flush_dcache_page and update_mmu_cache. In the future, the hope
 	is to remove this interface completely.
 
-The final category of APIs is for I/O to deliberately aliased address
+Another set of APIs is for I/O to deliberately aliased address
 ranges inside the kernel.  Such aliases are set up by use of the
 vmap/vmalloc API.  Since kernel I/O goes via physical pages, the I/O
 subsystem assumes that the user mapping and kernel offset mapping are
@@ -401,3 +401,19 @@ I/O and invalidating it after the I/O returns.
        speculatively reading data while the I/O was occurring to the
        physical pages.  This is only necessary for data reads into the
        vmap area.
+
+Nearly all drivers can handle cache management using the existing DMA model.
+There may be limited circumstances when a driver or framework needs to
+explicitly manage the cache; trying to force cache management into the DMA
+framework may lead to performance loss or unnecessary work. These APIs may
+be used to provide explicit coherency for memory that does not fall into
+any of the above categories. Implementers of this API must assume the
+address can be aliased. Any cache operations shall not be delayed and must
+be completed by the time the call returns.
+
+   void kernel_force_cache_clean(struct page *page, size_t size);
+	Ensures that any data in the cache by the page is written back
+        and visible across all aliases.
+
+   void kernel_force_cache_invalidate(struct page *page, size_t size);
+	Invalidates the cache for the given page.
diff --git a/include/linux/cacheflush.h b/include/linux/cacheflush.h
new file mode 100644
index 0000000..4388846
--- /dev/null
+++ b/include/linux/cacheflush.h
@@ -0,0 +1,11 @@
+#ifndef CACHEFLUSH_H
+#define CACHEFLUSH_H
+
+#include <asm/cacheflush.h>
+
+#ifndef ARCH_HAS_FORCE_CACHE
+static inline void kernel_force_cache_clean(struct page *page, size_t size) { }
+static inline void kernel_force_cache_invalidate(struct page *page, size_t size) { }
+#endif
+
+#endif
-- 
2.7.4
