From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 28 Sep 2015 11:13:25 +0200
Subject: [PATCH linux-next v11 2/3] mfd: devicetree: add bindings for Atmel
 Flexcom
In-Reply-To: <cover.1443431309.git.cyrille.pitchen@atmel.com>
References: <cover.1443431309.git.cyrille.pitchen@atmel.com>
Message-ID: <377681c95dc91d6fc1d2c7b012ed8a71f7565e80.1443431309.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents the DT bindings for the Atmel Flexcom which will be
introduced by sama5d2x SoCs. These bindings will be used by the actual
Flexcom driver to be sent in another patch.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../devicetree/bindings/mfd/atmel-flexcom.txt      | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt

diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
new file mode 100644
index 000000000000..692300117c64
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
@@ -0,0 +1,63 @@
+* Device tree bindings for Atmel Flexcom (Flexible Serial Communication Unit)
+
+The Atmel Flexcom is just a wrapper which embeds a SPI controller, an I2C
+controller and an USART. Only one function can be used at a time and is chosen
+at boot time according to the device tree.
+
+Required properties:
+- compatible:		Should be "atmel,sama5d2-flexcom"
+- reg:			Should be the offset/length value for Flexcom dedicated
+			I/O registers (without USART, TWI or SPI registers).
+- clocks:		Should be the Flexcom peripheral clock from PMC.
+- #address-cells:	Should be <1>
+- #size-cells:		Should be <1>
+- ranges:		Should be one range for the full I/O register region
+			(including USART, TWI and SPI registers).
+- atmel,flexcom-mode:	Should be one of the following values:
+			- <1> for USART
+			- <2> for SPI
+			- <3> for I2C
+
+Required child:
+A single available child device of type matching the "atmel,flexcom-mode"
+property.
+
+The phandle provided by the clocks property of the child is the same as one for
+the Flexcom parent.
+
+For other properties, please refer to the documentations of the respective
+device:
+- ../serial/atmel-usart.txt
+- ../spi/spi_atmel.txt
+- ../i2c/i2c-at91.txt
+
+Example:
+
+flexcom at f8034000 {
+	compatible = "atmel,sama5d2-flexcom";
+	reg = <0xf8034000 0x200>;
+	clocks = <&flx0_clk>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x0 0xf8034000 0x800>;
+	atmel,flexcom-mode = <2>;
+
+	spi at 400 {
+		compatible = "atmel,at91rm9200-spi";
+		reg = <0x400 0x200>;
+		interrupts = <19 IRQ_TYPE_LEVEL_HIGH 7>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flx0_default>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&flx0_clk>;
+		clock-names = "spi_clk";
+		atmel,fifo-size = <32>;
+
+		mtd_dataflash at 0 {
+			compatible = "atmel,at25f512b";
+			reg = <0>;
+			spi-max-frequency = <20000000>;
+		};
+	};
+};
-- 
1.8.2.2
