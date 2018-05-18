From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:22 +0200
Subject: [PATCH 060/102] arm64: dts: renesas: condor: add eMMC support
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <cc9222448a339b62a05bb7cc6f3a091718ff182e.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the Condor board dependent part of the MMC0 (connected to eMMC chip)
device node along with the necessary voltage regulators...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts | 43 +++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
index 7af5afa41795..b8df7604dece 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -27,6 +27,24 @@
 		/* first 128MB is reserved for secure area. */
 		reg = <0 0x48000000 0 0x78000000>;
 	};
+
+	d3_3v: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "D3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vddq_vin01: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDQ_VIN01";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &avb {
@@ -52,12 +70,37 @@
 	clock-frequency = <32768>;
 };
 
+&mmc0 {
+	pinctrl-0 = <&mmc_pins>;
+	pinctrl-1 = <&mmc_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&d3_3v>;
+	vqmmc-supply = <&vddq_vin01>;
+	mmc-hs200-1_8v;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
 &pfc {
 	avb_pins: avb {
 		groups = "avb_mdio", "avb_rgmii";
 		function = "avb";
 	};
 
+	mmc_pins: mmc {
+		groups = "mmc_data8", "mmc_ctrl", "mmc_ds";
+		function = "mmc";
+		power-source = <3300>;
+	};
+
+	mmc_pins_uhs: mmc_uhs {
+		groups = "mmc_data8", "mmc_ctrl", "mmc_ds";
+		function = "mmc";
+		power-source = <1800>;
+	};
+
 	scif0_pins: scif0 {
 		groups = "scif0_data";
 		function = "scif0";
-- 
2.11.0
