From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 20 Aug 2014 09:24:03 +0900
Subject: [PATCH 12/12] ARM: shmobile: lager: add VIN1/ADV7180 device nodes
In-Reply-To: <cover.1408492753.git.horms+renesas@verge.net.au>
References: <cover.1408492753.git.horms+renesas@verge.net.au>
Message-ID: <d594c9775409a4276133db5e34dbd791329c5eae.1408492753.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Add the Lager board specific device node part for VIN1 (composite video in);
add the device node for Analog Devices ADV7180 video decoder to IIC2 bus.
Add the necessary subnodes to interconnect VIN1 and ADV7180 devices.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[Sergei: rebased, edited changelog and summary]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 856b423..b5f56bc 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -234,6 +234,11 @@
 		renesas,groups = "usb2";
 		renesas,function = "usb2";
 	};
+
+	vin1_pins: vin {
+		renesas,groups = "vin1_data8", "vin1_clk";
+		renesas,function = "vin1";
+	};
 };
 
 &ether {
@@ -366,6 +371,19 @@
 	status = "ok";
 	pinctrl-0 = <&iic2_pins>;
 	pinctrl-names = "default";
+
+	composite-in at 20 {
+		compatible = "adi,adv7180";
+		reg = <0x20>;
+		remote = <&vin1>;
+
+		port {
+			adv7180: endpoint {
+				bus-width = <8>;
+				remote-endpoint = <&vin1ep0>;
+			};
+		};
+	};
 };
 
 &iic3 {
@@ -401,3 +419,21 @@
 	pinctrl-0 = <&usb2_pins>;
 	pinctrl-names = "default";
 };
+
+/* composite video input */
+&vin1 {
+	pinctrl-0 = <&vin1_pins>;
+	pinctrl-names = "default";
+
+	status = "ok";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vin1ep0: endpoint {
+			remote-endpoint = <&adv7180>;
+			bus-width = <8>;
+		};
+	};
+};
-- 
2.0.1
