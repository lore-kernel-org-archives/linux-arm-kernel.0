From: stefan@agner.ch (Stefan Agner)
Date: Sun, 26 Jun 2016 01:47:53 -0700
Subject: [PATCH v2 3/5] ARM: dts: imx7d: recreate imx7d.dtsi with i.MX 7Dual
 specifics
In-Reply-To: <20160626084755.21925-1-stefan@agner.ch>
References: <20160626084755.21925-1-stefan@agner.ch>
Message-ID: <20160626084755.21925-4-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX 7Solo implements a subset of features available on
i.MX 7Dual. Recreate imx7s.dtsi as the base device tree for
i.MX 7Dual boards. The i.MX 7Dual's additional features over
i.MX 7Solo are:
- Second Cortex-A7 core
- Second Gigabit Ethernet controller
- EPD (Electronc Paper Display, not yet part of the device tree)
- PCIe (not yet part of the device tree)
- Additional USB2.0 OTG controller

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts |   2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts   |   2 +-
 arch/arm/boot/dts/imx7d-sdb.dts         |   2 +-
 arch/arm/boot/dts/imx7d.dtsi            | 128 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7s.dtsi            |  79 +-------------------
 5 files changed, 133 insertions(+), 80 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7d.dtsi

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 3942c7d..4863451 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -13,7 +13,7 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
-#include "imx7s.dtsi"
+#include "imx7d.dtsi"
 
 / {
 	model = "CompuLab CL-SOM-iMX7";
diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index 8e993cb..bef394e 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -43,7 +43,7 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
-#include "imx7s.dtsi"
+#include "imx7d.dtsi"
 
 / {
 	model = "Boundary Devices i.MX7 Nitrogen7 Board";
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 1286569..d6da506 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -43,7 +43,7 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
-#include "imx7s.dtsi"
+#include "imx7d.dtsi"
 
 / {
 	model = "Freescale i.MX7 SabreSD Board";
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
new file mode 100644
index 0000000..51c13cb
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -0,0 +1,128 @@
+/*
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ * Copyright 2016 Toradex AG
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "imx7s.dtsi"
+
+/ {
+	cpus {
+		cpu1: cpu at 1 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+	etm at 3007d000 {
+		compatible = "arm,coresight-etm3x", "arm,primecell";
+		reg = <0x3007d000 0x1000>;
+
+		/*
+		 * System will hang if added nosmp in kernel command line
+		 * without arm,primecell-periphid because amba bus try to
+		 * read id and core1 power off at this time.
+		 */
+		arm,primecell-periphid = <0xbb956>;
+		cpu = <&cpu1>;
+		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
+		clock-names = "apb_pclk";
+
+		port {
+			etm1_out_port: endpoint {
+				remote-endpoint = <&ca_funnel_in_port1>;
+			};
+		};
+	};
+};
+
+&aips3 {
+	usbotg2: usb at 30b20000 {
+		compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
+		reg = <0x30b20000 0x200>;
+		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clks IMX7D_USB_CTRL_CLK>;
+		fsl,usbphy = <&usbphynop2>;
+		fsl,usbmisc = <&usbmisc2 0>;
+		phy-clkgate-delay-us = <400>;
+		status = "disabled";
+	};
+
+	usbmisc2: usbmisc at 30b20200 {
+		#index-cells = <1>;
+		compatible = "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
+		reg = <0x30b20200 0x200>;
+	};
+
+	usbphynop2: usbphynop2 {
+		compatible = "usb-nop-xceiv";
+		clocks = <&clks IMX7D_USB_PHY2_CLK>;
+		clock-names = "main_clk";
+	};
+
+	fec2: ethernet at 30bf0000 {
+		compatible = "fsl,imx7d-fec", "fsl,imx6sx-fec";
+		reg = <0x30bf0000 0x10000>;
+		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
+			<&clks IMX7D_ENET_AXI_ROOT_CLK>,
+			<&clks IMX7D_ENET2_TIME_ROOT_CLK>,
+			<&clks IMX7D_PLL_ENET_MAIN_125M_CLK>,
+			<&clks IMX7D_ENET_PHY_REF_ROOT_CLK>;
+		clock-names = "ipg", "ahb", "ptp",
+			"enet_clk_ref", "enet_out";
+		fsl,num-tx-queues=<3>;
+		fsl,num-rx-queues=<3>;
+		status = "disabled";
+	};
+};
+
+&ca_funnel_ports {
+	port at 1 {
+		reg = <1>;
+		ca_funnel_in_port1: endpoint {
+			slave-mode;
+			remote-endpoint = <&etm1_out_port>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index d70d55d..672dde2 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1,5 +1,6 @@
 /*
  * Copyright 2015 Freescale Semiconductor, Inc.
+ * Copyright 2016 Toradex AG
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -87,12 +88,6 @@
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clks IMX7D_CLK_ARM>;
 		};
-
-		cpu1: cpu at 1 {
-			compatible = "arm,cortex-a7";
-			device_type = "cpu";
-			reg = <1>;
-		};
 	};
 
 	intc: interrupt-controller at 31001000 {
@@ -263,7 +258,7 @@
 		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
 		clock-names = "apb_pclk";
 
-		ports {
+		ca_funnel_ports: ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
@@ -276,14 +271,6 @@
 				};
 			};
 
-			port at 1 {
-				reg = <1>;
-				ca_funnel_in_port1: endpoint {
-					slave-mode;
-					remote-endpoint = <&etm1_out_port>;
-				};
-			};
-
 			/* funnel output port */
 			port at 2 {
 				reg = <0>;
@@ -310,27 +297,6 @@
 		};
 	};
 
-	etm at 3007d000 {
-		compatible = "arm,coresight-etm3x", "arm,primecell";
-		reg = <0x3007d000 0x1000>;
-
-		/*
-		 * System will hang if added nosmp in kernel command line
-		 * without arm,primecell-periphid because amba bus try to
-		 * read id and core1 power off at this time.
-		 */
-		arm,primecell-periphid = <0xbb956>;
-		cpu = <&cpu1>;
-		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
-		clock-names = "apb_pclk";
-
-		port {
-			etm1_out_port: endpoint {
-				remote-endpoint = <&ca_funnel_in_port1>;
-			};
-		};
-	};
-
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -819,17 +785,6 @@
 				status = "disabled";
 			};
 
-			usbotg2: usb at 30b20000 {
-				compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
-				reg = <0x30b20000 0x200>;
-				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_USB_CTRL_CLK>;
-				fsl,usbphy = <&usbphynop2>;
-				fsl,usbmisc = <&usbmisc2 0>;
-				phy-clkgate-delay-us = <400>;
-				status = "disabled";
-			};
-
 			usbh: usb at 30b30000 {
 				compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x30b30000 0x200>;
@@ -849,12 +804,6 @@
 				reg = <0x30b10200 0x200>;
 			};
 
-			usbmisc2: usbmisc at 30b20200 {
-				#index-cells = <1>;
-				compatible = "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
-				reg = <0x30b20200 0x200>;
-			};
-
 			usbmisc3: usbmisc at 30b30200 {
 				#index-cells = <1>;
 				compatible = "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
@@ -867,12 +816,6 @@
 				clock-names = "main_clk";
 			};
 
-			usbphynop2: usbphynop2 {
-				compatible = "usb-nop-xceiv";
-				clocks = <&clks IMX7D_USB_PHY2_CLK>;
-				clock-names = "main_clk";
-			};
-
 			usbphynop3: usbphynop3 {
 				compatible = "usb-nop-xceiv";
 				clocks = <&clks IMX7D_USB_HSIC_ROOT_CLK>;
@@ -932,24 +875,6 @@
 				fsl,num-rx-queues=<3>;
 				status = "disabled";
 			};
-
-			fec2: ethernet at 30bf0000 {
-				compatible = "fsl,imx7d-fec", "fsl,imx6sx-fec";
-				reg = <0x30bf0000 0x10000>;
-				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
-					<&clks IMX7D_ENET_AXI_ROOT_CLK>,
-					<&clks IMX7D_ENET2_TIME_ROOT_CLK>,
-					<&clks IMX7D_PLL_ENET_MAIN_125M_CLK>,
-					<&clks IMX7D_ENET_PHY_REF_ROOT_CLK>;
-				clock-names = "ipg", "ahb", "ptp",
-					"enet_clk_ref", "enet_out";
-				fsl,num-tx-queues=<3>;
-				fsl,num-rx-queues=<3>;
-				status = "disabled";
-			};
 		};
 	};
 };
-- 
2.8.3
