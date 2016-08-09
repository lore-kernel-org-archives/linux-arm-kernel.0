From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  9 Aug 2016 14:19:04 +0200
Subject: [PATCH 2/2] ARM: dts: alt: add MMCIF support
In-Reply-To: <1470745144-5394-1-git-send-email-horms+renesas@verge.net.au>
References: <1470745144-5394-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1470745144-5394-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Alt board dependent part of the MMCIF device node.

Like the Silk the board has eMMC chip along with the  necessary voltage
regulator (note that the Vcc/Vccq regulator is dummy -- it's required by
the MMCIF driver but doesn't actually exist on the board).

Based on work for the Silk board by Vladimir Barinov and Sergei Shtylyov.

Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>.
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index fe7c128cc965..8d1b35afaf82 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -30,6 +30,15 @@
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
+	d3_3v: regulator-d3-3v {
+		compatible = "regulator-fixed";
+		regulator-name = "D3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	vcc_sdhi0: regulator-vcc-sdhi0 {
 		compatible = "regulator-fixed";
 
@@ -190,6 +199,11 @@
 		function = "vin0";
 	};
 
+	mmcif0_pins: mmcif0 {
+		groups = "mmc_data8", "mmc_ctrl";
+		function = "mmc";
+	};
+
 	sdhi0_pins: sd0 {
 		groups = "sdhi0_data4", "sdhi0_ctrl";
 		function = "sdhi0";
@@ -228,6 +242,17 @@
 	};
 };
 
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
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
-- 
2.7.0.rc3.207.g0ac5344
