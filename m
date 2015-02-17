From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 17 Feb 2015 19:52:08 +0100
Subject: [PATCH 7/8] ARM: dts: dove: Add internal i2c multiplexer node
In-Reply-To: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1424199129-22099-8-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a i2c-mux-pinctrl node to dove.dtsi for the internal i2c
mux found on Dove SoCs. Up to now, we had no board using any of the
two additional i2c busses, so make sure the change does not break
any existing boards.

Therefore, we rename the i2c-controller node label to "i2c" and
enable it by default. Also, the dedicated sub-bus (now "i2c0") is
enabled by default. The two optional sub-busses require additional
external pin-muxing, so disable them by default.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Wolfram,

Actually, I was hoping that default pin hog mechanism
(pinctrl-names = "default") could also be used from i2c mux nodes
and devices. Anyway, I had a look at i2c-core/mux code and failed
how to achieve that easily. Instead I decided, it would also be ok
to put the pin hog into the i2c controller node where pins will be
bound by standard platform device code.

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Gabriel Dobato <dobatog@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-i2c at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove.dtsi | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 9ad829523a13..b3340e862b0e 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -28,6 +28,42 @@
 		};
 	};
 
+	i2c-mux {
+		compatible = "i2c-mux-pinctrl";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c-parent = <&i2c>;
+
+		pinctrl-names = "i2c0", "i2c1", "i2c2";
+		pinctrl-0 = <&pmx_i2cmux_0>;
+		pinctrl-1 = <&pmx_i2cmux_1>;
+		pinctrl-2 = <&pmx_i2cmux_2>;
+
+		i2c0: i2c at 0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "okay";
+		};
+
+		i2c1: i2c at 1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			/* Requires pmx_i2c1 on i2c controller node */
+			status = "disabled";
+		};
+
+		i2c2: i2c at 2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			/* Requires pmx_i2c2 on i2c controller node */
+			status = "disabled";
+		};
+	};
+
 	l2: l2-cache {
 		compatible = "marvell,tauros2-cache";
 		marvell,tauros2-cache-features = <0>;
@@ -123,7 +159,7 @@
 				status = "disabled";
 			};
 
-			i2c0: i2c-ctrl at 11000 {
+			i2c: i2c-ctrl at 11000 {
 				compatible = "marvell,mv64xxx-i2c";
 				reg = <0x11000 0x20>;
 				#address-cells = <1>;
@@ -132,7 +168,7 @@
 				clock-frequency = <400000>;
 				timeout-ms = <1000>;
 				clocks = <&core_clk 0>;
-				status = "disabled";
+				status = "okay";
 			};
 
 			uart0: serial at 12000 {
-- 
2.1.0
