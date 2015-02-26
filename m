From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 26 Feb 2015 15:59:33 -0600
Subject: [PATCH 1/4] ARM: qcom: Merge scm and scm boot code together
Message-ID: <1424987976-14531-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Put all scm related code into a single file as a first step in cleaning
up the scm interface to just expose functional behavior insteam of making
direct scm calls.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 arch/arm/mach-qcom/Makefile   |  2 +-
 arch/arm/mach-qcom/platsmp.c  |  2 +-
 arch/arm/mach-qcom/scm-boot.c | 39 ---------------------------------------
 arch/arm/mach-qcom/scm-boot.h | 26 --------------------------
 arch/arm/mach-qcom/scm.c      | 17 +++++++++++++++++
 arch/arm/mach-qcom/scm.h      | 11 +++++++++++
 6 files changed, 30 insertions(+), 67 deletions(-)
 delete mode 100644 arch/arm/mach-qcom/scm-boot.c
 delete mode 100644 arch/arm/mach-qcom/scm-boot.h

diff --git a/arch/arm/mach-qcom/Makefile b/arch/arm/mach-qcom/Makefile
index 8f756ae..10b6841 100644
--- a/arch/arm/mach-qcom/Makefile
+++ b/arch/arm/mach-qcom/Makefile
@@ -1,5 +1,5 @@
 obj-y			:= board.o
 obj-$(CONFIG_SMP)	+= platsmp.o
-obj-$(CONFIG_QCOM_SCM)	+= scm.o scm-boot.o
+obj-$(CONFIG_QCOM_SCM)	+= scm.o
 
 CFLAGS_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
index 09cffed..8f4962e 100644
--- a/arch/arm/mach-qcom/platsmp.c
+++ b/arch/arm/mach-qcom/platsmp.c
@@ -20,7 +20,7 @@
 
 #include <asm/smp_plat.h>
 
-#include "scm-boot.h"
+#include "scm.h"
 
 #define VDD_SC1_ARRAY_CLAMP_GFS_CTL	0x35a0
 #define SCSS_CPU1CORE_RESET		0x2d80
diff --git a/arch/arm/mach-qcom/scm-boot.c b/arch/arm/mach-qcom/scm-boot.c
deleted file mode 100644
index e8ff7be..0000000
--- a/arch/arm/mach-qcom/scm-boot.c
+++ /dev/null
@@ -1,39 +0,0 @@
-/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-
-#include <linux/module.h>
-#include <linux/slab.h>
-
-#include "scm.h"
-#include "scm-boot.h"
-
-/*
- * Set the cold/warm boot address for one of the CPU cores.
- */
-int scm_set_boot_addr(u32 addr, int flags)
-{
-	struct {
-		__le32 flags;
-		__le32 addr;
-	} cmd;
-
-	cmd.addr = cpu_to_le32(addr);
-	cmd.flags = cpu_to_le32(flags);
-	return scm_call(SCM_SVC_BOOT, SCM_BOOT_ADDR,
-			&cmd, sizeof(cmd), NULL, 0);
-}
-EXPORT_SYMBOL(scm_set_boot_addr);
diff --git a/arch/arm/mach-qcom/scm-boot.h b/arch/arm/mach-qcom/scm-boot.h
deleted file mode 100644
index 3e210fb..0000000
--- a/arch/arm/mach-qcom/scm-boot.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef __MACH_SCM_BOOT_H
-#define __MACH_SCM_BOOT_H
-
-#define SCM_BOOT_ADDR			0x1
-#define SCM_FLAG_COLDBOOT_CPU1		0x01
-#define SCM_FLAG_COLDBOOT_CPU2		0x08
-#define SCM_FLAG_COLDBOOT_CPU3		0x20
-#define SCM_FLAG_WARMBOOT_CPU0		0x04
-#define SCM_FLAG_WARMBOOT_CPU1		0x02
-#define SCM_FLAG_WARMBOOT_CPU2		0x10
-#define SCM_FLAG_WARMBOOT_CPU3		0x40
-
-int scm_set_boot_addr(u32 addr, int flags);
-
-#endif
diff --git a/arch/arm/mach-qcom/scm.c b/arch/arm/mach-qcom/scm.c
index 1d9cf18..e20db10 100644
--- a/arch/arm/mach-qcom/scm.c
+++ b/arch/arm/mach-qcom/scm.c
@@ -324,3 +324,20 @@ u32 scm_get_version(void)
 	return version;
 }
 EXPORT_SYMBOL(scm_get_version);
+
+/*
+ * Set the cold/warm boot address for one of the CPU cores.
+ */
+int scm_set_boot_addr(u32 addr, int flags)
+{
+	struct {
+		__le32 flags;
+		__le32 addr;
+	} cmd;
+
+	cmd.addr = cpu_to_le32(addr);
+	cmd.flags = cpu_to_le32(flags);
+	return scm_call(SCM_SVC_BOOT, SCM_BOOT_ADDR,
+			&cmd, sizeof(cmd), NULL, 0);
+}
+EXPORT_SYMBOL(scm_set_boot_addr);
diff --git a/arch/arm/mach-qcom/scm.h b/arch/arm/mach-qcom/scm.h
index 00b31ea..cfe6935 100644
--- a/arch/arm/mach-qcom/scm.h
+++ b/arch/arm/mach-qcom/scm.h
@@ -18,6 +18,17 @@
 extern int scm_call(u32 svc_id, u32 cmd_id, const void *cmd_buf, size_t cmd_len,
 		void *resp_buf, size_t resp_len);
 
+#define SCM_BOOT_ADDR			0x1
+#define SCM_FLAG_COLDBOOT_CPU1		0x01
+#define SCM_FLAG_COLDBOOT_CPU2		0x08
+#define SCM_FLAG_COLDBOOT_CPU3		0x20
+#define SCM_FLAG_WARMBOOT_CPU0		0x04
+#define SCM_FLAG_WARMBOOT_CPU1		0x02
+#define SCM_FLAG_WARMBOOT_CPU2		0x10
+#define SCM_FLAG_WARMBOOT_CPU3		0x40
+
+extern int scm_set_boot_addr(u32 addr, int flags);
+
 #define SCM_VERSION(major, minor) (((major) << 16) | ((minor) & 0xFF))
 
 extern u32 scm_get_version(void);
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
