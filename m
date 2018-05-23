From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 23 May 2018 13:43:40 +0200
Subject: [PATCH] ARM: dts: porter: Add missing PMIC nodes
Message-ID: <20180523114340.10216-1-marek.vasut+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PMIC nodes to Porter and connect CPU DVFS supply. There is
one DA9063L and one DA9210 on Porter, the only difference from
the other boards is that DA9063L is at I2C address 0x5a rather
than 0x58 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc at vger.kernel.org
---
 arch/arm/boot/dts/r8a7791-porter.dts | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index a01101b49d99..5f77d73d7462 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -375,10 +375,43 @@
 	clock-frequency = <400000>;
 };
 
+&i2c6 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	pmic at 5a {
+		compatible = "dlg,da9063l";
+		reg = <0x5a>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+
+		wdt {
+			compatible = "dlg,da9063-watchdog";
+		};
+	};
+
+	vdd_dvfs: regulator at 68 {
+		compatible = "dlg,da9210";
+		reg = <0x68>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
 &sata0 {
 	status = "okay";
 };
 
+&cpu0 {
+	cpu0-supply = <&vdd_dvfs>;
+};
+
 /* composite video input */
 &vin0 {
 	status = "okay";
-- 
2.16.2
