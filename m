From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2018 10:03:39 +0800
Subject: [PATCH 2/3] arm64: dts: hi3798cv200: enable usb2 support for poplar
 board
In-Reply-To: <1526004220-17030-1-git-send-email-shawn.guo@linaro.org>
References: <1526004220-17030-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1526004220-17030-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds usb2 phy devices, and enables ehci/ohci support for Hi3798CV200
Poplar board.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts      |  8 +++
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     | 68 ++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
index c4382e1f3c92..b0b790a5aa8d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
@@ -72,6 +72,10 @@
 	};
 };
 
+&ehci {
+	status = "okay";
+};
+
 &gmac1 {
 	status = "okay";
 	#address-cells = <1>;
@@ -155,6 +159,10 @@
 	status = "okay";
 };
 
+&ohci {
+	status = "okay";
+};
+
 &pcie {
 	reset-gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;
 	vpcie-supply = <&reg_pcie>;
diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index 5b73403551e6..c1723ef01cac 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -116,6 +116,42 @@
 			#size-cells = <1>;
 			ranges = <0x0 0x8a20000 0x1000>;
 
+			usb2_phy1: usb2-phy at 120 {
+				compatible = "hisilicon,hi3798cv200-usb2-phy";
+				reg = <0x120 0x4>;
+				clocks = <&crg HISTB_USB2_PHY1_REF_CLK>;
+				resets = <&crg 0xbc 4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				usb2_phy1_port0: phy at 0 {
+					reg = <0>;
+					#phy-cells = <0>;
+					resets = <&crg 0xbc 8>;
+				};
+
+				usb2_phy1_port1: phy at 1 {
+					reg = <1>;
+					#phy-cells = <0>;
+					resets = <&crg 0xbc 9>;
+				};
+			};
+
+			usb2_phy2: usb2-phy at 124 {
+				compatible = "hisilicon,hi3798cv200-usb2-phy";
+				reg = <0x124 0x4>;
+				clocks = <&crg HISTB_USB2_PHY2_REF_CLK>;
+				resets = <&crg 0xbc 6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				usb2_phy2_port0: phy at 0 {
+					reg = <0>;
+					#phy-cells = <0>;
+					resets = <&crg 0xbc 10>;
+				};
+			};
+
 			combphy0: phy at 850 {
 				compatible = "hisilicon,hi3798cv200-combphy";
 				reg = <0x850 0x8>;
@@ -482,5 +518,37 @@
 			phy-names = "phy";
 			status = "disabled";
 		};
+
+		ohci: ohci at 9880000 {
+			compatible = "generic-ohci";
+			reg = <0x9880000 0x10000>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HISTB_USB2_BUS_CLK>,
+				 <&crg HISTB_USB2_12M_CLK>,
+				 <&crg HISTB_USB2_48M_CLK>;
+			clock-names = "bus", "clk12", "clk48";
+			resets = <&crg 0xb8 12>;
+			reset-names = "bus";
+			phys = <&usb2_phy1_port0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ehci: ehci at 9890000 {
+			compatible = "generic-ehci";
+			reg = <0x9890000 0x10000>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HISTB_USB2_BUS_CLK>,
+				 <&crg HISTB_USB2_PHY_CLK>,
+				 <&crg HISTB_USB2_UTMI_CLK>;
+			clock-names = "bus", "phy", "utmi";
+			resets = <&crg 0xb8 12>,
+				 <&crg 0xb8 16>,
+				 <&crg 0xb8 13>;
+			reset-names = "bus", "phy", "utmi";
+			phys = <&usb2_phy1_port0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1
