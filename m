From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 22 Jul 2012 15:18:59 +0200
Subject: [PATCH 4/7] decompressor: import malloc/free implementation for linux
 3.4
In-Reply-To: <1342963142-30339-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120722130301.GI22657@game.jcrosoft.org>
 <1342963142-30339-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1342963142-30339-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is need for gunzip support

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 include/linux/decompress/mm.h |   68 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 include/linux/decompress/mm.h

diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
new file mode 100644
index 0000000..0c35411
--- /dev/null
+++ b/include/linux/decompress/mm.h
@@ -0,0 +1,68 @@
+/*
+ * linux/compr_mm.h
+ *
+ * Memory management for pre-boot and ramdisk uncompressors
+ *
+ * Authors: Alain Knaff <alain@knaff.lu>
+ *
+ */
+
+#ifndef DECOMPR_MM_H
+#define DECOMPR_MM_H
+
+#ifdef STATIC
+
+/* Code active when included from pre-boot environment: */
+
+/*
+ * Some architectures want to ensure there is no local data in their
+ * pre-boot environment, so that data can arbitrarily relocated (via
+ * GOT references).  This is achieved by defining STATIC_RW_DATA to
+ * be null.
+ */
+#ifndef STATIC_RW_DATA
+#define STATIC_RW_DATA static
+#endif
+
+/* A trivial malloc implementation, adapted from
+ *  malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
+ */
+STATIC_RW_DATA unsigned long malloc_ptr;
+STATIC_RW_DATA int malloc_count;
+
+static void *malloc(int size)
+{
+	void *p;
+
+	if (size < 0)
+		return NULL;
+	if (!malloc_ptr)
+		malloc_ptr = free_mem_ptr;
+
+	malloc_ptr = (malloc_ptr + 3) & ~3;     /* Align */
+
+	p = (void *)malloc_ptr;
+	malloc_ptr += size;
+
+	if (free_mem_end_ptr && malloc_ptr >= free_mem_end_ptr)
+		return NULL;
+
+	malloc_count++;
+	return p;
+}
+
+static void free(void *where)
+{
+	malloc_count--;
+	if (!malloc_count)
+		malloc_ptr = free_mem_ptr;
+}
+
+#define large_malloc(a) malloc(a)
+#define large_free(a) free(a)
+
+#define INIT
+
+#endif /* STATIC */
+
+#endif /* DECOMPR_MM_H */
-- 
1.7.10
