From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:13 +0100
Subject: [PATCH 45/51] ARM: mach-w90x900: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-46-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-w90x900 to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-w90x900/Makefile              |    2 +-
 arch/arm/mach-w90x900/include/mach/system.h |   19 +---------------
 arch/arm/mach-w90x900/reset.c               |   31 +++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/mach-w90x900/reset.c

diff --git a/arch/arm/mach-w90x900/Makefile b/arch/arm/mach-w90x900/Makefile
index 828c032..e771d1b 100644
--- a/arch/arm/mach-w90x900/Makefile
+++ b/arch/arm/mach-w90x900/Makefile
@@ -5,7 +5,7 @@
 # Object file lists.
 
 obj-y				:= irq.o time.o mfp.o gpio.o clock.o
-obj-y				+= clksel.o dev.o cpu.o
+obj-y				+= clksel.o dev.o cpu.o reset.o
 # W90X900 CPU support files
 
 obj-$(CONFIG_CPU_W90P910)	+= nuc910.o
diff --git a/arch/arm/mach-w90x900/include/mach/system.h b/arch/arm/mach-w90x900/include/mach/system.h
index ce228bd..ed3478b 100644
--- a/arch/arm/mach-w90x900/include/mach/system.h
+++ b/arch/arm/mach-w90x900/include/mach/system.h
@@ -15,27 +15,10 @@
  *
  */
 
-#include <linux/io.h>
-#include <asm/proc-fns.h>
-#include <mach/map.h>
-#include <mach/regs-timer.h>
-
-#define	WTCR	(TMR_BA + 0x1C)
-#define	WTCLK	(1 << 10)
-#define	WTE	(1 << 7)
-#define	WTRE	(1 << 1)
-
 static void arch_idle(void)
 {
 }
 
-static void arch_reset(char mode, const char *cmd)
+static inline void arch_reset(char mode, const char *cmd)
 {
-	if (mode == 's') {
-		/* Jump into ROM@address 0 */
-		cpu_reset(0);
-	} else {
-		__raw_writel(WTE | WTRE | WTCLK, WTCR);
-	}
 }
-
diff --git a/arch/arm/mach-w90x900/reset.c b/arch/arm/mach-w90x900/reset.c
new file mode 100644
index 0000000..08f1953
--- /dev/null
+++ b/arch/arm/mach-w90x900/reset.c
@@ -0,0 +1,31 @@
+/*
+ * arch/arm/mach-w90x900/reset.c
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <asm/proc-fns.h>
+#include <mach/map.h>
+#include <mach/regs-timer.h>
+
+#define	WTCR	(TMR_BA + 0x1C)
+#define	WTCLK	(1 << 10)
+#define	WTE	(1 << 7)
+#define	WTRE	(1 << 1)
+
+static void w90x900_arch_reset(char mode, const char *cmd)
+{
+	if (mode == 's') {
+		/* Jump into ROM@address 0 */
+		cpu_reset(0);
+	} else {
+		__raw_writel(WTE | WTRE | WTCLK, WTCR);
+	}
+}
+
+static int __init w90x900_arch_reset_init(void)
+{
+	arm_arch_reset = w90x900_arch_reset;
+	return 0;
+}
+arch_initcall(w90x900_arch_reset_init);
-- 
1.7.4.1
