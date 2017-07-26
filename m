From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Wed, 26 Jul 2017 14:06:02 +0800
Subject: [PATCH v2 3/4] arm64: dts: hisilicon: add usb2 controller and phy
 nodes for poplar board.
In-Reply-To: <1501049163-18892-1-git-send-email-xuejiancheng@hisilicon.com>
References: <1501049163-18892-1-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <1501049163-18892-4-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usb2 controller and phy nodes for poplar board.

Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts      | 13 +++++
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     | 60 ++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
index b914287..4656ba9 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
@@ -63,6 +63,10 @@
 	};
 };
 
+&ehci {
+	status = "okay";
+};
+
 &gmac1 {
 	status = "okay";
 	#address-cells = <1>;
@@ -146,6 +150,10 @@
 	status = "okay";
 };
 
+&ohci {
+	status = "okay";
+};
+
 &spi0 {
 	status = "okay";
 	label = "LS-SPI0";
@@ -160,3 +168,8 @@
 	label = "LS-UART0";
 };
 /* No optional LS-UART1 on Low Speed Expansion Connector. */
+
+&usb2_phy1 {
+	status = "okay";
+};
+
diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index 75865f8a..250b68b 100644
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
@@ -407,5 +412,60 @@
 			clocks = <&sysctrl HISTB_IR_CLK>;
 			status = "disabled";
 		};
+
+		ehci: ehci at 0x9890000 {
+			compatible = "generic-ehci";
+			reg = <0x9890000 0x10000>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg HISTB_USB2_BUS_CLK>,
+				 <&crg HISTB_USB2_PHY_CLK>,
+				 <&crg HISTB_USB2_UTMI_CLK>;
+			clock-names = "ehci_system", "phy", "utmi";
+			resets = <&crg 0xb8 12>,
+				 <&crg 0xb8 16>,
+				 <&crg 0xb8 13>;
+			reset-names = "bus", "phy", "utmi";
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
+			hisilicon,phycon-reg = <0x120>;
+			hisilicon,port-num = <2>;
+			clocks = <&crg HISTB_USB2_PHY1_REF_CLK>;
+			resets = <&crg 0xbc 4>,
+				 <&crg 0xbc 8>,
+				 <&crg 0xbc 9>;
+			reset-names = "power_on", "utmi0", "utmi1";
+			status = "disabled";
+		};
+
+		usb2_phy2: usb-phy at 2 {
+			compatible = "hisilicon,hi3798cv200-usb2-phy";
+			#phy-cells = <0>;
+			hisilicon,peripheral-syscon = <&peri_ctrl>;
+			hisilicon,phycon-reg = <0x124>;
+			hisilicon,port-num = <1>;
+			clocks = <&crg HISTB_USB2_PHY2_REF_CLK>;
+			resets = <&crg 0xbc 6>,
+				 <&crg 0xbc 10>;
+			reset-names = "power_on", "utmi0";
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1
