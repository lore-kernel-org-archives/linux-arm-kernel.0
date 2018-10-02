From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed,  3 Oct 2018 07:59:50 +0900
Subject: [PATCH 1/2] ARM: dts: uniphier: add SD/eMMC controller nodes
Message-ID: <1538521191-16333-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SD controller nodes for LD4, Pro4, sLD8, Pro5, and PXs2.
This is also used as an eMMC controller for LD4, Pro4, and sLD8.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ld4-ref.dts     |  4 +++
 arch/arm/boot/dts/uniphier-ld4.dtsi        | 34 +++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ld6b-ref.dts    |  4 +++
 arch/arm/boot/dts/uniphier-pinctrl.dtsi    |  5 ++++
 arch/arm/boot/dts/uniphier-pro4-ace.dts    |  4 +++
 arch/arm/boot/dts/uniphier-pro4-ref.dts    |  4 +++
 arch/arm/boot/dts/uniphier-pro4-sanji.dts  |  4 +++
 arch/arm/boot/dts/uniphier-pro4.dtsi       | 48 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pro5.dtsi       | 34 +++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts |  4 +++
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts  |  4 +++
 arch/arm/boot/dts/uniphier-pxs2.dtsi       | 34 +++++++++++++++++++++
 arch/arm/boot/dts/uniphier-sld8-ref.dts    |  4 +++
 arch/arm/boot/dts/uniphier-sld8.dtsi       | 34 +++++++++++++++++++++
 14 files changed, 221 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ld4-ref.dts
index 21407e1..3aaca10 100644
--- a/arch/arm/boot/dts/uniphier-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld4-ref.dts
@@ -63,6 +63,10 @@
 	status = "okay";
 };
 
+&sd {
+	status = "okay";
+};
+
 &usb0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 2a17066..fa00ec8 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -224,6 +224,40 @@
 			};
 		};
 
+		sd: sdhc at 5a400000 {
+			compatible = "socionext,uniphier-sd-v2.91";
+			status = "disabled";
+			reg = <0x5a400000 0x200>;
+			interrupts = <0 76 4>;
+			pinctrl-names = "default", "uhs";
+			pinctrl-0 = <&pinctrl_sd>;
+			pinctrl-1 = <&pinctrl_sd_uhs>;
+			clocks = <&mio_clk 0>;
+			reset-names = "host", "bridge";
+			resets = <&mio_rst 0>, <&mio_rst 3>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+		};
+
+		emmc: sdhc at 5a500000 {
+			compatible = "socionext,uniphier-sd-v2.91";
+			status = "disabled";
+			reg = <0x5a500000 0x200>;
+			interrupts = <0 78 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_emmc>;
+			clocks = <&mio_clk 1>;
+			reset-names = "host", "bridge", "hw";
+			resets = <&mio_rst 1>, <&mio_rst 4>, <&mio_rst 6>;
+			bus-width = <8>;
+			cap-mmc-highspeed;
+			cap-mmc-hw-reset;
+			non-removable;
+		};
+
 		usb0: usb at 5a800100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index a0a44a4..e505a94 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -65,6 +65,10 @@
 	status = "okay";
 };
 
+&sd {
+	status = "okay";
+};
+
 &eth {
 	status = "okay";
 	phy-handle = <&ethphy>;
diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index 51f0e69..aeb47b0 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -121,6 +121,11 @@
 		function = "sd";
 	};
 
+	pinctrl_sd_uhs: sd-uhs {
+		groups = "sd";
+		function = "sd";
+	};
+
 	pinctrl_sd1: sd1 {
 		groups = "sd1";
 		function = "sd1";
diff --git a/arch/arm/boot/dts/uniphier-pro4-ace.dts b/arch/arm/boot/dts/uniphier-pro4-ace.dts
index db1b089..46e0917 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ace.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ace.dts
@@ -68,6 +68,10 @@
 	status = "okay";
 };
 
+&sd {
+	status = "okay";
+};
+
 &usb2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index efb0849..1429908 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -65,6 +65,10 @@
 	status = "okay";
 };
 
+&sd {
+	status = "okay";
+};
+
 &usb2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-pro4-sanji.dts b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
index dac4d66..eaca4a7 100644
--- a/arch/arm/boot/dts/uniphier-pro4-sanji.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
@@ -71,6 +71,10 @@
 	status = "okay";
 };
 
+&emmc {
+	status = "okay";
+};
+
 &eth {
 	status = "okay";
 	phy-handle = <&ethphy>;
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index da88ccc..e2e13de 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -258,6 +258,54 @@
 			};
 		};
 
+		sd: sdhc at 5a400000 {
+			compatible = "socionext,uniphier-sd-v2.91";
+			status = "disabled";
+			reg = <0x5a400000 0x200>;
+			interrupts = <0 76 4>;
+			pinctrl-names = "default", "uhs";
+			pinctrl-0 = <&pinctrl_sd>;
+			pinctrl-1 = <&pinctrl_sd_uhs>;
+			clocks = <&mio_clk 0>;
+			reset-names = "host", "bridge";
+			resets = <&mio_rst 0>, <&mio_rst 3>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+		};
+
+		emmc: sdhc at 5a500000 {
+			compatible = "socionext,uniphier-sd-v2.91";
+			status = "disabled";
+			reg = <0x5a500000 0x200>;
+			interrupts = <0 78 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_emmc>;
+			clocks = <&mio_clk 1>;
+			reset-names = "host", "bridge", "hw";
+			resets = <&mio_rst 1>, <&mio_rst 4>, <&mio_rst 6>;
+			bus-width = <8>;
+			cap-mmc-highspeed;
+			cap-mmc-hw-reset;
+			non-removable;
+		};
+
+		sd1: sdhc at 5a600000 {
+			compatible = "socionext,uniphier-sd-v2.91";
+			status = "disabled";
+			reg = <0x5a600000 0x200>;
+			interrupts = <0 85 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_sd1>;
+			clocks = <&mio_clk 2>;
+			reset-names = "host", "bridge";
+			resets = <&mio_rst 2>, <&mio_rst 5>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+		};
+
 		usb2: usb at 5a800100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 40a84f2..cabee2d 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -443,6 +443,40 @@
 			clocks = <&sys_clk 2>, <&sys_clk 3>, <&sys_clk 3>;
 			resets = <&sys_rst 2>;
 		};
+
+		emmc: sdhc at 68400000 {
+			compatible = "socionext,uniphier-sd-v3.1";
+			status = "disabled";
+			reg = <0x68400000 0x800>;
+			interrupts = <0 78 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_emmc>;
+			clocks = <&sd_clk 1>;
+			reset-names = "host", "hw";
+			resets = <&sd_rst 1>, <&sd_rst 6>;
+			bus-width = <8>;
+			cap-mmc-highspeed;
+			cap-mmc-hw-reset;
+			non-removable;
+		};
+
+		sd: sdhc at 68800000 {
+			compatible = "socionext,uniphier-sd-v3.1";
+			status = "disabled";
+			reg = <0x68800000 0x800>;
+			interrupts = <0 76 4>;
+			pinctrl-names = "default", "uhs";
+			pinctrl-0 = <&pinctrl_sd>;
+			pinctrl-1 = <&pinctrl_sd_uhs>;
+			clocks = <&sd_clk 0>;
+			reset-names = "host";
+			resets = <&sd_rst 0>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
index bed26b8..3a34694 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
@@ -76,6 +76,10 @@
 	};
 };
 
+&emmc {
+	status = "okay";
+};
+
 &eth {
 	status = "okay";
 	phy-handle = <&ethphy>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
index b13d2d1..545cc3e 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
@@ -77,6 +77,10 @@
 	status = "okay";
 };
 
+&emmc {
+	status = "okay";
+};
+
 &eth {
 	status = "okay";
 	phy-handle = <&ethphy>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 79f5c2d..c7e5175 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -422,6 +422,40 @@
 			};
 		};
 
+		emmc: sdhc at 5a000000 {
+			compatible = "socionext,uniphier-sd-v3.1.1";
+			status = "disabled";
+			reg = <0x5a000000 0x800>;
+			interrupts = <0 78 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_emmc>;
+			clocks = <&sd_clk 1>;
+			reset-names = "host", "hw";
+			resets = <&sd_rst 1>, <&sd_rst 6>;
+			bus-width = <8>;
+			cap-mmc-highspeed;
+			cap-mmc-hw-reset;
+			non-removable;
+		};
+
+		sd: sdhc at 5a400000 {
+			compatible = "socionext,uniphier-sd-v3.1.1";
+			status = "disabled";
+			reg = <0x5a400000 0x800>;
+			interrupts = <0 76 4>;
+			pinctrl-names = "default", "uhs";
+			pinctrl-0 = <&pinctrl_sd>;
+			pinctrl-1 = <&pinctrl_sd_uhs>;
+			clocks = <&sd_clk 0>;
+			reset-names = "host";
+			resets = <&sd_rst 0>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+		};
+
 		soc_glue: soc-glue at 5f800000 {
 			compatible = "socionext,uniphier-pxs2-soc-glue",
 				     "simple-mfd", "syscon";
diff --git a/arch/arm/boot/dts/uniphier-sld8-ref.dts b/arch/arm/boot/dts/uniphier-sld8-ref.dts
index fe386fa..01bf94c 100644
--- a/arch/arm/boot/dts/uniphier-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-sld8-ref.dts
@@ -63,6 +63,10 @@
 	status = "okay";
 };
 
+&sd {
+	status = "okay";
+};
+
 &usb0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index dc723bf..388109d 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -228,6 +228,40 @@
 			};
 		};
 
+		sd: sdhc at 5a400000 {
+			compatible = "socionext,uniphier-sd-v2.91";
+			status = "disabled";
+			reg = <0x5a400000 0x200>;
+			interrupts = <0 76 4>;
+			pinctrl-names = "default", "uhs";
+			pinctrl-0 = <&pinctrl_sd>;
+			pinctrl-1 = <&pinctrl_sd_uhs>;
+			clocks = <&mio_clk 0>;
+			reset-names = "host", "bridge";
+			resets = <&mio_rst 0>, <&mio_rst 3>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+		};
+
+		emmc: sdhc at 5a500000 {
+			compatible = "socionext,uniphier-sd-v2.91";
+			status = "disabled";
+			reg = <0x5a500000 0x200>;
+			interrupts = <0 78 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_emmc>;
+			clocks = <&mio_clk 1>;
+			reset-names = "host", "bridge", "hw";
+			resets = <&mio_rst 1>, <&mio_rst 4>, <&mio_rst 6>;
+			bus-width = <8>;
+			cap-mmc-highspeed;
+			cap-mmc-hw-reset;
+			non-removable;
+		};
+
 		usb0: usb at 5a800100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
-- 
2.7.4
