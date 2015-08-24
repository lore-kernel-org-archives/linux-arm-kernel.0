From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 24 Aug 2015 08:40:08 +0000
Subject: [PATCH v4 5/5] dt/bindings: bcm2835: Add binding documentation for
 auxiliar spi devices
In-Reply-To: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org>
References: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1440405608-3995-6-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 .../bindings/spi/brcm,bcm2835-aux-spi.txt          |   61 ++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
new file mode 100644
index 0000000..2a69a3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
@@ -0,1 +1,61 @@
+Broadcom BCM2835 auxiliar SPI1/2 controller
+
+The BCM2835 contains two forms of SPI master controller, one known simply as
+SPI0, and the other known as the "Universal SPI Master"; part of the
+auxiliary block. This binding applies to the SPI1/2 controller.
+
+Required properties:
+- compatible: Should be "brcm,bcm2835-aux-spi".
+- reg: Should contain register location and length for the spi block
+       as well as for the common aux block control
+- interrupts: Should contain shared interrupt of the aux block
+- clocks: The clock feeding the SPI controller.
+- cs-gpios: the cs-gpios (native cs is NOT supported)
+	    see also spi-bus.txt
+- bcrm,aux-enable: the bcrm,bcm2835-aux-enable config entry to handle
+		  enabling/disabling of the spi1/spi2/uart1 HW block
+		  second "argument" is the mask to apply to the
+		  enable register
+
+Example:
+
+spi1 at 7e215080 {
+	compatible = "brcm,bcm2835-aux-spi";
+	reg = <0x7e215080 0x40>;
+	interrupts = <1 29>;
+	clocks = <&clk_spi>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpio 18>, <&gpio 17>, <&gpio 16>;
+	bcrm,aux-enable = <&aux_enable 2>;
+};
+
+spi2 at 7e2150c0 {
+	compatible = "brcm,bcm2835-aux-spi";
+	reg = <0x7e2150c0 0x40>;
+	interrupts = <1 29>;
+	clocks = <&clk_spi>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpio 43>, <&gpio 44>, <&gpio 45>;
+	bcrm,aux-enable = <&aux_enable 4>;
+};
+
+/* the necessary syscon config referenced above*/
+aux_enable: aux_enable at 0x7e215004 {
+	compatible = "bcrm,bcm2835-aux";
+	reg = <0x7e215004 0x04>;
+};
+
+Note that it also requires the GPIOs to be set up with the
+correct ALT-functions.
+
+For spi1 the following pins need to be set as:
+* ALT4: 19, 20, 21 (MISO, MOSI, SCK)
+
+For spi2 the following pins need to be set as:
+* ALT4: 40, 41, 42 (MISO, MOSI, SCK)
+
+CS-GPIOS need to get set as output - typically:
+* spi1: 18, 17, 16 (CS0, CS1, CS2)
+* spi2: 43, 44, 45 (CS0, CS1, CS2)
--
1.7.10.4
