From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Jan 2013 22:12:45 +0800
Subject: [PATCH 3/3] ARM: samsung: remove unused arch_decomp_wdog() code
In-Reply-To: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
References: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1357827165-9320-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With ARCH_HAS_DECOMP_WDOG removed from arch/arm/boot/compressed/decompress.c,
all the arch_decomp_wdog() related codes become unused.  Remove them.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p64x0/include/mach/uncompress.h |   28 -----------------------
 arch/arm/plat-samsung/include/plat/uncompress.h |   28 -----------------------
 2 files changed, 56 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/include/mach/uncompress.h b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
index 1608faf..19e0d64 100644
--- a/arch/arm/mach-s5p64x0/include/mach/uncompress.h
+++ b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
@@ -116,33 +116,6 @@ static inline void flush(void)
 		*((volatile unsigned int __force *)(ad)) = (d); \
 	} while (0)
 
-/*
- * CONFIG_S3C_BOOT_WATCHDOG
- *
- * Simple boot-time watchdog setup, to reboot the system if there is
- * any problem with the boot process
- */
-
-#ifdef CONFIG_S3C_BOOT_WATCHDOG
-
-#define WDOG_COUNT (0xff00)
-
-static inline void arch_decomp_wdog(void)
-{
-	__raw_writel(WDOG_COUNT, S3C2410_WTCNT);
-}
-
-static void arch_decomp_wdog_start(void)
-{
-	__raw_writel(WDOG_COUNT, S3C2410_WTDAT);
-	__raw_writel(WDOG_COUNT, S3C2410_WTCNT);
-	__raw_writel(S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV128 | S3C2410_WTCON_RSTEN | S3C2410_WTCON_PRESCALE(0x80), S3C2410_WTCON);
-}
-
-#else
-#define arch_decomp_wdog_start()
-#define arch_decomp_wdog()
-#endif
 
 #ifdef CONFIG_S3C_BOOT_ERROR_RESET
 
@@ -192,7 +165,6 @@ static void arch_decomp_setup(void)
 	 */
 
 	arch_detect_cpu();
-	arch_decomp_wdog_start();
 
 	/*
 	 * Enable the UART FIFOs if they where not enabled and our
diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
index 7e068d1..438b248 100644
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -97,33 +97,6 @@ static inline void flush(void)
 		*((volatile unsigned int __force *)(ad)) = (d); \
 	} while (0)
 
-/* CONFIG_S3C_BOOT_WATCHDOG
- *
- * Simple boot-time watchdog setup, to reboot the system if there is
- * any problem with the boot process
-*/
-
-#ifdef CONFIG_S3C_BOOT_WATCHDOG
-
-#define WDOG_COUNT (0xff00)
-
-static inline void arch_decomp_wdog(void)
-{
-	__raw_writel(WDOG_COUNT, S3C2410_WTCNT);
-}
-
-static void arch_decomp_wdog_start(void)
-{
-	__raw_writel(WDOG_COUNT, S3C2410_WTDAT);
-	__raw_writel(WDOG_COUNT, S3C2410_WTCNT);
-	__raw_writel(S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV128 | S3C2410_WTCON_RSTEN | S3C2410_WTCON_PRESCALE(0x80), S3C2410_WTCON);
-}
-
-#else
-#define arch_decomp_wdog_start()
-#define arch_decomp_wdog()
-#endif
-
 #ifdef CONFIG_S3C_BOOT_ERROR_RESET
 
 static void arch_decomp_error(const char *x)
@@ -173,7 +146,6 @@ arch_decomp_setup(void)
 	 */
 
 	arch_detect_cpu();
-	arch_decomp_wdog_start();
 
 	/* Enable the UART FIFOs if they where not enabled and our
 	 * configuration says we should turn them on.
-- 
1.7.9.5
