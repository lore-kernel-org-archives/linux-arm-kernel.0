From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:44:10 +0100
Subject: [PATCH 42/51] ARM: mach-u300: use arm_arch_reset instead of arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-43-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-u300 to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-u300/Makefile              |    2 +-
 arch/arm/mach-u300/include/mach/system.h |   26 +-----------------
 arch/arm/mach-u300/reset.c               |   42 ++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/mach-u300/reset.c

diff --git a/arch/arm/mach-u300/Makefile b/arch/arm/mach-u300/Makefile
index 8fd354a..599f4eb 100644
--- a/arch/arm/mach-u300/Makefile
+++ b/arch/arm/mach-u300/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel, U300 machine.
 #
 
-obj-y		:= core.o clock.o timer.o padmux.o
+obj-y		:= core.o clock.o timer.o padmux.o reset.o
 obj-m		:=
 obj-n		:=
 obj-		:=
diff --git a/arch/arm/mach-u300/include/mach/system.h b/arch/arm/mach-u300/include/mach/system.h
index 8daf136..0ddf3cd 100644
--- a/arch/arm/mach-u300/include/mach/system.h
+++ b/arch/arm/mach-u300/include/mach/system.h
@@ -8,35 +8,11 @@
  * System shutdown and reset functions.
  * Author: Linus Walleij <linus.walleij@stericsson.com>
  */
-#include <mach/hardware.h>
-#include <asm/io.h>
-#include <asm/hardware/vic.h>
-#include <asm/irq.h>
-
-/* Forward declare this function from the watchdog */
-void coh901327_watchdog_reset(void);
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
 }
 
-static void arch_reset(char mode, const char *cmd)
+static inline void arch_reset(char mode, const char *cmd)
 {
-	switch (mode) {
-	case 's':
-	case 'h':
-		printk(KERN_CRIT "RESET: shutting down/rebooting system\n");
-		/* Disable interrupts */
-		local_irq_disable();
-#ifdef CONFIG_COH901327_WATCHDOG
-		coh901327_watchdog_reset();
-#endif
-		break;
-	default:
-		/* Do nothing */
-		break;
-	}
-	/* Wait for system do die/reset. */
-	while (1);
 }
diff --git a/arch/arm/mach-u300/reset.c b/arch/arm/mach-u300/reset.c
new file mode 100644
index 0000000..607e7f8
--- /dev/null
+++ b/arch/arm/mach-u300/reset.c
@@ -0,0 +1,42 @@
+/*
+ * arch/arm/mach-u300/reset.c
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <mach/hardware.h>
+
+#include <asm/io.h>
+#include <asm/hardware/vic.h>
+#include <asm/irq.h>
+
+/* Forward declare this function from the watchdog */
+void coh901327_watchdog_reset(void);
+
+static void u300_arch_reset(char mode, const char *cmd)
+{
+	switch (mode) {
+	case 's':
+	case 'h':
+		printk(KERN_CRIT "RESET: shutting down/rebooting system\n");
+		/* Disable interrupts */
+		local_irq_disable();
+#ifdef CONFIG_COH901327_WATCHDOG
+		coh901327_watchdog_reset();
+#endif
+		break;
+	default:
+		/* Do nothing */
+		break;
+	}
+	/* Wait for system do die/reset. */
+	while (1);
+}
+
+static int __init u300_arch_reset_init(void)
+{
+	arm_arch_reset = u300_arch_reset;
+	return 0;
+}
+arch_initcall(u300_arch_reset_init);
-- 
1.7.4.1
