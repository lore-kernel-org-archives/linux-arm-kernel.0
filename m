From: keescook@chromium.org (Kees Cook)
Date: Wed,  6 Jul 2016 15:25:28 -0700
Subject: [PATCH 9/9] mm: SLUB hardened usercopy support
In-Reply-To: <1467843928-29351-1-git-send-email-keescook@chromium.org>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
Message-ID: <1467843928-29351-10-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Under CONFIG_HARDENED_USERCOPY, this adds object size checking to the
SLUB allocator to catch any copies that may span objects.

Based on code from PaX and grsecurity.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 init/Kconfig |  1 +
 mm/slub.c    | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 798c2020ee7c..1c4711819dfd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1765,6 +1765,7 @@ config SLAB
 
 config SLUB
 	bool "SLUB (Unqueued Allocator)"
+	select HAVE_HARDENED_USERCOPY_ALLOCATOR
 	help
 	   SLUB is a slab allocator that minimizes cache line usage
 	   instead of managing queues of cached objects (SLAB approach).
diff --git a/mm/slub.c b/mm/slub.c
index 825ff4505336..0c8ace04f075 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3614,6 +3614,33 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 EXPORT_SYMBOL(__kmalloc_node);
 #endif
 
+#ifdef CONFIG_HARDENED_USERCOPY
+/*
+ * Rejects objects that are incorrectly sized.
+ *
+ * Returns NULL if check passes, otherwise const char * to name of cache
+ * to indicate an error.
+ */
+const char *__check_heap_object(const void *ptr, unsigned long n,
+				struct page *page)
+{
+	struct kmem_cache *s;
+	unsigned long offset;
+
+	/* Find object. */
+	s = page->slab_cache;
+
+	/* Find offset within object. */
+	offset = (ptr - page_address(page)) % s->size;
+
+	/* Allow address range falling entirely within object size. */
+	if (offset <= s->object_size && n <= s->object_size - offset)
+		return NULL;
+
+	return s->name;
+}
+#endif /* CONFIG_HARDENED_USERCOPY */
+
 static size_t __ksize(const void *object)
 {
 	struct page *page;
-- 
2.7.4
