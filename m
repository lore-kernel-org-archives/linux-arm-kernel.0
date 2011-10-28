From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:50 +0100
Subject: [PATCH 22/51] ARM: mach-ks8695: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-23-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-ks8695 to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-ks8695/Makefile              |    2 +-
 arch/arm/mach-ks8695/include/mach/system.h |   19 +---------------
 arch/arm/mach-ks8695/reset.c               |   33 ++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/mach-ks8695/reset.c

diff --git a/arch/arm/mach-ks8695/Makefile b/arch/arm/mach-ks8695/Makefile
index 7e3e816..c2dcdde 100644
--- a/arch/arm/mach-ks8695/Makefile
+++ b/arch/arm/mach-ks8695/Makefile
@@ -3,7 +3,7 @@
 # Makefile for KS8695 architecture support
 #
 
-obj-y				:= cpu.o irq.o time.o gpio.o devices.o
+obj-y				:= cpu.o irq.o time.o gpio.o devices.o reset.o
 obj-m				:=
 obj-n				:=
 obj-				:=
diff --git a/arch/arm/mach-ks8695/include/mach/system.h b/arch/arm/mach-ks8695/include/mach/system.h
index fb1dda9..b73ee70 100644
--- a/arch/arm/mach-ks8695/include/mach/system.h
+++ b/arch/arm/mach-ks8695/include/mach/system.h
@@ -14,9 +14,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-#include <linux/io.h>
-#include <mach/regs-timer.h>
-
 static void arch_idle(void)
 {
 	/*
@@ -27,22 +24,8 @@ static void arch_idle(void)
 
 }
 
-static void arch_reset(char mode, const char *cmd)
+static inline void arch_reset(char mode, const char *cmd)
 {
-	unsigned int reg;
-
-	if (mode == 's')
-		cpu_reset(0);
-
-	/* disable timer0 */
-	reg = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
-	__raw_writel(reg & ~TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
-
-	/* enable watchdog mode */
-	__raw_writel((10 << 8) | T0TC_WATCHDOG, KS8695_TMR_VA + KS8695_T0TC);
-
-	/* re-enable timer0 */
-	__raw_writel(reg | TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
 }
 
 #endif
diff --git a/arch/arm/mach-ks8695/reset.c b/arch/arm/mach-ks8695/reset.c
new file mode 100644
index 0000000..911eb95
--- /dev/null
+++ b/arch/arm/mach-ks8695/reset.c
@@ -0,0 +1,33 @@
+/*
+ * arch/arm/mach-ks8695/reset.c
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <asm/proc-fns.h>
+#include <mach/regs-timer.h>
+
+static void ks8695_arch_reset(char mode, const char *cmd)
+{
+	unsigned int reg;
+
+	if (mode == 's')
+		cpu_reset(0);
+
+	/* disable timer0 */
+	reg = __raw_readl(KS8695_TMR_VA + KS8695_TMCON);
+	__raw_writel(reg & ~TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
+
+	/* enable watchdog mode */
+	__raw_writel((10 << 8) | T0TC_WATCHDOG, KS8695_TMR_VA + KS8695_T0TC);
+
+	/* re-enable timer0 */
+	__raw_writel(reg | TMCON_T0EN, KS8695_TMR_VA + KS8695_TMCON);
+}
+
+static int __init ks8695_arch_reset_init(void)
+{
+	arm_arch_reset = ks8695_arch_reset;
+	return 0;
+}
+arch_initcall(ks8695_arch_reset_init);
-- 
1.7.4.1
