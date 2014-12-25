From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 25 Dec 2014 16:34:17 +0800
Subject: [PATCH 1/4] ARM: sirf: add two debug ports for CSRatlas7 SoC
In-Reply-To: <1419496460-4929-1-git-send-email-21cnbao@gmail.com>
References: <1419496460-4929-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1419496460-4929-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guo Zeng <Guo.Zeng@csr.com>

this patch adds UART0 and UART1 as LLUART port, as the new atlas7
registers layout are different, it also refines some names of old
hard-coded MARCOs.

Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/Kconfig.debug        | 21 ++++++++++++++++++++-
 arch/arm/include/debug/sirf.S | 37 ++++++++++++++++++++++++-------------
 arch/arm/mach-prima2/lluart.c | 21 ++++++++++++---------
 3 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5ddd490..25d4f6b 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -927,6 +927,22 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the uart1 port on SiRFmarco devices.
 
+        config DEBUG_SIRFATLAS7_UART0
+                bool "Kernel low-level debugging messages via SiRFatlas7 UART0"
+                depends on ARCH_ATLAS7
+                help
+                  Say Y here if you want the debug print routines to direct
+                  their output to the uart0 port on SiRFATLAS7 devices.The uart0
+                  is used on SiRFATLAS7 as a extra debug port.sometimes an extra
+                  debug port can be very useful.
+
+        config DEBUG_SIRFATLAS7_UART1
+                bool "Kernel low-level debugging messages via SiRFatlas7 UART1"
+                depends on ARCH_ATLAS7
+                help
+                  Say Y here if you want the debug print routines to direct
+                  their output to the uart1 port on SiRFATLAS7 devices.
+
 	config STIH41X_DEBUG_ASC2
 		bool "Use StiH415/416 ASC2 UART for low-level debug"
 		depends on ARCH_STI
@@ -1195,7 +1211,10 @@ config DEBUG_LL_INCLUDE
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA4
 	default "debug/s3c24xx.S" if DEBUG_S3C24XX_UART
 	default "debug/s5pv210.S" if DEBUG_S5PV210_UART
-	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
+	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || \
+				  DEBUG_SIRFMARCO_UART1 || \
+				  DEBUG_SIRFATLAS7_UART0 || \
+				  DEBUG_SIRFATLAS7_UART1
 	default "debug/sti.S" if DEBUG_STI_UART
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
 	default "debug/ux500.S" if DEBUG_UX500_UART
diff --git a/arch/arm/include/debug/sirf.S b/arch/arm/include/debug/sirf.S
index dbf250c..38327fa 100644
--- a/arch/arm/include/debug/sirf.S
+++ b/arch/arm/include/debug/sirf.S
@@ -7,36 +7,47 @@
  */
 
 #if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
-#define SIRFSOC_UART1_PA_BASE          0xb0060000
+#define SIRF_LLUART_PA_BASE          0xb0060000
 #elif defined(CONFIG_DEBUG_SIRFMARCO_UART1)
-#define SIRFSOC_UART1_PA_BASE          0xcc060000
+#define SIRF_LLUART_PA_BASE          0xcc060000
+#elif defined(CONFIG_DEBUG_SIRFATLAS7_UART1)
+#define SIRF_LLUART_PA_BASE          0x18020000
+#elif defined(CONFIG_DEBUG_SIRFATLAS7_UART0)
+#define SIRF_LLUART_PA_BASE          0x18010000
 #else
-#define SIRFSOC_UART1_PA_BASE          0
+#define SIRF_LLUART_PA_BASE          0
 #endif
 
-#define SIRFSOC_UART1_VA_BASE		0xFEC60000
+#define SIRF_LLUART_VA_BASE	(0xFEC00000 \
+			| (SIRF_LLUART_PA_BASE & 0x000FFFFF))
 
-#define SIRFSOC_UART_TXFIFO_STATUS	0x0114
-#define SIRFSOC_UART_TXFIFO_DATA	0x0118
+#define SIRF_LLUART_TXFIFO_STATUS	0x0114
+#define SIRF_LLUART_TXFIFO_DATA	0x0118
+
+#define SIRF_LLUART_TXFIFO_FULL                       (1 << 5)
+
+#ifdef CONFIG_DEBUG_SIRFATLAS7_UART0
+#define SIRF_LLUART_TXFIFO_EMPTY			(1 << 8)
+#else
+#define SIRF_LLUART_TXFIFO_EMPTY			(1 << 6)
+#endif
 
-#define SIRFSOC_UART1_TXFIFO_FULL                       (1 << 5)
-#define SIRFSOC_UART1_TXFIFO_EMPTY			(1 << 6)
 
 	.macro	addruart, rp, rv, tmp
-	ldr	\rp, =SIRFSOC_UART1_PA_BASE		@ physical
-	ldr	\rv, =SIRFSOC_UART1_VA_BASE		@ virtual
+	ldr	\rp, =SIRF_LLUART_PA_BASE		@ physical
+	ldr	\rv, =SIRF_LLUART_VA_BASE		@ virtual
 	.endm
 
 	.macro	senduart,rd,rx
-	str	\rd, [\rx, #SIRFSOC_UART_TXFIFO_DATA]
+	str	\rd, [\rx, #SIRF_LLUART_TXFIFO_DATA]
 	.endm
 
 	.macro	busyuart,rd,rx
 	.endm
 
 	.macro	waituart,rd,rx
-1001:	ldr	\rd, [\rx, #SIRFSOC_UART_TXFIFO_STATUS]
-	tst	\rd, #SIRFSOC_UART1_TXFIFO_EMPTY
+1001:	ldr	\rd, [\rx, #SIRF_LLUART_TXFIFO_STATUS]
+	tst	\rd, #SIRF_LLUART_TXFIFO_EMPTY
 	beq	1001b
 	.endm
 
diff --git a/arch/arm/mach-prima2/lluart.c b/arch/arm/mach-prima2/lluart.c
index 99c0c92..c42d69b 100644
--- a/arch/arm/mach-prima2/lluart.c
+++ b/arch/arm/mach-prima2/lluart.c
@@ -12,24 +12,27 @@
 #include "common.h"
 
 #if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
-#define SIRFSOC_UART1_PA_BASE          0xb0060000
+#define SIRF_LLUART_PA_BASE	0xb0060000
 #elif defined(CONFIG_DEBUG_SIRFMARCO_UART1)
-#define SIRFSOC_UART1_PA_BASE          0xcc060000
+#define SIRF_LLUART_PA_BASE	0xcc060000
+#elif defined(CONFIG_DEBUG_SIRFATLAS7_UART1)
+#define SIRF_LLUART_PA_BASE	0x18020000
+#elif defined(CONFIG_DEBUG_SIRFATLAS7_UART0)
+#define SIRF_LLUART_PA_BASE	0x18010000
 #else
-#define SIRFSOC_UART1_PA_BASE          0
+#define SIRF_LLUART_PA_BASE	0
 #endif
 
-#define SIRFSOC_UART1_VA_BASE          SIRFSOC_VA(0x060000)
-#define SIRFSOC_UART1_SIZE		SZ_4K
+#define SIRF_LLUART_VA_BASE	SIRFSOC_VA(SIRF_LLUART_PA_BASE & 0x000FFFFF)
+#define SIRF_LLUART_SIZE		SZ_4K
 
 void __init sirfsoc_map_lluart(void)
 {
 	struct map_desc sirfsoc_lluart_map = {
-		.virtual        = SIRFSOC_UART1_VA_BASE,
-		.pfn            = __phys_to_pfn(SIRFSOC_UART1_PA_BASE),
-		.length         = SIRFSOC_UART1_SIZE,
+		.virtual        = SIRF_LLUART_VA_BASE,
+		.pfn            = __phys_to_pfn(SIRF_LLUART_PA_BASE),
+		.length         = SIRF_LLUART_SIZE,
 		.type           = MT_DEVICE,
 	};
-
 	iotable_init(&sirfsoc_lluart_map, 1);
 }
-- 
2.2.0
