From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Wed, 18 Nov 2015 13:51:07 +0100
Subject: [PATCH 2/2] ARM: shmobile: alt: add VIN0, ADV7180 DT support
In-Reply-To: <1447851067-8214-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1447851067-8214-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <1447851067-8214-3-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the device board-dependent part of the VIN0 device and its ADV7180
video decoder on I2C1, and the interconnection between them.

Based on silk patch by Sergei Shtylyov.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 88ed017..fd1cfcd 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -120,6 +120,11 @@
 		renesas,groups = "i2c1";
 		renesas,function = "i2c1";
 	};
+
+	vin0_pins: vin0 {
+		renesas,groups = "vin0_data8", "vin0_clk";
+		renesas,function = "vin0";
+	};
 };
 
 &cmt0 {
@@ -145,6 +150,35 @@
 
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
+};
+
+&vin0 {
+	status = "okay";
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
 };
 
 &scif2 {
-- 
2.6.1
