From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 21 Jul 2015 10:09:10 +0100
Subject: [PATCH v4 1/2] mfd: devicetree: add bindings for Atmel Flexcom
In-Reply-To: <337ab4936bd6ec2f24c42e2f8f363df21f491a02.1434967670.git.cyrille.pitchen@atmel.com>
References: <cover.1434967670.git.cyrille.pitchen@atmel.com>
 <337ab4936bd6ec2f24c42e2f8f363df21f491a02.1434967670.git.cyrille.pitchen@atmel.com>
Message-ID: <20150721090910.GG3061@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Jun 2015, Cyrille Pitchen wrote:

> This patch documents the DT bindings for the Atmel Flexcom which will be
> introduced by sama5d2x SoCs. These bindings will be used by the actual Flexcom
> driver to be sent in another patch.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  .../devicetree/bindings/mfd/atmel-flexcom.txt      | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> new file mode 100644
> index 0000000..38f0e43
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> @@ -0,0 +1,58 @@
> +* Device tree bindings for Atmel Flexcom (Flexible Serial Communication Unit)
> +
> +The Atmel Flexcom is just a wrapper which embeds a SPI controller, an I2C
> +controller and an USART. Only one function can be used at a time and is chosen
> +at boot time according to the device tree.
> +
> +Required properties:
> +- compatible: "atmel,sama5d2-flexcom"
> +- reg: shall be the offset/length value for Flexcom dedicated I/O registers
> +  (without USART, TWI or SPI registers).
> +- clocks: shall be the Flexcom peripheral clock from PMC.
> +- #address-cells: should be <1>
> +- #size-cells: should be <1>
> +- ranges: one range for the full I/O register region (including USART, TWI and
> +  SPI registers)
> +- atmel,flexcom-mode: shall be a string among { "spi", "usart", "i2c", "twi" }.
> +  "i2c" and "twi" are synonymous.

Please use a numerical value instead.  You can then define it in
include/dt-bindings/*

This is only required if you supply more than one child node.  Is that
the plan?  I ask because you only have one child node in the example
below.

This document is pretty hard to read.  Please line everything up
nicely, so it's easy on the eye:

- compatible: 	      "atmel,sama5d2-flexcom"
- reg: 		      shall be the offset/length value for Flexcom dedicated I/O registers
  		      (without USART, TWI or SPI registers).
- clocks: 	      shall be the Flexcom peripheral clock from PMC.
- #address-cells:     should be <1>
- #size-cells: 	      should be <1>
- ranges: 	      one range for the full I/O register region (including USART, TWI and
  		      SPI registers)
- atmel,flexcom-mode: shall be a string among { "spi", "usart", "i2c", "twi" }.
  		      "i2c" and "twi" are synonymous.

> +Required child:
> +a child device of type matching the "atmel,flexcom-mode" property.
> +The reg property of this child should be:
> +- <0x200 0x200> for USART
> +- <0x400 0x200> for SPI
> +- <0x600 0x200> for I2C
> +
> +The phandle provided by the clocks property of the child is the same as one for
> +the Flexcom parent.
> +Other properties remain unchanged. See documentation of the respective device.

Please point to the other documentation.

../uart/<blah>
../spi/<blah>
../i2c/<blah>

> +Example:
> +
> +flx0: flexcom at f8034000 {

What references this node?  If nothing, then you can remove the label.

> +	compatible = "atmel,sama5d2-flexcom";
> +	reg = <0xf8034000 0x200>;
> +	clocks = <&flx0_clk>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges = <0x0 0xf8034000 0x800>;
> +	atmel,flexcom-mode = "spi";
> +
> +	spi at f8034400 {
> +		compatible = "atmel,at91rm9200-spi";
> +		reg = <0x400 0x200>;
> +		interrupts = <19 IRQ_TYPE_LEVEL_HIGH 7>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flx0_ioset1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&flx0_clk>;
> +		clock-names = "spi_clk";
> +		atmel,fifo-size = <32>;
> +
> +		mtd_dataflash at 0 {
> +			compatible = "atmel,at25f512b";
> +			reg = <0>;
> +			spi-max-frequency = <20000000>;
> +		};
> +	};
> +};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
