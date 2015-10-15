From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 09:34:15 +0900
Subject: [PATCH 4/7] ARM: shmobile: porter: add VIN0/ADV7180 DT support
In-Reply-To: <cover.1444868963.git.horms+renesas@verge.net.au>
References: <cover.1444868963.git.horms+renesas@verge.net.au>
Message-ID: <778f2e7a7b75e643fb56151797b7d950305b48ea.1444868963.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the  Porter board dependent part of the VIN0 device node.
Add the device node for Analog Devices  ADV7180 video decoder to I2C2 bus.
Add the necessary subnodes to interconnect VIN0 and ADV7180 devices.

This patch is  analogous to the commit 8d62f4f75320 ("ARM: shmobile:
henninger: add VIN0/ADV7180 DT support") as there are no differences
between the boards in this respect.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 03edb8424ef5..b7fa8261e02f 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -114,6 +114,11 @@
 		renesas,groups = "i2c2";
 		renesas,function = "i2c2";
 	};
+
+	vin0_pins: vin0 {
+		renesas,groups = "vin0_data8", "vin0_clk";
+		renesas,function = "vin0";
+	};
 };
 
 &scif0 {
@@ -166,8 +171,38 @@
 
 	status = "okay";
 	clock-frequency = <400000>;
+
+	composite-in at 20 {
+		compatible = "adi,adv7180";
+		reg = <0x20>;
+		remote = <&vin0>;
+
+		port {
+			adv7180: endpoint {
+				bus-width = <8>;
+				remote-endpoint = <&vin0ep>;
+			};
+		};
+	};
 };
 
 &sata0 {
 	status = "okay";
 };
+
+/* composite video input */
+&vin0 {
+	status = "ok";
+	pinctrl-0 = <&vin0_pins>;
+	pinctrl-names = "default";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vin0ep: endpoint {
+			remote-endpoint = <&adv7180>;
+			bus-width = <8>;
+		};
+	};
+};
-- 
2.1.4
