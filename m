From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 11 Jan 2012 15:55:39 +0100
Subject: [PATCH 6/7] at91 : group selfrefresh functions
In-Reply-To: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1326293740-15735-7-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Group in a single function the multiple functions declaration.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/pm.h |  105 ++++++++++++++++------------------------------
 1 files changed, 37 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index b9de247..aaa8e14 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -18,7 +18,13 @@ struct ram_saved {
 	u32 lpr1;
 };
 
-#ifdef CONFIG_ARCH_AT91RM9200
+#ifdef CONFIG_ARCH_AT91SAM9263
+/*
+ * FIXME either or both the SDRAM controllers (EB0, EB1) might be in use;
+ * handle those cases both here and in the Suspend-To-RAM support.
+ */
+#warning Assuming EB1 SDRAM controller is *NOT* used
+#endif
 
 /*
  * The AT91RM9200 goes into self-refresh mode with this command, and will
@@ -32,56 +38,32 @@ struct ram_saved {
 
 static inline void sdram_selfrefresh_enable(struct ram_saved *rs)
 {
-	rs->lpr0 = at91_sys_read(AT91_SDRAMC_LPR);
+	u32 lpr0;
+
+#ifdef CONFIG_ARCH_AT91RM9200
+
+	lpr0 = at91_sys_read(AT91_SDRAMC_LPR);
 
 	at91_sys_write(AT91_SDRAMC_LPR, 0);
 	at91_sys_write(AT91_SDRAMC_SRR, 1);
-}
 
-static inline void sdram_selfrefresh_disable(struct ram_saved *rs)
-{
-	at91_sys_write(AT91_SDRAMC_LPR, rs->lpr0);
-}
-
-static inline void wait_for_interrupt_enable(void)
-{
-	asm volatile ("mcr p15, 0, %0, c7, c0, 4" : : "r" (0));
-}
+	rs->lpr0 = lpr0;
 
 #elif defined(CONFIG_ARCH_AT91CAP9)
 
-static inline void sdram_selfrefresh_enable(struct ram_saved *rs)
-{
-	u32 lpr;
-
 	rs->lpr0 = at91_ramc_read(0, AT91_DDRSDRC_LPR);
 
-	lpr = rs->lpr0 & ~AT91_DDRSDRC_LPCB;
-	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr |
+	lpr0 = rs->lpr0 & ~AT91_DDRSDRC_LPCB;
+	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr0 |
 			AT91_DDRSDRC_LPCB_SELF_REFRESH);
-}
-
-static inline void sdram_selfrefresh_disable(struct ram_saved *rs)
-{
-	at91_ramc_write(0, AT91_DDRSDRC_LPR, rs->lpr0);
-}
-
-static inline void wait_for_interrupt_enable(void)
-{
-	cpu_do_idle();
-}
-
 #elif defined(CONFIG_ARCH_AT91SAM9G45)
 
-/* We manage both DDRAM/SDRAM controllers, we need more than one value to
- * remember.
- */
-static inline void sdram_selfrefresh_enable(struct ram_saved *rs)
-{
-	/* Those tow values allow us to delay self-refresh activation
-	 * to the maximum. */
-	u32 lpr0, lpr1;
+	/* We manage both DDRAM/SDRAM controllers, we need more than one value
+	 * to remember */
+	u32  lpr1;
 
+	/* Those two values allow us to delay self-refresh activation
+	 * to the maximum. */
 	rs->lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
 	lpr1 = rs->lpr1 & ~AT91_DDRSDRC_LPCB;
 	lpr1 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
@@ -93,50 +75,37 @@ static inline void sdram_selfrefresh_enable(struct ram_saved *rs)
 	/* self-refresh mode now */
 	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr0);
 	at91_ramc_write(1, AT91_DDRSDRC_LPR, lpr1);
+#else
+	rs->lpr0 = at91_ramc_read(0, AT91_SDRAMC_LPR);
+	lpr0 = rs->lpr0 & ~AT91_SDRAMC_LPCB;
+	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr0 |
+			AT91_SDRAMC_LPCB_SELF_REFRESH);
+
+#endif
 }
 
 static inline void sdram_selfrefresh_disable(struct ram_saved *rs)
 {
+#ifdef CONFIG_ARCH_AT91RM9200
+	at91_sys_write(AT91_SDRAMC_LPR, rs->lpr0);
+#elif defined(CONFIG_ARCH_AT91CAP9)
+	at91_ramc_write(0, AT91_DDRSDRC_LPR, rs->lpr0);
+#elif defined(CONFIG_ARCH_AT91SAM9G45)
 	at91_ramc_write(0, AT91_DDRSDRC_LPR, rs->lpr0);
 	at91_ramc_write(1, AT91_DDRSDRC_LPR, rs->lpr1);
-}
-
-static inline void wait_for_interrupt_enable(void)
-{
-	cpu_do_idle();
-}
-
 #else
-
-#ifdef CONFIG_ARCH_AT91SAM9263
-/*
- * FIXME either or both the SDRAM controllers (EB0, EB1) might be in use;
- * handle those cases both here and in the Suspend-To-RAM support.
- */
-#warning Assuming EB1 SDRAM controller is *NOT* used
+	at91_ramc_write(0, AT91_SDRAMC_LPR, rs->lpr0);
 #endif
 
-static inline void sdram_selfrefresh_enable(struct ram_saved *rs)
-{
-	u32 lpr;
-
-	rs->lpr0 = at91_ramc_read(0, AT91_SDRAMC_LPR);
-
-	lpr = rs->lpr0 & ~AT91_SDRAMC_LPCB;
-	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr |
-			AT91_SDRAMC_LPCB_SELF_REFRESH);
-}
-
-static inline void sdram_selfrefresh_disable(struct ram_saved *rs)
-{
-	at91_ramc_write(0, AT91_SDRAMC_LPR, rs->lpr0);
 }
 
 static inline void wait_for_interrupt_enable(void)
 {
+#ifdef CONFIG_ARCH_AT91RM9200
+	asm volatile ("mcr p15, 0, %0, c7, c0, 4" : : "r" (0));
+#else
 	cpu_do_idle();
-}
-
 #endif
+}
 
 #endif
-- 
1.7.4.1
