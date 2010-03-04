From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Realview/Versatile: separate out common sched_clock()
References: <git-1267729916-5a852a86ebb11b488b619f8386b6df6332c730de@rmk-PC>
Message-ID: <git-1267729916-2297f112a4e3ab4a5241c68977bf2e1b96438c54@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Provide a common sched_clock() implementation for Versatile and
Realview.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-realview/core.c         |   16 ----------
 arch/arm/mach-versatile/core.c        |   22 -------------
 arch/arm/plat-versatile/Makefile      |    2 +
 arch/arm/plat-versatile/sched-clock.c |   53 +++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm/plat-versatile/sched-clock.c

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 80b8142..f97f001 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -53,8 +53,6 @@
 
 #include "core.h"
 
-#define REALVIEW_REFCOUNTER	(__io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_24MHz_OFFSET)
-
 /* used by entry-macro.S and platsmp.c */
 void __iomem *gic_cpu_base_addr;
 
@@ -77,20 +75,6 @@ void __init realview_adjust_zones(int node, unsigned long *size,
 }
 #endif
 
-/*
- * This is the RealView sched_clock implementation.  This has
- * a resolution of 41.7ns, and a maximum value of about 179s.
- */
-unsigned long long sched_clock(void)
-{
-	unsigned long long v;
-
-	v = (unsigned long long)readl(REALVIEW_REFCOUNTER) * 125;
-	do_div(v, 3);
-
-	return v;
-}
-
 
 #define REALVIEW_FLASHCTRL    (__io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_FLASH_OFFSET)
 
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index b68ddd3..490fc75 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -28,7 +28,6 @@
 #include <linux/amba/clcd.h>
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
-#include <linux/cnt32_to_63.h>
 #include <linux/io.h>
 
 #include <asm/clkdev.h>
@@ -227,27 +226,6 @@ void __init versatile_map_io(void)
 	iotable_init(versatile_io_desc, ARRAY_SIZE(versatile_io_desc));
 }
 
-#define VERSATILE_REFCOUNTER	(__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_24MHz_OFFSET)
-
-/*
- * This is the Versatile sched_clock implementation.  This has
- * a resolution of 41.7ns, and a maximum value of about 35583 days.
- *
- * The return value is guaranteed to be monotonic in that range as
- * long as there is always less than 89 seconds between successive
- * calls to this function.
- */
-unsigned long long sched_clock(void)
-{
-	unsigned long long v = cnt32_to_63(readl(VERSATILE_REFCOUNTER));
-
-	/* the <<1 gets rid of the cnt_32_to_63 top bit saving on a bic insn */
-	v *= 125<<1;
-	do_div(v, 3<<1);
-
-	return v;
-}
-
 
 #define VERSATILE_FLASHCTRL    (__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_FLASH_OFFSET)
 
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 334d2f1..9b1a668 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,2 +1,4 @@
 obj-y	:= clock.o
 obj-$(CONFIG_ARM_TIMER_SP804) += timer-sp.o
+obj-$(CONFIG_ARCH_REALVIEW) += sched-clock.o
+obj-$(CONFIG_ARCH_VERSATILE) += sched-clock.o
diff --git a/arch/arm/plat-versatile/sched-clock.c b/arch/arm/plat-versatile/sched-clock.c
new file mode 100644
index 0000000..9768cf7
--- /dev/null
+++ b/arch/arm/plat-versatile/sched-clock.c
@@ -0,0 +1,53 @@
+/*
+ *  linux/arch/arm/plat-versatile/sched-clock.c
+ *
+ *  Copyright (C) 1999 - 2003 ARM Limited
+ *  Copyright (C) 2000 Deep Blue Solutions Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/cnt32_to_63.h>
+#include <linux/io.h>
+#include <asm/div64.h>
+
+#include <mach/hardware.h>
+#include <mach/platform.h>
+
+#ifdef VERSATILE_SYS_BASE
+#define REFCOUNTER	(__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_24MHz_OFFSET)
+#endif
+
+#ifdef REALVIEW_SYS_BASE
+#define REFCOUNTER	(__io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_24MHz_OFFSET)
+#endif
+
+/*
+ * This is the Realview and Versatile sched_clock implementation.  This
+ * has a resolution of 41.7ns, and a maximum value of about 35583 days.
+ *
+ * The return value is guaranteed to be monotonic in that range as
+ * long as there is always less than 89 seconds between successive
+ * calls to this function.
+ */
+unsigned long long sched_clock(void)
+{
+	unsigned long long v = cnt32_to_63(readl(REFCOUNTER));
+
+	/* the <<1 gets rid of the cnt_32_to_63 top bit saving on a bic insn */
+	v *= 125<<1;
+	do_div(v, 3<<1);
+
+	return v;
+}
