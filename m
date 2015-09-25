From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 25 Sep 2015 22:32:13 +0100
Subject: [PATCH linux-next v10 2/3] mfd: devicetree: add bindings for
 Atmel Flexcom
In-Reply-To: <07fc381ccc3247e28eb94faf76cbcc94762ba622.1443087121.git.cyrille.pitchen@atmel.com>
References: <cover.1443087121.git.cyrille.pitchen@atmel.com>
 <07fc381ccc3247e28eb94faf76cbcc94762ba622.1443087121.git.cyrille.pitchen@atmel.com>
Message-ID: <20150925213213.GN27197@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Sep 2015, Cyrille Pitchen wrote:

> This patch documents the DT bindings for the Atmel Flexcom which will be
> introduced by sama5d2x SoCs. These bindings will be used by the actual
> Flexcom driver to be sent in another patch.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  .../devicetree/bindings/mfd/atmel-flexcom.txt      | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> new file mode 100644
> index 000000000000..fc3511e41542
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
> +- compatible:		Should be "atmel,sama5d2-flexcom"
> +- reg:			Should be the offset/length value for Flexcom dedicated
> +			I/O registers (without USART, TWI or SPI registers).
> +- clocks:		Should be the Flexcom peripheral clock from PMC.
> +- #address-cells:	Should be <1>
> +- #size-cells:		Should be <1>
> +- ranges:		Should be one range for the full I/O register region
> +			(including USART, TWI and SPI registers).
> +- atmel,flexcom-mode:	Should be one of the 3 following macros as defined in

They're not macros.

> +			include/dt-bindings/mfd/atmel-flexcom.h:

This is Linux specific.  Please remove it from the binding document.

> +			- ATMEL_FLEXCOM_MODE_USART for USART
> +			- ATMEL_FLEXCOM_MODE_SPI for SPI
> +			- ATMEL_FLEXCOM_MODE_TWI for I2C
> +
> +Required child:
> +a single child device of type matching the "atmel,flexcom-mode" property.

s/a/A/

> +The reg property of this child should be:
> +- <0x200 0x200> for USART
> +- <0x400 0x200> for SPI
> +- <0x600 0x200> for I2C

Address/offset information doesn't belong in the binding document.

> +The phandle provided by the clocks property of the child is the same as one for
> +the Flexcom parent.
> +
> +Other properties remain unchanged. See documentation of the respective device:

Unchanged since when?

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
> +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_SPI>;
> +
> +	spi at 400 {
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
