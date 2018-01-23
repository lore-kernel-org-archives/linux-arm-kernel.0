From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 23 Jan 2018 22:00:54 +0900
Subject: [PATCH 4/4] arm64: dts: uniphier: add dwc3 usb node for LD20
In-Reply-To: <1516712454-2915-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1516712454-2915-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1516712454-2915-5-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb node for LD20, which has 1 dwc3 controller instance, and
enable this for LD20 boards.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../boot/dts/socionext/uniphier-ld20-global.dts    |  4 ++
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |  4 ++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 77 ++++++++++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index fc2bc9d..82eea9d 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -54,3 +54,7 @@
 &nand {
 	status = "okay";
 };
+
+&usb {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 6933710..3ea0985 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -58,3 +58,7 @@
 &i2c0 {
 	status = "okay";
 };
+
+&usb {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 8a3276b..e3e1900 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -467,6 +467,50 @@
 			efuse at 200 {
 				compatible = "socionext,uniphier-efuse";
 				reg = <0x200 0x68>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				/* USB cells */
+				usb_rterm0: trim at 54,4 {
+					reg = <0x54 1>;
+					bits = <4 2>;
+				};
+				usb_rterm1: trim at 55,4 {
+					reg = <0x55 1>;
+					bits = <4 2>;
+				};
+				usb_rterm2: trim at 58,4 {
+					reg = <0x58 1>;
+					bits = <4 2>;
+				};
+				usb_rterm3: trim at 59,4 {
+					reg = <0x59 1>;
+					bits = <4 2>;
+				};
+				usb_sel_t0: trim at 54,0 {
+					reg = <0x54 1>;
+					bits = <0 4>;
+				};
+				usb_sel_t1: trim at 55,0 {
+					reg = <0x55 1>;
+					bits = <0 4>;
+				};
+				usb_sel_t2: trim at 58,0 {
+					reg = <0x58 1>;
+					bits = <0 4>;
+				};
+				usb_sel_t3: trim at 59,0 {
+					reg = <0x59 1>;
+					bits = <0 4>;
+				};
+				usb_hs_i0: trim at 56,0 {
+					reg = <0x56 1>;
+					bits = <0 4>;
+				};
+				usb_hs_i2: trim at 5a,0 {
+					reg = <0x5a 1>;
+					bits = <0 4>;
+				};
 			};
 		};
 
@@ -513,6 +557,39 @@
 			};
 		};
 
+		usb: usb at 65b00000 {
+			compatible = "socionext,uniphier-ld20-dwc3";
+			status = "disabled";
+			reg = <0x65b00000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb0>, <&pinctrl_usb1>,
+				    <&pinctrl_usb2>, <&pinctrl_usb3>;
+			clocks = <&sys_clk 14>, <&sys_clk 16>, <&sys_clk 17>;
+			resets = <&sys_rst 12>, <&sys_rst 16>, <&sys_rst 17>,
+				 <&sys_rst 18>, <&sys_rst 19>;
+			nvmem-cells = <&usb_rterm0>, <&usb_rterm1>,
+				      <&usb_rterm2>, <&usb_rterm3>,
+				      <&usb_sel_t0>, <&usb_sel_t1>,
+				      <&usb_sel_t2>, <&usb_sel_t3>,
+				      <&usb_hs_i0>,  <&usb_hs_i0>,
+				      <&usb_hs_i2>,  <&usb_hs_i2>;
+			nvmem-cell-names =
+				      "rterm0", "rterm1", "rterm2", "rterm3",
+				      "sel_t0", "sel_t1", "sel_t2", "sel_t3",
+				      "hs_i0",  "hs_i1",  "hs_i2",  "hs_i3";
+			ranges;
+
+			dwc3 at 65a00000 {
+				compatible = "snps,dwc3";
+				reg = <0x65a00000 0xcd00>;
+				interrupt-names = "host";
+				interrupts = <0 134 4>;
+				dr_mode = "host";
+			};
+		};
+
 		nand: nand at 68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
-- 
2.7.4
