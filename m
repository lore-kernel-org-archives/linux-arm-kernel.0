From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 31 Mar 2016 14:29:41 +0200
Subject: [PATCH 1/4] mm: add is_highmem_addr() helper
In-Reply-To: <1459427384-21374-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459427384-21374-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459427384-21374-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an helper to check if a virtual address is in the highmem region.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/highmem.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index bb3f329..13dff37 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -41,6 +41,14 @@ void kmap_flush_unused(void);
 
 struct page *kmap_to_page(void *addr);
 
+static inline bool is_highmem_addr(const void *x)
+{
+	unsigned long vaddr = (unsigned long)x;
+
+	return vaddr >=  PKMAP_BASE &&
+	       vaddr < ((PKMAP_BASE + LAST_PKMAP) * PAGE_SIZE);
+}
+
 #else /* CONFIG_HIGHMEM */
 
 static inline unsigned int nr_free_highpages(void) { return 0; }
@@ -50,6 +58,11 @@ static inline struct page *kmap_to_page(void *addr)
 	return virt_to_page(addr);
 }
 
+static inline bool is_highmem_addr(const void *x)
+{
+	return false;
+}
+
 #define totalhigh_pages 0UL
 
 #ifndef ARCH_HAS_KMAP
-- 
2.5.0
