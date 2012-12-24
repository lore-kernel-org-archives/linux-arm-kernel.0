From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 23 Dec 2012 18:25:01 -0700
Subject: [PATCH 3/3] ARM: OMAP: SRAM: resolve sparse warnings
In-Reply-To: <20121224012304.13698.43551.stgit@dusk.lan>
References: <20121224012304.13698.43551.stgit@dusk.lan>
Message-ID: <20121224012500.13698.73653.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit bb77209432873214a796a70a4539e4ebdf3feb54 ("ARM: OMAP: Move
omap2+ specific parts of sram.c to mach-omap2") adds some new sparse
warnings:

arch/arm/plat-omap/sram.c:43:6: warning: symbol 'omap_sram_push_address' was not declared. Should it be static?
arch/arm/plat-omap/sram.c:65:6: warning: symbol 'omap_sram_reset' was not declared. Should it be static?
arch/arm/plat-omap/sram.c:73:13: warning: symbol 'omap_map_sram' was not declared. Should it be static?

Fix by creating a temporary header file containing prototypes for
these SRAM functions - needed until the SRAM code is moved to
drivers/.  arch/arm/plat-omap/include/plat/sram.h can't be added due
to ARM CONFIG_ARCH_MULTIPLATFORM restrictions on the use of the "plat/"
include path shortcut.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/sram.c |    2 ++
 arch/arm/plat-omap/sram.h |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 arch/arm/plat-omap/sram.h

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 743fc28..d15e7b9 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -26,6 +26,8 @@
 
 #include <asm/mach/map.h>
 
+#include "sram.h"
+
 #define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
 
 static void __iomem *omap_sram_base;
diff --git a/arch/arm/plat-omap/sram.h b/arch/arm/plat-omap/sram.h
new file mode 100644
index 0000000..7e47de4
--- /dev/null
+++ b/arch/arm/plat-omap/sram.h
@@ -0,0 +1,35 @@
+/*
+ * OMAP common SRAM prototypes
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ *
+ * XXX This file is needed until the SRAM handling is implemented via
+ * some device driver.
+ */
+
+#ifndef __ARCH_ARM_PLAT_OMAP_SRAM_H
+#define __ARCH_ARM_PLAT_OMAP_SRAM_H
+
+#include <linux/kernel.h>
+
+extern void *omap_sram_push_address(unsigned long size);
+extern void omap_sram_reset(void);
+extern void __init omap_map_sram(unsigned long start, unsigned long size,
+				 unsigned long skip, int cached);
+
+#endif
