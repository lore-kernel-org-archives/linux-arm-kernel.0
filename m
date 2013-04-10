From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue,  9 Apr 2013 17:34:57 -0700
Subject: [RFC PATCHv2 2/2] mm: highmem: Add definitions for
 kmap_atomic_flush_unused
In-Reply-To: <1365554097-21305-1-git-send-email-lauraa@codeaurora.org>
References: <1365554097-21305-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1365554097-21305-2-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kmap_flush_unused does not flush kmap_atomic mappings which
are handled separately. Architectures may have use cases to require
these to be flushed. Add an option to let archtectures define
kmap_atomic flushing to get rid of extra mappings.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 include/linux/highmem.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 7fb31da..e666549 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -39,6 +39,12 @@ extern unsigned long totalhigh_pages;
 
 void kmap_flush_unused(void);
 
+#ifdef CONFIG_ARCH_WANT_KMAP_ATOMIC_FLUSH
+void kmap_atomic_flush_unused(void);
+#else
+static inline void kmap_atomic_flush_unused(void) { }
+#endif
+
 struct page *kmap_to_page(void *addr);
 
 #else /* CONFIG_HIGHMEM */
@@ -79,6 +85,7 @@ static inline void __kunmap_atomic(void *addr)
 #define kmap_atomic_to_page(ptr)	virt_to_page(ptr)
 
 #define kmap_flush_unused()	do {} while(0)
+#define kmap_atomic_flush_unused()	do {} while(0)
 #endif
 
 #endif /* CONFIG_HIGHMEM */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
