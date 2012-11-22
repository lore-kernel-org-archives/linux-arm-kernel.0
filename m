From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 22 Nov 2012 16:51:15 +0100
Subject: [PATCH v4 2/5] ARM: EXYNOS: Add support for secure monitor calls
In-Reply-To: <1353599478-24617-1-git-send-email-t.figa@samsung.com>
References: <1353599478-24617-1-git-send-email-t.figa@samsung.com>
Message-ID: <1353599478-24617-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards use secure monitor calls to communicate with secure
firmware.

This patch adds exynos_smc function which uses smc assembly instruction
to do secure monitor calls.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/Makefile     |  5 +++++
 arch/arm/mach-exynos/exynos-smc.S | 22 ++++++++++++++++++++++
 arch/arm/mach-exynos/smc.h        | 31 +++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100644 arch/arm/mach-exynos/exynos-smc.S
 create mode 100644 arch/arm/mach-exynos/smc.h

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index c12ed6a..a031012 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -30,6 +30,11 @@ obj-$(CONFIG_EXYNOS4_MCT)	+= mct.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 
+obj-$(CONFIG_ARCH_EXYNOS)	+= exynos-smc.o
+
+plus_sec := $(call as-instr,.arch_extension sec,+sec)
+AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
+
 # machine support
 
 obj-$(CONFIG_MACH_SMDKC210)		+= mach-smdkv310.o
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
diff --git a/arch/arm/mach-exynos/smc.h b/arch/arm/mach-exynos/smc.h
new file mode 100644
index 0000000..e972390
--- /dev/null
+++ b/arch/arm/mach-exynos/smc.h
@@ -0,0 +1,31 @@
+/*
+ *  Copyright (c) 2012 Samsung Electronics.
+ *
+ * EXYNOS - SMC Call
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_EXYNOS_SMC_H
+#define __ASM_ARCH_EXYNOS_SMC_H
+
+#define SMC_CMD_INIT            (-1)
+#define SMC_CMD_INFO            (-2)
+/* For Power Management */
+#define SMC_CMD_SLEEP           (-3)
+#define SMC_CMD_CPU1BOOT        (-4)
+#define SMC_CMD_CPU0AFTR        (-5)
+/* For CP15 Access */
+#define SMC_CMD_C15RESUME       (-11)
+/* For L2 Cache Access */
+#define SMC_CMD_L2X0CTRL        (-21)
+#define SMC_CMD_L2X0SETUP1      (-22)
+#define SMC_CMD_L2X0SETUP2      (-23)
+#define SMC_CMD_L2X0INVALL      (-24)
+#define SMC_CMD_L2X0DEBUG       (-25)
+
+extern void exynos_smc(u32 cmd, u32 arg1, u32 arg2, u32 arg3);
+
+#endif
-- 
1.8.0
