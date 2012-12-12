From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Dec 2012 21:45:45 +0800
Subject: [PATCH 4/4] ARM: uncompress: support uncompress debug for
 multiplatform build
In-Reply-To: <1355319945-3199-1-git-send-email-shawn.guo@linaro.org>
References: <1355319945-3199-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1355319945-3199-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When moving to multiplatform build, platforms lose the output from
decompressor.  Not only does it mean that we will never see message
"Uncompressing Linux... done, booting the kernel.", but also that
the debug facility in arch/arm/boot/compressed/head.S outputs nothing
even DEBUG is turned on.

The patch follows the approach handling DEBUG_LL to create a Kconfig
symbol CONFIG_UNCOMPRESS_INCLUDE for choosing the correct uncompress
header.  For traditional build, mach/uncompress.h will be included in
arch/arm/boot/compressed/misc.c.  For multiplatform build with none
DEBUG_LL port enabled, debug/uncompress/dummy.h will be used.  And
for multiplatform build with a DEBUG_LL port, platform specific
uncompress header like debug/uncompress/imx.h will come to play.

Different from traditional build that uncompress output and DEBUG_LL
are two separated pieces, for multiplatform build uncompress output
becomes a subset of DEBUG_LL and will not work unless DEBUG_LL is
enabled.

The arch/arm/include/debug/uncompress/imx.h is cleaned up and added
here as an example to show how this approach works.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig.debug                    |   13 +++++
 arch/arm/boot/compressed/misc.c           |    8 +--
 arch/arm/include/debug/uncompress/dummy.h |    3 ++
 arch/arm/include/debug/uncompress/imx.h   |   75 ++---------------------------
 4 files changed, 20 insertions(+), 79 deletions(-)
 create mode 100644 arch/arm/include/debug/uncompress/dummy.h

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 05f83c8..3cb7a98 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -523,6 +523,19 @@ config DEBUG_LL_INCLUDE
 	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
 	default "mach/debug-macro.S"
 
+config UNCOMPRESS_INCLUDE
+	string
+	default "debug/uncompress/imx.h" if DEBUG_IMX1_UART || \
+					    DEBUG_IMX25_UART || \
+					    DEBUG_IMX21_IMX27_UART || \
+					    DEBUG_IMX31_UART || \
+					    DEBUG_IMX35_UART || \
+					    DEBUG_IMX51_UART || \
+					    DEBUG_IMX50_IMX53_UART || \
+					    DEBUG_IMX6Q_UART
+	default "debug/uncompress/dummy.h" if ARCH_MULTIPLATFORM
+	default "mach/uncompress.h"
+
 config EARLY_PRINTK
 	bool "Early printk"
 	depends on DEBUG_LL
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index df89983..31bd43b 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -25,13 +25,7 @@ unsigned int __machine_arch_type;
 static void putstr(const char *ptr);
 extern void error(char *x);
 
-#ifdef CONFIG_ARCH_MULTIPLATFORM
-static inline void putc(int c) {}
-static inline void flush(void) {}
-static inline void arch_decomp_setup(void) {}
-#else
-#include <mach/uncompress.h>
-#endif
+#include CONFIG_UNCOMPRESS_INCLUDE
 
 #ifdef CONFIG_DEBUG_ICEDCC
 
diff --git a/arch/arm/include/debug/uncompress/dummy.h b/arch/arm/include/debug/uncompress/dummy.h
new file mode 100644
index 0000000..e19955d
--- /dev/null
+++ b/arch/arm/include/debug/uncompress/dummy.h
@@ -0,0 +1,3 @@
+static inline void putc(int c) {}
+static inline void flush(void) {}
+static inline void arch_decomp_setup(void) {}
diff --git a/arch/arm/include/debug/uncompress/imx.h b/arch/arm/include/debug/uncompress/imx.h
index 477971b..7c5ad5d 100644
--- a/arch/arm/include/debug/uncompress/imx.h
+++ b/arch/arm/include/debug/uncompress/imx.h
@@ -17,9 +17,7 @@
 #ifndef __ASM_ARCH_MXC_UNCOMPRESS_H__
 #define __ASM_ARCH_MXC_UNCOMPRESS_H__
 
-#define __MXC_BOOT_UNCOMPRESS
-
-#include <asm/mach-types.h>
+#include "../imx-uart.h"
 
 unsigned long uart_base;
 
@@ -57,76 +55,9 @@ static inline void flush(void)
 {
 }
 
-#define MX1_UART1_BASE_ADDR	0x00206000
-#define MX25_UART1_BASE_ADDR	0x43f90000
-#define MX2X_UART1_BASE_ADDR	0x1000a000
-#define MX3X_UART1_BASE_ADDR	0x43F90000
-#define MX3X_UART2_BASE_ADDR	0x43F94000
-#define MX3X_UART5_BASE_ADDR	0x43FB4000
-#define MX51_UART1_BASE_ADDR	0x73fbc000
-#define MX50_UART1_BASE_ADDR	0x53fbc000
-#define MX53_UART1_BASE_ADDR	0x53fbc000
-
-static __inline__ void __arch_decomp_setup(unsigned long arch_id)
+static inline void arch_decomp_setup(void)
 {
-	switch (arch_id) {
-	case MACH_TYPE_MX1ADS:
-	case MACH_TYPE_SCB9328:
-		uart_base = MX1_UART1_BASE_ADDR;
-		break;
-	case MACH_TYPE_MX25_3DS:
-		uart_base = MX25_UART1_BASE_ADDR;
-		break;
-	case MACH_TYPE_IMX27LITE:
-	case MACH_TYPE_MX27_3DS:
-	case MACH_TYPE_MX27ADS:
-	case MACH_TYPE_PCM038:
-	case MACH_TYPE_MX21ADS:
-	case MACH_TYPE_PCA100:
-	case MACH_TYPE_MXT_TD60:
-	case MACH_TYPE_IMX27IPCAM:
-		uart_base = MX2X_UART1_BASE_ADDR;
-		break;
-	case MACH_TYPE_MX31LITE:
-	case MACH_TYPE_ARMADILLO5X0:
-	case MACH_TYPE_MX31MOBOARD:
-	case MACH_TYPE_QONG:
-	case MACH_TYPE_MX31_3DS:
-	case MACH_TYPE_PCM037:
-	case MACH_TYPE_MX31ADS:
-	case MACH_TYPE_MX35_3DS:
-	case MACH_TYPE_PCM043:
-	case MACH_TYPE_LILLY1131:
-	case MACH_TYPE_VPR200:
-	case MACH_TYPE_EUKREA_CPUIMX35SD:
-		uart_base = MX3X_UART1_BASE_ADDR;
-		break;
-	case MACH_TYPE_MAGX_ZN5:
-		uart_base = MX3X_UART2_BASE_ADDR;
-		break;
-	case MACH_TYPE_BUG:
-		uart_base = MX3X_UART5_BASE_ADDR;
-		break;
-	case MACH_TYPE_MX51_BABBAGE:
-	case MACH_TYPE_EUKREA_CPUIMX51SD:
-	case MACH_TYPE_MX51_3DS:
-		uart_base = MX51_UART1_BASE_ADDR;
-		break;
-	case MACH_TYPE_MX50_RDP:
-		uart_base = MX50_UART1_BASE_ADDR;
-		break;
-	case MACH_TYPE_MX53_EVK:
-	case MACH_TYPE_MX53_LOCO:
-	case MACH_TYPE_MX53_SMD:
-	case MACH_TYPE_MX53_ARD:
-		uart_base = MX53_UART1_BASE_ADDR;
-		break;
-	default:
-		break;
-	}
+	uart_base = UART_PADDR;
 }
 
-#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
-#define arch_decomp_wdog()
-
 #endif				/* __ASM_ARCH_MXC_UNCOMPRESS_H__ */
-- 
1.7.9.5
