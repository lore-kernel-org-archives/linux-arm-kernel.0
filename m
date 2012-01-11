From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 11 Jan 2012 15:55:38 +0100
Subject: [PATCH 5/7] at91 : fix dirty hack for the selfrefresh function
In-Reply-To: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1326293740-15735-6-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the static variable saved_lpr1 defined in the header and
define a structure to be common with all the functions.
That will cleanly unify the function definitions.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/cpuidle.c |    6 ++--
 arch/arm/mach-at91/pm.c      |    6 ++--
 arch/arm/mach-at91/pm.h      |   61 ++++++++++++++++++++----------------------
 3 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
index a851e6c..e3eac45 100644
--- a/arch/arm/mach-at91/cpuidle.c
+++ b/arch/arm/mach-at91/cpuidle.c
@@ -38,8 +38,8 @@ static int at91_enter_idle(struct cpuidle_device *dev,
 			       int index)
 {
 	struct timeval before, after;
+	struct ram_saved rs;
 	int idle_time;
-	u32 saved_lpr;
 
 	local_irq_disable();
 	do_gettimeofday(&before);
@@ -49,9 +49,9 @@ static int at91_enter_idle(struct cpuidle_device *dev,
 	else if (index == 1) {
 		asm("b 1f; .align 5; 1:");
 		asm("mcr p15, 0, r0, c7, c10, 4");	/* drain write buffer */
-		saved_lpr = sdram_selfrefresh_enable();
+		sdram_selfrefresh_enable(&rs);
 		cpu_do_idle();
-		sdram_selfrefresh_disable(saved_lpr);
+		sdram_selfrefresh_disable(&rs);
 	}
 	do_gettimeofday(&after);
 	local_irq_enable();
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 62ad955..f97bbfa 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -208,7 +208,7 @@ extern u32 at91_slow_clock_sz;
 
 static int at91_pm_enter(suspend_state_t state)
 {
-	u32 saved_lpr;
+	struct ram_saved rs;
 	at91_gpio_suspend();
 	at91_irq_suspend();
 
@@ -271,9 +271,9 @@ static int at91_pm_enter(suspend_state_t state)
 					: /* no output */
 					: /* no input */
 					: "r0");
-			saved_lpr = sdram_selfrefresh_enable();
+			sdram_selfrefresh_enable(&rs);
 			wait_for_interrupt_enable();
-			sdram_selfrefresh_disable(saved_lpr);
+			sdram_selfrefresh_disable(&rs);
 			break;
 
 		case PM_SUSPEND_ON:
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 3aa8b66..b9de247 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -13,6 +13,11 @@
 
 #include <mach/at91_mc.h>
 
+struct ram_saved {
+	u32 lpr0;
+	u32 lpr1;
+};
+
 #ifdef CONFIG_ARCH_AT91RM9200
 
 /*
@@ -25,18 +30,17 @@
  * still in self-refresh is "not recommended", but seems to work.
  */
 
-static inline u32 sdram_selfrefresh_enable(void)
+static inline void sdram_selfrefresh_enable(struct ram_saved *rs)
 {
-	u32 saved_lpr = at91_sys_read(AT91_SDRAMC_LPR);
+	rs->lpr0 = at91_sys_read(AT91_SDRAMC_LPR);
 
 	at91_sys_write(AT91_SDRAMC_LPR, 0);
 	at91_sys_write(AT91_SDRAMC_SRR, 1);
-	return saved_lpr;
 }
 
-static inline void sdram_selfrefresh_disable(u32 saved_lpr)
+static inline void sdram_selfrefresh_disable(struct ram_saved *rs)
 {
-	at91_sys_write(AT91_SDRAMC_LPR, saved_lpr);
+	at91_sys_write(AT91_SDRAMC_LPR, rs->lpr0);
 }
 
 static inline void wait_for_interrupt_enable(void)
@@ -46,21 +50,20 @@ static inline void wait_for_interrupt_enable(void)
 
 #elif defined(CONFIG_ARCH_AT91CAP9)
 
-static inline u32 sdram_selfrefresh_enable(void)
+static inline void sdram_selfrefresh_enable(struct ram_saved *rs)
 {
-	u32 saved_lpr, lpr;
+	u32 lpr;
 
-	saved_lpr = at91_ramc_read(0, AT91_DDRSDRC_LPR);
+	rs->lpr0 = at91_ramc_read(0, AT91_DDRSDRC_LPR);
 
-	lpr = saved_lpr & ~AT91_DDRSDRC_LPCB;
+	lpr = rs->lpr0 & ~AT91_DDRSDRC_LPCB;
 	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr |
 			AT91_DDRSDRC_LPCB_SELF_REFRESH);
-	return saved_lpr;
 }
 
-static inline void sdram_selfrefresh_disable(u32 saved_lpr)
+static inline void sdram_selfrefresh_disable(struct ram_saved *rs)
 {
-	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr);
+	at91_ramc_write(0, AT91_DDRSDRC_LPR, rs->lpr0);
 }
 
 static inline void wait_for_interrupt_enable(void)
@@ -73,34 +76,29 @@ static inline void wait_for_interrupt_enable(void)
 /* We manage both DDRAM/SDRAM controllers, we need more than one value to
  * remember.
  */
-static u32 saved_lpr1;
-
-static inline u32 sdram_selfrefresh_enable(void)
+static inline void sdram_selfrefresh_enable(struct ram_saved *rs)
 {
 	/* Those tow values allow us to delay self-refresh activation
 	 * to the maximum. */
 	u32 lpr0, lpr1;
-	u32 saved_lpr0;
 
-	saved_lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
-	lpr1 = saved_lpr1 & ~AT91_DDRSDRC_LPCB;
+	rs->lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
+	lpr1 = rs->lpr1 & ~AT91_DDRSDRC_LPCB;
 	lpr1 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
 
-	saved_lpr0 = at91_ramc_read(0, AT91_DDRSDRC_LPR);
-	lpr0 = saved_lpr0 & ~AT91_DDRSDRC_LPCB;
+	rs->lpr0 = at91_ramc_read(0, AT91_DDRSDRC_LPR);
+	lpr0 = rs->lpr0 & ~AT91_DDRSDRC_LPCB;
 	lpr0 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
 
 	/* self-refresh mode now */
 	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr0);
 	at91_ramc_write(1, AT91_DDRSDRC_LPR, lpr1);
-
-	return saved_lpr0;
 }
 
-static inline void sdram_selfrefresh_disable(u32 saved_lpr0)
+static inline void sdram_selfrefresh_disable(struct ram_saved *rs)
 {
-	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0);
-	at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
+	at91_ramc_write(0, AT91_DDRSDRC_LPR, rs->lpr0);
+	at91_ramc_write(1, AT91_DDRSDRC_LPR, rs->lpr1);
 }
 
 static inline void wait_for_interrupt_enable(void)
@@ -118,21 +116,20 @@ static inline void wait_for_interrupt_enable(void)
 #warning Assuming EB1 SDRAM controller is *NOT* used
 #endif
 
-static inline u32 sdram_selfrefresh_enable(void)
+static inline void sdram_selfrefresh_enable(struct ram_saved *rs)
 {
-	u32 saved_lpr, lpr;
+	u32 lpr;
 
-	saved_lpr = at91_ramc_read(0, AT91_SDRAMC_LPR);
+	rs->lpr0 = at91_ramc_read(0, AT91_SDRAMC_LPR);
 
-	lpr = saved_lpr & ~AT91_SDRAMC_LPCB;
+	lpr = rs->lpr0 & ~AT91_SDRAMC_LPCB;
 	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr |
 			AT91_SDRAMC_LPCB_SELF_REFRESH);
-	return saved_lpr;
 }
 
-static inline void sdram_selfrefresh_disable(u32 saved_lpr)
+static inline void sdram_selfrefresh_disable(struct ram_saved *rs)
 {
-	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr);
+	at91_ramc_write(0, AT91_SDRAMC_LPR, rs->lpr0);
 }
 
 static inline void wait_for_interrupt_enable(void)
-- 
1.7.4.1
