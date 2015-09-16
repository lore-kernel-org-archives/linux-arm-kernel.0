From: plaes@plaes.org (Priit Laes)
Date: Wed, 16 Sep 2015 10:59:39 +0300
Subject: [PATCH 3/4] ARM: dts: sun4i: gemei-g9: Enable NAND Flash controller
 on Gemei G9
In-Reply-To: <1442390380-1406-1-git-send-email-plaes@plaes.org>
References: <1442390380-1406-1-git-send-email-plaes@plaes.org>
Message-ID: <1442390380-1406-3-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 62 +++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index aafe771..0959c45 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -67,7 +67,6 @@
  *   2x cameras via CSI
  *   audio
  *   AXP battery management
- *   NAND
  *   OTG
  *   Touchscreen - gt801_2plus1 @ i2c adapter 2 @ 0x48
  */
@@ -153,6 +152,67 @@
 	status = "okay";
 };
 
+&nfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nand_pins_a &nand_cs0_pins_a &nand_rb0_pins_a>;
+	status = "okay";
+
+	nand at 0 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0>;
+		allwinner,rb = <0>;
+
+		nand-ecc-mode = "hw";
+		nand-rnd-mode = "hw";
+		nand-on-flash-bbt;
+
+		boot0 at 0 {
+			label = "boot0";
+			reg = /bits/ 64 <0x0 0x200000>;
+			nand-ecc-mode = "hw_syndrome";
+			nand-rnd-mode = "hw";
+			nand-randomizer-seeds = /bits/ 16 <0x4a80>;
+		};
+
+		boot0-rescue at 200000 {
+			label = "boot0-rescue";
+			reg = /bits/ 64 <0x200000 0x200000>;
+			nand-ecc-mode = "hw_syndrome";
+			nand-rnd-mode = "hw";
+			nand-randomizer-seeds = /bits/ 16 <0x4a80>;
+		};
+
+		main at 200000 {
+			label = "main";
+			reg = /bits/ 64 <0x400000 0xffc00000>;
+			nand-ecc-mode = "hw";
+			nand-rnd-mode = "hw";
+			nand-randomizer-seeds = /bits/ 16 <
+				0x2b75 0x0bd0 0x5ca3 0x62d1 0x1c93 0x07e9 0x2162 0x3a72
+				0x0d67 0x67f9 0x1be7 0x077d 0x032f 0x0dac 0x2716 0x2436
+				0x7922 0x1510 0x3860 0x5287 0x480f 0x4252 0x1789 0x5a2d
+				0x2a49 0x5e10 0x437f 0x4b4e 0x2f45 0x216e 0x5cb7 0x7130
+				0x2a3f 0x60e4 0x4dc9 0x0ef0 0x0f52 0x1bb9 0x6211 0x7a56
+				0x226d 0x4ea7 0x6f36 0x3692 0x38bf 0x0c62 0x05eb 0x4c55
+				0x60f4 0x728c 0x3b6f 0x2037 0x7f69 0x0936 0x651a 0x4ceb
+				0x6218 0x79f3 0x383f 0x18d9 0x4f05 0x5c82 0x2912 0x6f17
+				0x6856 0x5938 0x1007 0x61ab 0x3e7f 0x57c2 0x542f 0x4f62
+				0x7454 0x2eac 0x7739 0x42d4 0x2f90 0x435a 0x2e52 0x2064
+				0x637c 0x66ad 0x2c90 0x0bad 0x759c 0x0029 0x0986 0x7126
+				0x1ca7 0x1605 0x386a 0x27f5 0x1380 0x6d75 0x24c3 0x0f8e
+				0x2b7a 0x1418 0x1fd1 0x7dc1 0x2d8e 0x43af 0x2267 0x7da3
+				0x4e3d 0x1338 0x50db 0x454d 0x764d 0x40a3 0x42e6 0x262b
+				0x2d2e 0x1aea 0x2e17 0x173d 0x3a6e 0x71bf 0x25f9 0x0a5d
+				0x7c57 0x0fbe 0x46ce 0x4939 0x6b17 0x37bb 0x3e91 0x76db>;
+		};
+	};
+};
+
+&ohci0 {
+	status = "okay";
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
-- 
2.5.2
