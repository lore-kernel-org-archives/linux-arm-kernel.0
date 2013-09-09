From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  8 Sep 2013 22:00:07 -0300
Subject: [PATCH 1/2] ARM: dts: mx6: Add mx6solo support
Message-ID: <1378688408-8689-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Allow booting a device tree kernel on mx6solo.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6s.dtsi   | 82 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/Kconfig      |  4 +--
 arch/arm/mach-imx/mach-imx6q.c |  3 +-
 3 files changed, 86 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6s.dtsi

diff --git a/arch/arm/boot/dts/imx6s.dtsi b/arch/arm/boot/dts/imx6s.dtsi
new file mode 100644
index 0000000..461f44c
--- /dev/null
+++ b/arch/arm/boot/dts/imx6s.dtsi
@@ -0,0 +1,82 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include "imx6dl-pinfunc.h"
+#include "imx6qdl.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	soc {
+		ocram: sram at 00900000 {
+			compatible = "mmio-sram";
+			reg = <0x00900000 0x20000>;
+			clocks = <&clks 142>;
+		};
+
+		aips1: aips-bus at 02000000 {
+			iomuxc: iomuxc at 020e0000 {
+				compatible = "fsl,imx6dl-iomuxc";
+			};
+
+			pxp: pxp at 020f0000 {
+				reg = <0x020f0000 0x4000>;
+				interrupts = <0 98 0x04>;
+			};
+
+			epdc: epdc at 020f4000 {
+				reg = <0x020f4000 0x4000>;
+				interrupts = <0 97 0x04>;
+			};
+
+			lcdif: lcdif at 020f8000 {
+				reg = <0x020f8000 0x4000>;
+				interrupts = <0 39 0x04>;
+			};
+		};
+
+		aips2: aips-bus at 02100000 {
+			i2c4: i2c at 021f8000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx1-i2c";
+				reg = <0x021f8000 0x4000>;
+				interrupts = <0 35 0x04>;
+				status = "disabled";
+			};
+		};
+	};
+};
+
+&ldb {
+	clocks = <&clks 33>, <&clks 34>,
+		 <&clks 39>, <&clks 40>,
+		 <&clks 135>, <&clks 136>;
+	clock-names = "di0_pll", "di1_pll",
+		      "di0_sel", "di1_sel",
+		      "di0", "di1";
+
+	lvds-channel at 0 {
+		crtcs = <&ipu1 0>, <&ipu1 1>;
+	};
+
+	lvds-channel at 1 {
+		crtcs = <&ipu1 0>, <&ipu1 1>;
+	};
+};
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 29a8af6..9d96be8 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -784,7 +784,7 @@ config	SOC_IMX53
 	  This enables support for Freescale i.MX53 processor.
 
 config SOC_IMX6Q
-	bool "i.MX6 Quad/DualLite support"
+	bool "i.MX6 Quad/DualLite/Solo support"
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 	select ARM_ERRATA_754322
@@ -809,7 +809,7 @@ config SOC_IMX6Q
 	select PM_OPP if PM
 
 	help
-	  This enables support for Freescale i.MX6 Quad processor.
+	  This enables support for Freescale i.MX6 Q/DL/S processors.
 
 config SOC_IMX6SL
 	bool "i.MX6 SoloLite support"
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 85a1b51..3d22a6c 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -299,10 +299,11 @@ static void __init imx6q_timer_init(void)
 static const char *imx6q_dt_compat[] __initdata = {
 	"fsl,imx6dl",
 	"fsl,imx6q",
+	"fsl,imx6s",
 	NULL,
 };
 
-DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad/DualLite (Device Tree)")
+DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Q/DL/S (Device Tree)")
 	.smp		= smp_ops(imx_smp_ops),
 	.map_io		= imx6q_map_io,
 	.init_irq	= imx6q_init_irq,
-- 
1.8.1.2
