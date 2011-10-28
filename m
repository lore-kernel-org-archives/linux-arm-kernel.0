From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:08 +0100
Subject: [PATCH 40/51] ARM: mach-shmobile: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-41-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-shmobile to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-shmobile/Makefile              |    2 +-
 arch/arm/mach-shmobile/include/mach/system.h |    1 -
 arch/arm/mach-shmobile/reset.c               |   18 ++++++++++++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/reset.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 612b270..8f12b57 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common objects
-obj-y				:= timer.o console.o clock.o pm_runtime.o
+obj-y				:= timer.o console.o clock.o pm_runtime.o reset.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o intc-sh7367.o
diff --git a/arch/arm/mach-shmobile/include/mach/system.h b/arch/arm/mach-shmobile/include/mach/system.h
index 76a687e..4f2bea5 100644
--- a/arch/arm/mach-shmobile/include/mach/system.h
+++ b/arch/arm/mach-shmobile/include/mach/system.h
@@ -8,7 +8,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	cpu_reset(0);
 }
 
 #endif
diff --git a/arch/arm/mach-shmobile/reset.c b/arch/arm/mach-shmobile/reset.c
new file mode 100644
index 0000000..ab53fb9
--- /dev/null
+++ b/arch/arm/mach-shmobile/reset.c
@@ -0,0 +1,18 @@
+/*
+ * arch/arm/mach-shmobile/reset.c
+ */
+
+#include <linux/init.h>
+#include <asm/proc-fns.h>
+
+static void shmobile_arch_reset(char mode, const char *cmd)
+{
+	cpu_reset(0);
+}
+
+static int __init shmobile_arch_reset_init(void)
+{
+	arm_arch_reset = shmobile_arch_reset;
+	return 0;
+}
+arch_initcall(shmobile_arch_reset_init);
-- 
1.7.4.1
