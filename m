From: romain.perier@collabora.com (Romain Perier)
Date: Wed, 26 Jul 2017 15:55:18 +0200
Subject: [PATCH RESEND v3 3/3] arm: dts: Add support for ES8323 to the
 Firefly-RK3288
In-Reply-To: <20170726135526.475-1-romain.perier@collabora.com>
References: <20170726135526.475-1-romain.perier@collabora.com>
Message-ID: <20170726135526.475-4-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the DT definition of the es8388 i2c device found at
address 0x10. It also adds the definition for connecting the Rockchip
I2S to the es8323 analog output.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 32dabae12e67..24e3fe77bc42 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -116,6 +116,19 @@
 		};
 	};
 
+	sound-i2s {
+		compatible = "rockchip,rk3288-hdmi-analog";
+		pinctrl-names = "default";
+		pinctrl-0 = <&phone_ctl>, <&hp_det>;
+		rockchip,audio-codec = <&es8323>;
+		rockchip,hp-det-gpios = <&gpio7 15 GPIO_ACTIVE_HIGH>;
+		rockchip,hp-en-gpios = <&gpio0 10 GPIO_ACTIVE_HIGH>;
+		rockchip,i2s-controller = <&i2s>;
+		rockchip,model = "I2S";
+		rockchip,routing = "Analog", "LOUT2",
+				   "Analog", "ROUT2";
+	};
+
 	vbat_wl: vcc_sys: vsys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
@@ -389,6 +402,17 @@
 
 &i2c2 {
 	status = "okay";
+
+	es8323: es8323 at 10 {
+		compatible = "everest,es8323", "everest,es8328";
+		reg = <0x10>;
+		AVDD-supply = <&vcca_33>;
+		DVDD-supply = <&vcca_33>;
+		HPVDD-supply = <&vcca_33>;
+		PVDD-supply = <&vcca_33>;
+		clocks = <&cru SCLK_I2S0_OUT>;
+		clock-names = "i2s_clk_out";
+	};
 };
 
 &i2c4 {
@@ -399,6 +423,10 @@
 	status = "okay";
 };
 
+&i2s {
+	status = "okay";
+};
+
 &io_domains {
 	status = "okay";
 
@@ -501,6 +529,16 @@
 		};
 	};
 
+	headphone {
+		hp_det: hp-det {
+			rockchip,pins = <7 15 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		phone_ctl: phone-ctl {
+			rockchip,pins = <0 10 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	usb_host {
 		host_vbus_drv: host-vbus-drv {
 			rockchip,pins = <0 14 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.11.0
