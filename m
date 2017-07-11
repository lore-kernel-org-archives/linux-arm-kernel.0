From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 11 Jul 2017 23:21:24 +0900
Subject: [PATCH 1/2] ARM: dts: uniphier: add Denali NAND controller node
Message-ID: <1499782885-29023-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NAND controller node to sLD3, LD4, Pro4, sLD8, Pro5, and PXs2.
Set up pinctrl to enable 2 chip select lines except Pro4.  The CS1
for Pro4 is multiplexed with other peripherals such as UART2, so
I did not enable it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4-ref.dts  |  4 ++++
 arch/arm/boot/dts/uniphier-ld4.dtsi     | 11 +++++++++++
 arch/arm/boot/dts/uniphier-ld6b-ref.dts |  4 ++++
 arch/arm/boot/dts/uniphier-pro4-ref.dts |  4 ++++
 arch/arm/boot/dts/uniphier-pro4.dtsi    | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pro5.dtsi    | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi    | 11 +++++++++++
 arch/arm/boot/dts/uniphier-sld3-ref.dts |  4 ++++
 arch/arm/boot/dts/uniphier-sld3.dtsi    |  9 +++++++++
 arch/arm/boot/dts/uniphier-sld8.dtsi    | 11 +++++++++++
 10 files changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ld4-ref.dts
index 4817ebb28eb2..dd4a0e181d7f 100644
--- a/arch/arm/boot/dts/uniphier-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld4-ref.dts
@@ -64,3 +64,7 @@
 &usb1 {
 	status = "okay";
 };
+
+&nand {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index fb2fd9605b9d..dcabb5b2c0f7 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -285,6 +285,17 @@
 				#reset-cells = <1>;
 			};
 		};
+
+		nand: nand at 68000000 {
+			compatible = "socionext,uniphier-denali-nand-v5a";
+			status = "disabled";
+			reg-names = "nand_data", "denali_reg";
+			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
+			interrupts = <0 65 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand2cs>;
+			clocks = <&sys_clk 2>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index 96db4abc02c3..ba46d2cab2fd 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -58,3 +58,7 @@
 &i2c0 {
 	status = "okay";
 };
+
+&nand {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index 4cf539245f2e..a2bbb800c70b 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -66,3 +66,7 @@
 &usb3 {
 	status = "okay";
 };
+
+&nand {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 37400becf4ba..13198f7fee4e 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -305,6 +305,17 @@
 				#reset-cells = <1>;
 			};
 		};
+
+		nand: nand at 68000000 {
+			compatible = "denali,denali-nand-uniphier-v5a";
+			status = "disabled";
+			reg-names = "nand_data", "denali_reg";
+			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
+			interrupts = <0 65 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand>;
+			clocks = <&sys_clk 2>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 140327ddde1c..dc61e1282254 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -368,6 +368,17 @@
 				#reset-cells = <1>;
 			};
 		};
+
+		nand: nand at 68000000 {
+			compatible = "denali,denali-nand-uniphier-v5b";
+			status = "disabled";
+			reg-names = "nand_data", "denali_reg";
+			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
+			interrupts = <0 65 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand2cs>;
+			clocks = <&sys_clk 2>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index bace751d4023..8b7412ccd160 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -352,6 +352,17 @@
 				#reset-cells = <1>;
 			};
 		};
+
+		nand: nand at 68000000 {
+			compatible = "socionext,uniphier-denali-nand-v5b";
+			status = "disabled";
+			reg-names = "nand_data", "denali_reg";
+			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
+			interrupts = <0 65 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand2cs>;
+			clocks = <&sys_clk 2>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/uniphier-sld3-ref.dts b/arch/arm/boot/dts/uniphier-sld3-ref.dts
index 70cda39a3dd2..c4d4a6d0ce7c 100644
--- a/arch/arm/boot/dts/uniphier-sld3-ref.dts
+++ b/arch/arm/boot/dts/uniphier-sld3-ref.dts
@@ -73,3 +73,7 @@
 &usb3 {
 	status = "okay";
 };
+
+&nand {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-sld3.dtsi b/arch/arm/boot/dts/uniphier-sld3.dtsi
index 408287936613..eaedce34d706 100644
--- a/arch/arm/boot/dts/uniphier-sld3.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld3.dtsi
@@ -256,5 +256,14 @@
 				#reset-cells = <1>;
 			};
 		};
+
+		nand: nand at f8000000 {
+			compatible = "denali,denali-nand-uniphier-v5a";
+			status = "disabled";
+			reg-names = "nand_data", "denali_reg";
+			reg = <0xf8000000 0x20>, <0xf8100000 0x1000>;
+			interrupts = <0 65 4>;
+			clocks = <&sys_clk 2>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index 9fb9167f2db4..433d00d588e2 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -285,6 +285,17 @@
 				#reset-cells = <1>;
 			};
 		};
+
+		nand: nand at 68000000 {
+			compatible = "denali,denali-nand-uniphier-v5a";
+			status = "disabled";
+			reg-names = "nand_data", "denali_reg";
+			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
+			interrupts = <0 65 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_nand2cs>;
+			clocks = <&sys_clk 2>;
+		};
 	};
 };
 
-- 
2.7.4
