From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 26 Nov 2016 15:56:31 +0100
Subject: [PATCH 1/5] Documentation: dt-bindings: Add documentation for Meson
 GXL USB2/3 PHYs
In-Reply-To: <20161126145635.24488-1-martin.blumenstingl@googlemail.com>
References: <20161126145635.24488-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161126145635.24488-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the DT binding documentation for the USB2 and USB3 PHYs found
in the Meson GXL and GXM SoCs.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/phy/meson-gxl-usb2-phy.txt | 25 ++++++++++++++++++++
 .../devicetree/bindings/phy/meson-gxl-usb3-phy.txt | 27 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-gxl-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/meson-gxl-usb3-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/meson-gxl-usb2-phy.txt b/Documentation/devicetree/bindings/phy/meson-gxl-usb2-phy.txt
new file mode 100644
index 0000000..e7828ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/meson-gxl-usb2-phy.txt
@@ -0,0 +1,25 @@
+* Amlogic Meson GXL and GXM USB2 PHY binding
+
+This describes the USB2 PHY block which provides multiple USB2 PHY ports.
+
+Required properties:
+- compatible:	Should be "amlogic,meson-gxl-usb2-phy"
+- reg:		The base address and length of the registers
+- #phys-cells:	should be 1 (see phy-bindings.txt in this directory)
+- clocks:	phandle and clock identifier for the phy clocks
+- clock-names:	"usb" and "usb_ddr"
+- resets:	reference to the reset controller
+
+Optional properties:
+- phy-supply:	see phy-bindings.txt in this directory
+
+
+Example:
+	usb2_phys: phy at 78000 {
+		compatible = "amlogic,meson-gxl-usb2-phy";
+		#phy-cells = <1>;
+		reg = <0x0 0x78000 0x0 0x80>;
+		clocks = <&clkc CLKID_USB1>, <&clkc CLKID_USB1_DDR_BRIDGE>;
+		clock-names = "usb", "usb_ddr";
+		resets = <&reset RESET_USB_OTG>;
+	};
diff --git a/Documentation/devicetree/bindings/phy/meson-gxl-usb3-phy.txt b/Documentation/devicetree/bindings/phy/meson-gxl-usb3-phy.txt
new file mode 100644
index 0000000..be779e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/meson-gxl-usb3-phy.txt
@@ -0,0 +1,27 @@
+* Amlogic Meson GXL and GXM USB3 PHY binding
+
+Required properties:
+- compatible:	Should be "amlogic,meson-gxl-usb3-phy"
+- reg:		The base address and length of the registers
+- #phys-cells:	should be 0 (see phy-bindings.txt in this directory)
+- interrupts:	describes the OTG device/host mode detection interrupt
+- phys:		a list of related PHYs (typically the USB2 PHYs, see
+		meson-gxl-usb2-phy.txt in this directory). The mode of
+		the listed PHYs will be managed by the USB3 PHY (which
+		is required for OTG device/host detection to work).
+		The number of PHYs listed typically matches the number
+		of ports which are enabled in the USB controller which
+		uses this PHY.
+
+Optional properties:
+- phy-supply:	see phy-bindings.txt in this directory
+
+
+Example:
+	usb3_phy0: phy at 78080 {
+		compatible = "amlogic,meson-gxl-usb3-phy";
+		#phy-cells = <0>;
+		reg = <0x0 0x78080 0x0 0x20>;
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+		phys = <&usb2_phys 0>, <&usb2_phys 1>;
+	};
-- 
2.10.2
