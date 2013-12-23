From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:08:24 +0900
Subject: [PATCH 2/3] ARM: shmobile: kzm9g: add FSI support for DTS
In-Reply-To: <cover.1387764079.git.horms+renesas@verge.net.au>
References: <cover.1387764079.git.horms+renesas@verge.net.au>
Message-ID: <3c2a87c85391272b098827e432813c9437e93992.1387764079.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch support FSI-AK4648 with simple audio card

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 5bb593d..eb8886b 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -152,6 +152,20 @@
 			label = "SW1";
 		};
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "left_j";
+		simple-audio-card,cpu {
+			sound-dai = <&sh_fsi2 0>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&ak4648>;
+			bitclock-master;
+			frame-master;
+			system-clock-frequency = <11289600>;
+		};
+	};
 };
 
 &i2c0 {
@@ -226,6 +240,12 @@
 			};
 		};
 	};
+
+	ak4648: ak4648 at 0x12 {
+		#sound-dai-cells = <0>;
+		compatible = "asahi-kasei,ak4648";
+		reg = <0x12>;
+	};
 };
 
 &i2c3 {
@@ -289,6 +309,12 @@
 		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
 		renesas,function = "sdhi2";
 	};
+
+	fsia_pins: sounda {
+		renesas,groups = "fsia_mclk_in", "fsia_sclk_in",
+				 "fsia_data_in", "fsia_data_out";
+		renesas,function = "fsia";
+	};
 };
 
 &sdhi0 {
@@ -309,3 +335,10 @@
 	broken-cd;
 	status = "okay";
 };
+
+&sh_fsi2 {
+	pinctrl-0 = <&fsia_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
1.8.4
