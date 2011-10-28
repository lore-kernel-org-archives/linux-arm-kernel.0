From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:03 +0100
Subject: [PATCH 35/51] ARM: mach-realview: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-36-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-realview to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-realview/core.c                |   20 ++++++++++++++++++++
 arch/arm/mach-realview/include/mach/system.h |   13 -------------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 5c23450..96b6f75 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -534,3 +534,23 @@ void realview_fixup(struct machine_desc *mdesc, struct tag *tags, char **from,
 	meminfo->nr_banks = 1;
 #endif
 }
+
+void (*realview_reset)(char mode);
+
+static void realview_arch_reset(char mode, const char *cmd)
+{
+	/*
+	 * To reset, we hit the on-board reset register
+	 * in the system FPGA
+	 */
+	if (realview_reset)
+		realview_reset(mode);
+	dsb();
+}
+
+static int __init realview_arch_reset_init(void)
+{
+	arm_arch_reset = realview_arch_reset;
+	return 0;
+}
+arch_initcall(realview_arch_reset_init);
diff --git a/arch/arm/mach-realview/include/mach/system.h b/arch/arm/mach-realview/include/mach/system.h
index 6657ff23..1630766 100644
--- a/arch/arm/mach-realview/include/mach/system.h
+++ b/arch/arm/mach-realview/include/mach/system.h
@@ -21,12 +21,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-#include <linux/io.h>
-#include <mach/hardware.h>
-#include <mach/platform.h>
-
-void (*realview_reset)(char mode);
-
 static inline void arch_idle(void)
 {
 	/*
@@ -38,13 +32,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	/*
-	 * To reset, we hit the on-board reset register
-	 * in the system FPGA
-	 */
-	if (realview_reset)
-		realview_reset(mode);
-	dsb();
 }
 
 #endif
-- 
1.7.4.1
