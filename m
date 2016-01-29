From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 11:17:21 +0100
Subject: [PATCH v4 4/9] ARM: dts: koelsch: Enable SCIF_CLK frequency and pins
In-Reply-To: <1454062646-4826-1-git-send-email-geert+renesas@glider.be>
References: <1454062646-4826-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1454062646-4826-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add and enable the external crystal for the SCIF_CLK and its pinctrl, to
be used by the Baud Rate Generator for External Clock (BRG) on (H)SCIF.

This increases the range and accuracy of supported baud rates:
  - SCIF:
      - Supports now 50, 75, 110, 1152000, 1500000, 2000000, and
        4000000 bps,
      - Perfect match for standard 50-460800, and 9216000 bps.
      - More accurate 576000 bps.
  - HSCIF:
      - Supports now 50, 75, 110, 134, 150, and 200 bps,
      - Perfect match for standard 50-460800, and 9216000 bps.
      - More accurate 576000, 1152000, 3000000, 3500000, and 4000000
	bps.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v4:
  - Change one-line summary prefix to match current arm-soc practices,

v3:
  - Add Reviewed-by.
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 45256f3cc83560a8..0ad71b81d3a25f59 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -320,6 +320,9 @@
 };
 
 &pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
 	i2c2_pins: i2c2 {
 		renesas,groups = "i2c2";
 		renesas,function = "i2c2";
@@ -340,6 +343,11 @@
 		renesas,function = "scif1";
 	};
 
+	scif_clk_pins: scif_clk {
+		renesas,groups = "scif_clk";
+		renesas,function = "scif_clk";
+	};
+
 	ether_pins: ether {
 		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
 		renesas,function = "eth";
@@ -440,6 +448,11 @@
 	status = "okay";
 };
 
+&scif_clk {
+	clock-frequency = <14745600>;
+	status = "okay";
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
-- 
1.9.1
