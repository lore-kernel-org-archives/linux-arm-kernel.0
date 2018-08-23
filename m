From: cheat.sc.linux@outlook.com (Maruyama Shohei)
Date: Thu, 23 Aug 2018 17:07:54 +0000
Subject: [PATCH 2/2] arm64: dts: rockchip: fix vcc5v0_host regulator
 dependency for Firefly-RK3399
In-Reply-To: <1dcc0e7d6524fff5d820a58f865da68b94dbc87d.1535044024.git.cheat.sc.linux@outlook.com>
References: <1dcc0e7d6524fff5d820a58f865da68b94dbc87d.1535044024.git.cheat.sc.linux@outlook.com>
Message-ID: <SLXP216MB054387E3FA798EF424559E8AD1370@SLXP216MB0543.KORP216.PROD.OUTLOOK.COM>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shohei Maruyama <cheat.sc.linux@outlook.com>

During booting the Firefly-RK3399, the following errors occur many times.

	vcc5v0_host: unable to resolve supply

vcc5v0_host depends on vcc_sys, but vcc5v0_host is described in front of
vcc_sys on the devicetree. Therefore, can't resolve the dependency.
This commit fixes the problem.

Signed-off-by: Shohei Maruyama <cheat.sc.linux@outlook.com>
---
 .../boot/dts/rockchip/rk3399-firefly.dts      | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index d124b65dc315..ca54390304a7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -193,18 +193,6 @@
 		vin-supply = <&dc_12v>;
 	};
 
-	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
-	vcc5v0_host: vcc5v0-host-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&vcc5v0_host_en>;
-		regulator-name = "vcc5v0_host";
-		regulator-always-on;
-		vin-supply = <&vcc_sys>;
-	};
-
 	vcc_sys: vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
@@ -225,6 +213,18 @@
 		vin-supply = <&vcc_sys>;
 	};
 
+	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
+	vcc5v0_host: vcc5v0-host-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_host_en>;
+		regulator-name = "vcc5v0_host";
+		regulator-always-on;
+		vin-supply = <&vcc_sys>;
+	};
+
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
-- 
2.18.0
