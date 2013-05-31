From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 31 May 2013 17:19:02 +0530
Subject: [PATCH 1/3] ARM: EXYNOS: uncompress - print debug messages if
 DEBUG_LL is defined
In-Reply-To: <1370000944-19786-1-git-send-email-tushar.behera@linaro.org>
References: <1370000944-19786-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1370000944-19786-2-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Printing low-level debug messages make an assumption that the specified
UART port has been preconfigured by the bootloader. Incorrectly
specified UART port results in system getting stalled while printing the
message "Uncompressing Linux... done, booting the kernel"

This UART port number is specified through S3C_LOWLEVEL_UART_PORT. Since
the UART port might different for different board, it is not possible to
specify it correctly for every board that use a common defconfig file.

Calling this print subroutine only when DEBUG_LL fixes the problem. By
disabling DEBUG_LL in default config file, we would be able to boot
multiple boards with different default UART ports.

With this current approach, we miss the print "Uncompressing Linux...
done, booting the kernel." when DEBUG_LL is not defined.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-exynos/include/mach/uncompress.h  |   11 ++++++++---
 arch/arm/plat-samsung/include/plat/uncompress.h |   10 +++++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/uncompress.h b/arch/arm/mach-exynos/include/mach/uncompress.h
index 2979995..730f69f 100644
--- a/arch/arm/mach-exynos/include/mach/uncompress.h
+++ b/arch/arm/mach-exynos/include/mach/uncompress.h
@@ -37,11 +37,16 @@ static void arch_detect_cpu(void)
 	chip_id >>= 20;
 	chip_id &= 0xf;
 
+#ifdef CONFIG_DEBUG_LL
 	if (chip_id == 0x5)
-		uart_base = (volatile u8 *)EXYNOS5_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
+		uart_base = (volatile u8 *)EXYNOS5_PA_UART +
+			(S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
 	else
-		uart_base = (volatile u8 *)EXYNOS4_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
-
+		uart_base = (volatile u8 *)EXYNOS4_PA_UART +
+			(S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
+#else
+	uart_base = NULL;
+#endif
 	/*
 	 * For preventing FIFO overrun or infinite loop of UART console,
 	 * fifo_max should be the minimum fifo size of all of the UART channels
diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
index 438b248..350032b 100644
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -66,6 +66,9 @@ uart_rd(unsigned int reg)
 
 static void putc(int ch)
 {
+	if (!uart_base)
+		return;
+
 	if (uart_rd(S3C2410_UFCON) & S3C2410_UFCON_FIFOMODE) {
 		int level;
 
@@ -118,7 +121,12 @@ static void arch_decomp_error(const char *x)
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
