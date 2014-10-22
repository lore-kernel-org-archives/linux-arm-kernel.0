From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 22 Oct 2014 17:54:23 +0200
Subject: [PATCH v2] ARM: shmobile: Add early debugging support using SCIF(A)
Message-ID: <1413993263-10444-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add serial port debug macros for the SCIF(A) serial ports.
This includes all shmobile SoCs, except for EMEV2.

The configuration logic (both Kconfig and #ifdef) is more complicated than
one would expect, for several reasons:
  1. Not all SoCs have the same serial ports, and they're not always at
     the same addresses.
  2. There are two different types: SCIF and SCIFA. Fortunately they can
     easily be distinguished by physical address.
  3. Not all boards use the same serial port for the console.
     The defaults correspond to the boards that are supported in
     mainline. If you want to use a different serial port, just change
     the value of CONFIG_DEBUG_UART_PHYS, and the rest will auto-adapt.
  4. On SoCs using the legacy machine_desc.map_io(), an identity mapping
     of the SCIF(A) registers must be set up in .map_io(). On all but
     r8a7779 this was already done.
     On other SoCs, debug_ll_io_init() maps the SCIF(A) registers to a
     fixed virtual address. 0xfdxxxxxx was chosen, as it should lie below
     VMALLOC_END = 0xff000000, and must not conflict with the 2 MiB
     reserved region at PCI_IO_VIRT_BASE = 0xfee00000.
     Once all SoCs have migrated away from machine_desc.map_io(), more
     consolidation of DEBUG_<SoC>_<PORT> can be done.

This was derived from the r8a7790 version by Laurent Pinchart.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on r8a7791/koelsch and r8a7740/armadillo.
Testing on other platforms would be highly appreciated.

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

Notes:
  - On armadillo-multiplatform there may be a period while garbage data
    is output.
    This happens because sh_mobile_i2c_init() enables and disables its
    clock during probing. As iic0 and scifa1 share the same parent
    clock, this causes the scifa1 clock to no longer receive clock
    ticks.
    On armadillo-legacy, this is mitigated by the pre-CCF clock driver,
    which never really disables clocks during boot-up for exactly this
    reason. Cfr. "One example of this is the handling of the Mackerel
    serial console output that shares clock with the I2C controller.",
    in commit 794d78fea51504ba ("drivers: sh: late disabling of clocks
    V2").
    I'm wondering whether this can be fixed in the i2c driver? Does it
    really have to enable and disable the clock?
---
 MAINTAINERS                            |  1 +
 arch/arm/Kconfig.debug                 | 67 +++++++++++++++++++++++++++++++++-
 arch/arm/include/debug/renesas-scif.S  | 62 +++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7779.c |  9 +++++
 4 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/debug/renesas-scif.S

diff --git a/MAINTAINERS b/MAINTAINERS
index a20df9bf8ab0efc2..7d843099e9c6de98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1387,6 +1387,7 @@ F:	arch/arm/configs/lager_defconfig
 F:	arch/arm/configs/mackerel_defconfig
 F:	arch/arm/configs/marzen_defconfig
 F:	arch/arm/configs/shmobile_defconfig
+F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
 F:	drivers/sh/
 
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 03dc4c1a8736e78e..1fc7879a7067b229 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -589,6 +589,14 @@ choice
 		  their output to the standard serial port on the RealView
 		  PB1176 platform.
 
+	config DEBUG_RENESAS_SCIF
+		bool "Kernel low-level debugging messages via Renesas SCIF(A)"
+		depends on ARCH_RMOBILE || ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2 || ARCH_R7S72100
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Renesas ARM based platforms using SCIF(A) serial ports
+		  (SH-Mobile, R-Mobile, R-Car Gen1 and Gen2, and RZ/A1H).
+
 	config DEBUG_RK29_UART0
 		bool "Kernel low-level debugging messages via Rockchip RK29 UART0"
 		depends on ARCH_ROCKCHIP
@@ -1039,6 +1047,54 @@ config DEBUG_STI_UART
 	bool
 	depends on ARCH_STI
 
+choice
+	prompt "Renesas SCIF(A) debugging SoC/port"
+	depends on DEBUG_RENESAS_SCIF
+	help
+	  Choose SoC and SCIF(A) debug port combination from the list below.
+
+	  The kernel will most probably only work on the selected SoC.
+	  The selected debug port will be used to provide the default SCIF(A)
+	  physical address; the actual address can still be overridden using
+	  the DEBUG_UART_PHYS option, if needed.
+
+	config DEBUG_R8A73A4_SCIFA0
+		bool "SCIFA0 on R-Mobile APE6 (R8A73A4)"
+		depends on ARCH_R8A73A4
+
+	config DEBUG_R8A7740_SCIFA1
+		bool "SCIFA1 on R-Mobile A1 (R8A7740)"
+		depends on ARCH_R8A7740
+
+	config DEBUG_R8A7778_SCIF0
+		bool "SCIF0 on R-Car M1A (R8A7778)"
+		depends on ARCH_R8A7778
+
+	config DEBUG_R8A7779_SCIF2
+		bool "SCIF2 on R-Car H1 (R8A7779)"
+		depends on ARCH_R8A7779
+
+	config DEBUG_RCAR_GEN2_SCIF0
+		bool "SCIF0 on R-Car H2 (R8A7790), M2-W (R8A7791), or M2-N (R8A7793)"
+		depends on ARCH_R8A7790 || ARCH_R8A7791 || ARCH_R8A7793
+
+	config DEBUG_RCAR_GEN2_SCIF2
+		bool "SCIF2 on R-Car E2 (R8A7794)"
+		depends on ARCH_R8A7794
+
+	config DEBUG_R7S72100_SCIF2
+		bool "SCIF2 on RZ/A1H (R7S72100)"
+		depends on ARCH_R7S72100
+
+	config DEBUG_SH7372_SCIFA0
+		bool "SCIFA0 on SH-Mobile AP4 (SH7372)"
+		depends on ARCH_SH7372
+
+	config DEBUG_SH73A0_SCIFA4
+		bool "SCIFA4 on SH-Mobile AG5 (SH73A0)"
+		depends on ARCH_SH73A0
+endchoice
+
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
@@ -1061,6 +1117,7 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX6SX_UART
 	default "debug/msm.S" if DEBUG_MSM_UART || DEBUG_QCOM_UARTDM
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
+	default "debug/renesas-scif.S" if DEBUG_RENESAS_SCIF
 	default "debug/s3c24xx.S" if DEBUG_S3C24XX_UART
 	default "debug/s5pv210.S" if DEBUG_S5PV210_UART
 	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
@@ -1152,6 +1209,12 @@ config DEBUG_UART_PHYS
 	default 0xd4018000 if DEBUG_MMP_UART3
 	default 0xe0000000 if ARCH_SPEAR13XX
 	default 0xe4007000 if DEBUG_HIP04_UART
+	default 0xe6c40000 if DEBUG_R8A73A4_SCIFA0 || DEBUG_SH7372_SCIFA0
+	default 0xe6c50000 if DEBUG_R8A7740_SCIFA1
+	default 0xe6c80000 if DEBUG_SH73A0_SCIFA4
+	default 0xe6e58000 if DEBUG_RCAR_GEN2_SCIF2
+	default 0xe6e60000 if DEBUG_RCAR_GEN2_SCIF0
+	default 0xe8008000 if DEBUG_R7S72100_SCIF2
 	default 0xf0000be0 if ARCH_EBSA110
 	default 0xf1012000 if DEBUG_MVEBU_UART_ALTERNATE
 	default 0xf1012000 if ARCH_DOVE || ARCH_MV78XX0 || \
@@ -1164,6 +1227,8 @@ config DEBUG_UART_PHYS
 	default 0xff690000 if DEBUG_RK32_UART2
 	default 0xffc02000 if DEBUG_SOCFPGA_UART
 	default 0xffd82340 if ARCH_IOP13XX
+	default 0xffe40000 if DEBUG_R8A7778_SCIF0
+	default 0xffe42000 if DEBUG_R8A7779_SCIF2
 	default 0xfff36000 if DEBUG_HIGHBANK_UART
 	default 0xfffe8600 if DEBUG_UART_BCM63XX
 	default 0xfffff700 if ARCH_IOP33X
@@ -1171,7 +1236,7 @@ config DEBUG_UART_PHYS
 		DEBUG_LL_UART_EFM32 || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
 		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART || \
-		DEBUG_UART_BCM63XX
+		DEBUG_UART_BCM63XX || DEBUG_RENESAS_SCIF
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
diff --git a/arch/arm/include/debug/renesas-scif.S b/arch/arm/include/debug/renesas-scif.S
new file mode 100644
index 0000000000000000..3129d48ba2c79571
--- /dev/null
+++ b/arch/arm/include/debug/renesas-scif.S
@@ -0,0 +1,62 @@
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
+
+#if defined(CONFIG_DEBUG_R8A7740_SCIFA1) || \
+    defined(CONFIG_DEBUG_R8A7779_SCIF2) || \
+    defined(CONFIG_DEBUG_SH7372_SCIFA0) || \
+    defined(CONFIG_DEBUG_SH73A0_SCIFA4)
+/* Legacy machine_desc.map_io() sets up an identity mapping for us */
+#define SCIF_VIRT	SCIF_PHYS
+#else
+/* Relying on debug_ll_io_init(), so we have to select a free gap ourselves */
+#define SCIF_VIRT	((SCIF_PHYS & 0x00ffffff) | 0xfd000000)
+#endif
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
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 136078ab9407cc2d..84e44045fe93a674 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -66,6 +66,15 @@ static struct map_desc r8a7779_io_desc[] __initdata = {
 		.length		= SZ_16M,
 		.type		= MT_DEVICE_NONSHARED
 	},
+#ifdef CONFIG_DEBUG_R8A7779_SCIF2
+	/* 64K entity map for 0xffe40000 (SCIF) */
+	{
+		.virtual	= 0xffe40000,
+		.pfn		= __phys_to_pfn(0xffe40000),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE_NONSHARED
+	},
+#endif /* CONFIG_DEBUG_R8A7779_SCIF2 */
 };
 
 void __init r8a7779_map_io(void)
-- 
1.9.1
