From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jul 2018 14:06:25 +0200
Subject: [PATCH 7/8] ARM: dts: gr-peach: Add GR-Peach audiocamerashield support
In-Reply-To: <cover.1532345886.git.horms+renesas@verge.net.au>
References: <cover.1532345886.git.horms+renesas@verge.net.au>
Message-ID: <c85aabb841f5ed544b492544e8280f2a9c1cc647.1532345886.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Add device tree header for GR-Peach's audiocamerashield with MT9V111
image sensor.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/gr-peach-audiocamerashield.dtsi | 79 +++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 arch/arm/boot/dts/gr-peach-audiocamerashield.dtsi

diff --git a/arch/arm/boot/dts/gr-peach-audiocamerashield.dtsi b/arch/arm/boot/dts/gr-peach-audiocamerashield.dtsi
new file mode 100644
index 000000000000..e31a9e3c18a2
--- /dev/null
+++ b/arch/arm/boot/dts/gr-peach-audiocamerashield.dtsi
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the GR-Peach audiocamera shield expansion board
+ *
+ * Copyright (C) 2017 Jacopo Mondi <jacopo+renesas@jmondi.org>
+ */
+
+#include "r7s72100.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/r7s72100-pinctrl.h>
+
+/ {
+	/* On-board camera clock. */
+	camera_clk: camera_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <27000000>;
+	};
+};
+
+&pinctrl {
+	i2c1_pins: i2c1 {
+		/* P1_2 as SCL; P1_3 as SDA */
+		pinmux = <RZA1_PINMUX(1, 2, 1)>, <RZA1_PINMUX(1, 3, 1)>;
+	};
+
+	vio_pins: vio {
+		/* CEU pins: VIO_D[0-10], VIO_VD, VIO_HD, VIO_CLK */
+		pinmux = <RZA1_PINMUX(1, 0, 5)>, /* VIO_VD */
+			 <RZA1_PINMUX(1, 1, 5)>, /* VIO_HD */
+			 <RZA1_PINMUX(2, 0, 7)>, /* VIO_D0 */
+			 <RZA1_PINMUX(2, 1, 7)>, /* VIO_D1 */
+			 <RZA1_PINMUX(2, 2, 7)>, /* VIO_D2 */
+			 <RZA1_PINMUX(2, 3, 7)>, /* VIO_D3 */
+			 <RZA1_PINMUX(2, 4, 7)>, /* VIO_D4 */
+			 <RZA1_PINMUX(2, 5, 7)>, /* VIO_D5 */
+			 <RZA1_PINMUX(2, 6, 7)>, /* VIO_D6 */
+			 <RZA1_PINMUX(2, 7, 7)>, /* VIO_D7 */
+			 <RZA1_PINMUX(10, 0, 6)>; /* VIO_CLK */
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	status = "okay";
+	clock-frequency = <100000>;
+
+	camera at 48 {
+		compatible = "aptina,mt9v111";
+		reg = <0x48>;
+
+		clocks = <&camera_clk>;
+
+		port {
+			mt9v111_out: endpoint {
+				remote-endpoint = <&ceu_in>;
+			};
+		};
+	};
+};
+
+&ceu {
+	pinctrl-names = "default";
+	pinctrl-0 = <&vio_pins>;
+
+	status = "okay";
+
+	port {
+		ceu_in: endpoint {
+			hsync-active = <1>;
+			vsync-active = <1>;
+			bus-width = <8>;
+			pclk-sample = <1>;
+			remote-endpoint = <&mt9v111_out>;
+		};
+	};
+};
-- 
2.11.0
