From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Feb 2010 11:01:11 +0000
Subject: [PATCH 2/4] ARM: Move the outer_cache definitions into a separate file
Message-ID: <20100223110111.11048.37651.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid #include collisions with subsequent patches in the series, this
patch moves the outer_cache definitions to a separate asm/outercache.h
file.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/cacheflush.h |   38 +----------------------
 arch/arm/include/asm/outercache.h |   61 +++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/include/asm/outercache.h

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index c77d2fa..08accb4 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -15,6 +15,7 @@
 #include <asm/glue.h>
 #include <asm/shmparam.h>
 #include <asm/cachetype.h>
+#include <asm/outercache.h>
 
 #define CACHE_COLOUR(vaddr)	((vaddr & (SHMLBA - 1)) >> PAGE_SHIFT)
 
@@ -232,12 +233,6 @@ struct cpu_cache_fns {
 	void (*dma_flush_range)(const void *, const void *);
 };
 
-struct outer_cache_fns {
-	void (*inv_range)(unsigned long, unsigned long);
-	void (*clean_range)(unsigned long, unsigned long);
-	void (*flush_range)(unsigned long, unsigned long);
-};
-
 /*
  * Select the calling method
  */
@@ -294,37 +289,6 @@ extern void dmac_flush_range(const void *, const void *);
 
 #endif
 
-#ifdef CONFIG_OUTER_CACHE
-
-extern struct outer_cache_fns outer_cache;
-
-static inline void outer_inv_range(unsigned long start, unsigned long end)
-{
-	if (outer_cache.inv_range)
-		outer_cache.inv_range(start, end);
-}
-static inline void outer_clean_range(unsigned long start, unsigned long end)
-{
-	if (outer_cache.clean_range)
-		outer_cache.clean_range(start, end);
-}
-static inline void outer_flush_range(unsigned long start, unsigned long end)
-{
-	if (outer_cache.flush_range)
-		outer_cache.flush_range(start, end);
-}
-
-#else
-
-static inline void outer_inv_range(unsigned long start, unsigned long end)
-{ }
-static inline void outer_clean_range(unsigned long start, unsigned long end)
-{ }
-static inline void outer_flush_range(unsigned long start, unsigned long end)
-{ }
-
-#endif
-
 /*
  * Copy user data from/to a page which is mapped into a different
  * processes address space.  Really, we want to allow our "user
diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
new file mode 100644
index 0000000..c8571cb
--- /dev/null
+++ b/arch/arm/include/asm/outercache.h
@@ -0,0 +1,61 @@
+/*
+ * arch/arm/include/asm/outercache.h
+ *
+ * Copyright (C) 2010 ARM Ltd.
+ * Written by Catalin Marinas <catalin.marinas@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __ASM_OUTERCACHE_H
+#define __ASM_OUTERCACHE_H
+
+struct outer_cache_fns {
+	void (*inv_range)(unsigned long, unsigned long);
+	void (*clean_range)(unsigned long, unsigned long);
+	void (*flush_range)(unsigned long, unsigned long);
+};
+
+#ifdef CONFIG_OUTER_CACHE
+
+extern struct outer_cache_fns outer_cache;
+
+static inline void outer_inv_range(unsigned long start, unsigned long end)
+{
+	if (outer_cache.inv_range)
+		outer_cache.inv_range(start, end);
+}
+static inline void outer_clean_range(unsigned long start, unsigned long end)
+{
+	if (outer_cache.clean_range)
+		outer_cache.clean_range(start, end);
+}
+static inline void outer_flush_range(unsigned long start, unsigned long end)
+{
+	if (outer_cache.flush_range)
+		outer_cache.flush_range(start, end);
+}
+
+#else
+
+static inline void outer_inv_range(unsigned long start, unsigned long end)
+{ }
+static inline void outer_clean_range(unsigned long start, unsigned long end)
+{ }
+static inline void outer_flush_range(unsigned long start, unsigned long end)
+{ }
+
+#endif
+
+#endif	/* __ASM_OUTERCACHE_H */
