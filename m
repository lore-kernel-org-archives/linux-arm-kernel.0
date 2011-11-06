From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:51:50 +0000
Subject: [PATCH 35/41] ARM: restart: u300: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6so-0001Yx-4x@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-u300/core.c                  |   21 +++++++++++++++++++++
 arch/arm/mach-u300/include/mach/platform.h |    1 +
 arch/arm/mach-u300/include/mach/system.h   |   24 +-----------------------
 arch/arm/mach-u300/u300.c                  |    1 +
 4 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index ac0791e..27be5a7 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -1888,3 +1888,24 @@ static int core_module_init(void)
 	return mmc_init(&mmcsd_device);
 }
 module_init(core_module_init);
+
+/* Forward declare this function from the watchdog */
+void coh901327_watchdog_reset(void);
+
+void u300_restart(char mode, const char *cmd)
+{
+	switch (mode) {
+	case 's':
+	case 'h':
+		printk(KERN_CRIT "RESET: shutting down/rebooting system\n");
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
diff --git a/arch/arm/mach-u300/include/mach/platform.h b/arch/arm/mach-u300/include/mach/platform.h
index 77d9210..096333f 100644
--- a/arch/arm/mach-u300/include/mach/platform.h
+++ b/arch/arm/mach-u300/include/mach/platform.h
@@ -14,6 +14,7 @@
 void u300_map_io(void);
 void u300_init_irq(void);
 void u300_init_devices(void);
+void u300_restart(char, const char *);
 extern struct sys_timer u300_timer;
 
 #endif
diff --git a/arch/arm/mach-u300/include/mach/system.h b/arch/arm/mach-u300/include/mach/system.h
index 6b6fef7..0ddf3cd 100644
--- a/arch/arm/mach-u300/include/mach/system.h
+++ b/arch/arm/mach-u300/include/mach/system.h
@@ -8,33 +8,11 @@
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
diff --git a/arch/arm/mach-u300/u300.c b/arch/arm/mach-u300/u300.c
index 89422ee..a75c9b8 100644
--- a/arch/arm/mach-u300/u300.c
+++ b/arch/arm/mach-u300/u300.c
@@ -51,4 +51,5 @@ MACHINE_START(U300, MACH_U300_STRING)
 	.init_irq	= u300_init_irq,
 	.timer		= &u300_timer,
 	.init_machine	= u300_init_machine,
+	.restart	= u300_restart,
 MACHINE_END
-- 
1.7.4.4
