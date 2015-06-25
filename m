From: b18965@freescale.com (Alison Wang)
Date: Thu, 25 Jun 2015 14:24:58 +0800
Subject: [PATCH] dts: ls1021a: Add dts nodes for eTSEC0, eTSEC1 and eTSEC2
Message-ID: <1435213498-21025-1-git-send-email-b18965@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds generic dts nodes for eTSEC0, eTSEC1 and eTSEC2.

Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
Signed-off-by: Alison Wang <alison.wang@freescale.com>
---
 arch/arm/boot/dts/ls1021a-qds.dts | 20 ++++++++++
 arch/arm/boot/dts/ls1021a-twr.dts | 20 ++++++++++
 arch/arm/boot/dts/ls1021a.dtsi    | 82 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 9c5e16b..f16a061 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -75,6 +75,26 @@
 	};
 };
 
+&enet0 {
+	tbi-handle = <&tbi0>;
+	phy-handle = <&sgmii_phy1c>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&enet1 {
+	tbi-handle = <&tbi0>;
+	phy-handle = <&sgmii_phy1d>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&enet2 {
+	phy-handle = <&rgmii_phy3>;
+	phy-connection-type = "rgmii-id";
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index a2c591e..4b61766 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -73,6 +73,26 @@
 	};
 };
 
+&enet0 {
+	tbi-handle = <&tbi1>;
+	phy-handle = <&sgmii_phy2>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&enet1 {
+	tbi-handle = <&tbi1>;
+	phy-handle = <&sgmii_phy0>;
+	phy-connection-type = "sgmii";
+	status = "okay";
+};
+
+&enet2 {
+	phy-handle = <&rgmii_phy1>;
+	phy-connection-type = "rgmii-id";
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..6c41b10 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -59,6 +59,9 @@
 		serial3 = &lpuart3;
 		serial4 = &lpuart4;
 		serial5 = &lpuart5;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
 		sysclk = &sysclk;
 	};
 
@@ -391,6 +394,85 @@
 			reg = <0x0 0x2d24000 0x0 0x4000>;
 		};
 
+		enet0: ethernet at 2d10000 {
+			compatible = "fsl,etsec2";
+			device_type = "network";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupt-parent = <&gic>;
+			model = "eTSEC";
+			fsl,dma-endian-le;
+			fsl,magic-packet;
+			fsl,wake-on-filer;
+			fsl,num_rx_queues = <0x1>;
+			fsl,num_tx_queues = <0x1>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			ranges;
+
+			queue-group at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x0 0x2d10000 0x0 0x8000>;
+				fsl,rx-bit-map = <0xff>;
+				fsl,tx-bit-map = <0xff>;
+				interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+		};
+
+		enet1: ethernet at 2d50000 {
+			compatible = "fsl,etsec2";
+			device_type = "network";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupt-parent = <&gic>;
+			model = "eTSEC";
+			fsl,dma-endian-le;
+			fsl,num_rx_queues = <0x1>;
+			fsl,num_tx_queues = <0x1>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			ranges;
+
+			queue-group at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x0 0x2d50000 0x0 0x8000>;
+				fsl,rx-bit-map = <0xff>;
+				fsl,tx-bit-map = <0xff>;
+				interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+		};
+
+		enet2: ethernet at 2d90000 {
+			compatible = "fsl,etsec2";
+			device_type = "network";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupt-parent = <&gic>;
+			model = "eTSEC";
+			fsl,dma-endian-le;
+			fsl,num_rx_queues = <0x1>;
+			fsl,num_tx_queues = <0x1>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			ranges;
+
+			queue-group at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x0 0x2d90000 0x0 0x8000>;
+				fsl,rx-bit-map = <0xff>;
+				fsl,tx-bit-map = <0xff>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		usb at 8600000 {
 			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
 			reg = <0x0 0x8600000 0x0 0x1000>;
-- 
2.1.0.27.g96db324
