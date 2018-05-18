From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:56 +0200
Subject: [PATCH 094/102] arm64: dts: renesas: r8a77990: ebisu: Enable
 EthernetAVB
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <8441ef643d7dc8b4df85cbd7d8b99efc08ec00f3.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch enables EthernetAVB for r8a77990 Ebisu board.

Based on a patch from Takeshi Kihara <takeshi.kihara.df@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index 63ee1347bb19..7a09d0524f9b 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 #include "r8a77990.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Renesas Ebisu board based on r8a77990";
@@ -14,6 +15,7 @@
 
 	aliases {
 		serial0 = &scif2;
+		ethernet0 = &avb;
 	};
 
 	chosen {
@@ -28,10 +30,36 @@
 	};
 };
 
+&avb {
+	pinctrl-0 = <&avb_pins>;
+	pinctrl-names = "default";
+	renesas,no-ether-link;
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-txid";
+	status = "okay";
+
+	phy0: ethernet-phy at 0 {
+		rxc-skew-ps = <1500>;
+		reg = <0>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
+	};
+};
+
 &extal_clk {
 	clock-frequency = <48000000>;
 };
 
+&pfc {
+	avb_pins: avb {
+		mux {
+			groups = "avb_link", "avb_mii";
+			function = "avb";
+		};
+	};
+};
+
 &scif2 {
 	status = "okay";
 };
-- 
2.11.0
