From: nobuhiro.iwamatsu@cybertrust.co.jp (Nobuhiro Iwamatsu)
Date: Mon, 26 Feb 2018 09:59:49 +0900
Subject: [PATCH 2/2] arm: dts: zynq: Extract common Digilent Zybo board support
In-Reply-To: <20180226005949.31259-1-nobuhiro.iwamatsu@cybertrust.co.jp>
References: <20180226005949.31259-1-nobuhiro.iwamatsu@cybertrust.co.jp>
Message-ID: <20180226005949.31259-2-nobuhiro.iwamatsu@cybertrust.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Digilent Zybo and Zybo Z7 boards are very similar.
To avoid duplication, this extract common board parts into own dtsi file.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu@cybertrust.co.jp>
---
 arch/arm/boot/dts/zynq-zybo-common.dtsi | 58 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-zybo-z7.dts      | 45 ++-----------------------
 arch/arm/boot/dts/zynq-zybo.dts         | 43 +-----------------------
 3 files changed, 61 insertions(+), 85 deletions(-)
 create mode 100644 arch/arm/boot/dts/zynq-zybo-common.dtsi

diff --git a/arch/arm/boot/dts/zynq-zybo-common.dtsi b/arch/arm/boot/dts/zynq-zybo-common.dtsi
new file mode 100644
index 000000000000..9c9a92d59cc7
--- /dev/null
+++ b/arch/arm/boot/dts/zynq-zybo-common.dtsi
@@ -0,0 +1,58 @@
+/*
+ *  Copyright (C) 2011 - 2014 Xilinx
+ *  Copyright (C) 2012 National Instruments Corp.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+/dts-v1/;
+#include "zynq-7000.dtsi"
+
+/ {
+	aliases {
+		ethernet0 = &gem0;
+		serial0 = &uart1;
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x20000000>;
+	};
+
+	usb_phy0: phy0 {
+		#phy-cells = <0>;
+		compatible = "usb-nop-xceiv";
+		reset-gpios = <&gpio0 46 1>;
+	};
+};
+
+&gem0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy>;
+
+	ethernet_phy: ethernet-phy at 0 {
+		reg = <0>;
+		device_type = "ethernet-phy";
+	};
+};
+
+&sdhci0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+	usb-phy = <&usb_phy0>;
+};
diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
index 97e487913f8f..bd94147792cd 100644
--- a/arch/arm/boot/dts/zynq-zybo-z7.dts
+++ b/arch/arm/boot/dts/zynq-zybo-z7.dts
@@ -7,59 +7,18 @@
  *  SPDX-License-Identifier:	GPL-2.0+
  */
 /dts-v1/;
-#include "zynq-7000.dtsi"
+#include "zynq-zybo-common.dtsi"
 
 / {
-	model = "Zynq ZYBO Z7 Development Board";
+	model = "Zynq Zybo Z7 Development Board";
 	compatible = "digilent,zynq-zybo-z7", "xlnx,zynq-7000";
 
-	aliases {
-		ethernet0 = &gem0;
-		serial0 = &uart1;
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x0 0x20000000>;
-	};
-
 	chosen {
 		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
-
-	usb_phy0: phy0 {
-		#phy-cells = <0>;
-		compatible = "usb-nop-xceiv";
-		reset-gpios = <&gpio0 46 1>;
-	};
 };
 
 &clkc {
 	ps-clk-frequency = <33333333>;
 };
-
-&gem0 {
-	status = "okay";
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethernet_phy>;
-
-	ethernet_phy: ethernet-phy at 0 {
-		reg = <0>;
-		device_type = "ethernet-phy";
-	};
-};
-
-&sdhci0 {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-	dr_mode = "host";
-	usb-phy = <&usb_phy0>;
-};
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index e40cafc5ee5b..920294f41aff 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -12,59 +12,18 @@
  * GNU General Public License for more details.
  */
 /dts-v1/;
-#include "zynq-7000.dtsi"
+#include "zynq-zybo-common.dtsi"
 
 / {
 	model = "Zynq ZYBO Development Board";
 	compatible = "digilent,zynq-zybo", "xlnx,zynq-7000";
 
-	aliases {
-		ethernet0 = &gem0;
-		serial0 = &uart1;
-	};
-
-	memory at 0 {
-		device_type = "memory";
-		reg = <0x0 0x20000000>;
-	};
-
 	chosen {
 		bootargs = "";
 		stdout-path = "serial0:115200n8";
 	};
-
-	usb_phy0: phy0 {
-		#phy-cells = <0>;
-		compatible = "usb-nop-xceiv";
-		reset-gpios = <&gpio0 46 1>;
-	};
 };
 
 &clkc {
 	ps-clk-frequency = <50000000>;
 };
-
-&gem0 {
-	status = "okay";
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethernet_phy>;
-
-	ethernet_phy: ethernet-phy at 0 {
-		reg = <0>;
-		device_type = "ethernet-phy";
-	};
-};
-
-&sdhci0 {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-	dr_mode = "host";
-	usb-phy = <&usb_phy0>;
-};
-- 
2.16.1
