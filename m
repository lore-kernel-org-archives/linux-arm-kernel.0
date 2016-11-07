From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon,  7 Nov 2016 21:39:46 +0100
Subject: [PATCH v3 08/10] USB: ohci: da8xx: Add devicetree bindings
In-Reply-To: <20161107203948.28324-1-ahaslam@baylibre.com>
References: <20161107203948.28324-1-ahaslam@baylibre.com>
Message-ID: <20161107203948.28324-9-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents the device tree bindings required for
the ohci controller found in TI da8xx family of SoC's

Cc: devicetree at vger.kernel.org
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 .../devicetree/bindings/usb/ohci-da8xx.txt         | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ohci-da8xx.txt

diff --git a/Documentation/devicetree/bindings/usb/ohci-da8xx.txt b/Documentation/devicetree/bindings/usb/ohci-da8xx.txt
new file mode 100644
index 0000000..f18e82c
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ohci-da8xx.txt
@@ -0,0 +1,39 @@
+DA8XX USB OHCI controller
+
+Required properties:
+
+ - compatible: Should be "ti,da830-ohci"
+ - reg:        Should contain one register range i.e. start and length
+ - interrupts: Description of the interrupt line
+ - phys:       Phandle for the PHY device
+ - phy-names:  Should be "usb-phy"
+
+Optional properties:
+ - vbus-supply: Regulator that controls vbus power
+
+Example:
+
+reg_usb_ohci: regulator at 0 {
+        compatible = "regulator-fixed";
+        gpio = <&gpio 109 0>;
+        over-current-gpios = <&gpio 36 0>;
+        regulator-boot-on;
+        enable-active-high;
+        regulator-name = "usb_ohci_vbus";
+        regulator-min-microvolt = <5000000>;
+        regulator-max-microvolt = <5000000>;
+};
+
+usb_phy: usb-phy {
+        compatible = "ti,da830-usb-phy";
+        #phy-cells = <1>;
+};
+
+ohci: usb at 0225000 {
+        compatible = "ti,da830-ohci";
+        reg = <0x225000 0x1000>;
+        interrupts = <59>;
+        phys = <&usb_phy 1>;
+        phy-names = "usb-phy";
+        vbus-supply = <&reg_usb_ohci>;
+};
-- 
2.10.1
