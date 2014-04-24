From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 24 Apr 2014 15:23:45 +0200
Subject: [PATCH v2 3/4] ARM: S3C24XX: use generic DEBUG_UART_PHY/_VIRT in
 debug macro
In-Reply-To: <1856986.kkQFKFg1L2@phil>
References: <1856986.kkQFKFg1L2@phil>
Message-ID: <1407426.Blop7O5hnW@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the need for mach/-headers in the debug macro.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/Kconfig.debug                           | 23 +++++++++++++++++++++--
 arch/arm/mach-s3c24xx/include/mach/debug-macro.S |  9 ++-------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index cb5751f..9755e63 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -625,6 +625,7 @@ choice
 	config DEBUG_S3C_UART0
 		depends on PLAT_SAMSUNG
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
+		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		bool "Use S3C UART 0 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
@@ -637,6 +638,7 @@ choice
 	config DEBUG_S3C_UART1
 		depends on PLAT_SAMSUNG
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
+		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		bool "Use S3C UART 1 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
@@ -649,6 +651,7 @@ choice
 	config DEBUG_S3C_UART2
 		depends on PLAT_SAMSUNG
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
+		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		bool "Use S3C UART 2 for low-level debug"
 		help
 		  Say Y here if you want the debug print routines to direct
@@ -950,6 +953,10 @@ config DEBUG_EXYNOS_UART
 
 config DEBUG_S3C2410_UART
 	bool
+	select DEBUG_S3C24XX_UART
+
+config DEBUG_S3C24XX_UART
+	bool
 
 config DEBUG_OMAP2PLUS_UART
 	bool
@@ -1059,6 +1066,12 @@ config DEBUG_UART_PHYS
 	default 0x40090000 if ARCH_LPC32XX
 	default 0x40100000 if DEBUG_PXA_UART1
 	default 0x42000000 if ARCH_GEMINI
+	default 0x50000000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART0 || \
+				DEBUG_S3C2410_UART0)
+	default 0x50004000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART1 || \
+				DEBUG_S3C2410_UART1)
+	default 0x50008000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART2 || \
+				DEBUG_S3C2410_UART2)
 	default 0x7c0003f8 if FOOTBRIDGE
 	default 0x80230000 if DEBUG_PICOXCELL_UART
 	default 0x80070000 if DEBUG_IMX23_UART
@@ -1088,7 +1101,7 @@ config DEBUG_UART_PHYS
 	default 0xfffff700 if ARCH_IOP33X
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_LL_UART_EFM32 || \
-		DEBUG_UART_8250 || DEBUG_UART_PL01X
+		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_S3C24XX_UART
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
@@ -1105,6 +1118,12 @@ config DEBUG_UART_VIRT
 	default 0xf2100000 if DEBUG_PXA_UART1
 	default 0xf4090000 if ARCH_LPC32XX
 	default 0xf4200000 if ARCH_GEMINI
+	default 0xf7000000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART0 || \
+				DEBUG_S3C2410_UART0)
+	default 0xf7004000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART1 || \
+				DEBUG_S3C2410_UART1)
+	default 0xf7008000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART2 || \
+				DEBUG_S3C2410_UART2)
 	default 0xf7fc9000 if DEBUG_BERLIN_UART
 	default 0xf8009000 if DEBUG_VEXPRESS_UART0_CA9
 	default 0xf8090000 if DEBUG_VEXPRESS_UART0_RS1
@@ -1146,7 +1165,7 @@ config DEBUG_UART_VIRT
 	default 0xff003000 if DEBUG_U300_UART
 	default DEBUG_UART_PHYS if !MMU
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
-		DEBUG_UART_8250 || DEBUG_UART_PL01X
+		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_S3C24XX_UART
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
diff --git a/arch/arm/mach-s3c24xx/include/mach/debug-macro.S b/arch/arm/mach-s3c24xx/include/mach/debug-macro.S
index fbe3e71..b1f54dc 100644
--- a/arch/arm/mach-s3c24xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c24xx/include/mach/debug-macro.S
@@ -12,18 +12,13 @@
  * published by the Free Software Foundation.
 */
 
-#include <mach/map.h>
 #include <linux/serial_s3c.h>
 
 #define S3C2410_UART1_OFF (0x4000)
 
 	.macro addruart, rp, rv, tmp
-		ldr	\rp, = S3C24XX_PA_UART
-		ldr	\rv, = S3C24XX_VA_UART
-#if CONFIG_DEBUG_S3C_UART != 0
-		add	\rp, \rp, #(S3C2410_UART1_OFF * CONFIG_DEBUG_S3C_UART)
-		add	\rv, \rv, #(S3C2410_UART1_OFF * CONFIG_DEBUG_S3C_UART)
-#endif
+		ldr	\rp, = CONFIG_DEBUG_UART_PHYS
+		ldr	\rv, = CONFIG_DEBUG_UART_VIRT
 	.endm
 
 	.macro  fifo_full_s3c2410 rd, rx
-- 
1.9.0
