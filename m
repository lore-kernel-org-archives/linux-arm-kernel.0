From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri,  4 Sep 2015 09:41:50 +0000
Subject: [PATCH v5 6/6] dt/bindings: bcm2835: Add binding documentation for
 auxiliar spi devices
In-Reply-To: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
References: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1441359711-2800-7-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

add binding documentation

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 .../bindings/spi/brcm,bcm2835-aux-spi.txt          |   47 ++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt

Changelog:
	v4->v5: fixed wording for reg
		removed reference to syscon
		removed documentation on typical GPIO config

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
new file mode 100644
index 0000000..3ade499
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
@@ -0,0 +1,47 @@
+Broadcom BCM2835 auxiliar SPI1/2 controller
+
+The BCM2835 contains two forms of SPI master controller, one known simply as
+SPI0, and the other known as the "Universal SPI Master"; part of the
+auxiliary block. This binding applies to the SPI1/2 controller.
+
+Required properties:
+- compatible: Should be "brcm,bcm2835-aux-spi".
+- reg: Should contain register location and length for the spi block
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
+/* the necessary bcm2835 aux-enable referenced above */
+aux_enable: aux_enable at 0x7e215004 {
+	compatible = "bcrm,bcm2835-aux";
+	reg = <0x7e215004 0x04>;
+};
--
1.7.10.4
