From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Nov 2018 12:25:05 +0100
Subject: [PATCH 3/3] arm64: dts: renesas: condor: switch from EtherAVB to
 GEther
In-Reply-To: <cover.1541514075.git.horms+renesas@verge.net.au>
References: <cover.1541514075.git.horms+renesas@verge.net.au>
Message-ID: <eab53fdfd60a84b0cc514d4f1f5d79226c76df01.1541514075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The "official" Condor boards have always been wired to mount NFS via
GEther, not EtherAVB -- the boards resoldered for EtherAVB were local
to Cogent Embedded, so we've been having an unpleasant situation where
a "normal" Condor board still can't mount NFS (unless an EtherAVB PHY
extension board is plugged in). Switch from EtherAVB to GEther at last!

Fixes: 8091788f3d38 ("arm64: dts: renesas: condor: add EtherAVB support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts | 47 +++++++++++++------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
index fe2e2c051cc9..5a7012be0d6a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -15,7 +15,7 @@
 
 	aliases {
 		serial0 = &scif0;
-		ethernet0 = &avb;
+		ethernet0 = &gether;
 	};
 
 	chosen {
@@ -97,23 +97,6 @@
 	};
 };
 
-&avb {
-	pinctrl-0 = <&avb_pins>;
-	pinctrl-names = "default";
-
-	phy-mode = "rgmii-id";
-	phy-handle = <&phy0>;
-	renesas,no-ether-link;
-	status = "okay";
-
-	phy0: ethernet-phy at 0 {
-		rxc-skew-ps = <1500>;
-		reg = <0>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
-	};
-};
-
 &canfd {
 	pinctrl-0 = <&canfd0_pins>;
 	pinctrl-names = "default";
@@ -139,6 +122,23 @@
 	clock-frequency = <32768>;
 };
 
+&gether {
+	pinctrl-0 = <&gether_pins>;
+	pinctrl-names = "default";
+
+	phy-mode = "rgmii-id";
+	phy-handle = <&phy0>;
+	renesas,no-ether-link;
+	status = "okay";
+
+	phy0: ethernet-phy at 0 {
+		rxc-skew-ps = <1500>;
+		reg = <0>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
 &i2c0 {
 	pinctrl-0 = <&i2c0_pins>;
 	pinctrl-names = "default";
@@ -236,16 +236,17 @@
 };
 
 &pfc {
-	avb_pins: avb {
-		groups = "avb_mdio", "avb_rgmii";
-		function = "avb";
-	};
-
 	canfd0_pins: canfd0 {
 		groups = "canfd0_data_a";
 		function = "canfd0";
 	};
 
+	gether_pins: gether {
+		groups = "gether_mdio_a", "gether_rgmii",
+			 "gether_txcrefclk", "gether_txcrefclk_mega";
+		function = "gether";
+	};
+
 	i2c0_pins: i2c0 {
 		groups = "i2c0";
 		function = "i2c0";
-- 
2.11.0
