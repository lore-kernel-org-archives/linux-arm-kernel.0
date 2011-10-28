From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:14 +0100
Subject: [PATCH 46/51] ARM: plat-spear: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-47-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates plat-spear to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/plat-spear/Makefile              |    2 +-
 arch/arm/plat-spear/include/plat/system.h |   11 -----------
 arch/arm/plat-spear/reset.c               |   29 +++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/plat-spear/reset.c

diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index b4f340b..cb70a42 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -3,6 +3,6 @@
 #
 
 # Common support
-obj-y	:= clock.o time.o
+obj-y	:= clock.o reset.o time.o
 
 obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o padmux.o
diff --git a/arch/arm/plat-spear/include/plat/system.h b/arch/arm/plat-spear/include/plat/system.h
index a235fa0..4a0d125 100644
--- a/arch/arm/plat-spear/include/plat/system.h
+++ b/arch/arm/plat-spear/include/plat/system.h
@@ -14,10 +14,6 @@
 #ifndef __PLAT_SYSTEM_H
 #define __PLAT_SYSTEM_H
 
-#include <linux/io.h>
-#include <asm/hardware/sp810.h>
-#include <mach/hardware.h>
-
 static inline void arch_idle(void)
 {
 	/*
@@ -29,13 +25,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	if (mode == 's') {
-		/* software reset, Jump into ROM at address 0 */
-		cpu_reset(0);
-	} else {
-		/* hardware reset, Use on-chip reset capability */
-		sysctl_soft_reset((void __iomem *)VA_SPEAR_SYS_CTRL_BASE);
-	}
 }
 
 #endif /* __PLAT_SYSTEM_H */
diff --git a/arch/arm/plat-spear/reset.c b/arch/arm/plat-spear/reset.c
new file mode 100644
index 0000000..607efb3
--- /dev/null
+++ b/arch/arm/plat-spear/reset.c
@@ -0,0 +1,29 @@
+/*
+ * arch/arm/plat-spear/reset.c
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include <asm/proc-fns.h>
+#include <asm/hardware/sp810.h>
+
+#include <mach/hardware.h>
+
+static void spear_arch_reset(char mode, const char *cmd)
+{
+	if (mode == 's') {
+		/* software reset, Jump into ROM at address 0 */
+		cpu_reset(0);
+	} else {
+		/* hardware reset, Use on-chip reset capability */
+		sysctl_soft_reset((void __iomem *)VA_SPEAR_SYS_CTRL_BASE);
+	}
+}
+
+static int __init spear_arch_reset_init(void)
+{
+	arm_arch_reset = spear_arch_reset;
+	return 0;
+}
+arch_initcall(spear_arch_reset_init);
-- 
1.7.4.1
