From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 May 2017 12:30:24 +0200
Subject: [PATCH/RFT renesas-devel] arm64: dts: ulcb: Set drive-strength for
 ravb pins
Message-ID: <1493721024-15042-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EthernetAVB should not depend on the bootloader to setup correct
drive-strength values.  Values for drive-strength where found by
examining the registers after the bootloader has configured the
registers and successfully used the EthernetAVB.

Based on:
* commit 7d73a4da2681 ("arm64: dts: r8a7795: salvator-x: Set drive-strength
  for ravb pins")
* commit 4903987033be ("arm64: dts: r8a7796: salvator-x: Set drive-strength
  for ravb pins")

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
* Compile tested only due to lack of hardware access
---
 arch/arm64/boot/dts/renesas/ulcb.dtsi | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index 7669b282bde2..a38d68c4d9a6 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -199,8 +199,22 @@
 	pinctrl-names = "default";
 
 	avb_pins: avb {
-		groups = "avb_mdc";
-		function = "avb";
+		mux {
+			groups = "avb_link", "avb_phy_int", "avb_mdc",
+				 "avb_mii";
+			function = "avb";
+		};
+
+		pins_mdc {
+			groups = "avb_mdc";
+			drive-strength = <24>;
+		};
+
+		pins_mii_tx {
+			pins = "PIN_AVB_TX_CTL", "PIN_AVB_TXC", "PIN_AVB_TD0",
+			       "PIN_AVB_TD1", "PIN_AVB_TD2", "PIN_AVB_TD3";
+			drive-strength = <12>;
+		};
 	};
 
 	i2c2_pins: i2c2 {
-- 
2.1.4
