From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 24 Apr 2014 15:23:10 +0200
Subject: [PATCH v2 2/4] ARM: S3C24XX: trim down debug uart handling
In-Reply-To: <1856986.kkQFKFg1L2@phil>
References: <1856986.kkQFKFg1L2@phil>
Message-ID: <199768557.KA84zMPfE3@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the lowlevel debug uart is a corner case - even more so in a
multiplatform environment. So it seems reasonable to simply let the
developer set the appropriate uart type for the debugged SoC.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/Kconfig.debug                           | 30 ++++++++++++++
 arch/arm/mach-s3c24xx/Kconfig                    | 28 -------------
 arch/arm/mach-s3c24xx/include/mach/debug-macro.S | 52 +-----------------------
 3 files changed, 31 insertions(+), 79 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 4a2fc0b..cb5751f 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -670,6 +670,33 @@ choice
 		  The uncompressor code port configuration is now handled
 		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
 
+	config DEBUG_S3C2410_UART0
+		depends on ARCH_S3C24XX
+		select DEBUG_S3C2410_UART
+		bool "Use S3C2410/S3C2412 UART 0 for low-level debug"
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART 0. The port must have been initialised
+		  by the boot-loader before use.
+
+	config DEBUG_S3C2410_UART1
+		depends on ARCH_S3C24XX
+		select DEBUG_S3C2410_UART
+		bool "Use S3C2410/S3C2412 UART 1 for low-level debug"
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART 1. The port must have been initialised
+		  by the boot-loader before use.
+
+	config DEBUG_S3C2410_UART2
+		depends on ARCH_S3C24XX
+		select DEBUG_S3C2410_UART
+		bool "Use S3C2410/S3C2412 UART 2 for low-level debug"
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART 2. The port must have been initialised
+		  by the boot-loader before use.
+
 	config DEBUG_SOCFPGA_UART
 		depends on ARCH_SOCFPGA
 		bool "Use SOCFPGA UART for low-level debug"
@@ -921,6 +948,9 @@ endchoice
 config DEBUG_EXYNOS_UART
 	bool
 
+config DEBUG_S3C2410_UART
+	bool
+
 config DEBUG_OMAP2PLUS_UART
 	bool
 	depends on ARCH_OMAP2PLUS
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 40cf50b..98d17af 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -26,7 +26,6 @@ config CPU_S3C2410
 	bool "SAMSUNG S3C2410"
 	default y
 	select CPU_ARM920T
-	select CPU_LLSERIAL_S3C2410
 	select S3C2410_CLOCK
 	select S3C2410_DMA if S3C24XX_DMA
 	select ARM_S3C2410_CPUFREQ if ARM_S3C24XX_CPUFREQ
@@ -39,7 +38,6 @@ config CPU_S3C2410
 config CPU_S3C2412
 	bool "SAMSUNG S3C2412"
 	select CPU_ARM926T
-	select CPU_LLSERIAL_S3C2440
 	select S3C2412_DMA if S3C24XX_DMA
 	select S3C2412_PM if PM
 	help
@@ -48,7 +46,6 @@ config CPU_S3C2412
 config CPU_S3C2416
 	bool "SAMSUNG S3C2416/S3C2450"
 	select CPU_ARM926T
-	select CPU_LLSERIAL_S3C2440
 	select S3C2416_PM if PM
 	select S3C2443_COMMON
 	select S3C2443_DMA if S3C24XX_DMA
@@ -59,7 +56,6 @@ config CPU_S3C2416
 config CPU_S3C2440
 	bool "SAMSUNG S3C2440"
 	select CPU_ARM920T
-	select CPU_LLSERIAL_S3C2440
 	select S3C2410_CLOCK
 	select S3C2410_PM if PM
 	select S3C2440_DMA if S3C24XX_DMA
@@ -69,7 +65,6 @@ config CPU_S3C2440
 config CPU_S3C2442
 	bool "SAMSUNG S3C2442"
 	select CPU_ARM920T
-	select CPU_LLSERIAL_S3C2440
 	select S3C2410_CLOCK
 	select S3C2410_DMA if S3C24XX_DMA
 	select S3C2410_PM if PM
@@ -84,7 +79,6 @@ config CPU_S3C244X
 config CPU_S3C2443
 	bool "SAMSUNG S3C2443"
 	select CPU_ARM920T
-	select CPU_LLSERIAL_S3C2440
 	select S3C2443_COMMON
 	select S3C2443_DMA if S3C24XX_DMA
 	select SAMSUNG_CLKSRC
@@ -158,28 +152,6 @@ config S3C2410_PM
 	help
 	  Power Management code common to S3C2410 and better
 
-# low-level serial option nodes
-
-config CPU_LLSERIAL_S3C2410_ONLY
-	bool
-	default y if CPU_LLSERIAL_S3C2410 && !CPU_LLSERIAL_S3C2440
-
-config CPU_LLSERIAL_S3C2440_ONLY
-	bool
-	default y if CPU_LLSERIAL_S3C2440 && !CPU_LLSERIAL_S3C2410
-
-config CPU_LLSERIAL_S3C2410
-	bool
-	help
-	  Selected if there is an S3C2410 (or register compatible) serial
-	  low-level implementation needed
-
-config CPU_LLSERIAL_S3C2440
-	bool
-	help
-	  Selected if there is an S3C2440 (or register compatible) serial
-	  low-level implementation needed
-
 config S3C24XX_PLL
 	bool "Support CPUfreq changing of PLL frequency (EXPERIMENTAL)"
 	depends on ARM_S3C24XX_CPUFREQ
diff --git a/arch/arm/mach-s3c24xx/include/mach/debug-macro.S b/arch/arm/mach-s3c24xx/include/mach/debug-macro.S
index 2f39737..fbe3e71 100644
--- a/arch/arm/mach-s3c24xx/include/mach/debug-macro.S
+++ b/arch/arm/mach-s3c24xx/include/mach/debug-macro.S
@@ -13,11 +13,9 @@
 */
 
 #include <mach/map.h>
-#include <mach/regs-gpio.h>
 #include <linux/serial_s3c.h>
 
 #define S3C2410_UART1_OFF (0x4000)
-#define SHIFT_2440TXF (14-9)
 
 	.macro addruart, rp, rv, tmp
 		ldr	\rp, = S3C24XX_PA_UART
@@ -28,56 +26,11 @@
 #endif
 	.endm
 
-	.macro fifo_full_s3c24xx rd, rx
-		@ check for arm920 vs arm926. currently assume all arm926
-		@ devices have an 64 byte FIFO identical to the s3c2440
-		mrc	p15, 0, \rd, c0, c0
-		and	\rd, \rd, #0xff0
-		teq	\rd, #0x260
-		beq	1004f
-		mrc	p15, 0, \rd, c1, c0
-		tst	\rd, #1
-		addeq	\rd, \rx, #(S3C24XX_PA_GPIO - S3C24XX_PA_UART)
-		addne	\rd, \rx, #(S3C24XX_VA_GPIO - S3C24XX_VA_UART)
-		bic	\rd, \rd, #0xff000
-		ldr	\rd, [\rd, # S3C2410_GSTATUS1 - S3C2410_GPIOREG(0)]
-		and	\rd, \rd, #0x00ff0000
-		teq	\rd, #0x00440000		@ is it 2440?
-1004:
-		ldr	\rd, [\rx, # S3C2410_UFSTAT]
-		moveq	\rd, \rd, lsr #SHIFT_2440TXF
-		tst	\rd, #S3C2410_UFSTAT_TXFULL
-	.endm
-
 	.macro  fifo_full_s3c2410 rd, rx
 		ldr	\rd, [\rx, # S3C2410_UFSTAT]
 		tst	\rd, #S3C2410_UFSTAT_TXFULL
 	.endm
 
-/* fifo level reading */
-
-	.macro fifo_level_s3c24xx rd, rx
-		@ check for arm920 vs arm926. currently assume all arm926
-		@ devices have an 64 byte FIFO identical to the s3c2440
-		mrc	p15, 0, \rd, c0, c0
-		and	\rd, \rd, #0xff0
-		teq	\rd, #0x260
-		beq	10000f
-		mrc	p15, 0, \rd, c1, c0
-		tst	\rd, #1
-		addeq	\rd, \rx, #(S3C24XX_PA_GPIO - S3C24XX_PA_UART)
-		addne	\rd, \rx, #(S3C24XX_VA_GPIO - S3C24XX_VA_UART)
-		bic	\rd, \rd, #0xff000
-		ldr	\rd, [\rd, # S3C2410_GSTATUS1 - S3C2410_GPIOREG(0)]
-		and	\rd, \rd, #0x00ff0000
-		teq	\rd, #0x00440000		@ is it 2440?
-
-10000:
-		ldr	\rd, [\rx, # S3C2410_UFSTAT]
-		andne	\rd, \rd, #S3C2410_UFSTAT_TXMASK
-		andeq	\rd, \rd, #S3C2440_UFSTAT_TXMASK
-	.endm
-
 	.macro fifo_level_s3c2410 rd, rx
 		ldr	\rd, [\rx, # S3C2410_UFSTAT]
 		and	\rd, \rd, #S3C2410_UFSTAT_TXMASK
@@ -88,12 +41,9 @@
  * used variants of these
 */
 
-#if defined(CONFIG_CPU_LLSERIAL_S3C2410_ONLY)
+#if defined(CONFIG_DEBUG_S3C2410_UART)
 #define fifo_full  fifo_full_s3c2410
 #define fifo_level fifo_level_s3c2410
-#elif !defined(CONFIG_CPU_LLSERIAL_S3C2440_ONLY)
-#define fifo_full  fifo_full_s3c24xx
-#define fifo_level fifo_level_s3c24xx
 #endif
 
 /* include the reset of the code which will do the work */
-- 
1.9.0
