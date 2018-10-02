From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue,  2 Oct 2018 20:11:59 +0900
Subject: [PATCH 1/4] ARM: dts: uniphier: Add USB3 controller nodes
In-Reply-To: <1538478722-20351-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1538478722-20351-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1538478722-20351-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB3 controller nodes including usb-core, resets, regulator, ss-phy
and hs-phy. This supports for Pro4, PXs2 and the boards.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pro4-ace.dts    |   8 ++
 arch/arm/boot/dts/uniphier-pro4-ref.dts    |   8 ++
 arch/arm/boot/dts/uniphier-pro4.dtsi       |  94 +++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts |   8 ++
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts  |   4 +
 arch/arm/boot/dts/uniphier-pxs2.dtsi       | 180 +++++++++++++++++++++++++++++
 6 files changed, 302 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pro4-ace.dts b/arch/arm/boot/dts/uniphier-pro4-ace.dts
index db1b089..c6ac72c 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ace.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ace.dts
@@ -68,6 +68,14 @@
 	status = "okay";
 };
 
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
 &usb2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index efb0849..0debf5a 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -65,6 +65,14 @@
 	status = "okay";
 };
 
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
 &usb2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 49539f0..b994494 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -386,6 +386,100 @@
 			};
 		};
 
+		usb0: usb at 65a00000 {
+			compatible = "socionext,uniphier-dwc3", "snps,dwc3";
+			status = "disabled";
+			reg = <0x65a00000 0xcd00>;
+			interrupt-names = "host", "peripheral";
+			interrupts = <0 134 4>, <0 135 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb0>;
+			clock-names = "ref", "bus_early", "suspend";
+			clocks = <&sys_clk 12>, <&sys_clk 12>, <&sys_clk 12>;
+			resets = <&usb0_rst 4>;
+			phys = <&usb0_ssphy>;
+			dr_mode = "host";
+		};
+
+		usb-glue at 65b00000 {
+			compatible = "socionext,uniphier-pro4-dwc3-glue",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x65b00000 0x100>;
+
+			usb0_vbus: regulator at 0 {
+				compatible = "socionext,uniphier-pro4-usb3-regulator";
+				reg = <0 0x10>;
+				clock-names = "gio", "link";
+				clocks = <&sys_clk 12>, <&sys_clk 14>;
+				reset-names = "gio", "link";
+				resets = <&sys_rst 12>, <&sys_rst 14>;
+			};
+
+			usb0_ssphy: ss-phy at 10 {
+				compatible = "socionext,uniphier-pro4-usb3-ssphy";
+				reg = <0x10 0x10>;
+				#phy-cells = <0>;
+				clock-names = "gio", "link";
+				clocks = <&sys_clk 12>, <&sys_clk 14>;
+				reset-names = "gio", "link";
+				resets = <&sys_rst 12>, <&sys_rst 14>;
+				vbus-supply = <&usb0_vbus>;
+			};
+
+			usb0_rst: reset at 40 {
+				compatible = "socionext,uniphier-pro4-usb3-reset";
+				reg = <0x40 0x4>;
+				#reset-cells = <1>;
+				clock-names = "gio", "link";
+				clocks = <&sys_clk 12>, <&sys_clk 14>;
+				reset-names = "gio", "link";
+				resets = <&sys_rst 12>, <&sys_rst 14>;
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
+			pinctrl-0 = <&pinctrl_usb1>;
+			clock-names = "ref", "bus_early", "suspend";
+			clocks = <&sys_clk 12>, <&sys_clk 12>, <&sys_clk 12>;
+			resets = <&usb1_rst 4>;
+			dr_mode = "host";
+		};
+
+		usb-glue at 65d00000 {
+			compatible = "socionext,uniphier-pro4-dwc3-glue",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x65d00000 0x100>;
+
+			usb1_vbus: regulator at 0 {
+				compatible = "socionext,uniphier-pro4-usb3-regulator";
+				reg = <0 0x10>;
+				clock-names = "gio", "link";
+				clocks = <&sys_clk 12>, <&sys_clk 15>;
+				reset-names = "gio", "link";
+				resets = <&sys_rst 12>, <&sys_rst 15>;
+			};
+
+			usb1_rst: reset at 40 {
+				compatible = "socionext,uniphier-pro4-usb3-reset";
+				reg = <0x40 0x4>;
+				#reset-cells = <1>;
+				clock-names = "gio", "link";
+				clocks = <&sys_clk 12>, <&sys_clk 15>;
+				reset-names = "gio", "link";
+				resets = <&sys_rst 12>, <&sys_rst 15>;
+			};
+		};
+
 		nand: nand at 68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5a";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
index bed26b8..095774c 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
@@ -86,3 +86,11 @@
 		reg = <1>;
 	};
 };
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
index b13d2d1..03dc63f 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
@@ -87,3 +87,7 @@
 		reg = <1>;
 	};
 };
+
+&usb0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index e2d1a22..2c93cc7 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -523,6 +523,186 @@
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
+			clocks = <&sys_clk 14>, <&sys_clk 14>, <&sys_clk 14>;
+			resets = <&usb0_rst 15>;
+			phys = <&usb0_hsphy0>, <&usb0_hsphy1>,
+			       <&usb0_ssphy0>, <&usb0_ssphy1>;
+			dr_mode = "host";
+		};
+
+		usb-glue at 65b00000 {
+			compatible = "socionext,uniphier-pxs2-dwc3-glue",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x65b00000 0x400>;
+
+			usb0_rst: reset at 0 {
+				compatible = "socionext,uniphier-pxs2-usb3-reset";
+				reg = <0x0 0x4>;
+				#reset-cells = <1>;
+				clock-names = "link";
+				clocks = <&sys_clk 14>;
+				reset-names = "link";
+				resets = <&sys_rst 14>;
+			};
+
+			usb0_vbus0: regulator at 100 {
+				compatible = "socionext,uniphier-pxs2-usb3-regulator";
+				reg = <0x100 0x10>;
+				clock-names = "link";
+				clocks = <&sys_clk 14>;
+				reset-names = "link";
+				resets = <&sys_rst 14>;
+			};
+
+			usb0_vbus1: regulator at 110 {
+				compatible = "socionext,uniphier-pxs2-usb3-regulator";
+				reg = <0x110 0x10>;
+				clock-names = "link";
+				clocks = <&sys_clk 14>;
+				reset-names = "link";
+				resets = <&sys_rst 14>;
+			};
+
+			usb0_hsphy0: hs-phy at 200 {
+				compatible = "socionext,uniphier-pxs2-usb3-hsphy";
+				reg = <0x200 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 14>, <&sys_clk 16>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 14>, <&sys_rst 16>;
+				vbus-supply = <&usb0_vbus0>;
+			};
+
+			usb0_hsphy1: hs-phy at 210 {
+				compatible = "socionext,uniphier-pxs2-usb3-hsphy";
+				reg = <0x210 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 14>, <&sys_clk 16>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 14>, <&sys_rst 16>;
+				vbus-supply = <&usb0_vbus1>;
+			};
+
+			usb0_ssphy0: ss-phy at 300 {
+				compatible = "socionext,uniphier-pxs2-usb3-ssphy";
+				reg = <0x300 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 14>, <&sys_clk 17>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 14>, <&sys_rst 17>;
+				vbus-supply = <&usb0_vbus0>;
+			};
+
+			usb0_ssphy1: ss-phy at 310 {
+				compatible = "socionext,uniphier-pxs2-usb3-ssphy";
+				reg = <0x310 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 14>, <&sys_clk 18>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 14>, <&sys_rst 18>;
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
+			clocks = <&sys_clk 15>, <&sys_clk 15>, <&sys_clk 15>;
+			resets = <&usb1_rst 15>;
+			phys = <&usb1_hsphy0>, <&usb1_hsphy1>, <&usb1_ssphy0>;
+			dr_mode = "host";
+		};
+
+		usb-glue at 65d00000 {
+			compatible = "socionext,uniphier-pxs2-dwc3-glue",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x65d00000 0x400>;
+
+			usb1_rst: reset at 0 {
+				compatible = "socionext,uniphier-pxs2-usb3-reset";
+				reg = <0x0 0x4>;
+				#reset-cells = <1>;
+				clock-names = "link";
+				clocks = <&sys_clk 15>;
+				reset-names = "link";
+				resets = <&sys_rst 15>;
+			};
+
+			usb1_vbus0: regulator at 100 {
+				compatible = "socionext,uniphier-pxs2-usb3-regulator";
+				reg = <0x100 0x10>;
+				clock-names = "link";
+				clocks = <&sys_clk 15>;
+				reset-names = "link";
+				resets = <&sys_rst 15>;
+			};
+
+			usb1_vbus1: regulator at 110 {
+				compatible = "socionext,uniphier-pxs2-usb3-regulator";
+				reg = <0x110 0x10>;
+				clock-names = "link";
+				clocks = <&sys_clk 15>;
+				reset-names = "link";
+				resets = <&sys_rst 15>;
+			};
+
+			usb1_hsphy0: hs-phy at 200 {
+				compatible = "socionext,uniphier-pxs2-usb3-hsphy";
+				reg = <0x200 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 15>, <&sys_clk 20>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 15>, <&sys_rst 20>;
+				vbus-supply = <&usb1_vbus0>;
+			};
+
+			usb1_hsphy1: hs-phy at 210 {
+				compatible = "socionext,uniphier-pxs2-usb3-hsphy";
+				reg = <0x210 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 15>, <&sys_clk 20>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 15>, <&sys_rst 20>;
+				vbus-supply = <&usb1_vbus1>;
+			};
+
+			usb1_ssphy0: ss-phy at 300 {
+				compatible = "socionext,uniphier-pxs2-usb3-ssphy";
+				reg = <0x300 0x10>;
+				#phy-cells = <0>;
+				clock-names = "link", "phy";
+				clocks = <&sys_clk 15>, <&sys_clk 21>;
+				reset-names = "link", "phy";
+				resets = <&sys_rst 15>, <&sys_rst 21>;
+				vbus-supply = <&usb1_vbus0>;
+			};
+		};
+
 		nand: nand at 68000000 {
 			compatible = "socionext,uniphier-denali-nand-v5b";
 			status = "disabled";
-- 
2.7.4
