From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 17:38:42 +0100
Subject: [PATCH 45/47] ARM: dts: marzen: Add SDHI0 VCCQ Regulator
In-Reply-To: <cover.1521218085.git.horms+renesas@verge.net.au>
References: <cover.1521218085.git.horms+renesas@verge.net.au>
Message-ID: <56bac953b15087dbced6951248ca05a6f0888831.1521218085.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add support for the on-board voltage regulator hooked up to GPIO3_20
on r8a7779 Marzen. The board schematics describes the regulator as U4
TPS2110A. Input wise, U4 has D0 fixed to ground, D1 tied to GPIO3_20
while IN1 is fixed to 3.3V and IN2 is fixed to 1.8V. OUT goes to the
pull-ups for the data pins of SDHI0.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 9412a86f9b30..4b9006bac3cb 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -42,6 +42,19 @@
 		regulator-always-on;
 	};
 
+	vccq_sdhi0: regulator-vccq-sdhi0 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
+
 	ethernet at 18000000 {
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x18000000 0x100>;
@@ -243,6 +256,7 @@
 	pinctrl-names = "default";
 
 	vmmc-supply = <&fixedregulator3v3>;
+	vqmmc-supply = <&vccq_sdhi0>;
 	bus-width = <4>;
 	status = "okay";
 };
-- 
2.11.0
