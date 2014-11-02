From: romain.perier@gmail.com (Romain Perier)
Date: Sun,  2 Nov 2014 10:20:01 +0000
Subject: [PATCH v3 2/2] ARM: dts: rockchip: Add devicetree source for
 MarsBoard RK3066
In-Reply-To: <1414923601-29504-1-git-send-email-romain.perier@gmail.com>
References: <1414923601-29504-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1414923601-29504-3-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds initial support for the Marsboard RK3066. It enables
EMAC Rockchip which is the ethernet support on the board and registers
it as a supported rockchip platform.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3066a-marsboard.dts            | 197 +++++++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3066a-marsboard.dts

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 857f126..eaa3d1a 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -1,6 +1,10 @@
 Rockchip platforms device tree bindings
 ---------------------------------------
 
+- MarsBoard RK3066 board:
+    Required root node properties:
+      - compatible = "haoyu,marsboard-rk3066", "rockchip,rk3066a";
+
 - bq Curie 2 tablet:
     Required root node properties:
       - compatible = "mundoreader,bq-curie2", "rockchip,rk3066a";
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 472c1c3..513b384 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -365,6 +365,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8960-cdp.dtb \
 	qcom-msm8974-sony-xperia-honami.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
+	rk3066a-marsboard.dtb \
 	rk3066a-bqcurie2.dtb \
 	rk3188-radxarock.dtb \
 	rk3288-evb-act8846.dtb \
diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts b/arch/arm/boot/dts/rk3066a-marsboard.dts
new file mode 100644
index 0000000..72f498f
--- /dev/null
+++ b/arch/arm/boot/dts/rk3066a-marsboard.dts
@@ -0,0 +1,197 @@
+/*
+ * Copyright (c) 2014 Romain Perier <romain.perier@gmail.com>
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
+ *     You should have received a copy of the GNU General Public
+ *     License along with this file; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
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
+/dts-v1/;
+#include "rk3066a.dtsi"
+
+/ {
+	model = "MarsBoard RK3066";
+	compatible = "haoyu,marsboard-rk3066", "rockchip,rk3066a";
+
+	memory {
+		reg = <0x60000000 0x40000000>;
+	};
+
+	vcc_sd0: fixed-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "sdmmc-supply";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_LOW>;
+		startup-delay-us = <100000>;
+		vin-supply = <&vcc_io>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	tps: tps at 2d {
+		reg = <0x2d>;
+
+		interrupt-parent = <&gpio6>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+
+		vcc5-supply = <&vcc_io>;
+		vcc6-supply = <&vcc_io>;
+
+		regulators {
+			vcc_rtc: regulator at 0 {
+				regulator-name = "vcc_rtc";
+				regulator-always-on;
+			};
+
+			vcc_io: regulator at 1 {
+				regulator-name = "vcc_io";
+				regulator-always-on;
+			};
+
+			vdd_arm: regulator at 2 {
+				regulator-name = "vdd_arm";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vcc_ddr: regulator at 3 {
+				regulator-name = "vcc_ddr";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vcc18_cif: regulator at 5 {
+				regulator-name = "vcc18_cif";
+				regulator-always-on;
+			};
+
+			vdd_11: regulator at 6 {
+				regulator-name = "vdd_11";
+				regulator-always-on;
+			};
+
+			vcc_25: regulator at 7 {
+				regulator-name = "vcc_25";
+				regulator-always-on;
+			};
+
+			vcc_18: regulator at 8 {
+				regulator-name = "vcc_18";
+				regulator-always-on;
+			};
+
+			vcc25_hdmi: regulator at 9 {
+				regulator-name = "vcc25_hdmi";
+				regulator-always-on;
+			};
+
+			vcca_33: regulator at 10 {
+				regulator-name = "vcca_33";
+				regulator-always-on;
+			};
+
+			vcc_rmii: regulator at 11 {
+				regulator-name = "vcc_rmii";
+			};
+
+			vcc28_cif: regulator at 12 {
+				regulator-name = "vcc28_cif";
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+/* must be included after &tps gets defined */
+#include "tps65910.dtsi"
+
+&emac {
+	status = "okay";
+
+	phy = <&phy0>;
+	phy-supply = <&vcc_rmii>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_xfer>, <&emac_mdio>, <&phy_int>;
+
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&pinctrl {
+	lan8720a {
+		phy_int: phy-int {
+			rockchip,pins = <RK_GPIO1 26 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
-- 
1.9.1
