From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:15 +0100
Subject: [PATCH 47/51] ARM: plat-tcc: use arm_arch_reset instead of arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-48-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates plat-tcc to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/plat-tcc/include/mach/system.h |    5 -----
 arch/arm/plat-tcc/system.c              |   10 +++++++++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-tcc/include/mach/system.h b/arch/arm/plat-tcc/include/mach/system.h
index 909e603..e97ae31 100644
--- a/arch/arm/plat-tcc/include/mach/system.h
+++ b/arch/arm/plat-tcc/include/mach/system.h
@@ -11,10 +11,6 @@
 
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
-#include <linux/clk.h>
-
-#include <asm/mach-types.h>
-#include <mach/hardware.h>
 
 extern void plat_tcc_reboot(void);
 
@@ -25,7 +21,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	plat_tcc_reboot();
 }
 
 #endif
diff --git a/arch/arm/plat-tcc/system.c b/arch/arm/plat-tcc/system.c
index cc208fa..c3badd5 100644
--- a/arch/arm/plat-tcc/system.c
+++ b/arch/arm/plat-tcc/system.c
@@ -7,12 +7,13 @@
  *
  */
 
+#include <linux/init.h>
 #include <linux/io.h>
 
 #include <mach/tcc8k-regs.h>
 
 /* System reboot */
-void plat_tcc_reboot(void)
+static void plat_tcc_reboot(char mode, const char *cmd)
 {
 	/* Make sure clocks are on */
 	__raw_writel(0xffffffff, CKC_BASE + BCLKCTR0_OFFS);
@@ -23,3 +24,10 @@ void plat_tcc_reboot(void)
 	while(1)
 		;
 }
+
+static int __init plat_tcc_reboot_init(void)
+{
+	arm_arch_reset = plat_tcc_reboot;
+	return 0;
+}
+arch_initcall(plat_tcc_reboot);
-- 
1.7.4.1
