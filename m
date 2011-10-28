From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:51 +0100
Subject: [PATCH 23/51] ARM: mach-lpc32xx: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-24-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-lpc32xx to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-lpc32xx/common.c              |   30 +++++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/include/mach/system.h |   21 ------------------
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index 205b2db..200bd51 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -311,3 +311,33 @@ void __init lpc32xx_map_io(void)
 {
 	iotable_init(lpc32xx_io_desc, ARRAY_SIZE(lpc32xx_io_desc));
 }
+
+static void lpc32xx_arch_reset(char mode, const char *cmd)
+{
+	switch (mode) {
+	case 's':
+	case 'h':
+		printk(KERN_CRIT "RESET: Rebooting system\n");
+
+		/* Disable interrupts */
+		local_irq_disable();
+
+		lpc32xx_watchdog_reset();
+		break;
+
+	default:
+		/* Do nothing */
+		break;
+	}
+
+	/* Wait for watchdog to reset system */
+	while (1)
+		;
+}
+
+static int __init lpc32xx_arch_reset_init(void)
+{
+	arm_arch_reset = lpc32xx_arch_reset;
+	return 0;
+}
+arch_initcall(lpc32xx_arch_reset_init);
diff --git a/arch/arm/mach-lpc32xx/include/mach/system.h b/arch/arm/mach-lpc32xx/include/mach/system.h
index df3b0de..9c6cc0c 100644
--- a/arch/arm/mach-lpc32xx/include/mach/system.h
+++ b/arch/arm/mach-lpc32xx/include/mach/system.h
@@ -26,27 +26,6 @@ static void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	extern void lpc32xx_watchdog_reset(void);
-
-	switch (mode) {
-	case 's':
-	case 'h':
-		printk(KERN_CRIT "RESET: Rebooting system\n");
-
-		/* Disable interrupts */
-		local_irq_disable();
-
-		lpc32xx_watchdog_reset();
-		break;
-
-	default:
-		/* Do nothing */
-		break;
-	}
-
-	/* Wait for watchdog to reset system */
-	while (1)
-		;
 }
 
 #endif
-- 
1.7.4.1
