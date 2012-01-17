From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 18 Jan 2012 00:40:20 +0100
Subject: [PATCH 4/4] at91 : implement the standby function for pm/cpuidle
In-Reply-To: <1326843620-13148-1-git-send-email-daniel.lezcano@linaro.org>
References: <1326843620-13148-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1326843620-13148-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch groups the self-refresh on/cpu_do_idle/self-refresh off into
a single 'standby' function.

The standby routine for rm9200 has been turned into an asm routine to have
a better control of the self refresh and to prevent a memory access when
running this code.

Draining the write buffer is done automatically when switching for the self
refresh on sam9, so the instruction is added to the rm9200 only.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/cpuidle.c |   11 ++-----
 arch/arm/mach-at91/pm.c      |   12 +-------
 arch/arm/mach-at91/pm.h      |   62 ++++++++++++++++++++++++-----------------
 3 files changed, 40 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
index a851e6c..555d956 100644
--- a/arch/arm/mach-at91/cpuidle.c
+++ b/arch/arm/mach-at91/cpuidle.c
@@ -39,20 +39,15 @@ static int at91_enter_idle(struct cpuidle_device *dev,
 {
 	struct timeval before, after;
 	int idle_time;
-	u32 saved_lpr;
 
 	local_irq_disable();
 	do_gettimeofday(&before);
 	if (index == 0)
 		/* Wait for interrupt state */
 		cpu_do_idle();
-	else if (index == 1) {
-		asm("b 1f; .align 5; 1:");
-		asm("mcr p15, 0, r0, c7, c10, 4");	/* drain write buffer */
-		saved_lpr = sdram_selfrefresh_enable();
-		cpu_do_idle();
-		sdram_selfrefresh_disable(saved_lpr);
-	}
+	else if (index == 1)
+		at91_standby();
+
 	do_gettimeofday(&after);
 	local_irq_enable();
 	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index acf32c7..94acc12 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -208,7 +208,6 @@ extern u32 at91_slow_clock_sz;
 
 static int at91_pm_enter(suspend_state_t state)
 {
-	u32 saved_lpr;
 	at91_gpio_suspend();
 	at91_irq_suspend();
 
@@ -264,16 +263,7 @@ static int at91_pm_enter(suspend_state_t state)
 			 * For ARM 926 based chips, this requirement is weaker
 			 * as at91sam9 can access a RAM in self-refresh mode.
 			 */
-			asm volatile (	"mov r0, #0\n\t"
-					"b 1f\n\t"
-					".align 5\n\t"
-					"1: mcr p15, 0, r0, c7, c10, 4\n\t"
-					: /* no output */
-					: /* no input */
-					: "r0");
-			saved_lpr = sdram_selfrefresh_enable();
-			cpu_do_idle();
-			sdram_selfrefresh_disable(saved_lpr);
+			at91_standby();
 			break;
 
 		case PM_SUSPEND_ON:
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 624c99c..b451822 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -24,22 +24,31 @@
  * still in self-refresh is "not recommended", but seems to work.
  */
 
-static inline u32 sdram_selfrefresh_enable(void)
+static inline void at91rm9200_standby(void)
 {
-	u32 saved_lpr = at91_sys_read(AT91_SDRAMC_LPR);
 
-	at91_sys_write(AT91_SDRAMC_LPR, 0);
-	at91_sys_write(AT91_SDRAMC_SRR, 1);
-	return saved_lpr;
+	u32 lpr = at91_sys_read(AT91_SDRAMC_LPR);
+
+	asm volatile(
+		"b    1f\n\t"
+		".align    5\n\t"
+		"1:  mcr    p15, 0, %0, c7, c10, 4\n\t"
+		"    str    %0, [%1, %2]\n\t"
+		"    str    %3, [%1, %4]\n\t"
+		"    mcr    p15, 0, %0, c7, c0, 4\n\t"
+		"    str    %5, [%1, %2]"
+		:
+		: "r" (0), "r" (AT91_BASE_SYS), "r" (AT91_SDRAMC_LPR),
+		  "r" (1), "r" (AT91_SDRAMC_SRR),
+		  "r" (lpr));
 }
 
-#define sdram_selfrefresh_disable(saved_lpr) \
-	at91_sys_write(AT91_SDRAMC_LPR, saved_lpr)
+#define at91_standby at91rm9200_standby
 
 #elif defined(CONFIG_ARCH_AT91CAP9)
 #include <mach/at91cap9_ddrsdr.h>
 
-static inline u32 sdram_selfrefresh_enable(void)
+static inline void at91cap9_standby(void)
 {
 	u32 saved_lpr, lpr;
 
@@ -48,11 +57,13 @@ static inline u32 sdram_selfrefresh_enable(void)
 	lpr = saved_lpr & ~AT91_DDRSDRC_LPCB;
 	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr |
 			AT91_DDRSDRC_LPCB_SELF_REFRESH);
-	return saved_lpr;
+
+	cpu_do_idle();
+
+	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr);
 }
 
-#define sdram_selfrefresh_disable(saved_lpr) \
-	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr)
+#define at91_standby at91cap9_standby
 
 #elif defined(CONFIG_ARCH_AT91SAM9G45)
 #include <mach/at91sam9_ddrsdr.h>
@@ -60,14 +71,12 @@ static inline u32 sdram_selfrefresh_enable(void)
 /* We manage both DDRAM/SDRAM controllers, we need more than one value to
  * remember.
  */
-static u32 saved_lpr1;
-
-static inline u32 sdram_selfrefresh_enable(void)
+static inline void at91sam9g45_standby(void)
 {
-	/* Those tow values allow us to delay self-refresh activation
+	/* Those two values allow us to delay self-refresh activation
 	 * to the maximum. */
 	u32 lpr0, lpr1;
-	u32 saved_lpr0;
+	u32 saved_lpr0, saved_lpr1;
 
 	saved_lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
 	lpr1 = saved_lpr1 & ~AT91_DDRSDRC_LPCB;
@@ -81,14 +90,13 @@ static inline u32 sdram_selfrefresh_enable(void)
 	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr0);
 	at91_ramc_write(1, AT91_DDRSDRC_LPR, lpr1);
 
-	return saved_lpr0;
+	cpu_do_idle();
+
+	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0);
+	at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
 }
 
-#define sdram_selfrefresh_disable(saved_lpr0)	\
-	do { \
-		at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0); \
-		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1); \
-	} while (0)
+#define at91_standby at91sam9g45_standby
 
 #else
 #include <mach/at91sam9_sdramc.h>
@@ -101,7 +109,7 @@ static inline u32 sdram_selfrefresh_enable(void)
 #warning Assuming EB1 SDRAM controller is *NOT* used
 #endif
 
-static inline u32 sdram_selfrefresh_enable(void)
+static inline void at91sam9_standby(void)
 {
 	u32 saved_lpr, lpr;
 
@@ -110,11 +118,13 @@ static inline u32 sdram_selfrefresh_enable(void)
 	lpr = saved_lpr & ~AT91_SDRAMC_LPCB;
 	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr |
 			AT91_SDRAMC_LPCB_SELF_REFRESH);
-	return saved_lpr;
-}
 
-#define sdram_selfrefresh_disable(saved_lpr) \
+	cpu_do_idle();
+
 	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr)
+}
+
+#define at91_standby at91sam9_standby
 
 #endif
 
-- 
1.7.5.4
