From: jszhang@marvell.com (Jisheng Zhang)
Date: Sat, 19 Sep 2015 18:02:36 +0800
Subject: [PATCH 5/5] arm64: dts: berlin4ct: add the pinctrl node and muxing
 setup for uart0
In-Reply-To: <1442656956-5740-1-git-send-email-jszhang@marvell.com>
References: <1442656956-5740-1-git-send-email-jszhang@marvell.com>
Message-ID: <1442656956-5740-6-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the avio, soc, sm pinctrl nodes for Marvell berlin4ct SoC. This
patch also adds urt0 txd and rxd muxing setup in the dtsi because uart0
always use them to work, no other possibilities.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index a3b5f1d..4566e4e 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
@@ -225,6 +225,16 @@
 			};
 		};
 
+		soc_pinctrl: pinctrl at ea8000 {
+			compatible = "marvell,berlin4ct-soc-pinctrl";
+			reg = <0xea8000 0x14>;
+		};
+
+		avio_pinctrl: pinctrl at ea8400 {
+			compatible = "marvell,berlin4ct-avio-pinctrl";
+			reg = <0xea8400 8>;
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -278,6 +288,23 @@
 				clocks = <&osc>;
 				reg-shift = <2>;
 				status = "disabled";
+				pinctrl-0 = <&urt0_txd_pmux>, <&urt0_rxd_pmux>;
+				pinctrl-names = "default", "default";
+			};
+		};
+
+		sm_pinctrl: pinctrl at fe2200 {
+			compatible = "marvell,berlin4ct-sm-pinctrl";
+			reg = <0xfe2200 0xc>;
+
+			urt0_txd_pmux: urt0_txd-pmux {
+				groups = "SM_URT0_TXD";
+				function = "sm_urt0_txd";
+			};
+
+			urt0_rxd_pmux: urt0_rxd-pmux {
+				groups = "SM_URT0_RXD";
+				function = "sm_urt0_rxd";
 			};
 		};
 	};
-- 
2.5.1
