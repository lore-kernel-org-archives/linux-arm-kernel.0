From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 29 Nov 2011 18:52:40 +0100
Subject: [PATCH 4/6] ARM: restart: at91: use new restart hook
In-Reply-To: <20111129173514.GW15008@game.jcrosoft.org>
References: <20111129173514.GW15008@game.jcrosoft.org>
Message-ID: <1322589162-5212-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

Rather than using a private function pointer, use the existing
arm_pm_restart function pointer instead.  We no longer need to enable
the I-cache in at91sam9_alt_reset() as the caches will now be on when
this function is called.

Update the function names to use the 'restart' terminology rather than
the 'reboot' terminology.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
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
index 81a9f38..e484a09 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -312,7 +312,7 @@ static struct at91_gpio_bank at91cap9_gpio[] __initdata = {
 	}
 };
 
-static void at91cap9_reset(void)
+static void at91cap9_restart(char mode, const char *cmd)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
 }
@@ -335,7 +335,7 @@ static void __init at91cap9_ioremap_registers(void)
 
 static void __init at91cap9_initialize(void)
 {
-	at91_arch_reset = at91cap9_reset;
+	arm_pm_restart = at91cap9_restart;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
 
 	/* Register GPIO subsystem */
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 9163d7d..99c3174 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -289,7 +289,7 @@ static struct at91_gpio_bank at91rm9200_gpio[] __initdata = {
 	}
 };
 
-static void at91rm9200_reset(void)
+static void at91rm9200_restart(char mode, const char *cmd)
 {
 	/*
 	 * Perform a hardware reset with the use of the Watchdog timer.
@@ -314,7 +314,7 @@ static void __init at91rm9200_ioremap_registers(void)
 
 static void __init at91rm9200_initialize(void)
 {
-	at91_arch_reset = at91rm9200_reset;
+	arm_pm_restart = at91rm9200_restart;
 	at91_extern_irq = (1 << AT91RM9200_ID_IRQ0) | (1 << AT91RM9200_ID_IRQ1)
 			| (1 << AT91RM9200_ID_IRQ2) | (1 << AT91RM9200_ID_IRQ3)
 			| (1 << AT91RM9200_ID_IRQ4) | (1 << AT91RM9200_ID_IRQ5)
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 5e25cef..9219b29 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -327,7 +327,7 @@ static void __init at91sam9260_ioremap_registers(void)
 
 static void __init at91sam9260_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arm_pm_restart = at91sam9_alt_restart;
 	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
 			| (1 << AT91SAM9260_ID_IRQ2);
 
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index a0538c5..b85b9ea 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -287,7 +287,7 @@ static void __init at91sam9261_ioremap_registers(void)
 
 static void __init at91sam9261_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arm_pm_restart = at91sam9_alt_restart;
 	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
 			| (1 << AT91SAM9261_ID_IRQ2);
 
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 0d90b6a..c26e0a1 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -306,7 +306,7 @@ static void __init at91sam9263_ioremap_registers(void)
 
 static void __init at91sam9263_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arm_pm_restart = at91sam9_alt_restart;
 	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
 
 	/* Register GPIO subsystem */
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
index 72c3cce..9344da5 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -316,7 +316,7 @@ static struct at91_gpio_bank at91sam9g45_gpio[] __initdata = {
 	}
 };
 
-static void at91sam9g45_reset(void)
+static void at91sam9g45_restart(char mode, const char *cmd)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
 }
@@ -340,7 +340,7 @@ static void __init at91sam9g45_ioremap_registers(void)
 
 static void __init at91sam9g45_initialize(void)
 {
-	at91_arch_reset = at91sam9g45_reset;
+	arm_pm_restart = at91sam9g45_restart;
 	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
 
 	/* Register GPIO subsystem */
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 96247f6..d6bcb1d 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -292,7 +292,7 @@ static void __init at91sam9rl_ioremap_registers(void)
 
 static void __init at91sam9rl_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arm_pm_restart = at91sam9_alt_restart;
 	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
 
 	/* Register GPIO subsystem */
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 4030958..4866b81 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -58,7 +58,7 @@ extern void at91_irq_suspend(void);
 extern void at91_irq_resume(void);
 
 /* reset */
-extern void at91sam9_alt_reset(void);
+extern void at91sam9_alt_restart(char, const char *);
 
 /* shutdown */
 extern void at91_ioremap_shdwc(u32 base_addr);
@@ -74,5 +74,4 @@ struct at91_gpio_bank {
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
1.7.7
