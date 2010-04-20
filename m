From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 20 Apr 2010 14:12:09 +0300
Subject: [PATCH] OMAP2/3: use different addresses for dump capture kernel
Message-ID: <mailman.320.1272362802.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dump capture kernels must be loaded into different address than the primary
kernel hence we load them into physical address 0x84000000.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/mach-omap2/Makefile.boot        |    7 ++++++-
 arch/arm/plat-omap/include/plat/memory.h |    8 ++++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
index 565aff7..b958007 100644
--- a/arch/arm/mach-omap2/Makefile.boot
+++ b/arch/arm/mach-omap2/Makefile.boot
@@ -1,3 +1,8 @@
-  zreladdr-y		:= 0x80008000
+ifeq ($(CONFIG_CRASH_DUMP),y)
+zreladdr-y		:= 0x84008000
+params_phys-y		:= 0x84000100
+else
+zreladdr-y		:= 0x80008000
 params_phys-y		:= 0x80000100
+endif
 initrd_phys-y		:= 0x80800000
diff --git a/arch/arm/plat-omap/include/plat/memory.h b/arch/arm/plat-omap/include/plat/memory.h
index d5306be..561ab32 100644
--- a/arch/arm/plat-omap/include/plat/memory.h
+++ b/arch/arm/plat-omap/include/plat/memory.h
@@ -39,7 +39,15 @@
 #if defined(CONFIG_ARCH_OMAP1)
 #define PHYS_OFFSET		UL(0x10000000)
 #else
+/*
+ * We want crashdump kernels to be in different physical address than
+ * the primary kernel.
+ */
+#ifdef CONFIG_CRASH_DUMP
+#define PHYS_OFFSET		UL(0x84000000)
+#else
 #define PHYS_OFFSET		UL(0x80000000)
+#endif /* CONFIG_CRASH_DUMP */
 #endif
 
 /*
-- 
1.5.6.5
