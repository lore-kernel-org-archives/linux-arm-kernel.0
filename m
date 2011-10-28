From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:39 +0100
Subject: [PATCH 11/51] ARM: mach-gemini: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-12-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-gemini to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-gemini/Makefile              |    2 +-
 arch/arm/mach-gemini/include/mach/system.h |    2 --
 arch/arm/mach-gemini/system.c              |   22 ++++++++++++++++++++++
 3 files changed, 23 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-gemini/system.c

diff --git a/arch/arm/mach-gemini/Makefile b/arch/arm/mach-gemini/Makefile
index c5b24b9..b6fc9a0 100644
--- a/arch/arm/mach-gemini/Makefile
+++ b/arch/arm/mach-gemini/Makefile
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-y			:= irq.o mm.o time.o devices.o gpio.o
+obj-y			:= irq.o mm.o time.o devices.o gpio.o system.o
 
 # Board-specific support
 obj-$(CONFIG_MACH_NAS4220B)	+= board-nas4220b.o
diff --git a/arch/arm/mach-gemini/include/mach/system.h b/arch/arm/mach-gemini/include/mach/system.h
index 4d9c1f8..7df8e48 100644
--- a/arch/arm/mach-gemini/include/mach/system.h
+++ b/arch/arm/mach-gemini/include/mach/system.h
@@ -30,8 +30,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	__raw_writel(RESET_GLOBAL | RESET_CPU1,
-		     IO_ADDRESS(GEMINI_GLOBAL_BASE) + GLOBAL_RESET);
 }
 
 #endif /* __MACH_SYSTEM_H */
diff --git a/arch/arm/mach-gemini/system.c b/arch/arm/mach-gemini/system.c
new file mode 100644
index 0000000..f1bba7f
--- /dev/null
+++ b/arch/arm/mach-gemini/system.c
@@ -0,0 +1,22 @@
+/*
+ * arch/arm/mach-gemini/system.c
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <mach/hardware.h>
+#include <mach/global_reg.h>
+#include <asm/system.h>
+
+static void gemini_arch_reset(char mode, const char *cmd)
+{
+	__raw_writel(RESET_GLOBAL | RESET_CPU1,
+		     IO_ADDRESS(GEMINI_GLOBAL_BASE) + GLOBAL_RESET);
+}
+
+static int __init gemini_arch_reset_init(void)
+{
+	arm_arch_reset = gemini_arch_reset;
+	return 0;
+}
+arch_initcall(gemini_arch_reset_init);
-- 
1.7.4.1
