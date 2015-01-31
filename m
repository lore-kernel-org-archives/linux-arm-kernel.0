From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 31 Jan 2015 17:33:04 +0100
Subject: [PATCH 11/11] ARM: dts: rockchip: add vga encoder and enable lvds on
 rk3288-firefly
In-Reply-To: <1422721984-27782-1-git-send-email-heiko@sntech.de>
References: <1422721984-27782-1-git-send-email-heiko@sntech.de>
Message-ID: <1422721984-27782-12-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the sda7123 simple vga encoder, connect it to the vop outputs
and enable the lvds controller with the correct settings.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index e6f873a..9d383ea 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -159,6 +159,27 @@
 		regulator-always-on;
 		vin-supply = <&vcc_5v>;
 	};
+
+	sda7123: vga-encoder {
+		compatible = "adi,adv7123";
+		ddc-i2c-bus = <&i2c4>;
+		enable-gpio = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+		rockchip,rgb-bridge = <&lvds>;
+		vaa-supply = <&vcc_io>;
+
+		vga_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			vga_in_vopb: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&vopb_out_vga>;
+			};
+			vga_in_vopl: endpoint at 1 {
+				reg = <1>;
+				remote-endpoint = <&vopl_out_vga>;
+			};
+		};
+	};
 };
 
 &cpu0 {
@@ -331,6 +352,16 @@
 	status = "okay";
 };
 
+&lvds {
+	avdd1v0-supply = <&vdd10_lcd>;
+	avdd1v8-supply = <&vcc18_lcd>;
+	avdd3v3-supply = <&vcca_33>;
+	rockchip,data-mapping = "jeida";
+	rockchip,data-width = <24>;
+	rockchip,output = "rgb";
+	status = "okay";
+};
+
 &pinctrl {
 	pcfg_output_high: pcfg-output-high {
 		output-high;
@@ -477,10 +508,24 @@
 	status = "okay";
 };
 
+&vopb_out {
+	vopb_out_vga: endpoint at 9 {
+		reg = <9>;
+		remote-endpoint = <&vga_in_vopb>;
+	};
+};
+
 &vopl {
 	status = "okay";
 };
 
+&vopl_out {
+	vopl_out_vga: endpoint at 9 {
+		reg = <9>;
+		remote-endpoint = <&vga_in_vopl>;
+	};
+};
+
 &vopl_mmu {
 	status = "okay";
 };
-- 
2.1.1
