From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 11 Jan 2012 15:55:37 +0100
Subject: [PATCH 4/7] at91 : convert pm.h macros to static inline functions
In-Reply-To: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1326293740-15735-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the macros to inline functions. That will allow to group
the different functions definitions in a single function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/pm.h |   52 +++++++++++++++++++++++++++++-----------------
 1 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index fc48bef..3aa8b66 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -34,12 +34,15 @@ static inline u32 sdram_selfrefresh_enable(void)
 	return saved_lpr;
 }
 
-#define sdram_selfrefresh_disable(saved_lpr) \
-	at91_sys_write(AT91_SDRAMC_LPR, saved_lpr)
+static inline void sdram_selfrefresh_disable(u32 saved_lpr)
+{
+	at91_sys_write(AT91_SDRAMC_LPR, saved_lpr);
+}
 
-#define wait_for_interrupt_enable() \
-	asm volatile ("mcr p15, 0, %0, c7, c0, 4" \
-		      : : "r" (0))
+static inline void wait_for_interrupt_enable(void)
+{
+	asm volatile ("mcr p15, 0, %0, c7, c0, 4" : : "r" (0));
+}
 
 #elif defined(CONFIG_ARCH_AT91CAP9)
 
@@ -55,11 +58,15 @@ static inline u32 sdram_selfrefresh_enable(void)
 	return saved_lpr;
 }
 
-#define sdram_selfrefresh_disable(saved_lpr) \
-	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr)
+static inline void sdram_selfrefresh_disable(u32 saved_lpr)
+{
+	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr);
+}
 
-#define wait_for_interrupt_enable() \
-	cpu_do_idle()
+static inline void wait_for_interrupt_enable(void)
+{
+	cpu_do_idle();
+}
 
 #elif defined(CONFIG_ARCH_AT91SAM9G45)
 
@@ -90,13 +97,16 @@ static inline u32 sdram_selfrefresh_enable(void)
 	return saved_lpr0;
 }
 
-#define sdram_selfrefresh_disable(saved_lpr0)	\
-	do { \
-		at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0); \
-		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1); \
-	} while (0)
+static inline void sdram_selfrefresh_disable(u32 saved_lpr0)
+{
+	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0);
+	at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
+}
 
-#define wait_for_interrupt_enable()		cpu_do_idle()
+static inline void wait_for_interrupt_enable(void)
+{
+	cpu_do_idle();
+}
 
 #else
 
@@ -120,11 +130,15 @@ static inline u32 sdram_selfrefresh_enable(void)
 	return saved_lpr;
 }
 
-#define sdram_selfrefresh_disable(saved_lpr) \
-	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr)
+static inline void sdram_selfrefresh_disable(u32 saved_lpr)
+{
+	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr);
+}
 
-#define wait_for_interrupt_enable() \
-	cpu_do_idle()
+static inline void wait_for_interrupt_enable(void)
+{
+	cpu_do_idle();
+}
 
 #endif
 
-- 
1.7.4.1
