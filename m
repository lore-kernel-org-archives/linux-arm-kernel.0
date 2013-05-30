From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 30 May 2013 10:10:27 +0530
Subject: [PATCH] ARM: EXYNOS: Consolidate multiple low-level UART port
 definitions
Message-ID: <1369888827-9427-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two definitions for low-level UART ports for Exynos platform.
CONFIG_S3C_LOWLEVEL_UART_PORT is used for printing "Uncompressing
Linux... done, booting the kernel." and CONFIG_S3C_UART for other
low-level messages.

The assumption for both the uart ports is that they are pre-configured
in the bootloader. Since they are essentially the same always, it
would be good to consolidate them to use only one macro, in this case
'DEBUG_S3C_UART' would be a better option.

'DEBUG_S3C_UART' is defined only if DEBUG_LL is enabled. We can safely
disable this option when DEBUG_LL is not defined and we can boot various
boards with different UART port settings. Only drawback of this
approach is that when DEBUG_LL is not defined, we would be missing the
print "Uncompressing Linux... done, booting the kernel."

Since CONFIG_S3C_LOWLEVEL_UART_PORT is still used by other Samsung
boards, the consolidation applies only for ARCH_EXYNOS.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-exynos/include/mach/uncompress.h  |   11 ++++++++---
 arch/arm/plat-samsung/include/plat/uncompress.h |   16 ++++++++++++++--
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/uncompress.h b/arch/arm/mach-exynos/include/mach/uncompress.h
index 2979995..45b5c2a 100644
--- a/arch/arm/mach-exynos/include/mach/uncompress.h
+++ b/arch/arm/mach-exynos/include/mach/uncompress.h
@@ -37,11 +37,16 @@ static void arch_detect_cpu(void)
 	chip_id >>= 20;
 	chip_id &= 0xf;
 
+#ifdef CONFIG_DEBUG_LL
 	if (chip_id == 0x5)
-		uart_base = (volatile u8 *)EXYNOS5_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
+		uart_base = (volatile u8 *)EXYNOS5_PA_UART +
+			(S3C_UART_OFFSET * CONFIG_DEBUG_S3C_UART);
 	else
-		uart_base = (volatile u8 *)EXYNOS4_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
-
+		uart_base = (volatile u8 *)EXYNOS4_PA_UART +
+			(S3C_UART_OFFSET * CONFIG_DEBUG_S3C_UART);
+#else
+	uart_base = 0;
+#endif
 	/*
 	 * For preventing FIFO overrun or infinite loop of UART console,
 	 * fifo_max should be the minimum fifo size of all of the UART channels
diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
index 438b248..028c2a8 100644
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -38,7 +38,11 @@ static void arch_detect_cpu(void);
 #define FIFO_MAX	 (14)
 
 #ifdef S3C_PA_UART
-#define uart_base S3C_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT)
+#ifdef CONFIG_DEBUG_LL
+#define uart_base (S3C_PA_UART + (S3C_UART_OFFSET * CONFIG_DEBUG_S3C_UART))
+#else
+#define uart_base 0
+#endif
 #endif
 
 static __inline__ void
@@ -66,6 +70,9 @@ uart_rd(unsigned int reg)
 
 static void putc(int ch)
 {
+	if (!uart_base)
+		return;
+
 	if (uart_rd(S3C2410_UFCON) & S3C2410_UFCON_FIFOMODE) {
 		int level;
 
@@ -118,7 +125,12 @@ static void arch_decomp_error(const char *x)
 #ifdef CONFIG_S3C_BOOT_UART_FORCE_FIFO
 static inline void arch_enable_uart_fifo(void)
 {
-	u32 fifocon = uart_rd(S3C2410_UFCON);
+	u32 fifocon;
+
+	if (!uart_base)
+		return;
+
+	fifocon = uart_rd(S3C2410_UFCON);
 
 	if (!(fifocon & S3C2410_UFCON_FIFOMODE)) {
 		fifocon |= S3C2410_UFCON_RESETBOTH;
-- 
1.7.9.5
