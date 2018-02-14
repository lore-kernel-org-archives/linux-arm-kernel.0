From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed, 14 Feb 2018 18:30:29 +0900
Subject: [PATCH v2 2/2] arm64: dts: uniphier: add AVE ethernet node
In-Reply-To: <1518600629-14317-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1518600629-14317-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1518600629-14317-3-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes of the AVE ethernet controller for LD11 and LD20 SoCs
and the boards.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 11 +++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts    | 11 +++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi       | 16 ++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 13 +++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts    | 11 +++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 18 ++++++++++++++++++
 6 files changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 2452b22..801997a 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -72,3 +72,14 @@
 &nand {
 	status = "okay";
 };
+
+&eth {
+	status = "okay";
+	phy-handle = <&ethphy>;
+};
+
+&mdio {
+	ethphy: ethphy at 1 {
+		reg = <1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
index 6bdefb2..db207e4 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
@@ -70,3 +70,14 @@
 &usb2 {
 	status = "okay";
 };
+
+&eth {
+	status = "okay";
+	phy-handle = <&ethphy>;
+};
+
+&mdio {
+	ethphy: ethphy at 1 {
+		reg = <1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 1c63d0a..2773cfa 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -456,6 +456,22 @@
 			};
 		};
 
+		eth: ethernet at 65000000 {
+			compatible = "socionext,uniphier-ld11-ave4";
+			status = "disabled";
+			reg = <0x65000000 0x8500>;
+			interrupts = <0 66 4>;
+			clocks = <&sys_clk 6>;
+			resets = <&sys_rst 6>;
+			phy-mode = "rmii";
+			local-mac-address = [00 00 00 00 00 00];
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		nand: nand at 68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index fc2bc9d..be95598 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -54,3 +54,16 @@
 &nand {
 	status = "okay";
 };
+
+&eth {
+	status = "okay";
+	phy-mode = "rmii";
+	pinctrl-0 = <&pinctrl_ether_rmii>;
+	phy-handle = <&ethphy>;
+};
+
+&mdio {
+	ethphy: ethphy at 1 {
+		reg = <1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 254d679..184a684 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -58,3 +58,14 @@
 &i2c0 {
 	status = "okay";
 };
+
+&eth {
+	status = "okay";
+	phy-handle = <&ethphy>;
+};
+
+&mdio {
+	ethphy: ethphy at 0 {
+		reg = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 5c81070..5652c59 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -512,6 +512,24 @@
 			};
 		};
 
+		eth: ethernet at 65000000 {
+			compatible = "socionext,uniphier-ld20-ave4";
+			status = "disabled";
+			reg = <0x65000000 0x8500>;
+			interrupts = <0 66 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ether_rgmii>;
+			clocks = <&sys_clk 6>;
+			resets = <&sys_rst 6>;
+			phy-mode = "rgmii";
+			local-mac-address = [00 00 00 00 00 00];
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		nand: nand at 68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
-- 
2.7.4
