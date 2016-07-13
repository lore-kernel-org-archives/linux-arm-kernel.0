From: keescook@chromium.org (Kees Cook)
Date: Wed, 13 Jul 2016 14:56:03 -0700
Subject: [PATCH v2 10/11] mm: SLAB hardened usercopy support
In-Reply-To: <1468446964-22213-1-git-send-email-keescook@chromium.org>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
Message-ID: <1468446964-22213-11-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Under CONFIG_HARDENED_USERCOPY, this adds object size checking to the
SLAB allocator to catch any copies that may span objects.

Based on code from PaX and grsecurity.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 init/Kconfig |  1 +
 mm/slab.c    | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index f755a602d4a1..798c2020ee7c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1757,6 +1757,7 @@ choice
 
 config SLAB
 	bool "SLAB"
+	select HAVE_HARDENED_USERCOPY_ALLOCATOR
 	help
 	  The regular slab allocator that is established and known to work
 	  well in all environments. It organizes cache hot objects in
diff --git a/mm/slab.c b/mm/slab.c
index cc8bbc1e6bc9..5e2d5f349aca 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4477,6 +4477,36 @@ static int __init slab_proc_init(void)
 module_init(slab_proc_init);
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
+	struct kmem_cache *cachep;
+	unsigned int objnr;
+	unsigned long offset;
+
+	/* Find and validate object. */
+	cachep = page->slab_cache;
+	objnr = obj_to_index(cachep, page, (void *)ptr);
+	BUG_ON(objnr >= cachep->num);
+
+	/* Find offset within object. */
+	offset = ptr - index_to_obj(cachep, page, objnr) - obj_offset(cachep);
+
+	/* Allow address range falling entirely within object size. */
+	if (offset <= cachep->object_size && n <= cachep->object_size - offset)
+		return NULL;
+
+	return cachep->name;
+}
+#endif /* CONFIG_HARDENED_USERCOPY */
+
 /**
  * ksize - get the actual amount of memory allocated for a given object
  * @objp: Pointer to the object
-- 
2.7.4
