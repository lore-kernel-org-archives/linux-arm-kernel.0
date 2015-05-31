From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 31 May 2015 11:15:07 +0200
Subject: [PATCH v3 3/4] ARM: dts: sun5i: Add A10s and A13 SRAM and SRAM
 controller
In-Reply-To: <1433063708-11726-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1433063708-11726-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1433063708-11726-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10s and A13 have a few SRAM that can be mapped either to a device or
to the CPU, with the mapping being controlled by a SRAM controller.

Add the SRAM controller, the SRAM that it drives and the section that can
be used by the various devices.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  4 ++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  9 +++++++
 arch/arm/boot/dts/sun5i.dtsi                     | 30 ++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 556b2027bbaf..a7e19e4847f7 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -88,6 +88,10 @@
 	status = "okay";
 };
 
+&emac_sram {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 934ecfd145c4..f11efb722bbb 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -125,6 +125,7 @@
 			reg = <0x01c0b000 0x1000>;
 			interrupts = <55>;
 			clocks = <&ahb_gates 17>;
+			allwinner,sram = <&emac_sram 1>;
 			status = "disabled";
 		};
 
@@ -201,3 +202,11 @@
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
+
+&sram_a {
+	emac_sram: sram-section at 8000 {
+		compatible = "allwinner,sun4i-a10-sram-a3-a4";
+		reg = <0x8000 0x4000>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 26095aa97ada..54b097830434 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -299,6 +299,36 @@
 		#size-cells = <1>;
 		ranges;
 
+		sram-controller at 01c00000 {
+			compatible = "allwinner,sun4i-a10-sram-controller";
+			reg = <0x01c00000 0x30>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			sram_a: sram at 00000000 {
+				compatible = "mmio-sram";
+				reg = <0x00000000 0xc000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x00000000 0xc000>;
+			};
+
+			sram_d: sram at 00010000 {
+				compatible = "mmio-sram";
+				reg = <0x00010000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x00010000 0x1000>;
+
+				otg_sram: sram-section at 0000 {
+					compatible = "allwinner,sun4i-a10-sram-d";
+					reg = <0x0000 0x1000>;
+					status = "disabled";
+				};
+			};
+		};
+
 		dma: dma-controller at 01c02000 {
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
-- 
2.4.1
