From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 Jul 2015 08:35:01 +0100
Subject: [PATCH v6 1/2] mfd: devicetree: add bindings for Atmel Flexcom
In-Reply-To: <bfff43813c2dc0a265bb644a87dcdd5fe58fc3e3.1437558598.git.cyrille.pitchen@atmel.com>
References: <cover.1437558598.git.cyrille.pitchen@atmel.com>
 <bfff43813c2dc0a265bb644a87dcdd5fe58fc3e3.1437558598.git.cyrille.pitchen@atmel.com>
Message-ID: <20150723073501.GU3061@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Jul 2015, Cyrille Pitchen wrote:

> This patch documents the DT bindings for the Atmel Flexcom which will be
> introduced by sama5d2x SoCs. These bindings will be used by the actual
> Flexcom driver to be sent in another patch.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  .../devicetree/bindings/mfd/atmel-flexcom.txt      | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> new file mode 100644
> index 000000000000..87a366b95ecf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> @@ -0,0 +1,67 @@
> +* Device tree bindings for Atmel Flexcom (Flexible Serial Communication Unit)
> +
> +The Atmel Flexcom is just a wrapper which embeds a SPI controller, an I2C
> +controller and an USART. Only one function can be used at a time and is chosen
> +at boot time according to the device tree.
> +
> +Required properties:
> +- compatible:		"atmel,sama5d2-flexcom"
> +- reg:			shall be the offset/length value for Flexcom dedicated
> +			I/O registers (without USART, TWI or SPI registers).
> +- clocks:		shall be the Flexcom peripheral clock from PMC.
> +- #address-cells:	should be <1>
> +- #size-cells:		should be <1>
> +- ranges:		one range for the full I/O register region (including
> +			USART, TWI and SPI registers).
> +
> +Required child:
> +a single available child for the serial controller to enable.

Not a fan of uppercase characters I see.

Nevertheless, documentation looks fine and doesn't introduce any new
properties, which we like.

Acked-by: Lee Jones <lee.jones@linaro.org>

> +One of the following substrings must be found inside the compatible property of
> +this child to enable the right serial controller:
> +- "-usart"
> +- "-spi"
> +- "-i2c"
> +
> +The reg property of this child should be:
> +- <0x200 0x200> for USART
> +- <0x400 0x200> for SPI
> +- <0x600 0x200> for I2C
> +
> +The phandle provided by the clocks property of the child is the same as one for
> +the Flexcom parent.
> +
> +Other properties remain unchanged. See documentation of the respective device:
> +- ../serial/atmel-usart.txt
> +- ../spi/spi_atmel.txt
> +- ../i2c/i2c-at91.txt
> +
> +Example:
> +
> +flexcom at f8034000 {
> +	compatible = "atmel,sama5d2-flexcom";
> +	reg = <0xf8034000 0x200>;
> +	clocks = <&flx0_clk>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges = <0x0 0xf8034000 0x800>;
> +
> +	spi at f8034400 {
> +		compatible = "atmel,at91rm9200-spi";
> +		reg = <0x400 0x200>;
> +		interrupts = <19 IRQ_TYPE_LEVEL_HIGH 7>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flx0_default>;
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
