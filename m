From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 16 Oct 2018 16:00:20 +0200
Subject: [PATCH] DT: rockchip: Fix stability issues with the 'performance'
 governor on rock960
Message-ID: <1539698431-12616-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the performance governor is set as default, the rock960 hangs
around one minute after booting, whatever the activity is (idle, key
pressed, loaded, ...).

Based on the commit log found at https://patchwork.kernel.org/patch/10092377/

"vdd_log has no consumer and therefore will not be set to a specific
voltage. Still the PWM output pin gets configured and thence the vdd_log
output voltage will changed from it's default. Depending on the idle
state of the PWM this will slightly over or undervoltage the logic supply
of the RK3399 and cause instability with GbE (undervoltage) and PCIe
(overvoltage). Since the default value set by a voltage divider is the
correct supply voltage and we don't need to change it during runtime we
remove the rail from the devicetree completely so the PWM pin will not
be configured."

After removing the vdd-log from the rock960's specific DT, the board
does no longer hang and shows a stable behavior.

Apply the same change for the rock960 by removing the vdd-log from the
DT.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index 6c8c4ab..56abbb0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -57,18 +57,6 @@
 		regulator-always-on;
 		vin-supply = <&vcc_sys>;
 	};
-
-	vdd_log: vdd-log {
-		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 25000 0>;
-		regulator-name = "vdd_log";
-		regulator-min-microvolt = <800000>;
-		regulator-max-microvolt = <1400000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
-	};
-
 };
 
 &cpu_l0 {
-- 
2.7.4
