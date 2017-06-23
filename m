From: briannorris@chromium.org (Brian Norris)
Date: Fri, 23 Jun 2017 10:07:36 -0700
Subject: [PATCH 2/3] arm64: dts: rockchip: Use vctrl regulators for dynamic
 CPU voltages on Gru/Kevin
In-Reply-To: <20170623170737.46265-1-briannorris@chromium.org>
References: <20170623170737.46265-1-briannorris@chromium.org>
Message-ID: <20170623170737.46265-2-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Kaehlcke <mka@chromium.org>

The Gru device tree currently contains entries for the regulators
ppvar_bigcpu, ppvar_litcpu, ppvar_gpu and ppvar_centerlogic; however,
the regulators have not been made, due to the lack of binding and driver
support for keeping the over-voltage protection (OVP) at bay and
preventing unintended regulator shutdowns on voltage downshifts.

Now, the vctrl regulator driver has been merged, along with new bindings
for asymmetric settling time. The driver is OVP aware, it splits larger
voltage decreases in multiple steps when necessary and adds required
delays.

This change renames each of the aforementioned regulators to
<orig_name>_pwm and adds a new vctrl regulator named <orig_name>.
The vctrl regulators use the voltage of their corresponding PWM regulator
as control voltage. The OVP related values are empirical and stem from
the Chrome OS kernel tree.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts |  24 +++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi      | 104 ++++++++++++++++------
 2 files changed, 100 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 658d63db0d6d..f86bd41be9c0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -264,24 +264,48 @@ ap_i2c_dig: &i2c2 {
 	};
 };
 
+&ppvar_bigcpu_pwm {
+	regulator-min-microvolt = <798674>;
+	regulator-max-microvolt = <1302172>;
+};
+
 &ppvar_bigcpu {
 	regulator-min-microvolt = <798674>;
 	regulator-max-microvolt = <1302172>;
+	ctrl-voltage-range = <798674 1302172>;
+};
+
+&ppvar_litcpu_pwm {
+	regulator-min-microvolt = <799065>;
+	regulator-max-microvolt = <1303738>;
 };
 
 &ppvar_litcpu {
 	regulator-min-microvolt = <799065>;
 	regulator-max-microvolt = <1303738>;
+	ctrl-voltage-range = <799065 1303738>;
+};
+
+&ppvar_gpu_pwm {
+	regulator-min-microvolt = <785782>;
+	regulator-max-microvolt = <1217729>;
 };
 
 &ppvar_gpu {
 	regulator-min-microvolt = <785782>;
 	regulator-max-microvolt = <1217729>;
+	ctrl-voltage-range = <785782 1217729>;
+};
+
+&ppvar_centerlogic_pwm {
+	regulator-min-microvolt = <800069>;
+	regulator-max-microvolt = <1049692>;
 };
 
 &ppvar_centerlogic {
 	regulator-min-microvolt = <800069>;
 	regulator-max-microvolt = <1049692>;
+	ctrl-voltage-range = <800069 1049692>;
 };
 
 &saradc {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 134afe8495b5..af51be6d5bed 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -164,14 +164,10 @@
 		vin-supply = <&ppvar_sys>;
 	};
 
-	ppvar_bigcpu: ppvar-bigcpu {
+	ppvar_bigcpu_pwm: ppvar-bigcpu_pwm {
 		compatible = "pwm-regulator";
-		regulator-name = "ppvar_bigcpu";
-		/*
-		 * OVP circuit requires special handling which is not yet
-		 * represented. Keep disabled for now.
-		 */
-		status = "disabled";
+		regulator-name = "ppvar_bigcpu_pwm";
+		status = "okay";
 
 		pwms = <&pwm1 0 3337 0>;
 		pwm-supply = <&ppvar_sys>;
@@ -185,14 +181,26 @@
 		regulator-max-microvolt = <1302232>;
 	};
 
-	ppvar_litcpu: ppvar-litcpu {
+	ppvar_bigcpu: ppvar-bigcpu {
+		compatible = "vctrl-regulator";
+		regulator-name = "ppvar_bigcpu";
+		status = "okay";
+
+		regulator-min-microvolt = <800107>;
+		regulator-max-microvolt = <1302232>;
+
+		ctrl-supply = <&ppvar_bigcpu_pwm>;
+		ctrl-voltage-range = <800107 1302232>;
+
+		regulator-settling-time-up-us = <322>;
+		min-slew-down-rate = <225>;
+		ovp-threshold-percent = <16>;
+	};
+
+	ppvar_litcpu_pwm: ppvar-litcpu_pwm {
 		compatible = "pwm-regulator";
-		regulator-name = "ppvar_litcpu";
-		/*
-		 * OVP circuit requires special handling which is not yet
-		 * represented. Keep disabled for now.
-		 */
-		status = "disabled";
+		regulator-name = "ppvar_litcpu_pwm";
+		status = "okay";
 
 		pwms = <&pwm2 0 3337 0>;
 		pwm-supply = <&ppvar_sys>;
@@ -206,14 +214,26 @@
 		regulator-max-microvolt = <1307837>;
 	};
 
-	ppvar_gpu: ppvar-gpu {
+	ppvar_litcpu: ppvar-litcpu {
+		compatible = "vctrl-regulator";
+		regulator-name = "ppvar_litcpu";
+		status = "okay";
+
+		regulator-min-microvolt = <797743>;
+		regulator-max-microvolt = <1307837>;
+
+		ctrl-supply = <&ppvar_litcpu_pwm>;
+		ctrl-voltage-range = <797743 1307837>;
+
+		regulator-settling-time-up-us = <384>;
+		min-slew-down-rate = <225>;
+		ovp-threshold-percent = <16>;
+	};
+
+	ppvar_gpu_pwm: ppvar-gpu-pwm {
 		compatible = "pwm-regulator";
-		regulator-name = "ppvar_gpu";
-		/*
-		 * OVP circuit requires special handling which is not yet
-		 * represented. Keep disabled for now.
-		 */
-		status = "disabled";
+		regulator-name = "ppvar_gpu_pwm";
+		status = "okay";
 
 		pwms = <&pwm0 0 3337 0>;
 		pwm-supply = <&ppvar_sys>;
@@ -227,14 +247,26 @@
 		regulator-max-microvolt = <1217747>;
 	};
 
-	ppvar_centerlogic: ppvar-centerlogic {
+	ppvar_gpu: ppvar-gpu {
+		compatible = "vctrl-regulator";
+		regulator-name = "ppvar_gpu";
+		status = "okay";
+
+		regulator-min-microvolt = <786384>;
+		regulator-max-microvolt = <1217747>;
+
+		ctrl-supply = <&ppvar_litcpu_pwm>;
+		ctrl-voltage-range = <786384 1217747>;
+
+		regulator-settling-time-up-us = <390>;
+		min-slew-down-rate = <225>;
+		ovp-threshold-percent = <16>;
+	};
+
+	ppvar_centerlogic_pwm: ppvar-centerlogic-pwm {
 		compatible = "pwm-regulator";
-		regulator-name = "ppvar_centerlogic";
-		/*
-		 * OVP circuit requires special handling which is not yet
-		 * represented. Keep disabled for now.
-		 */
-		status = "disabled";
+		regulator-name = "ppvar_centerlogic_pwm";
+		status = "okay";
 
 		pwms = <&pwm3 0 3337 0>;
 		pwm-supply = <&ppvar_sys>;
@@ -248,6 +280,22 @@
 		regulator-max-microvolt = <1049925>;
 	};
 
+	ppvar_centerlogic: ppvar-centerlogic {
+		compatible = "vctrl-regulator";
+		regulator-name = "ppvar_centerlogic";
+		status = "okay";
+
+		regulator-min-microvolt = <799434>;
+		regulator-max-microvolt = <1049925>;
+
+		ctrl-supply = <&ppvar_litcpu_pwm>;
+		ctrl-voltage-range = <799434 1049925>;
+
+		regulator-settling-time-up-us = <378>;
+		min-slew-down-rate = <225>;
+		ovp-threshold-percent = <16>;
+	};
+
 	/* Schematics call this PPVAR even though it's fixed */
 	ppvar_logic: ppvar-logic {
 		compatible = "regulator-fixed";
-- 
2.13.1.611.g7e3b11ae1-goog
