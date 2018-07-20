From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:05:09 +0200
Subject: [PATCH 1/9] ARM: dts: porter: Add missing PMIC nodes
In-Reply-To: <cover.1532086734.git.horms+renesas@verge.net.au>
References: <cover.1532086734.git.horms+renesas@verge.net.au>
Message-ID: <5058a96cb7e8dca97629c48084537fe5def8344f.1532086734.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Vasut <marek.vasut@gmail.com>

Add PMIC nodes to Porter and connect CPU DVFS supply. There is
one DA9063L and one DA9210 on Porter, the only difference from
the other boards is that DA9063L is at I2C address 0x5a rather
than 0x58 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
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
2.11.0
