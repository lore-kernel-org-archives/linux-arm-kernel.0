From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue,  4 Jun 2013 09:49:10 +0530
Subject: [PATCH v2 1/3] ARM: EXYNOS: uncompress - print debug messages if
 DEBUG_LL is defined
In-Reply-To: <1370319552-17694-1-git-send-email-tushar.behera@linaro.org>
References: <1370319552-17694-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1370319552-17694-2-git-send-email-tushar.behera@linaro.org>
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
Change for v2:
* Instead of checking value of uart_base, now check if DEBUG_LL
is enabled. This removes the ifdef's from mach/uncompress.h


 arch/arm/plat-samsung/include/plat/uncompress.h |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
index 438b248..02b66d7 100644
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -66,6 +66,9 @@ uart_rd(unsigned int reg)
 
 static void putc(int ch)
 {
+	if (!config_enabled(CONFIG_DEBUG_LL))
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
+	if (!config_enabled(CONFIG_DEBUG_LL))
+		return;
+
+	fifocon = uart_rd(S3C2410_UFCON);
 
 	if (!(fifocon & S3C2410_UFCON_FIFOMODE)) {
 		fifocon |= S3C2410_UFCON_RESETBOTH;
-- 
1.7.9.5
