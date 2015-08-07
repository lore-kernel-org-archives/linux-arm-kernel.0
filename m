From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Aug 2015 11:11:31 +0900
Subject: [PATCH 07/10] ARM: shmobile: silk: add eMMC DT support
In-Reply-To: <cover.1438911334.git.horms+renesas@verge.net.au>
References: <cover.1438911334.git.horms+renesas@verge.net.au>
Message-ID: <054531e7a5cb195140bead068b51cc6147c5c8bf.1438911334.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the SILK board dependent part of the MMCIF device node (the board has
eMMC chip) along with the  necessary voltage regulator (note that the Vcc/Vccq
regulator is dummy -- it's required by the MMCIF driver but doesn't actually
exist on the board).

Based on the original patch by Vladimir Barinov
<vladimir.barinov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-silk.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index 79bc64b94456..d4dd5a30ccdf 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -30,6 +30,15 @@
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x40000000>;
 	};
+
+	d3_3v: regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "D3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &extal_clk {
@@ -51,6 +60,11 @@
 		renesas,groups = "intc_irq8";
 		renesas,function = "intc";
 	};
+
+	mmcif0_pins: mmcif0 {
+		renesas,groups = "mmc_data8", "mmc_ctrl";
+		renesas,function = "mmc";
+	};
 };
 
 &scif2 {
@@ -75,3 +89,14 @@
 		micrel,led-mode = <1>;
 	};
 };
+
+&mmcif0 {
+	pinctrl-0 = <&mmcif0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&d3_3v>;
+	vqmmc-supply = <&d3_3v>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
-- 
2.1.4
