From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:41:18 +0000
Subject: [PATCH 04/41] ARM: restart: at91: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6ic-0001Wp-7t@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than using a private function pointer, use the existing
arm_pm_restart function pointer instead.  We no longer need to enable
the I-cache in at91sam9_alt_reset() as the caches will now be on when
this function is called.

Update the function names to use the 'restart' terminology rather than
the 'reboot' terminology.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-at91/at91cap9.c            |    4 ++--
 arch/arm/mach-at91/at91rm9200.c          |    4 ++--
 arch/arm/mach-at91/at91sam9260.c         |    2 +-
 arch/arm/mach-at91/at91sam9261.c         |    2 +-
 arch/arm/mach-at91/at91sam9263.c         |    2 +-
 arch/arm/mach-at91/at91sam9_alt_reset.S  |    9 ++-------
 arch/arm/mach-at91/at91sam9g45.c         |    4 ++--
 arch/arm/mach-at91/at91sam9rl.c          |    2 +-
 arch/arm/mach-at91/generic.h             |    3 +--
 arch/arm/mach-at91/include/mach/system.h |    5 -----
 10 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index ecdd54d..2937339 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -313,7 +313,7 @@ static struct at91_gpio_bank at91cap9_gpio[] = {
 	}
 };
 
-static void at91cap9_reset(void)
+static void at91cap9_restart(char mode, const char *cmd)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
 }
@@ -335,7 +335,7 @@ static void __init at91cap9_map_io(void)
 
 static void __init at91cap9_initialize(void)
 {
-	at91_arch_reset = at91cap9_reset;
+	arm_pm_restart = at91cap9_restart;
 	pm_power_off = at91cap9_poweroff;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
 
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 713d3bd..430a9fd 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -288,7 +288,7 @@ static struct at91_gpio_bank at91rm9200_gpio[] = {
 	}
 };
 
-static void at91rm9200_reset(void)
+static void at91rm9200_restart(char mode, const char *cmd)
 {
 	/*
 	 * Perform a hardware reset with the use of the Watchdog timer.
@@ -309,7 +309,7 @@ static void __init at91rm9200_map_io(void)
 
 static void __init at91rm9200_initialize(void)
 {
-	at91_arch_reset = at91rm9200_reset;
+	arm_pm_restart = at91rm9200_restart;
 	at91_extern_irq = (1 << AT91RM9200_ID_IRQ0) | (1 << AT91RM9200_ID_IRQ1)
 			| (1 << AT91RM9200_ID_IRQ2) | (1 << AT91RM9200_ID_IRQ3)
 			| (1 << AT91RM9200_ID_IRQ4) | (1 << AT91RM9200_ID_IRQ5)
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index b84a9f6..ec9e23d 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -327,7 +327,7 @@ static void __init at91sam9260_map_io(void)
 
 static void __init at91sam9260_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arm_pm_restart = at91sam9_alt_restart;
 	pm_power_off = at91sam9260_poweroff;
 	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
 			| (1 << AT91SAM9260_ID_IRQ2);
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 658a518..19ac7c0 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -287,7 +287,7 @@ static void __init at91sam9261_map_io(void)
 
 static void __init at91sam9261_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arm_pm_restart = at91sam9_alt_restart;
 	pm_power_off = at91sam9261_poweroff;
 	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
 			| (1 << AT91SAM9261_ID_IRQ2);
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index f83fbb0..50d0163 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -305,7 +305,7 @@ static void __init at91sam9263_map_io(void)
 
 static void __init at91sam9263_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arm_pm_restart = at91sam9_alt_restart;
 	pm_power_off = at91sam9263_poweroff;
 	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
 
diff --git a/arch/arm/mach-at91/at91sam9_alt_reset.S b/arch/arm/mach-at91/at91sam9_alt_reset.S
index e0256de..d3f931c 100644
--- a/arch/arm/mach-at91/at91sam9_alt_reset.S
+++ b/arch/arm/mach-at91/at91sam9_alt_reset.S
@@ -14,20 +14,15 @@
  */
 
 #include <linux/linkage.h>
-#include <asm/system.h>
 #include <mach/hardware.h>
 #include <mach/at91sam9_sdramc.h>
 #include <mach/at91_rstc.h>
 
 			.arm
 
-			.globl	at91sam9_alt_reset
+			.globl	at91sam9_alt_restart
 
-at91sam9_alt_reset:	mrc	p15, 0, r0, c1, c0, 0
-			orr	r0, r0, #CR_I
-			mcr	p15, 0, r0, c1, c0, 0		@ enable I-cache
-
-			ldr	r0, .at91_va_base_sdramc	@ preload constants
+at91sam9_alt_restart:	ldr	r0, .at91_va_base_sdramc	@ preload constants
 			ldr	r1, .at91_va_base_rstc_cr
 
 			mov	r2, #1
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 318b040..ff21f7a 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -317,7 +317,7 @@ static struct at91_gpio_bank at91sam9g45_gpio[] = {
 	}
 };
 
-static void at91sam9g45_reset(void)
+static void at91sam9g45_restart(char mode, const char *cmd)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
 }
@@ -340,7 +340,7 @@ static void __init at91sam9g45_map_io(void)
 
 static void __init at91sam9g45_initialize(void)
 {
-	at91_arch_reset = at91sam9g45_reset;
+	arm_pm_restart = at91sam9g45_restart;
 	pm_power_off = at91sam9g45_poweroff;
 	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
 
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index a238105..61cbb46 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -292,7 +292,7 @@ static void __init at91sam9rl_map_io(void)
 
 static void __init at91sam9rl_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arm_pm_restart = at91sam9_alt_restart;
 	pm_power_off = at91sam9rl_poweroff;
 	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
 
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 938b34f..7f4503b 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -57,7 +57,7 @@ extern void at91_irq_suspend(void);
 extern void at91_irq_resume(void);
 
 /* reset */
-extern void at91sam9_alt_reset(void);
+extern void at91sam9_alt_restart(char, const char *);
 
  /* GPIO */
 #define AT91RM9200_PQFP		3	/* AT91RM9200 PQFP package has 3 banks */
@@ -71,5 +71,4 @@ struct at91_gpio_bank {
 extern void __init at91_gpio_init(struct at91_gpio_bank *, int nr_banks);
 extern void __init at91_gpio_irq_setup(void);
 
-extern void (*at91_arch_reset)(void);
 extern int at91_extern_irq;
diff --git a/arch/arm/mach-at91/include/mach/system.h b/arch/arm/mach-at91/include/mach/system.h
index 36af14b..079eb12 100644
--- a/arch/arm/mach-at91/include/mach/system.h
+++ b/arch/arm/mach-at91/include/mach/system.h
@@ -47,13 +47,8 @@ static inline void arch_idle(void)
 #endif
 }
 
-void (*at91_arch_reset)(void);
-
 static inline void arch_reset(char mode, const char *cmd)
 {
-	/* call the CPU-specific reset function */
-	if (at91_arch_reset)
-		(at91_arch_reset)();
 }
 
 #endif
-- 
1.7.4.4
