From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 14 May 2012 15:19:27 +0100
Subject: [PATCH] clkdev: Add default clkdev.h
Message-ID: <1337005167-22628-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ease the deployment of clkdev by providing a default asm/clkdev.h which
will be used if the arch does not have an include/asm/clkdev.h.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/asm-generic/Kbuild.asm |    4 ++++
 include/asm-generic/clkdev.h   |   26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 include/asm-generic/clkdev.h

diff --git a/include/asm-generic/Kbuild.asm b/include/asm-generic/Kbuild.asm
index c5d2e5d..da121e0 100644
--- a/include/asm-generic/Kbuild.asm
+++ b/include/asm-generic/Kbuild.asm
@@ -13,6 +13,10 @@ ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/a.out.h \
 header-y += a.out.h
 endif
 
+ifeq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/clkdev.h),)
+generic-y += clkdev.h
+endif
+
 header-y += auxvec.h
 header-y += bitsperlong.h
 header-y += byteorder.h
diff --git a/include/asm-generic/clkdev.h b/include/asm-generic/clkdev.h
new file mode 100644
index 0000000..c362a9d
--- /dev/null
+++ b/include/asm-generic/clkdev.h
@@ -0,0 +1,26 @@
+/*
+ *  include/asm-generic/clkdev.h
+ *
+ * Based on the ARM clkdev.h:
+ *  Copyright (C) 2008 Russell King.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Helper for the clk API to assist looking up a struct clk.
+ */
+#ifndef __ASM_CLKDEV_H
+#define __ASM_CLKDEV_H
+
+#include <linux/slab.h>
+
+#define __clk_get(clk)	({ 1; })
+#define __clk_put(clk)	do { } while (0)
+
+static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
+{
+	return kzalloc(size, GFP_KERNEL);
+}
+
+#endif
-- 
1.7.10
