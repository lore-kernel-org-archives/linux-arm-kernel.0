From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 28 Jun 2017 17:44:27 +0200
Subject: [PATCH 2/3] arm64: dts: rockchip: Use vctrl regulators for
 dynamic CPU voltages on Gru/Kevin
In-Reply-To: <20170623170737.46265-2-briannorris@chromium.org>
References: <20170623170737.46265-1-briannorris@chromium.org>
 <20170623170737.46265-2-briannorris@chromium.org>
Message-ID: <5828446.D2497T5ZTs@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 23. Juni 2017, 10:07:36 CEST schrieb Brian Norris:
> From: Matthias Kaehlcke <mka@chromium.org>
> 
> The Gru device tree currently contains entries for the regulators
> ppvar_bigcpu, ppvar_litcpu, ppvar_gpu and ppvar_centerlogic; however,
> the regulators have not been made, due to the lack of binding and driver
> support for keeping the over-voltage protection (OVP) at bay and
> preventing unintended regulator shutdowns on voltage downshifts.
> 
> Now, the vctrl regulator driver has been merged, along with new bindings
> for asymmetric settling time. The driver is OVP aware, it splits larger
> voltage decreases in multiple steps when necessary and adds required
> delays.
> 
> This change renames each of the aforementioned regulators to
> <orig_name>_pwm and adds a new vctrl regulator named <orig_name>.
> The vctrl regulators use the voltage of their corresponding PWM regulator
> as control voltage. The OVP related values are empirical and stem from
> the Chrome OS kernel tree.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Running this on Kevin resulted in gpu+centerlogic being
children of litcpu, so applied for 4.14 with the diff below.

Please holler if something looks wrong
Heiko


diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 2f1ba5ba27c8..90259cf63bb6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -164,7 +164,7 @@
 		vin-supply = <&ppvar_sys>;
 	};
 
-	ppvar_bigcpu_pwm: ppvar-bigcpu_pwm {
+	ppvar_bigcpu_pwm: ppvar-bigcpu-pwm {
 		compatible = "pwm-regulator";
 		regulator-name = "ppvar_bigcpu_pwm";
 
@@ -195,7 +195,7 @@
 		ovp-threshold-percent = <16>;
 	};
 
-	ppvar_litcpu_pwm: ppvar-litcpu_pwm {
+	ppvar_litcpu_pwm: ppvar-litcpu-pwm {
 		compatible = "pwm-regulator";
 		regulator-name = "ppvar_litcpu_pwm";
 
@@ -249,7 +249,7 @@
 		regulator-min-microvolt = <786384>;
 		regulator-max-microvolt = <1217747>;
 
-		ctrl-supply = <&ppvar_litcpu_pwm>;
+		ctrl-supply = <&ppvar_gpu_pwm>;
 		ctrl-voltage-range = <786384 1217747>;
 
 		regulator-settling-time-up-us = <390>;
@@ -280,7 +280,7 @@
 		regulator-min-microvolt = <799434>;
 		regulator-max-microvolt = <1049925>;
 
-		ctrl-supply = <&ppvar_litcpu_pwm>;
+		ctrl-supply = <&ppvar_centerlogic_pwm>;
 		ctrl-voltage-range = <799434 1049925>;
 
 		regulator-settling-time-up-us = <378>;
