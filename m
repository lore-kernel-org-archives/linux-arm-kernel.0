From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:46:45 +0000
Subject: [PATCH 20/41] ARM: restart: lpc32xx: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6nt-0001Xu-7X@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the arm_pm_restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-lpc32xx/common.c              |   22 +++++++++++++++++++++-
 arch/arm/mach-lpc32xx/common.h              |    2 ++
 arch/arm/mach-lpc32xx/include/mach/system.h |   18 ------------------
 arch/arm/mach-lpc32xx/phy3250.c             |    1 +
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index 205b2db..b049fd1 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -164,7 +164,7 @@ int clk_is_sysclk_mainosc(void)
 /*
  * System reset via the watchdog timer
  */
-void lpc32xx_watchdog_reset(void)
+static void lpc32xx_watchdog_reset(void)
 {
 	/* Make sure WDT clocks are enabled */
 	__raw_writel(LPC32XX_CLKPWR_PWMCLK_WDOG_EN,
@@ -311,3 +311,23 @@ void __init lpc32xx_map_io(void)
 {
 	iotable_init(lpc32xx_io_desc, ARRAY_SIZE(lpc32xx_io_desc));
 }
+
+void lpc23xx_restart(char mode, const char *cmd)
+{
+	switch (mode) {
+	case 's':
+	case 'h':
+		printk(KERN_CRIT "RESET: Rebooting system\n");
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
diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
index 5583f52..4b4e700 100644
--- a/arch/arm/mach-lpc32xx/common.h
+++ b/arch/arm/mach-lpc32xx/common.h
@@ -39,6 +39,8 @@ extern void __init lpc32xx_init_irq(void);
 extern void __init lpc32xx_map_io(void);
 extern void __init lpc32xx_serial_init(void);
 extern void __init lpc32xx_gpio_init(void);
+extern void lpc23xx_restart(char, const char *);
+
 
 /*
  * Structure used for setting up and querying the PLLS
diff --git a/arch/arm/mach-lpc32xx/include/mach/system.h b/arch/arm/mach-lpc32xx/include/mach/system.h
index d47f3b1..9c6cc0c 100644
--- a/arch/arm/mach-lpc32xx/include/mach/system.h
+++ b/arch/arm/mach-lpc32xx/include/mach/system.h
@@ -26,24 +26,6 @@ static void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	extern void lpc32xx_watchdog_reset(void);
-
-	switch (mode) {
-	case 's':
-	case 'h':
-		printk(KERN_CRIT "RESET: Rebooting system\n");
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
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 6d2f0d1..ecb9411 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -388,4 +388,5 @@ MACHINE_START(PHY3250, "Phytec 3250 board with the LPC3250 Microcontroller")
 	.init_irq	= lpc32xx_init_irq,
 	.timer		= &lpc32xx_timer,
 	.init_machine	= phy3250_board_init,
+	.restart	= lpc23xx_restart,
 MACHINE_END
-- 
1.7.4.4
