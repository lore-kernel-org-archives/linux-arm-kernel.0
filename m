From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Fri, 13 Oct 2017 18:41:38 +0800
Subject: [RESEND PATCH 2/2] arm64: dts: rockchip: Enable edp disaplay on kevin
In-Reply-To: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
Message-ID: <20171013104138.3216-3-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add edp panel and enable related nodes on kevin.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 29 +++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi      | 16 +++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index a3d3cea7dc4f..bc67b19f0af5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -93,6 +93,18 @@
 		pwm-delay-us = <10000>;
 	};
 
+	edp_panel: edp-panel {
+		compatible = "sharp,lq123p1jx31", "simple-panel";
+		backlight = <&backlight>;
+		power-supply = <&pp3300_disp>;
+
+		ports {
+			panel_in_edp: endpoint {
+				remote-endpoint = <&edp_out_panel>;
+			};
+		};
+	};
+
 	thermistor_ppvar_bigcpu: thermistor-ppvar-bigcpu {
 		compatible = "murata,ncp15wb473";
 		pullup-uv = <1800000>;
@@ -264,6 +276,23 @@ ap_i2c_dig: &i2c2 {
 	};
 };
 
+&edp {
+	status = "okay";
+
+	ports {
+		edp_out: port at 1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			edp_out_panel: endpoint at 0 {
+				reg = <0>;
+				remote-endpoint = <&panel_in_edp>;
+			};
+		};
+	};
+};
+
 &ppvar_bigcpu_pwm {
 	regulator-min-microvolt = <798674>;
 	regulator-max-microvolt = <1302172>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 5772c52fbfd3..470105d651c2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -927,6 +927,22 @@ ap_i2c_audio: &i2c8 {
 	dr_mode = "host";
 };
 
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&vopl {
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};
+
 #include <arm/cros-ec-keyboard.dtsi>
 #include <arm/cros-ec-sbs.dtsi>
 
-- 
2.11.0
