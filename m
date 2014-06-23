From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:28:17 +0900
Subject: [PATCH 08/29] ARM: shmobile: koelsch dts: Add VDD MPU regulator for
 DVFS
In-Reply-To: <cover.1403487225.git.horms+renesas@verge.net.au>
References: <cover.1403487225.git.horms+renesas@verge.net.au>
Message-ID: <1d41f36a68c0f4e9b01d563ce33bab5201858b54.1403487225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

The CA15 cluster is capable of voltage scaling. Add the regulator
in the i2c6 node, to allow the generic CPUFreq driver to use it.

Enable the i2c6 pin mux and the device node as well since the
da9210 is connected to that bus.

Note: In R-CAR Gen2, each frequency is using the same voltage,
and DVS control is not used. Therefore, this patch set the
voltage(Vmin/Vmax) to 1000mv.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 05d44f9..95331d7 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -293,6 +293,11 @@
 				 "msiof0_tx";
 		renesas,function = "msiof0";
 	};
+
+	i2c6_pins: i2c6 {
+		renesas,groups = "i2c6";
+		renesas,function = "i2c6";
+	};
 };
 
 &ether {
@@ -408,3 +413,19 @@
 		spi-cpha;
 	};
 };
+
+&i2c6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c6_pins>;
+	status = "okay";
+
+	vdd_dvfs: regulator at 68 {
+		compatible = "diasemi,da9210";
+		reg = <0x68>;
+
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
-- 
2.0.0.rc2
