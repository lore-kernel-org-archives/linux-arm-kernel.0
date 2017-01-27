From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 26 Jan 2017 16:47:27 -0800
Subject: [PATCH 4/5] ARM: dts: qcom-apq8064: Collapse usb support into one node
In-Reply-To: <20170127004728.22490-1-stephen.boyd@linaro.org>
References: <20170127004728.22490-1-stephen.boyd@linaro.org>
Message-ID: <20170127004728.22490-5-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently have three device nodes for the same USB hardware
block, as evident by the reuse of the same reg address multiple
times. Now that the chipidea driver fully supports OTG with the
MSM wrapper we can collapse the three nodes into one USB device
node, reflecting the true nature of the hardware.

Since we're here, we also mark the irq trigger flags correctly,
as IRQ_TYPE_LEVEL_HIGH instead of IRQ_TYPE_NONE.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 .../arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts |  49 +++----
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts |  21 +--
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts        |  54 ++++---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |  54 ++++---
 .../arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts |  16 +--
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 156 ++++++++++++---------
 6 files changed, 170 insertions(+), 180 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
index 39ae2bc8cb08..eb2d0402c0f8 100644
--- a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
@@ -290,44 +290,37 @@
 			target-supply	= <&pm8921_lvs7>;
 		};
 
-		/* OTG */
-		phy at 12500000 {
-			status		= "okay";
-			dr_mode		= "peripheral";
-			vddcx-supply	= <&pm8921_s3>;
-			v3p3-supply	= <&pm8921_l3>;
-			v1p8-supply	= <&pm8921_l4>;
-		};
-
-		phy at 12520000 {
-			status		= "okay";
-			vddcx-supply	= <&pm8921_s3>;
-			v3p3-supply	= <&pm8921_l3>;
-			v1p8-supply	= <&pm8921_l23>;
-		};
-
-		phy at 12530000 {
-			status		= "okay";
-			vddcx-supply	= <&pm8921_s3>;
-			v3p3-supply	= <&pm8921_l3>;
-			v1p8-supply	= <&pm8921_l23>;
-		};
-
-		gadget at 12500000 {
-			status = "okay";
-		};
-
-		/* OTG */
 		usb at 12500000 {
 			status = "okay";
+			dr_mode = "peripheral";
+			ulpi {
+				phy {
+					v3p3-supply = <&pm8921_l3>;
+					v1p8-supply = <&pm8921_l4>;
+				};
+			};
 		};
 
 		usb at 12520000 {
 			status = "okay";
+			dr_mode = "otg";
+			ulpi {
+				phy {
+					v3p3-supply = <&pm8921_l3>;
+					v1p8-supply = <&pm8921_l23>;
+				};
+			};
 		};
 
 		usb at 12530000 {
 			status = "okay";
+			dr_mode = "otg";
+			ulpi {
+				phy {
+					v3p3-supply = <&pm8921_l3>;
+					v1p8-supply = <&pm8921_l23>;
+				};
+			};
 		};
 
 		amba {
diff --git a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
index e39440a86739..e5fef32342da 100644
--- a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
@@ -320,22 +320,15 @@
 			};
 		};
 
-		/* OTG */
-		phy at 12500000 {
-			status		= "okay";
-			vddcx-supply	= <&pm8921_s3>;
-			v3p3-supply	= <&pm8921_l3>;
-			v1p8-supply	= <&pm8921_l4>;
-			dr_mode		= "otg";
-		};
-
-		gadget at 12500000 {
-			status = "okay";
-		};
-
-		/* OTG */
 		usb at 12500000 {
 			status = "okay";
+			dr_mode = "otg";
+			ulpi {
+				phy {
+					v3p3-supply = <&pm8921_l3>;
+					v1p8-supply = <&pm8921_l4>;
+				};
+			};
 		};
 
 		amba {
diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index 35f1d46edded..d7362033a91b 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -149,43 +149,37 @@
 			};
 		};
 
-		/* OTG */
-		usb1_phy: phy at 12500000 {
-			status		= "okay";
-			vddcx-supply	= <&pm8921_s3>;
-			v3p3-supply	= <&pm8921_l3>;
-			v1p8-supply	= <&pm8921_l4>;
-		};
-
-		usb3_phy: phy at 12520000 {
-			status		= "okay";
-			vddcx-supply	= <&pm8921_s3>;
-			v3p3-supply	= <&pm8921_l3>;
-			v1p8-supply	= <&pm8921_l23>;
-		};
-
-		usb4_phy: phy at 12530000 {
-			status		= "okay";
-			vddcx-supply	= <&pm8921_s3>;
-			v3p3-supply	= <&pm8921_l3>;
-			v1p8-supply	= <&pm8921_l23>;
-		};
-
-		gadget1: gadget at 12500000 {
-			status = "ok";
-		};
-
-		/* OTG */
-		usb1: usb at 12500000 {
+		usb at 12500000 {
 			status = "ok";
+			dr_mode = "otg";
+			ulpi {
+				phy {
+					v3p3-supply = <&pm8921_l3>;
+					v1p8-supply = <&pm8921_l4>;
+				};
+			};
 		};
 
-		usb3: usb at 12520000 {
+		usb at 12520000 {
 			status = "okay";
+			dr_mode = "host";
+			ulpi {
+				phy {
+					v3p3-supply = <&pm8921_l3>;
+					v1p8-supply = <&pm8921_l23>;
+				};
+			};
 		};
 
-		usb4: usb at 12530000 {
+		usb at 12530000 {
 			status = "okay";
+			dr_mode = "host";
+			ulpi {
+				phy {
+					v3p3-supply = <&pm8921_l3>;
+					v1p8-supply = <&pm8921_l23>;
+				};
+			};
 		};
 
 		/* on board fixed 3.3v supply */
diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 3d37cab3b9a9..ec0b16fc48a1 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -262,43 +262,37 @@
 			target-supply	= <&pm8921_s4>;
 		};
 
-		/* OTG */
-		usb1_phy: phy at 12500000 {
-			status		= "okay";
-			vddcx-supply	= <&pm8921_s3>;
-			v3p3-supply	= <&pm8921_l3>;
-			v1p8-supply	= <&pm8921_l4>;
-		};
-
-		usb3_phy: phy at 12520000 {
-			status		= "okay";
-			vddcx-supply	= <&pm8921_s3>;
-			v3p3-supply	= <&pm8921_l3>;
-			v1p8-supply	= <&pm8921_l23>;
-		};
-
-		usb4_phy: phy at 12530000 {
-			status		= "okay";
-			vddcx-supply	= <&pm8921_s3>;
-			v3p3-supply	= <&pm8921_l3>;
-			v1p8-supply	= <&pm8921_l23>;
-		};
-
-		gadget1: gadget at 12500000 {
-			status = "okay";
-		};
-
-		/* OTG */
-		usb1: usb at 12500000 {
+		usb at 12500000 {
 			status = "okay";
+			dr_mode = "otg";
+			ulpi {
+				phy {
+					v3p3-supply = <&pm8921_l3>;
+					v1p8-supply = <&pm8921_l4>;
+				};
+			};
 		};
 
-		usb3: usb at 12520000 {
+		usb at 12520000 {
 			status = "okay";
+			dr_mode = "host";
+			ulpi {
+				phy {
+					v3p3-supply = <&pm8921_l3>;
+					v1p8-supply = <&pm8921_l23>;
+				};
+			};
 		};
 
-		usb4: usb at 12530000 {
+		usb at 12530000 {
 			status = "okay";
+			dr_mode = "host";
+			ulpi {
+				phy {
+					v3p3-supply = <&pm8921_l3>;
+					v1p8-supply = <&pm8921_l23>;
+				};
+			};
 		};
 
 		pci at 1b500000 {
diff --git a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
index ebd675ca94b4..e9083542d383 100644
--- a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
@@ -349,15 +349,15 @@
 			};
 		};
 
-		phy at 12500000 {
-			status		= "okay";
-			vddcx-supply	= <&pm8921_s3>;
-			v3p3-supply	= <&pm8921_l3>;
-			v1p8-supply	= <&pm8921_l4>;
-		};
-
-		gadget at 12500000 {
+		usb at 12500000 {
 			status = "okay";
+			dr_mode = "otg";
+			ulpi {
+				phy {
+					v3p3-supply = <&pm8921_l3>;
+					v1p8-supply = <&pm8921_l4>;
+				};
+			};
 		};
 
 		gsbi at 1a200000 {
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 268bd470c865..07b41b41f9ce 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -179,7 +179,7 @@
 	};
 
 	clocks {
-		cxo_board {
+		cxo_board: cxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <19200000>;
@@ -191,7 +191,7 @@
 			clock-frequency = <27000000>;
 		};
 
-		sleep_clk {
+		sleep_clk: sleep_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
@@ -848,81 +848,97 @@
 			};
 		};
 
-		usb1_phy: phy at 12500000 {
-			compatible	= "qcom,usb-otg-ci";
-			reg		= <0x12500000 0x400>;
-			interrupts	= <GIC_SPI 100 IRQ_TYPE_NONE>;
-			status		= "disabled";
-
-			clocks		= <&gcc USB_HS1_XCVR_CLK>,
-					  <&gcc USB_HS1_H_CLK>;
-			clock-names	= "core", "iface";
-
-			resets		= <&gcc USB_HS1_RESET>;
-			reset-names	= "link";
-		};
-
-		usb3_phy: phy at 12520000 {
-			compatible	= "qcom,usb-otg-ci";
-			reg		= <0x12520000 0x400>;
-			interrupts	= <GIC_SPI 188 IRQ_TYPE_NONE>;
-			status		= "disabled";
-			dr_mode		= "host";
-
-			clocks		= <&gcc USB_HS3_XCVR_CLK>,
-					  <&gcc USB_HS3_H_CLK>;
-			clock-names	= "core", "iface";
-
-			resets		= <&gcc USB_HS3_RESET>;
-			reset-names	= "link";
-		};
-
-		usb4_phy: phy at 12530000 {
-			compatible	= "qcom,usb-otg-ci";
-			reg		= <0x12530000 0x400>;
-			interrupts	= <GIC_SPI 215 IRQ_TYPE_NONE>;
-			status		= "disabled";
-			dr_mode		= "host";
-
-			clocks		= <&gcc USB_HS4_XCVR_CLK>,
-					  <&gcc USB_HS4_H_CLK>;
-			clock-names	= "core", "iface";
-
-			resets		= <&gcc USB_HS4_RESET>;
-			reset-names	= "link";
-		};
-
-		gadget1: gadget at 12500000 {
-			compatible	= "qcom,ci-hdrc";
-			reg		= <0x12500000 0x400>;
-			status		= "disabled";
-			dr_mode		= "peripheral";
-			interrupts	= <GIC_SPI 100 IRQ_TYPE_NONE>;
-			usb-phy		= <&usb1_phy>;
-		};
-
 		usb1: usb at 12500000 {
-			compatible	= "qcom,ehci-host";
-			reg		= <0x12500000 0x400>;
-			interrupts	= <GIC_SPI 100 IRQ_TYPE_NONE>;
-			status		= "disabled";
-			usb-phy		= <&usb1_phy>;
+			compatible = "qcom,ci-hdrc";
+			reg = <0x12500000 0x200>,
+			      <0x12500200 0x200>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc USB_HS1_XCVR_CLK>, <&gcc USB_HS1_H_CLK>;
+			clock-names = "core", "iface";
+			assigned-clocks = <&gcc USB_HS1_XCVR_CLK>;
+			assigned-clock-rates = <60000000>;
+			resets = <&gcc USB_HS1_RESET>;
+			reset-names = "core";
+			phy_type = "ulpi";
+			ahb-burst-config = <0>;
+			phys = <&usb_hs1_phy>;
+			phy-names = "usb-phy";
+			status = "disabled";
+			#reset-cells = <1>;
+
+			ulpi {
+				usb_hs1_phy: phy {
+					compatible = "qcom,usb-hs-phy-apq8064",
+						     "qcom,usb-hs-phy";
+					#phy-cells = <0>;
+					clocks = <&sleep_clk>, <&cxo_board>;
+					clock-names = "sleep", "ref";
+					resets = <&usb1 0>;
+					reset-names = "por";
+				};
+			};
 		};
 
 		usb3: usb at 12520000 {
-			compatible	= "qcom,ehci-host";
-			reg		= <0x12520000 0x400>;
-			interrupts	= <GIC_SPI 188 IRQ_TYPE_NONE>;
-			status		= "disabled";
-			usb-phy		= <&usb3_phy>;
+			compatible = "qcom,ci-hdrc";
+			reg = <0x12520000 0x200>,
+			      <0x12520200 0x200>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc USB_HS3_XCVR_CLK>, <&gcc USB_HS3_H_CLK>;
+			clock-names = "core", "iface";
+			assigned-clocks = <&gcc USB_HS3_XCVR_CLK>;
+			assigned-clock-rates = <60000000>;
+			resets = <&gcc USB_HS3_RESET>;
+			reset-names = "core";
+			phy_type = "ulpi";
+			ahb-burst-config = <0>;
+			phys = <&usb_hs3_phy>;
+			phy-names = "usb-phy";
+			status = "disabled";
+			#reset-cells = <1>;
+
+			ulpi {
+				usb_hs3_phy: phy {
+					compatible = "qcom,usb-hs-phy-apq8064",
+						     "qcom,usb-hs-phy";
+					#phy-cells = <0>;
+					clocks = <&sleep_clk>, <&cxo_board>;
+					clock-names = "sleep", "ref";
+					resets = <&usb3 0>;
+					reset-names = "por";
+				};
+			};
 		};
 
 		usb4: usb at 12530000 {
-			compatible	= "qcom,ehci-host";
-			reg		= <0x12530000 0x400>;
-			interrupts	= <GIC_SPI 215 IRQ_TYPE_NONE>;
-			status		= "disabled";
-			usb-phy		= <&usb4_phy>;
+			compatible = "qcom,ci-hdrc";
+			reg = <0x12530000 0x200>,
+			      <0x12530200 0x200>;
+			interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc USB_HS4_XCVR_CLK>, <&gcc USB_HS4_H_CLK>;
+			clock-names = "core", "iface";
+			assigned-clocks = <&gcc USB_HS4_XCVR_CLK>;
+			assigned-clock-rates = <60000000>;
+			resets = <&gcc USB_HS4_RESET>;
+			reset-names = "core";
+			phy_type = "ulpi";
+			ahb-burst-config = <0>;
+			phys = <&usb_hs4_phy>;
+			phy-names = "usb-phy";
+			status = "disabled";
+			#reset-cells = <1>;
+
+			ulpi {
+				usb_hs4_phy: phy {
+					compatible = "qcom,usb-hs-phy-apq8064",
+						     "qcom,usb-hs-phy";
+					#phy-cells = <0>;
+					clocks = <&sleep_clk>, <&cxo_board>;
+					clock-names = "sleep", "ref";
+					resets = <&usb4 0>;
+					reset-names = "por";
+				};
+			};
 		};
 
 		sata_phy0: phy at 1b400000 {
-- 
2.10.0.297.gf6727b0
