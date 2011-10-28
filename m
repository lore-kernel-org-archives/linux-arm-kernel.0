From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:32 +0100
Subject: [PATCH 04/51] ARM: mach-clps711x: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-clps711x to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-clps711x/Makefile              |    2 +-
 arch/arm/mach-clps711x/include/mach/system.h |    1 -
 arch/arm/mach-clps711x/system.c              |   23 +++++++++++++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-clps711x/system.c

diff --git a/arch/arm/mach-clps711x/Makefile b/arch/arm/mach-clps711x/Makefile
index 4a19731..c3f224d 100644
--- a/arch/arm/mach-clps711x/Makefile
+++ b/arch/arm/mach-clps711x/Makefile
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-y			:= irq.o mm.o time.o
+obj-y			:= irq.o mm.o system.o time.o
 obj-m			:=
 obj-n			:=
 obj-			:=
diff --git a/arch/arm/mach-clps711x/include/mach/system.h b/arch/arm/mach-clps711x/include/mach/system.h
index f916cd7..9982deb 100644
--- a/arch/arm/mach-clps711x/include/mach/system.h
+++ b/arch/arm/mach-clps711x/include/mach/system.h
@@ -34,7 +34,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	cpu_reset(0);
 }
 
 #endif
diff --git a/arch/arm/mach-clps711x/system.c b/arch/arm/mach-clps711x/system.c
new file mode 100644
index 0000000..030d758
--- /dev/null
+++ b/arch/arm/mach-clps711x/system.c
@@ -0,0 +1,23 @@
+/*
+ * arch/arm/mach-clps711x/system.c
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <mach/hardware.h>
+
+#include <asm/system.h>
+#include <asm/hardware/clps7111.h>
+
+static void clps711x_arch_reset(char mode, const char *cmd)
+{
+	cpu_reset(0);
+}
+
+static int __init clps711x_arch_reset_init(void)
+{
+	arm_arch_reset = clps711x_arch_reset;
+	return 0;
+}
+
+arch_initcall(clps711x_arch_reset_init);
-- 
1.7.4.1
