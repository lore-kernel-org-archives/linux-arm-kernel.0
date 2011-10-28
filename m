From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:12 +0100
Subject: [PATCH 44/51] ARM: mach-vt8500: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-45-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-vt8500 to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-vt8500/Makefile              |    2 +-
 arch/arm/mach-vt8500/include/mach/system.h |    5 -----
 arch/arm/mach-vt8500/reset.c               |   21 +++++++++++++++++++++
 3 files changed, 22 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-vt8500/reset.c

diff --git a/arch/arm/mach-vt8500/Makefile b/arch/arm/mach-vt8500/Makefile
index 81aedb7..1932b82 100644
--- a/arch/arm/mach-vt8500/Makefile
+++ b/arch/arm/mach-vt8500/Makefile
@@ -1,4 +1,4 @@
-obj-y += devices.o gpio.o irq.o timer.o
+obj-y += devices.o gpio.o irq.o reset.o timer.o
 
 obj-$(CONFIG_VTWM_VERSION_VT8500) += devices-vt8500.o
 obj-$(CONFIG_VTWM_VERSION_WM8505) += devices-wm8505.o
diff --git a/arch/arm/mach-vt8500/include/mach/system.h b/arch/arm/mach-vt8500/include/mach/system.h
index d6c757e..4bbcce4 100644
--- a/arch/arm/mach-vt8500/include/mach/system.h
+++ b/arch/arm/mach-vt8500/include/mach/system.h
@@ -2,10 +2,6 @@
  * arch/arm/mach-vt8500/include/mach/system.h
  *
  */
-#include <asm/io.h>
-
-/* PM Software Reset request register */
-#define VT8500_PMSR_VIRT	0xf8130060
 
 static inline void arch_idle(void)
 {
@@ -14,5 +10,4 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	writel(1, VT8500_PMSR_VIRT);
 }
diff --git a/arch/arm/mach-vt8500/reset.c b/arch/arm/mach-vt8500/reset.c
new file mode 100644
index 0000000..631721a
--- /dev/null
+++ b/arch/arm/mach-vt8500/reset.c
@@ -0,0 +1,21 @@
+/*
+ * arch/arm/mach-vt8500/reset.c
+ */
+
+#include <linux/init.h>
+#include <asm/io.h>
+
+/* PM Software Reset request register */
+#define VT8500_PMSR_VIRT	0xf8130060
+
+static void vt8500_arch_reset(char mode, const char *cmd)
+{
+	writel(1, VT8500_PMSR_VIRT);
+}
+
+static int __init vt8500_arch_reset_init(void)
+{
+	arm_arch_reset = vt8500_arch_reset;
+	return 0;
+}
+arch_initcall(vt8500_arch_reset_init);
-- 
1.7.4.1
