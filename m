From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 11 Sep 2015 11:22:03 +0000
Subject: [PATCH v6 1/4] dt/bindings: bcm2835: spi: add bindings for the
 bcm2835 auxiliary spi devices
In-Reply-To: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org>
References: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1441970527-2403-2-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

This defines the spi1 and spi2 devices in the device-tree.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 .../bindings/spi/brcm,bcm2835-aux-spi.txt          |   38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt

Changelog:
	v4->v5: fixed wording for reg
		removed reference to syscon
		removed documentation on typical GPIO config
	v5->v6:	move to clk-bcm2835-aux clock driver

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
new file mode 100644
index 0000000..9887b07
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
@@ -0,0 +1,38 @@
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
+- clocks: The clock feeding the SPI controller - needs to
+	  point to the auxiliar clock driver of the bcm2835,
+	  as this clock will enable the output gate for the specific
+	  clock.
+- cs-gpios: the cs-gpios (native cs is NOT supported)
+	    see also spi-bus.txt
+
+Example:
+
+spi1 at 7e215080 {
+	compatible = "brcm,bcm2835-aux-spi";
+	reg = <0x7e215080 0x40>;
+	interrupts = <1 29>;
+	clocks = <&aux_clocks BCM2835_AUX_CLOCK_SPI1>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpio 18>, <&gpio 17>, <&gpio 16>;
+};
+
+spi2 at 7e2150c0 {
+	compatible = "brcm,bcm2835-aux-spi";
+	reg = <0x7e2150c0 0x40>;
+	interrupts = <1 29>;
+	clocks = <&aux_clocks BCM2835_AUX_CLOCK_SPI2>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpio 43>, <&gpio 44>, <&gpio 45>;
+};
--
1.7.10.4
