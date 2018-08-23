From: cheat.sc.linux@outlook.com (Maruyama Shohei)
Date: Thu, 23 Aug 2018 17:07:50 +0000
Subject: [PATCH 1/2] arm64: dts: rockchip: fix vcc3v3_sys regulator dependency
 for Firefly-RK3399
Message-ID: <SLXP216MB0543F6A1789AC7DCD505D511D1370@SLXP216MB0543.KORP216.PROD.OUTLOOK.COM>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shohei Maruyama <cheat.sc.linux@outlook.com>

During booting the Firefly-RK3399, the following errors occur many times.

	vcc3v3_sys: unable to resolve supply

vcc3v3_sys depends on vcc_sys, but vcc3v3_sys is described in front of
vcc_sys on the devicetree. Therefore, can't resolve the dependency.
This commit fixes the problem.

Signed-off-by: Shohei Maruyama <cheat.sc.linux@outlook.com>
---
 .../boot/dts/rockchip/rk3399-firefly.dts      | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index a9376a316f63..d124b65dc315 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -193,16 +193,6 @@
 		vin-supply = <&dc_12v>;
 	};
 
-	vcc3v3_sys: vcc3v3-sys {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3_sys";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc_sys>;
-	};
-
 	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
 	vcc5v0_host: vcc5v0-host-regulator {
 		compatible = "regulator-fixed";
@@ -225,6 +215,16 @@
 		vin-supply = <&dc_12v>;
 	};
 
+	vcc3v3_sys: vcc3v3-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_sys>;
+	};
+
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
-- 
2.18.0
