From: 21cnbao@gmail.com (Barry Song)
Date: Sat,  3 Jan 2015 09:36:44 +0800
Subject: [PATCH V2 6/9] ARM: sirf: add two debug ports for CSRatlas7 SoC
In-Reply-To: <1420249007-8262-1-git-send-email-21cnbao@gmail.com>
References: <1420249007-8262-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1420249007-8262-7-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guo Zeng <Guo.Zeng@csr.com>

this patch adds UART0 and UART1 as LLUART port, as the new atlas7
registers layout are different, it also refines some names of old
hard-coded MARCOs.

this patch also moves to CONFIG_DEBUG_UART_PHYS/DEBUG_UART_VIRT
and debug_ll_io_init().

Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/Kconfig.debug        | 36 +++++++++++++++++++++++++++++++++---
 arch/arm/include/debug/sirf.S | 28 +++++++++++++---------------
 arch/arm/mach-prima2/common.c |  7 -------
 arch/arm/mach-prima2/lluart.c | 33 ---------------------------------
 4 files changed, 46 insertions(+), 58 deletions(-)
 delete mode 100644 arch/arm/mach-prima2/lluart.c

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e0a3cc9..1edfb86 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -916,10 +916,29 @@ choice
 	config DEBUG_SIRFPRIMA2_UART1
 		bool "Kernel low-level debugging messages via SiRFprimaII UART1"
 		depends on ARCH_PRIMA2
+		select DEBUG_SIRFSOC_UART
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the uart1 port on SiRFprimaII devices.
 
+	config DEBUG_SIRFATLAS7_UART0
+		bool "Kernel low-level debugging messages via SiRFatlas7 UART0"
+		depends on ARCH_ATLAS7
+		select DEBUG_SIRFSOC_UART
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the uart0 port on SiRFATLAS7 devices.The uart0
+		  is used on SiRFATLAS7 as a extra debug port.sometimes an extra
+		  debug port can be very useful.
+
+	config DEBUG_SIRFATLAS7_UART1
+		bool "Kernel low-level debugging messages via SiRFatlas7 UART1"
+		depends on ARCH_ATLAS7
+		select DEBUG_SIRFSOC_UART
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the uart1 port on SiRFATLAS7 devices.
+
 	config STIH41X_DEBUG_ASC2
 		bool "Use StiH415/416 ASC2 UART for low-level debug"
 		depends on ARCH_STI
@@ -1154,6 +1173,10 @@ config DEBUG_STI_UART
 	bool
 	depends on ARCH_STI
 
+config DEBUG_SIRFSOC_UART
+	bool
+	depends on ARCH_SIRF
+
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/sa1100.S" if DEBUG_SA1100
@@ -1188,7 +1211,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA4
 	default "debug/s3c24xx.S" if DEBUG_S3C24XX_UART
 	default "debug/s5pv210.S" if DEBUG_S5PV210_UART
-	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1
+	default "debug/sirf.S" if DEBUG_SIRFSOC_UART
 	default "debug/sti.S" if DEBUG_STI_UART
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
 	default "debug/ux500.S" if DEBUG_UX500_UART
@@ -1305,6 +1328,9 @@ config DEBUG_UART_PHYS
 	default 0xfff36000 if DEBUG_HIGHBANK_UART
 	default 0xfffe8600 if DEBUG_UART_BCM63XX
 	default 0xfffff700 if ARCH_IOP33X
+	default 0xb0060000 if DEBUG_SIRFPRIMA2_UART1
+	default 0x18010000 if DEBUG_SIRFATLAS7_UART0
+	default 0x18020000 if DEBUG_SIRFATLAS7_UART1
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_LL_UART_EFM32 || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
@@ -1313,7 +1339,8 @@ config DEBUG_UART_PHYS
 		DEBUG_RCAR_GEN2_SCIF0 || DEBUG_RCAR_GEN2_SCIF2 || \
 		DEBUG_RMOBILE_SCIFA0 || DEBUG_RMOBILE_SCIFA1 || \
 		DEBUG_RMOBILE_SCIFA4 || DEBUG_S3C24XX_UART || \
-		DEBUG_UART_BCM63XX || DEBUG_ASM9260_UART
+		DEBUG_UART_BCM63XX || DEBUG_ASM9260_UART || \
+		DEBUG_SIRFSOC_UART
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
@@ -1387,11 +1414,14 @@ config DEBUG_UART_VIRT
 	default 0xfef36000 if DEBUG_HIGHBANK_UART
 	default 0xfefff700 if ARCH_IOP33X
 	default 0xff003000 if DEBUG_U300_UART
+	default 0xfec60000 if DEBUG_SIRFPRIMA2_UART1
+	default 0xfec10000 if DEBUG_SIRFATLAS7_UART0
+	default 0xfec20000 if DEBUG_SIRFATLAS7_UART1
 	default DEBUG_UART_PHYS if !MMU
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
 		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART || \
-		DEBUG_UART_BCM63XX || DEBUG_ASM9260_UART
+		DEBUG_UART_BCM63XX || DEBUG_ASM9260_UART || DEBUG_SIRFSOC_UART
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
diff --git a/arch/arm/include/debug/sirf.S b/arch/arm/include/debug/sirf.S
index 006ec9f..630f231 100644
--- a/arch/arm/include/debug/sirf.S
+++ b/arch/arm/include/debug/sirf.S
@@ -6,35 +6,33 @@
  * Licensed under GPLv2 or later.
  */
 
-#if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
-#define SIRFSOC_UART1_PA_BASE          0xb0060000
-#else
-#define SIRFSOC_UART1_PA_BASE          0
-#endif
+#define SIRF_LLUART_TXFIFO_STATUS	0x0114
+#define SIRF_LLUART_TXFIFO_DATA	0x0118
 
-#define SIRFSOC_UART1_VA_BASE		0xFEC60000
+#define SIRF_LLUART_TXFIFO_FULL                       (1 << 5)
 
-#define SIRFSOC_UART_TXFIFO_STATUS	0x0114
-#define SIRFSOC_UART_TXFIFO_DATA	0x0118
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
+	ldr	\rp, =CONFIG_DEBUG_UART_PHYS		@ physical
+	ldr	\rv, =CONFIG_DEBUG_UART_VIRT		@ virtual
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
 
diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index a20b8d4..c62ff68 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -20,11 +20,6 @@ static void __init sirfsoc_init_late(void)
 	sirfsoc_pm_init();
 }
 
-static __init void sirfsoc_map_io(void)
-{
-	sirfsoc_map_lluart();
-}
-
 #ifdef CONFIG_ARCH_ATLAS6
 static const char *atlas6_dt_match[] __initconst = {
 	"sirf,atlas6",
@@ -35,7 +30,6 @@ DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
-	.map_io         = sirfsoc_map_io,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = atlas6_dt_match,
 MACHINE_END
@@ -51,7 +45,6 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
-	.map_io         = sirfsoc_map_io,
 	.dma_zone_size	= SZ_256M,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = prima2_dt_match,
diff --git a/arch/arm/mach-prima2/lluart.c b/arch/arm/mach-prima2/lluart.c
deleted file mode 100644
index 20453c1..0000000
--- a/arch/arm/mach-prima2/lluart.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * Static memory mapping for DEBUG_LL
- *
- * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
- */
-
-#include <linux/kernel.h>
-#include <asm/page.h>
-#include <asm/mach/map.h>
-#include "common.h"
-
-#if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
-#define SIRFSOC_UART1_PA_BASE          0xb0060000
-#else
-#define SIRFSOC_UART1_PA_BASE          0
-#endif
-
-#define SIRFSOC_UART1_VA_BASE          SIRFSOC_VA(0x060000)
-#define SIRFSOC_UART1_SIZE		SZ_4K
-
-void __init sirfsoc_map_lluart(void)
-{
-	struct map_desc sirfsoc_lluart_map = {
-		.virtual        = SIRFSOC_UART1_VA_BASE,
-		.pfn            = __phys_to_pfn(SIRFSOC_UART1_PA_BASE),
-		.length         = SIRFSOC_UART1_SIZE,
-		.type           = MT_DEVICE,
-	};
-
-	iotable_init(&sirfsoc_lluart_map, 1);
-}
-- 
2.2.1
