From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Mon, 11 May 2015 18:13:11 +0200
Subject: [PATCH 1/1] ARM:Gemini:Fix compiler warning due wrong data type.
Message-ID: <1431360791-11681-1-git-send-email-ulli.kroll@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a compiler warning in gemini_restart()
issued by commit

7b6d864b48d95e6ea1df7df64475b9cb9616dcf9
reboot:arm: reboot_mode changes from char to enum reboot_mode.

Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
---
 arch/arm/mach-gemini/common.h | 4 +++-
 arch/arm/mach-gemini/reset.c  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-gemini/common.h b/arch/arm/mach-gemini/common.h
index 38a4526..dd88369 100644
--- a/arch/arm/mach-gemini/common.h
+++ b/arch/arm/mach-gemini/common.h
@@ -12,6 +12,8 @@
 #ifndef __GEMINI_COMMON_H__
 #define __GEMINI_COMMON_H__
 
+#include <linux/reboot.h>
+
 struct mtd_partition;
 
 extern void gemini_map_io(void);
@@ -26,6 +28,6 @@ extern int platform_register_pflash(unsigned int size,
 				    struct mtd_partition *parts,
 				    unsigned int nr_parts);
 
-extern void gemini_restart(char mode, const char *cmd);
+extern void gemini_restart(enum reboot_mode mode, const char *cmd);
 
 #endif /* __GEMINI_COMMON_H__ */
diff --git a/arch/arm/mach-gemini/reset.c b/arch/arm/mach-gemini/reset.c
index b266597..21a6d6d 100644
--- a/arch/arm/mach-gemini/reset.c
+++ b/arch/arm/mach-gemini/reset.c
@@ -14,7 +14,9 @@
 #include <mach/hardware.h>
 #include <mach/global_reg.h>
 
-void gemini_restart(char mode, const char *cmd)
+#include "common.h"
+
+void gemini_restart(enum reboot_mode mode, const char *cmd)
 {
 	__raw_writel(RESET_GLOBAL | RESET_CPU1,
 		     IO_ADDRESS(GEMINI_GLOBAL_BASE) + GLOBAL_RESET);
-- 
2.3.5
