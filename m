From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Jan 2010 18:01:23 -0800
Subject: [PATCH 1/9] omap: Move multi-omap ifdeffery into it's own header file
In-Reply-To: <20100130020036.10590.78028.stgit@baageli.muru.com>
References: <20100130020036.10590.78028.stgit@baageli.muru.com>
Message-ID: <20100130020123.10590.29024.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This way we can include it easily as needed also for .S files.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/cpu.h   |   70 -----------------------
 arch/arm/plat-omap/include/plat/multi.h |   94 +++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 69 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/multi.h

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 995466d..b80151c 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -31,6 +31,7 @@
 #define __ASM_ARCH_OMAP_CPU_H
 
 #include <linux/bitops.h>
+#include <plat/multi.h>
 
 /*
  * Omap device type i.e. EMU/HS/TST/GP/BAD
@@ -76,75 +77,6 @@ unsigned int omap_rev(void);
 #define GET_OMAP_REVISION()	((omap_rev() >> 8) & 0xff)
 
 /*
- * Test if multicore OMAP support is needed
- */
-#undef MULTI_OMAP1
-#undef MULTI_OMAP2
-#undef OMAP_NAME
-
-#ifdef CONFIG_ARCH_OMAP730
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP1
-#  define MULTI_OMAP1
-# else
-#  define OMAP_NAME omap730
-# endif
-#endif
-#ifdef CONFIG_ARCH_OMAP850
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP1
-#  define MULTI_OMAP1
-# else
-#  define OMAP_NAME omap850
-# endif
-#endif
-#ifdef CONFIG_ARCH_OMAP15XX
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP1
-#  define MULTI_OMAP1
-# else
-#  define OMAP_NAME omap1510
-# endif
-#endif
-#ifdef CONFIG_ARCH_OMAP16XX
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP1
-#  define MULTI_OMAP1
-# else
-#  define OMAP_NAME omap16xx
-# endif
-#endif
-#if (defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
-# if (defined(OMAP_NAME) || defined(MULTI_OMAP1))
-#  error "OMAP1 and OMAP2 can't be selected at the same time"
-# endif
-#endif
-#ifdef CONFIG_ARCH_OMAP2420
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME omap2420
-# endif
-#endif
-#ifdef CONFIG_ARCH_OMAP2430
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME omap2430
-# endif
-#endif
-#ifdef CONFIG_ARCH_OMAP3430
-# ifdef OMAP_NAME
-#  undef  MULTI_OMAP2
-#  define MULTI_OMAP2
-# else
-#  define OMAP_NAME omap3430
-# endif
-#endif
-
-/*
  * Macros to group OMAP into cpu classes.
  * These can be used in most places.
  * cpu_is_omap7xx():	True for OMAP730, OMAP850
diff --git a/arch/arm/plat-omap/include/plat/multi.h b/arch/arm/plat-omap/include/plat/multi.h
new file mode 100644
index 0000000..f235d32
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/multi.h
@@ -0,0 +1,94 @@
+/*
+ * Support for compiling in multiple OMAP processors
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#ifndef __PLAT_OMAP_MULTI_H
+#define __PLAT_OMAP_MULTI_H
+
+/*
+ * Test if multicore OMAP support is needed
+ */
+#undef MULTI_OMAP1
+#undef MULTI_OMAP2
+#undef OMAP_NAME
+
+#ifdef CONFIG_ARCH_OMAP730
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP1
+#  define MULTI_OMAP1
+# else
+#  define OMAP_NAME omap730
+# endif
+#endif
+#ifdef CONFIG_ARCH_OMAP850
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP1
+#  define MULTI_OMAP1
+# else
+#  define OMAP_NAME omap850
+# endif
+#endif
+#ifdef CONFIG_ARCH_OMAP15XX
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP1
+#  define MULTI_OMAP1
+# else
+#  define OMAP_NAME omap1510
+# endif
+#endif
+#ifdef CONFIG_ARCH_OMAP16XX
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP1
+#  define MULTI_OMAP1
+# else
+#  define OMAP_NAME omap16xx
+# endif
+#endif
+#if (defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
+# if (defined(OMAP_NAME) || defined(MULTI_OMAP1))
+#  error "OMAP1 and OMAP2 can't be selected at the same time"
+# endif
+#endif
+#ifdef CONFIG_ARCH_OMAP2420
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME omap2420
+# endif
+#endif
+#ifdef CONFIG_ARCH_OMAP2430
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME omap2430
+# endif
+#endif
+#ifdef CONFIG_ARCH_OMAP3430
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME omap3430
+# endif
+#endif
+
+#endif	/* __PLAT_OMAP_MULTI_H */
