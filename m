From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 14 Nov 2014 16:49:47 +0100
Subject: [PATCH v4b 2/2] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <1415980187-12683-1-git-send-email-geert+renesas@glider.be>
References: <1415980187-12683-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1415980187-12683-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add serial port debug macros for the SCIF(A) serial ports.
This includes all supported shmobile SoCs, except for EMEV2.

The configuration logic (both Kconfig and #ifdef) is more complicated than
one would expect, for several reasons:
  1. Not all SoCs have the same serial devices, and they're not always
     at the same addresses.
  2. There are two different types: SCIF and SCIFA. Fortunately they can
     easily be distinguished by physical address.
  3. Not all boards use the same serial port for the console.
     The defaults correspond to the boards that are supported in
     mainline. If you want to use a different serial port, just change
     the value of CONFIG_DEBUG_UART_PHYS, and the rest will auto-adapt.
  4. debug_ll_io_init() maps the SCIF(A) registers to a fixed virtual
     address. 0xfdxxxxxx was chosen, as it should lie below VMALLOC_END
     = 0xff000000, and must not conflict with the 2 MiB reserved region
     at PCI_IO_VIRT_BASE = 0xfee00000.
       - On SoCs not using the legacy machine_desc.map_io(),
	 debug_ll_io_init() is called by the ARM core code.
       - On SoCs using the legacy machine_desc.map_io(),
	 debug_ll_io_init() must be called explicitly. Calls are added
	 for r8a7740, r8a7779, sh7372, and sh73a0.

This was derived from the r8a7790 version by Laurent Pinchart.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Tested by me on r8a7791/koelsch (multiplatform), r8a7740/armadillo
(legacy and reference), and sh73a0/kzm9g (legacy, reference, and
multiplatform), also with a multiplatform kernel based on
shmobile_defconfig.
TTBOMK tested by Simon on r8a73a4/ape6evm.

Testing on other platforms would still be appreciated, but I think at
this point it's already better to have it than not to have it, at least
in renesas-devel-*.

v4b:
  - Get rid of the multi-level choice statements,
  - Sort config options by SoC/family,
  - Spelling s/entity/identity/,
  - Add calls to debug_ll_io_init() for r8a7740, r8a7779, sh7372, and
    sh73a0.  This allows to:
      - Drop the identify mapping for SCIF on r8a7779,
      - Use 0xfdxxxxxx as the virtual SCIF address everywhere, i.e. no
	more #ifdefs in renesas-scif.S, and true
	based-by-physical-address configuration,
      - Consolidate Kconfig sections for the same serial port:
          - Merge DEBUG_R8A73A4_SCIFA0 and DEBUG_SH7372_SCIFA0 into
	    DEBUG_RMOBILE_SCIFA0,
	  - Use SoC family-specific prefixes (DEBUG_RMOBILE_* and
	    DEBUG_RCAR_GEN1_*) instead of SoC-specific prefixes where
	    possible, like was done for R-Car Gen2 before.
  - Drop note about garbage output on armadillo-multiplatform, as the
    problem went away after commit b89ff7c3c2dee189 ("ARM: shmobile:
    r8a7740 dtsi: Correct IIC0 parent clock").

v3:
  - Add Acked-by,

v2:
  - Rename CONFIG_DEBUG_SCIF to CONFIG_DEBUG_RENESAS_SCIF,
  - Rename scif.S to renesas-scif.S,
  - Add intermediate DEBUG_<SoC>_<PORT> Kconfig symbols in a Kconfig
    choice statement to select the SoC/port combination for debugging.
    Use these symbols instead of the SoC type to (a) control the
    DEBUG_UART_PHYS defaults, and (b) pick the right virtual address.
    This fixes the case of debugging on an SoC not using
    machine_desc.map_io(), while platform support for any SoC still
    using machine_desc.map_io() is enabled.
  - Protect SCIF mapping on r8a7779 by #ifdef CONFIG_DEBUG_R8A7779_SCIF2,
  - Add renesas-scif.S to the ARM/SHMOBILE section in MAINTAINERS.
---
 MAINTAINERS                            |  1 +
 arch/arm/Kconfig.debug                 | 80 +++++++++++++++++++++++++++++++++-
 arch/arm/include/debug/renesas-scif.S  | 52 ++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c |  1 +
 arch/arm/mach-shmobile/setup-r8a7779.c |  1 +
 arch/arm/mach-shmobile/setup-sh7372.c  |  1 +
 arch/arm/mach-shmobile/setup-sh73a0.c  |  1 +
 7 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/debug/renesas-scif.S

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f08f7959a1eff48..87e9a34bcc82df07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1386,6 +1386,7 @@ F:	arch/arm/configs/lager_defconfig
 F:	arch/arm/configs/mackerel_defconfig
 F:	arch/arm/configs/marzen_defconfig
 F:	arch/arm/configs/shmobile_defconfig
+F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
 F:	drivers/sh/
 
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index d8f6a2ec3d4e065b..4e8fb67ef57b1e3b 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -653,6 +653,64 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on Rockchip RK32xx based platforms.
 
+	config DEBUG_R7S72100_SCIF2
+		bool "Kernel low-level debugging messages via SCIF2 on R7S72100"
+		depends on ARCH_R7S72100
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  via SCIF2 on Renesas RZ/A1H (R7S72100).
+
+	config DEBUG_RCAR_GEN1_SCIF0
+		bool "Kernel low-level debugging messages via SCIF0 on R8A7778"
+		depends on ARCH_R8A7778
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  via SCIF0 on Renesas R-Car M1A (R8A7778).
+
+	config DEBUG_RCAR_GEN1_SCIF2
+		bool "Kernel low-level debugging messages via SCIF2 on R8A7779"
+		depends on ARCH_R8A7779
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  via SCIF2 on Renesas R-Car H1 (R8A7779).
+
+	config DEBUG_RCAR_GEN2_SCIF0
+		bool "Kernel low-level debugging messages via SCIF0 on R8A7790/R8A7791/R8A7793)"
+		depends on ARCH_R8A7790 || ARCH_R8A7791 || ARCH_R8A7793
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  via SCIF0 on Renesas R-Car H2 (R8A7790), M2-W (R8A7791), or
+		  M2-N (R8A7793).
+
+	config DEBUG_RCAR_GEN2_SCIF2
+		bool "Kernel low-level debugging messages via SCIF2 on R8A7794"
+		depends on ARCH_R8A7794
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  via SCIF2 on Renesas R-Car E2 (R8A7794).
+
+	config DEBUG_RMOBILE_SCIFA0
+		bool "Kernel low-level debugging messages via SCIFA0 on R8A73A4/SH7372"
+		depends on ARCH_R8A73A4 || ARCH_SH7372
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  via SCIFA0 on Renesas R-Mobile APE6 (R8A73A4) or SH-Mobile
+		  AP4 (SH7372).
+
+	config DEBUG_RMOBILE_SCIFA1
+		bool "Kernel low-level debugging messages via SCIFA1 on R8A7740"
+		depends on ARCH_R8A7740
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  via SCIFA1 on Renesas R-Mobile A1 (R8A7740).
+
+	config DEBUG_RMOBILE_SCIFA4
+		bool "Kernel low-level debugging messages via SCIFA4 on SH73A0"
+		depends on ARCH_SH73A0
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  via SCIFA4 on Renesas SH-Mobile AG5 (SH73A0).
+
 	config DEBUG_S3C_UART0
 		depends on PLAT_SAMSUNG
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
@@ -1061,6 +1119,14 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX6SX_UART
 	default "debug/msm.S" if DEBUG_MSM_UART || DEBUG_QCOM_UARTDM
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
+	default "debug/renesas-scif.S" if DEBUG_R7S72100_SCIF2
+	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN1_SCIF0
+	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN1_SCIF2
+	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF0
+	default "debug/renesas-scif.S" if DEBUG_RCAR_GEN2_SCIF2
+	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA0
+	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA1
+	default "debug/renesas-scif.S" if DEBUG_RMOBILE_SCIFA4
 	default "debug/s3c24xx.S" if DEBUG_S3C24XX_UART
 	default "debug/s5pv210.S" if DEBUG_S5PV210_UART
 	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
@@ -1152,6 +1218,12 @@ config DEBUG_UART_PHYS
 	default 0xd4018000 if DEBUG_MMP_UART3
 	default 0xe0000000 if ARCH_SPEAR13XX
 	default 0xe4007000 if DEBUG_HIP04_UART
+	default 0xe6c40000 if DEBUG_RMOBILE_SCIFA0
+	default 0xe6c50000 if DEBUG_RMOBILE_SCIFA1
+	default 0xe6c80000 if DEBUG_RMOBILE_SCIFA4
+	default 0xe6e58000 if DEBUG_RCAR_GEN2_SCIF2
+	default 0xe6e60000 if DEBUG_RCAR_GEN2_SCIF0
+	default 0xe8008000 if DEBUG_R7S72100_SCIF2
 	default 0xf0000be0 if ARCH_EBSA110
 	default 0xf1012000 if DEBUG_MVEBU_UART_ALTERNATE
 	default 0xf1012000 if ARCH_DOVE || ARCH_MV78XX0 || \
@@ -1164,13 +1236,19 @@ config DEBUG_UART_PHYS
 	default 0xff690000 if DEBUG_RK32_UART2
 	default 0xffc02000 if DEBUG_SOCFPGA_UART
 	default 0xffd82340 if ARCH_IOP13XX
+	default 0xffe40000 if DEBUG_RCAR_GEN1_SCIF0
+	default 0xffe42000 if DEBUG_RCAR_GEN1_SCIF2
 	default 0xfff36000 if DEBUG_HIGHBANK_UART
 	default 0xfffe8600 if DEBUG_UART_BCM63XX
 	default 0xfffff700 if ARCH_IOP33X
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_LL_UART_EFM32 || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
-		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART || \
+		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_R7S72100_SCIF2 || \
+		DEBUG_RCAR_GEN1_SCIF0 || DEBUG_RCAR_GEN1_SCIF2 || \
+		DEBUG_RCAR_GEN2_SCIF0 || DEBUG_RCAR_GEN2_SCIF2 || \
+		DEBUG_RMOBILE_SCIFA0 || DEBUG_RMOBILE_SCIFA1 || \
+		DEBUG_RMOBILE_SCIFA4 || DEBUG_S3C24XX_UART || \
 		DEBUG_UART_BCM63XX
 
 config DEBUG_UART_VIRT
diff --git a/arch/arm/include/debug/renesas-scif.S b/arch/arm/include/debug/renesas-scif.S
new file mode 100644
index 0000000000000000..97820a8df51ae745
--- /dev/null
+++ b/arch/arm/include/debug/renesas-scif.S
@@ -0,0 +1,52 @@
+/*
+ * Renesas SCIF(A) debugging macro include header
+ *
+ * Based on r8a7790.S
+ *
+ * Copyright (C) 2012-2013 Renesas Electronics Corporation
+ * Copyright (C) 1994-1999 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define SCIF_PHYS	CONFIG_DEBUG_UART_PHYS
+#define SCIF_VIRT	((SCIF_PHYS & 0x00ffffff) | 0xfd000000)
+
+#if CONFIG_DEBUG_UART_PHYS < 0xe6e00000
+/* SCIFA */
+#define FTDR		0x20
+#define FSR		0x14
+#else
+/* SCIF */
+#define FTDR		0x0c
+#define FSR		0x10
+#endif
+
+#define TDFE	(1 << 5)
+#define TEND	(1 << 6)
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =SCIF_PHYS
+	ldr	\rv, =SCIF_VIRT
+	.endm
+
+	.macro	waituart, rd, rx
+1001:	ldrh	\rd, [\rx, #FSR]
+	tst	\rd, #TDFE
+	beq	1001b
+	.endm
+
+	.macro	senduart, rd, rx
+	strb	\rd, [\rx, #FTDR]
+	ldrh	\rd, [\rx, #FSR]
+	bic	\rd, \rd, #TEND
+	strh	\rd, [\rx, #FSR]
+	.endm
+
+	.macro	busyuart, rd, rx
+1001:	ldrh	\rd, [\rx, #FSR]
+	tst	\rd, #TEND
+	beq	1001b
+	.endm
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 248d914592b95ef9..79ad93dfdae4ee70 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -67,6 +67,7 @@ static struct map_desc r8a7740_io_desc[] __initdata = {
 
 void __init r8a7740_map_io(void)
 {
+	debug_ll_io_init();
 	iotable_init(r8a7740_io_desc, ARRAY_SIZE(r8a7740_io_desc));
 }
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index d08e75cceaab3ead..9452dd4ea925a093 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -66,6 +66,7 @@ static struct map_desc r8a7779_io_desc[] __initdata = {
 
 void __init r8a7779_map_io(void)
 {
+	debug_ll_io_init();
 	iotable_init(r8a7779_io_desc, ARRAY_SIZE(r8a7779_io_desc));
 }
 
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 0da61c1c77c15354..68fbae51279d7108 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -56,6 +56,7 @@ static struct map_desc sh7372_io_desc[] __initdata = {
 
 void __init sh7372_map_io(void)
 {
+	debug_ll_io_init();
 	iotable_init(sh7372_io_desc, ARRAY_SIZE(sh7372_io_desc));
 }
 
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 73b25f999a98ab0a..042448440720b998 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -55,6 +55,7 @@ static struct map_desc sh73a0_io_desc[] __initdata = {
 
 void __init sh73a0_map_io(void)
 {
+	debug_ll_io_init();
 	iotable_init(sh73a0_io_desc, ARRAY_SIZE(sh73a0_io_desc));
 }
 
-- 
1.9.1
