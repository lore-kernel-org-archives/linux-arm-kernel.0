From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 22 Jun 2016 10:16:07 +0800
Subject: [PATCH v2 4/4] ARM: dts: rockchip: add support rk3229 evb board
In-Reply-To: <1466561768-29770-1-git-send-email-zhengxing@rock-chips.com>
References: <1466561768-29770-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1466561768-29770-5-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial release for rk3229 evb board, and turn the GMAC on.


Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v2:
- rename rk3228.dtsi to rk322x.dtsi

 arch/arm/boot/dts/Makefile       |    1 +
 arch/arm/boot/dts/rk3229-evb.dts |   90 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3229.dtsi    |   45 +++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3229-evb.dts
 create mode 100644 arch/arm/boot/dts/rk3229.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 06b6c2d..5e0833f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -602,6 +602,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3066a-rayeager.dtb \
 	rk3188-radxarock.dtb \
 	rk3228-evb.dtb \
+	rk3229-evb.dtb \
 	rk3288-evb-act8846.dtb \
 	rk3288-evb-rk808.dtb \
 	rk3288-firefly-beta.dtb \
diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
new file mode 100644
index 0000000..77a46c7
--- /dev/null
+++ b/arch/arm/boot/dts/rk3229-evb.dts
@@ -0,0 +1,90 @@
+/*
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
+ *  Or, alternatively,
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
+
+#include "rk3229.dtsi"
+
+/ {
+	model = "Rockchip RK3229 Evaluation board";
+	compatible = "rockchip,rk3229-evb", "rockchip,rk3229";
+
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
+	};
+
+	ext_gmac: ext_gmac {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "ext_gmac";
+		#clock-cells = <0>;
+	};
+
+	vcc_phy: vcc-phy-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		regulator-name = "vcc_phy";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&gmac {
+	phy-supply = <&vcc_phy>;
+	phy-mode = "rgmii";
+	clock_in_out = "input";
+	snps,reset-gpio = <&gpio2 24 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 1000000>;
+	assigned-clocks = <&cru SCLK_MAC_EXTCLK>, <&cru SCLK_MAC>;
+	assigned-clock-parents = <&ext_gmac>, <&cru SCLK_MAC_EXTCLK>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	tx_delay = <0x30>;
+	rx_delay = <0x10>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/rk3229.dtsi b/arch/arm/boot/dts/rk3229.dtsi
new file mode 100644
index 0000000..35ca047
--- /dev/null
+++ b/arch/arm/boot/dts/rk3229.dtsi
@@ -0,0 +1,45 @@
+/*
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
+#include "rk322x.dtsi"
+
+/ {
+	compatible = "rockchip,rk3229";
+};
-- 
1.7.9.5
