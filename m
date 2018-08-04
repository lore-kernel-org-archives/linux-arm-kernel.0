From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat,  4 Aug 2018 18:38:18 +0200
Subject: [PATCH V2] ARM: dts: silk: Add DA9063 PMIC node
Message-ID: <20180804163818.23360-1-marek.vasut+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DA9063 PMIC node to the I2C bus.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc at vger.kernel.org
---
V2: - Replace shmobile with dts since it's a DT patch in subject
    - Connect the 9063_IRQ# line to GP3_31
    - Since the DA9063 is connected to both i2c1 and i2c7, connect
      it to i2c7, which is the dedicated dvfs i2c.
---
 arch/arm/boot/dts/r8a7794-silk.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index daec965889d3..6ea60e1faf75 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -405,6 +405,23 @@
 	clock-frequency = <400000>;
 };
 
+&i2c7 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	pmic at 58 {
+		compatible = "dlg,da9063";
+		reg = <0x58>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+
+		wdt {
+			compatible = "dlg,da9063-watchdog";
+		};
+	};
+};
+
 &mmcif0 {
 	pinctrl-0 = <&mmcif0_pins>;
 	pinctrl-names = "default";
-- 
2.16.2
