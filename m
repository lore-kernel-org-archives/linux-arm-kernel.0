From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 15:12:10 +0000
Subject: AT91 reboot code
In-Reply-To: <20111102145903.GK19187@n2100.arm.linux.org.uk>
References: <20111101144058.GP19187@n2100.arm.linux.org.uk>
	<CAFumwP2m7=QsMTGAafPJs2ekm0R5FqCg8QxbOESBCq5r1PQkrA@mail.gmail.com>
	<20111102145903.GK19187@n2100.arm.linux.org.uk>
Message-ID: <20111102151210.GL19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 02:59:03PM +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 02, 2011 at 07:43:28AM +0200, Andrew Victor wrote:
> > hi Russell,
> > 
> > > Is there any reason this can't just be:
> > >
> > > void (*arch_reset)(char mode, const char *cmd);
> > 
> > I don't see any reason why not, except if arch_reset() can be called
> > early in the setup code (before the platform initialization).
> 
> There is a case where it could happen - that is if you panic and you
> have a non-zero panic timeout.
> 
> However, if you don't know how to restart your machine, then you're not
> going to be able to do anything.  I'd therefore suggest this patch:

And we can do one better with this given the size of this change.
As all the AT91 reset handlers are using a hardware method, we can
do without the arm_machine_restart() indirection too.  And we can
get rid of the icache enable in the assembly restart code as this
will now be the case.  This is a replacement patch for the previous.

I've taken the liberty to rename _reset to _restart as well, so we
have a common naming for this operation across converted platforms.

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
index bfc6844..d4427f8 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -311,7 +311,7 @@ static struct at91_gpio_bank at91cap9_gpio[] = {
 	}
 };
 
-static void at91cap9_reset(void)
+static void at91cap9_restart(char mode, const char *cmd)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
 }
@@ -333,7 +333,7 @@ static void __init at91cap9_map_io(void)
 
 static void __init at91cap9_initialize(void)
 {
-	at91_arch_reset = at91cap9_reset;
+	arm_pm_restart = at91cap9_restart;
 	pm_power_off = at91cap9_poweroff;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
 
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index f73302d..0a7b3bb 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -286,7 +286,7 @@ static struct at91_gpio_bank at91rm9200_gpio[] = {
 	}
 };
 
-static void at91rm9200_reset(void)
+static void at91rm9200_restart(char mode, const char *cmd)
 {
 	/*
 	 * Perform a hardware reset with the use of the Watchdog timer.
@@ -307,7 +307,7 @@ static void __init at91rm9200_map_io(void)
 
 static void __init at91rm9200_initialize(void)
 {
-	at91_arch_reset = at91rm9200_reset;
+	arm_pm_restart = at91rm9200_restart;
 	at91_extern_irq = (1 << AT91RM9200_ID_IRQ0) | (1 << AT91RM9200_ID_IRQ1)
 			| (1 << AT91RM9200_ID_IRQ2) | (1 << AT91RM9200_ID_IRQ3)
 			| (1 << AT91RM9200_ID_IRQ4) | (1 << AT91RM9200_ID_IRQ5)
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index cb397be..85c5826 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -317,7 +317,7 @@ static void __init at91sam9260_map_io(void)
 
 static void __init at91sam9260_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arm_pm_restart = at91sam9_alt_restart;
 	pm_power_off = at91sam9260_poweroff;
 	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
 			| (1 << AT91SAM9260_ID_IRQ2);
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 6c8e3b5..054182b 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -286,7 +286,7 @@ static void __init at91sam9261_map_io(void)
 
 static void __init at91sam9261_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arm_pm_restart = at91sam9_alt_restart;
 	pm_power_off = at91sam9261_poweroff;
 	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
 			| (1 << AT91SAM9261_ID_IRQ2);
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 044f3c9..cd3c407 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -303,7 +303,7 @@ static void __init at91sam9263_map_io(void)
 
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
index e04c5fb..8acaf7e 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -301,7 +301,7 @@ static struct at91_gpio_bank at91sam9g45_gpio[] = {
 	}
 };
 
-static void at91sam9g45_reset(void)
+static void at91sam9g45_restart(char mode, const char *cmd)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
 }
@@ -323,7 +323,7 @@ static void __init at91sam9g45_map_io(void)
 
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
