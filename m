From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:16:30 +0000
Subject: [PATCH 35/44] ARM: outer cache: add WARN_ON() to outer_disable()
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLEE-0002eD-3f@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add WARN_ON() conditions to outer_disable() to ensure that its
requirements aren't violated.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/outercache.h |  7 ++-----
 arch/arm/mm/Makefile              |  1 +
 arch/arm/mm/l2c-common.c          | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mm/l2c-common.c

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index bd80540fe8b9..1ee2cf23fae1 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -21,6 +21,7 @@
 #ifndef __ASM_OUTERCACHE_H
 #define __ASM_OUTERCACHE_H
 
+#include <linux/bug.h>
 #include <linux/types.h>
 
 struct outer_cache_fns {
@@ -96,11 +97,7 @@ static inline void outer_flush_all(void)
  * cache is pushed out to lower levels of system memory.  The note and
  * conditions above concerning outer_flush_all() applies here.
  */
-static inline void outer_disable(void)
-{
-	if (outer_cache.disable)
-		outer_cache.disable();
-}
+extern void outer_disable(void);
 
 /**
  * outer_resume: restore the cache configuration and re-enable outer cache
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 7f39ce2f841f..de5a6a27081b 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_CPU_V7M)		+= proc-v7m.o
 AFLAGS_proc-v6.o	:=-Wa,-march=armv6
 AFLAGS_proc-v7.o	:=-Wa,-march=armv7-a
 
+obj-$(CONFIG_OUTER_CACHE)	+= l2c-common.o
 obj-$(CONFIG_CACHE_FEROCEON_L2)	+= cache-feroceon-l2.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_CACHE_XSC3L2)	+= cache-xsc3l2.o
diff --git a/arch/arm/mm/l2c-common.c b/arch/arm/mm/l2c-common.c
new file mode 100644
index 000000000000..10a3cf28c362
--- /dev/null
+++ b/arch/arm/mm/l2c-common.c
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2010 ARM Ltd.
+ * Written by Catalin Marinas <catalin.marinas@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/bug.h>
+#include <linux/smp.h>
+#include <asm/outercache.h>
+
+void outer_disable(void)
+{
+	WARN_ON(!irqs_disabled());
+	WARN_ON(num_online_cpus() > 1);
+
+	if (outer_cache.disable)
+		outer_cache.disable();
+}
-- 
1.8.3.1
