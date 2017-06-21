From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Wed, 21 Jun 2017 17:00:44 +0800
Subject: [PATCH 4/5] arm64: dts: hisilicon: add usb2 controller and phy nodes
 for poplar board.
In-Reply-To: <1498035645-22804-1-git-send-email-xuejiancheng@hisilicon.com>
References: <1498035645-22804-1-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <1498035645-22804-5-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb2 controller and phy nodes for poplar board.

Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts      | 13 ++++++
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     | 47 ++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
index 684fa09..40db803 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
@@ -64,6 +64,10 @@
 	};
 };
 
+&ehci {
+	status = "okay";
+};
+
 &gmac1 {
 	status = "okay";
 	#address-cells = <1>;
@@ -147,6 +151,10 @@
 	status = "okay";
 };
 
+&ohci {
+	status = "okay";
+};
+
 &spi0 {
 	status = "okay";
 	label = "LS-SPI0";
@@ -161,3 +169,8 @@
 	label = "LS-UART0";
 };
 /* No optional LS-UART1 on Low Speed Expansion Connector. */
+
+&usb2_phy1 {
+	status = "okay";
+};
+
diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index 75865f8a..422aeaf 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -106,6 +106,11 @@
 			#reset-cells = <2>;
 		};
 
+		peri_ctrl: system-controller at 8a20000 {
+			compatible = "syscon";
+			reg = <0x8a20000 0x1000>;
+		};
+
 		uart0: serial at 8b00000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x8b00000 0x1000>;
@@ -407,5 +412,47 @@
 			clocks = <&sysctrl HISTB_IR_CLK>;
 			status = "disabled";
 		};
+
+		ehci: ehci at 0x9890000 {
+			compatible = "generic-ehci";
+			reg = <0x9890000 0x10000>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HISTB_USB2_BUS_CLK>,
+				 <&crg HISTB_USB2_PHY_CLK>;
+			clock-names = "ehci_system", "phy";
+			resets = <&crg 0xb8 12>,
+				 <&crg 0xb8 16>;
+			reset-names = "bus", "phy";
+			status = "disabled";
+		};
+
+		ohci: ohci at 0x9880000 {
+			compatible = "generic-ohci";
+			reg = <0x9880000 0x10000>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HISTB_USB2_BUS_CLK>,
+				 <&crg HISTB_USB2_12M_CLK>,
+				 <&crg HISTB_USB2_48M_CLK>;
+			clock-names = "ahb_biu", "clk12", "clk48";
+			resets = <&crg 0xb8 12>;
+			reset-names = "bus";
+			status = "disabled";
+		};
+
+		usb2_phy1: usb-phy at 1 {
+			compatible = "hisilicon,hi3798cv200-usb2-phy";
+			#phy-cells = <0>;
+			hisilicon,peripheral-syscon = <&peri_ctrl>;
+			clocks = <&crg HISTB_USB2_PHY1_REF_CLK>;
+			resets = <&crg 0xbc 4>;
+			reset-names = "por_rst";
+			status = "disabled";
+
+			usb2_port1: port at 1 {
+				clocks = <&crg HISTB_USB2_UTMI_CLK>;
+				resets = <&crg 0xbc 9>, <&crg 0xb8 13>;
+				reset-names = "port_rst", "utmi_rst";
+			};
+		};
 	};
 };
-- 
1.9.1
