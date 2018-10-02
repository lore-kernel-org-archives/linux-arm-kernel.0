From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue,  2 Oct 2018 20:12:01 +0900
Subject: [PATCH 3/4] arm64: dts: uniphier: Add USB3 controller nodes
In-Reply-To: <1538478722-20351-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1538478722-20351-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1538478722-20351-4-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB3 controller nodes including usb-core, resets, regulator, ss-phy
and hs-phy. This supports for LD20, PXs3 and the boards. This includes
additional efuse nodes for obtaining PHY trimming values.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../boot/dts/socionext/uniphier-ld20-global.dts    |   4 +
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |   4 +
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 194 +++++++++++++++++
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |   8 +
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   | 240 +++++++++++++++++++++
 5 files changed, 450 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index 1a5e7c2..d7ae28a 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -148,3 +148,7 @@
 &nand {
 	status = "okay";
 };
+
+&usb {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 440c2e6..406244a 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -75,3 +75,7 @@
 		drive-strength = <9>;
 	};
 };
+
+&usb {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index caf1126..dcf6178 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -553,6 +553,50 @@
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
 
@@ -620,6 +664,156 @@
 			};
 		};
 
+		usb: usb at 65a00000 {
+			compatible = "socionext,uniphier-dwc3", "snps,dwc3";
+			status = "disabled";
+			reg = <0x65a00000 0xcd00>;
+			interrupt-names = "host";
+			interrupts = <0 134 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb0>, <&pinctrl_usb1>,
+				    <&pinctrl_usb2>, <&pinctrl_usb3>;
+			clock-names = "ref", "bus_early", "suspend";
+			clocks = <&sys_clk 14>, <&sys_clk 14>, <&sys_clk 14>;
+			resets = <&usb_rst 15>;
+			phys = <&usb_hsphy0>, <&usb_hsphy1>,
+			       <&usb_hsphy2>, <&usb_hsphy3>,
+			       <&usb_ssphy0>, <&usb_ssphy1>;
+			dr_mode = "host";
+		};
+
+		usb-glue at 65b00000 {
+			compatible = "socionext,uniphier-ld20-dwc3-glue",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x65b00000 0x400>;
+
+			usb_rst: reset at 0 {
+				compatible = "socionext,uniphier-ld20-usb3-reset";
+				reg = <0x0 0x4>;
+				#reset-cells = <1>;
+				clock-names = "link";
+				clocks = <&sys_clk 14>;
+				reset-names = "link";
+				resets = <&sys_rst 14>;
+			};
+
+			usb_vbus0: regulator at 100 {
+				compatible = "socionext,uniphier-ld20-usb3-regulator";
+				reg = <0x100 0x10>;
+				clock-names = "link";
+				clocks = <&sys_clk 14>;
+				reset-names = "link";
+				resets = <&sys_rst 14>;
+			};
+
+			usb_vbus1: regulator at 110 {
+				compatible = "socionext,uniphier-ld20-usb3-regulator";
+				reg = <0x110 0x10>;
+				clock-names = "link";
+				clocks = <&sys_clk 14>;
+				reset-names = "link";
+				resets = <&sys_rst 14>;
+			};
+
+			usb_vbus2: regulator at 120 {
+				compatible = "socionext,uniphier-ld20-usb3-regulator";
+				reg = <0x120 0x10>;
+				clock-names = "link";
+				clocks = <&sys_clk 14>;
+				reset-names = "link";
+				resets = <&sys_rst 14>;
+			};
+
+			usb_vbus3: regulator at 130 {
+				compatible = "socionext,uniphier-ld20-usb3-regulator";
+				reg = <0x130 0x10>;
+				clock-names = "link";
+				clocks = <&sys_clk 14>;
+				reset-names = "link";
+				resets = <&sys_rst 14>;
+			};
+
+			usb_hsphy0: hs-phy at 200 {
+				compatible = "socionext,uniphier-ld20-usb3-hsphy";
+				reg = <0x200 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 14>, <&sys_clk 16>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 14>, <&sys_rst 16>;
+				vbus-supply = <&usb_vbus0>;
+				nvmem-cell-names = "rterm", "sel_t", "hs_i";
+				nvmem-cells = <&usb_rterm0>, <&usb_sel_t0>,
+					      <&usb_hs_i0>;
+			};
+
+			usb_hsphy1: hs-phy at 210 {
+				compatible = "socionext,uniphier-ld20-usb3-hsphy";
+				reg = <0x210 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 14>, <&sys_clk 16>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 14>, <&sys_rst 16>;
+				vbus-supply = <&usb_vbus1>;
+				nvmem-cell-names = "rterm", "sel_t", "hs_i";
+				nvmem-cells = <&usb_rterm1>, <&usb_sel_t1>,
+					      <&usb_hs_i0>;
+			};
+
+			usb_hsphy2: hs-phy at 220 {
+				compatible = "socionext,uniphier-ld20-usb3-hsphy";
+				reg = <0x220 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 14>, <&sys_clk 17>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 14>, <&sys_rst 17>;
+				vbus-supply = <&usb_vbus2>;
+				nvmem-cell-names = "rterm", "sel_t", "hs_i";
+				nvmem-cells = <&usb_rterm2>, <&usb_sel_t2>,
+					      <&usb_hs_i2>;
+			};
+
+			usb_hsphy3: hs-phy at 230 {
+				compatible = "socionext,uniphier-ld20-usb3-hsphy";
+				reg = <0x230 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 14>, <&sys_clk 17>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 14>, <&sys_rst 17>;
+				vbus-supply = <&usb_vbus3>;
+				nvmem-cell-names = "rterm", "sel_t", "hs_i";
+				nvmem-cells = <&usb_rterm3>, <&usb_sel_t3>,
+					      <&usb_hs_i2>;
+			};
+
+			usb_ssphy0: ss-phy at 300 {
+				compatible = "socionext,uniphier-ld20-usb3-ssphy";
+				reg = <0x300 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 14>, <&sys_clk 18>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 14>, <&sys_rst 18>;
+				vbus-supply = <&usb_vbus0>;
+			};
+
+			usb_ssphy1: ss-phy at 310 {
+				compatible = "socionext,uniphier-ld20-usb3-ssphy";
+				reg = <0x310 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 14>, <&sys_clk 19>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 14>, <&sys_rst 19>;
+				vbus-supply = <&usb_vbus1>;
+			};
+		};
+
 		nand: nand at 68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index c1bb607..b00db39 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -100,3 +100,11 @@
 &nand {
 	status = "okay";
 };
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 2a4cf42..f688bd7 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -366,6 +366,50 @@
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
 
@@ -447,6 +491,202 @@
 			};
 		};
 
+		usb0: usb at 65a00000 {
+			compatible = "socionext,uniphier-dwc3", "snps,dwc3";
+			status = "disabled";
+			reg = <0x65a00000 0xcd00>;
+			interrupt-names = "host", "peripheral";
+			interrupts = <0 134 4>, <0 135 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb0>, <&pinctrl_usb2>;
+			clock-names = "ref", "bus_early", "suspend";
+			clocks = <&sys_clk 12>, <&sys_clk 12>, <&sys_clk 12>;
+			resets = <&usb0_rst 15>;
+			phys = <&usb0_hsphy0>, <&usb0_hsphy1>,
+			       <&usb0_ssphy0>, <&usb0_ssphy1>;
+			dr_mode = "host";
+		};
+
+		usb-glue at 65b00000 {
+			compatible = "socionext,uniphier-pxs3-dwc3-glue",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x65b00000 0x400>;
+
+			usb0_rst: reset at 0 {
+				compatible = "socionext,uniphier-pxs3-usb3-reset";
+				reg = <0x0 0x4>;
+				#reset-cells = <1>;
+				clock-names = "link";
+				clocks = <&sys_clk 12>;
+				reset-names = "link";
+				resets = <&sys_rst 12>;
+			};
+
+			usb0_vbus0: regulator at 100 {
+				compatible = "socionext,uniphier-pxs3-usb3-regulator";
+				reg = <0x100 0x10>;
+				clock-names = "link";
+				clocks = <&sys_clk 12>;
+				reset-names = "link";
+				resets = <&sys_rst 12>;
+			};
+
+			usb0_vbus1: regulator at 110 {
+				compatible = "socionext,uniphier-pxs3-usb3-regulator";
+				reg = <0x110 0x10>;
+				clock-names = "link";
+				clocks = <&sys_clk 12>;
+				reset-names = "link";
+				resets = <&sys_rst 12>;
+			};
+
+			usb0_hsphy0: hs-phy at 200 {
+				compatible = "socionext,uniphier-pxs3-usb3-hsphy";
+				reg = <0x200 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 12>, <&sys_clk 16>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 12>, <&sys_rst 16>;
+				vbus-supply = <&usb0_vbus0>;
+				nvmem-cell-names = "rterm", "sel_t", "hs_i";
+				nvmem-cells = <&usb_rterm0>, <&usb_sel_t0>,
+					      <&usb_hs_i0>;
+			};
+
+			usb0_hsphy1: hs-phy at 210 {
+				compatible = "socionext,uniphier-pxs3-usb3-hsphy";
+				reg = <0x210 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 12>, <&sys_clk 16>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 12>, <&sys_rst 16>;
+				vbus-supply = <&usb0_vbus1>;
+				nvmem-cell-names = "rterm", "sel_t", "hs_i";
+				nvmem-cells = <&usb_rterm1>, <&usb_sel_t1>,
+					      <&usb_hs_i0>;
+			};
+
+			usb0_ssphy0: ss-phy at 300 {
+				compatible = "socionext,uniphier-pxs3-usb3-ssphy";
+				reg = <0x300 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 12>, <&sys_clk 17>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 12>, <&sys_rst 17>;
+				vbus-supply = <&usb0_vbus0>;
+			};
+
+			usb0_ssphy1: ss-phy at 310 {
+				compatible = "socionext,uniphier-pxs3-usb3-ssphy";
+				reg = <0x310 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 12>, <&sys_clk 18>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 12>, <&sys_rst 18>;
+				vbus-supply = <&usb0_vbus1>;
+			};
+		};
+
+		usb1: usb at 65c00000 {
+			compatible = "socionext,uniphier-dwc3", "snps,dwc3";
+			status = "disabled";
+			reg = <0x65c00000 0xcd00>;
+			interrupt-names = "host", "peripheral";
+			interrupts = <0 137 4>, <0 138 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb1>, <&pinctrl_usb3>;
+			clock-names = "ref", "bus_early", "suspend";
+			clocks = <&sys_clk 13>, <&sys_clk 13>, <&sys_clk 13>;
+			resets = <&usb1_rst 15>;
+			phys = <&usb1_hsphy0>, <&usb1_hsphy1>,
+			       <&usb1_ssphy0>;
+			dr_mode = "host";
+		};
+
+		usb-glue at 65d00000 {
+			compatible = "socionext,uniphier-pxs3-dwc3-glue",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x65d00000 0x400>;
+
+			usb1_rst: reset at 0 {
+				compatible = "socionext,uniphier-pxs3-usb3-reset";
+				reg = <0x0 0x4>;
+				#reset-cells = <1>;
+				clock-names = "link";
+				clocks = <&sys_clk 13>;
+				reset-names = "link";
+				resets = <&sys_rst 13>;
+			};
+
+			usb1_vbus0: regulator at 100 {
+				compatible = "socionext,uniphier-pxs3-usb3-regulator";
+				reg = <0x100 0x10>;
+				clock-names = "link";
+				clocks = <&sys_clk 13>;
+				reset-names = "link";
+				resets = <&sys_rst 13>;
+			};
+
+			usb1_vbus1: regulator at 110 {
+				compatible = "socionext,uniphier-pxs3-usb3-regulator";
+				reg = <0x110 0x10>;
+				clock-names = "link";
+				clocks = <&sys_clk 13>;
+				reset-names = "link";
+				resets = <&sys_rst 13>;
+			};
+
+			usb1_hsphy0: hs-phy at 200 {
+				compatible = "socionext,uniphier-pxs3-usb3-hsphy";
+				reg = <0x200 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy", "phy-ext";
+				clocks = <&sys_clk 13>, <&sys_clk 20>,
+					 <&sys_clk 14>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 13>, <&sys_rst 20>;
+				vbus-supply = <&usb1_vbus0>;
+				nvmem-cell-names = "rterm", "sel_t", "hs_i";
+				nvmem-cells = <&usb_rterm2>, <&usb_sel_t2>,
+					      <&usb_hs_i2>;
+			};
+
+			usb1_hsphy1: hs-phy at 210 {
+				compatible = "socionext,uniphier-pxs3-usb3-hsphy";
+				reg = <0x210 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy", "phy-ext";
+				clocks = <&sys_clk 13>, <&sys_clk 20>,
+					 <&sys_clk 14>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 13>, <&sys_rst 20>;
+				vbus-supply = <&usb1_vbus1>;
+				nvmem-cell-names = "rterm", "sel_t", "hs_i";
+				nvmem-cells = <&usb_rterm3>, <&usb_sel_t3>,
+					      <&usb_hs_i2>;
+			};
+
+			usb1_ssphy0: ss-phy at 300 {
+				compatible = "socionext,uniphier-pxs3-usb3-ssphy";
+				reg = <0x300 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy", "phy-ext";
+				clocks = <&sys_clk 13>, <&sys_clk 21>,
+					 <&sys_clk 14>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 13>, <&sys_rst 21>;
+				vbus-supply = <&usb1_vbus0>;
+			};
+		};
+
 		nand: nand at 68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
-- 
2.7.4
