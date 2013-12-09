From: w-kwok2@ti.com (WingMan Kwok)
Date: Mon, 9 Dec 2013 17:32:12 -0500
Subject: [PATCH v3 2/3] ARM: dts: keystone: Add usb devicetree bindings
In-Reply-To: <1386628333-1849-1-git-send-email-w-kwok2@ti.com>
References: <1386628333-1849-1-git-send-email-w-kwok2@ti.com>
Message-ID: <1386628333-1849-3-git-send-email-w-kwok2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added device tree support for TI's Keystone USB driver and updated the
Documentation with device tree binding information.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
---
 .../devicetree/bindings/usb/keystone-usb.txt       |   42 ++++++++++++++++++++
 arch/arm/boot/dts/k2hk-evm.dts                     |    8 ++++
 arch/arm/boot/dts/keystone.dtsi                    |   19 +++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/keystone-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/keystone-usb.txt b/Documentation/devicetree/bindings/usb/keystone-usb.txt
new file mode 100644
index 0000000..60527d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/keystone-usb.txt
@@ -0,0 +1,42 @@
+TI Keystone Soc USB Controller
+
+DWC3 GLUE
+
+Required properties:
+ - compatible: should be "ti,keystone-dwc3".
+ - #address-cells, #size-cells : should be '1' if the device has sub-nodes
+   with 'reg' property.
+ - reg : Address and length of the register set for the USB subsystem on
+   the SOC.
+ - interrupts : The irq number of this device that is used to interrupt the
+   MPU.
+ - ranges: allows valid 1:1 translation between child's address space and
+   parent's address space.
+ - clocks: Clock IDs array as required by the controller.
+ - clock-names: names of clocks correseponding to IDs in the clock property.
+
+Sub-nodes:
+The dwc3 core should be added as subnode to Keystone DWC3 glue.
+- dwc3 :
+   The binding details of dwc3 can be found in:
+   Documentation/devicetree/bindings/usb/dwc3.txt
+
+Example:
+	usb: usb at 2680000 {
+		compatible = "ti,keystone-dwc3";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x2680000 0x10000>;
+		clocks = <&clkusb>;
+		clock-names = "usb";
+		interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
+		ranges;
+		status = "disabled";
+
+		dwc3 at 2690000 {
+			compatible = "synopsys,dwc3";
+			reg = <0x2690000 0x70000>;
+			interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
+			usb-phy = <&usb_phy>, <&usb_phy>;
+		};
+	};
diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
index 15b3a95..eaefdfe 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -53,3 +53,11 @@
 		};
 	};
 };
+
+&usb_phy {
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 276bea9..b420290 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -189,5 +189,24 @@
 			reg = <0x2620738 32>;
 			status = "disabled";
 		};
+
+		usb: usb at 2680000 {
+			compatible = "ti,keystone-dwc3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x2680000 0x10000>;
+			clocks = <&clkusb>;
+			clock-names = "usb";
+			interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
+			ranges;
+			status = "disabled";
+
+			dwc3 at 2690000 {
+				compatible = "synopsys,dwc3";
+				reg = <0x2690000 0x70000>;
+				interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
+				usb-phy = <&usb_phy>, <&usb_phy>;
+			};
+		};
 	};
 };
-- 
1.7.9.5
