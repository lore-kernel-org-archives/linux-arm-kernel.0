From: claudiu.manoil@freescale.com (Claudiu Manoil)
Date: Tue, 14 Jul 2015 18:46:17 +0300
Subject: [PATCH v2] dts: ls1021a: Add dts nodes for eTSEC0, eTSEC1 and eTSEC2
In-Reply-To: <20150713133138.GO23464@tiger>
References: <20150713133138.GO23464@tiger>
Message-ID: <1436888777-29742-1-git-send-email-claudiu.manoil@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds generic dts nodes for eTSEC0, eTSEC1 and eTSEC2.

Signed-off-by: Alison Wang <alison.wang@freescale.com>

Enable support for the second interrupt group register block
and the corresponding Rx/Tx/Err interrupt sources, for each
eTSEC node.  DT binding documentation updates.

Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
---
v2:
 - register block size is 0x1000 (4kB memory page), not 0x8000;
 - reg property has 2 "address" and resp. 2 "size" cells;
 - remove optional/ obsoleted properties;
 - use register block address as queue-group id for consistency;
 - binding documentation updates for missing vendor properties;


 .../devicetree/bindings/net/fsl-tsec-phy.txt       |  6 +-
 arch/arm/boot/dts/ls1021a-qds.dts                  | 20 +++++
 arch/arm/boot/dts/ls1021a-twr.dts                  | 20 +++++
 arch/arm/boot/dts/ls1021a.dtsi                     | 92 ++++++++++++++++++++++
 4 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
index 1e97532..b3291c7 100644
--- a/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
+++ b/Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
@@ -45,7 +45,7 @@ Properties:
 
   - device_type : Should be "network"
   - model : Model of the device.  Can be "TSEC", "eTSEC", or "FEC"
-  - compatible : Should be "gianfar"
+  - compatible : "gianfar", "fsl-etsec2"
   - reg : Offset and length of the register set for the device
   - interrupts : For FEC devices, the first interrupt is the device's
     interrupt.  For TSEC and eTSEC devices, the first interrupt is
@@ -57,6 +57,10 @@ Properties:
     "rgmii-id", as all other connection types are detected by hardware.
   - fsl,magic-packet : If present, indicates that the hardware supports
     waking up via magic packet.
+  - fsl,wake-on-filer: Indicates that the device can wake up the system
+    by generating a filer interrupt. Depending on the wake-on-lan mode
+    set for this device, the filer interrupt can be triggered by certain
+    user-defined ethernet packets (usually ARP or L2 unicast packets).
   - bd-stash : If present, indicates that the hardware supports stashing
     buffer descriptors in the L2.
   - rx-stash-len : Denotes the number of bytes of a received buffer to stash
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
index c70bb27..cc48d56 100644
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
 
@@ -391,6 +394,95 @@
 			reg = <0x0 0x2d24000 0x0 0x4000>;
 		};
 
+		enet0: ethernet at 2d10000 {
+			compatible = "fsl,etsec2";
+			device_type = "network";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupt-parent = <&gic>;
+			model = "eTSEC";
+			fsl,magic-packet;
+			fsl,wake-on-filer;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			ranges;
+
+			queue-group at 2d10000 {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				reg = <0x0 0x2d10000 0x0 0x1000>;
+				interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			queue-group at 2d14000  {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				reg = <0x0 0x2d14000 0x0 0x1000>;
+				interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		enet1: ethernet at 2d50000 {
+			compatible = "fsl,etsec2";
+			device_type = "network";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupt-parent = <&gic>;
+			model = "eTSEC";
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			ranges;
+
+			queue-group at 2d50000  {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				reg = <0x0 0x2d50000 0x0 0x1000>;
+				interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			queue-group at 2d54000  {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				reg = <0x0 0x2d54000 0x0 0x1000>;
+				interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		enet2: ethernet at 2d90000 {
+			compatible = "fsl,etsec2";
+			device_type = "network";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupt-parent = <&gic>;
+			model = "eTSEC";
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			ranges;
+
+			queue-group at 2d90000  {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				reg = <0x0 0x2d90000 0x0 0x1000>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			queue-group at 2d94000  {
+				#address-cells = <2>;
+				#size-cells = <2>;
+				reg = <0x0 0x2d94000 0x0 0x1000>;
+				interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		usb at 8600000 {
 			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
 			reg = <0x0 0x8600000 0x0 0x1000>;
-- 
1.7.11.7
