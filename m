From: markus.mayer@linaro.org (Markus Mayer)
Date: Fri, 26 Jul 2013 13:25:44 -0700
Subject: [PATCH v3 2/3] ARM: bcm281xx: Device Tree bindings for GPIO
 driver
In-Reply-To: <1374870345-8276-1-git-send-email-markus.mayer@linaro.org>
References: <1374870345-8276-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <1374870345-8276-3-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Christian Daudt <csd@broadcom.com>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
 .../devicetree/bindings/gpio/gpio-bcm-kona.txt     |   41 ++++++++++++++++++++
 arch/arm/boot/dts/bcm11351.dtsi                    |   16 ++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt b/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt
new file mode 100644
index 0000000..08e9b5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt
@@ -0,0 +1,41 @@
+Broadcom Kona Family GPIO
+-------------------------
+
+This GPIO driver is used in the following Broadcom SoCs:
+  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
+
+The GPIO controller only supports edge, not level triggering.
+
+Required properties:
+  - compatible: "brcm,kona-gpio"
+  - reg: Physical base address and length of the controller's registers.
+  - interrupts: The interrupt outputs from the controller.
+  - #gpio-cells: Should be <2>. The first cell is the pin number, the second
+    cell is used to specify optional parameters:
+    - bit 0 specifies polarity (0 for normal, 1 for inverted)
+  - #interrupt-cells: Should be <2>. The first cell is the GPIO number.
+    The second cell is used to specify flags:
+    - trigger type (bits[1:0]):
+        1 = low-to-high edge triggered.
+        2 = high-to-low edge triggered.
+        3 = low-to-high or high-to-low edge triggered
+        Valid values are 1, 2, 3
+  - gpio-controller: Marks the device node as a GPIO controller.
+  - interrupt-controller: Marks the device node as an interrupt controller.
+
+Example:
+	gpio: gpio at 35003000 {
+		compatible = "brcm,kona-gpio";
+		reg = <0x35003000 0x800>;
+		interrupts =
+		       <0x0 106 0x4
+			0x0 115 0x4
+			0x0 114 0x4
+			0x0 113 0x4
+			0x0 112 0x4
+			0x0 111 0x4>;
+		#gpio-cells = <2>;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+	};
diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index c0cdf66..13aaa06 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -63,6 +63,22 @@
 		clock-frequency = <32768>;
 	};
 
+	gpio: gpio at 35003000 {
+		compatible = "brcm,kona-gpio";
+		reg = <0x35003000 0x800>;
+		interrupts =
+		       <0x0 106 0x4
+			0x0 115 0x4
+			0x0 114 0x4
+			0x0 113 0x4
+			0x0 112 0x4
+			0x0 111 0x4>;
+		#gpio-cells = <2>;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+	};
+
 	sdio0: sdio at 0x3f180000 {
 		compatible = "bcm,kona-sdhci";
 		reg = <0x3f180000 0x10000>;
-- 
1.7.9.5
