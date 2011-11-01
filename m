From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 01 Nov 2011 16:08:48 +0000
Subject: [PATCH 2/5] ARM: restart: get rid of needless at91_arch_reset
	additional indirection
In-Reply-To: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
Message-ID: <E1RLGtM-0005IR-FL@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need an additional level of indirection here, we can just
turn arch_reset into a function pointer directly and assign the
appropriate function (with appropriate arguments to it) just like
other platforms do.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-at91/at91cap9.c            |    4 ++--
 arch/arm/mach-at91/at91rm9200.c          |    4 ++--
 arch/arm/mach-at91/at91sam9260.c         |    2 +-
 arch/arm/mach-at91/at91sam9261.c         |    2 +-
 arch/arm/mach-at91/at91sam9263.c         |    2 +-
 arch/arm/mach-at91/at91sam9g45.c         |    4 ++--
 arch/arm/mach-at91/at91sam9rl.c          |    2 +-
 arch/arm/mach-at91/generic.h             |    2 +-
 arch/arm/mach-at91/include/mach/system.h |    9 +--------
 9 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index bfc6844..d45a877 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -311,7 +311,7 @@ static struct at91_gpio_bank at91cap9_gpio[] = {
 	}
 };
 
-static void at91cap9_reset(void)
+static void at91cap9_reset(char mode, const char *cmd)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
 }
@@ -333,7 +333,7 @@ static void __init at91cap9_map_io(void)
 
 static void __init at91cap9_initialize(void)
 {
-	at91_arch_reset = at91cap9_reset;
+	arch_reset = at91cap9_reset;
 	pm_power_off = at91cap9_poweroff;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
 
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index f73302d..15161a2 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -286,7 +286,7 @@ static struct at91_gpio_bank at91rm9200_gpio[] = {
 	}
 };
 
-static void at91rm9200_reset(void)
+static void at91rm9200_reset(char mode, const char *cmd)
 {
 	/*
 	 * Perform a hardware reset with the use of the Watchdog timer.
@@ -307,7 +307,7 @@ static void __init at91rm9200_map_io(void)
 
 static void __init at91rm9200_initialize(void)
 {
-	at91_arch_reset = at91rm9200_reset;
+	arch_reset = at91rm9200_reset;
 	at91_extern_irq = (1 << AT91RM9200_ID_IRQ0) | (1 << AT91RM9200_ID_IRQ1)
 			| (1 << AT91RM9200_ID_IRQ2) | (1 << AT91RM9200_ID_IRQ3)
 			| (1 << AT91RM9200_ID_IRQ4) | (1 << AT91RM9200_ID_IRQ5)
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index cb397be..2301336 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -317,7 +317,7 @@ static void __init at91sam9260_map_io(void)
 
 static void __init at91sam9260_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9260_poweroff;
 	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
 			| (1 << AT91SAM9260_ID_IRQ2);
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 6c8e3b5..771134b 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -286,7 +286,7 @@ static void __init at91sam9261_map_io(void)
 
 static void __init at91sam9261_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9261_poweroff;
 	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
 			| (1 << AT91SAM9261_ID_IRQ2);
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 044f3c9..733abdd 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -303,7 +303,7 @@ static void __init at91sam9263_map_io(void)
 
 static void __init at91sam9263_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9263_poweroff;
 	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
 
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index e04c5fb..9a02804 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -301,7 +301,7 @@ static struct at91_gpio_bank at91sam9g45_gpio[] = {
 	}
 };
 
-static void at91sam9g45_reset(void)
+static void at91sam9g45_reset(char mode, const char *cmd)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
 }
@@ -323,7 +323,7 @@ static void __init at91sam9g45_map_io(void)
 
 static void __init at91sam9g45_initialize(void)
 {
-	at91_arch_reset = at91sam9g45_reset;
+	arch_reset = at91sam9g45_reset;
 	pm_power_off = at91sam9g45_poweroff;
 	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
 
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index a238105..043d3ac 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -292,7 +292,7 @@ static void __init at91sam9rl_map_io(void)
 
 static void __init at91sam9rl_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9rl_poweroff;
 	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
 
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 938b34f..80bc57f 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -57,7 +57,7 @@ extern void at91_irq_suspend(void);
 extern void at91_irq_resume(void);
 
 /* reset */
-extern void at91sam9_alt_reset(void);
+extern void at91sam9_alt_reset(char, const char *);
 
  /* GPIO */
 #define AT91RM9200_PQFP		3	/* AT91RM9200 PQFP package has 3 banks */
diff --git a/arch/arm/mach-at91/include/mach/system.h b/arch/arm/mach-at91/include/mach/system.h
index 36af14b..b141fe0 100644
--- a/arch/arm/mach-at91/include/mach/system.h
+++ b/arch/arm/mach-at91/include/mach/system.h
@@ -47,13 +47,6 @@ static inline void arch_idle(void)
 #endif
 }
 
-void (*at91_arch_reset)(void);
-
-static inline void arch_reset(char mode, const char *cmd)
-{
-	/* call the CPU-specific reset function */
-	if (at91_arch_reset)
-		(at91_arch_reset)();
-}
+void (*arch_reset)(char mode, const char *cmd);
 
 #endif
-- 
1.7.4.4
