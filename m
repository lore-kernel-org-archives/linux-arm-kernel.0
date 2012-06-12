From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 12 Jun 2012 16:27:20 +0900
Subject: [PATCH v2] ARM: EXYNOS: Add smc call to support trustzone feature
Message-ID: <20120612072720.GA3211@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Linux runs in non-secure mode on some boards, so we need secure monitor calls

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 9b58024..d3ec71c 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -30,6 +30,11 @@ obj-$(CONFIG_EXYNOS4_MCT)	+= mct.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 
+obj-$(CONFIG_ARM_TRUSTZONE)	+= exynos-smc.o
+
+plus_sec := $(call as-instr,.arch_extension sec,+sec)
+AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
+
 # machine support
 
 obj-$(CONFIG_MACH_SMDKC210)		+= mach-smdkv310.o
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index aed2eeb..dc69705 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -21,6 +21,8 @@ void exynos4_restart(char mode, const char *cmd);
 void exynos5_restart(char mode, const char *cmd);
 void exynos_init_late(void);
 
+extern void exynos_smc(u32 cmd, u32 arg1, u32 arg2, u32 arg3);
+
 #ifdef CONFIG_PM_GENERIC_DOMAINS
 int exynos_pm_late_initcall(void);
 #else
diff --git a/arch/arm/mach-exynos/exynos-smc.S b/arch/arm/mach-exynos/exynos-smc.S
new file mode 100644
index 0000000..2e27aa3
--- /dev/null
+++ b/arch/arm/mach-exynos/exynos-smc.S
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2012 Samsung Electronics.
+ *
+ * Copied from omap-smc.S Copyright (C) 2010 Texas Instruments, Inc.
+ *
+ * This program is free software,you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+
+/*
+ * Function signature: void exynos_smc(u32 cmd, u32 arg1, u32 arg2, u32 arg3)
+ */
+
+ENTRY(exynos_smc)
+	stmfd	sp!, {r4-r11, lr}
+	dsb
+	smc	#0
+	ldmfd	sp!, {r4-r11, pc}
+ENDPROC(exynos_smc)
