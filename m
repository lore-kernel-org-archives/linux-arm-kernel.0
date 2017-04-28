From: jon.mason@broadcom.com (Jon Mason)
Date: Fri, 28 Apr 2017 16:29:41 -0400
Subject: [PATCH 3/3] arm64: dts: ns2: Add USB3 Support
In-Reply-To: <1493411381-16833-1-git-send-email-jon.mason@broadcom.com>
References: <1493411381-16833-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1493411381-16833-4-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>

Add USB3 support to the Northstar2 Device tree files

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 16 +++++++++
 arch/arm64/boot/dts/broadcom/ns2-xmc.dts |  8 +++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 62 ++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index ec19fbf..7cd2ef7 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -234,3 +234,19 @@
 		};
 	};
 };
+
+&usb3_phy0 {
+	status = "okay";
+};
+
+&usb3_phy1 {
+	status = "okay";
+};
+
+&xhci0 {
+	status = "okay";
+};
+
+&xhci1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/ns2-xmc.dts b/arch/arm64/boot/dts/broadcom/ns2-xmc.dts
index ab4ae1a..8e8feb7 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-xmc.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-xmc.dts
@@ -189,3 +189,11 @@
 &uart3 {
 	status = "okay";
 };
+
+&usb3_phy0 {
+	status = "okay";
+};
+
+&xhci0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 35a309a..2360ff5 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -343,6 +343,11 @@
 			      <0x660009b0 0x40>;
 		};
 
+		usb3_ctrl: syscon at 6501d144 {
+			compatible = "brcm,ns2-usb3-ctrl", "syscon";
+			reg = <0x6501d144 0x4>;
+		};
+
 		gpio_aon: gpio at 65024800 {
 			compatible = "brcm,iproc-gpio";
 			reg = <0x65024800 0x50>,
@@ -460,6 +465,11 @@
 			};
 		};
 
+		usb3_phy_cfg: syscon at 66000910 {
+			compatible = "brcm,ns2-usb3-phy-cfg", "syscon";
+			reg = <0x66000910 0x14>;
+		};
+
 		pwm: pwm at 66010000 {
 			compatible = "brcm,iproc-pwm";
 			reg = <0x66010000 0x28>;
@@ -487,6 +497,34 @@
 				};
 			};
 
+			mdio at 1 {
+				reg = <0x1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				usb3_phy: usb3_phy at 0 {
+					compatible = "brcm,ns2-usb3-phy";
+					reg = <0x0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					usb3-ctrl-syscon = <&usb3_ctrl>;
+					usb3-phy-cfg-syscon = <&usb3_phy_cfg>;
+					usb3-rst-ctrl-syscon = <&usb3_rst_ctrl>;
+
+					usb3_phy0: usb3_phy at 0 {
+						reg = <0>;
+						#phy-cells = <0>;
+						status = "disabled";
+					};
+
+					usb3_phy1: usb_phy at 1 {
+						reg = <1>;
+						#phy-cells = <0>;
+						status = "disabled";
+					};
+				};
+			};
+
 			mdio at 7 {
 				reg = <0x7>;
 				#address-cells = <1>;
@@ -652,6 +690,26 @@
 			reg = <0x66220000 0x28>;
 		};
 
+		xhci0: usb at 66300000 {
+			compatible = "generic-xhci";
+			reg = <0x66300000 0x1000>;
+			interrupts = <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb3_phy0>;
+			phy-names = "usb";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		xhci1: usb at 66310000 {
+			compatible = "generic-xhci";
+			reg = <0x66310000 0x1000>;
+			interrupts = <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb3_phy1>;
+			phy-names = "usb";
+			dma-coherent;
+			status = "disabled";
+		};
+
 		sata_phy: sata_phy at 663f0100 {
 			compatible = "brcm,iproc-ns2-sata-phy";
 			reg = <0x663f0100 0x1f00>,
@@ -747,5 +805,9 @@
 			#size-cells = <0>;
 		};
 
+		usb3_rst_ctrl: syscon at 67000408 {
+			compatible = "brcm,ns2-usb3-rst-ctrl", "syscon";
+			reg = <0x67000408 0x1808>;
+		};
 	};
 };
-- 
2.7.4
