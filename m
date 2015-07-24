From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 24 Jul 2015 16:08:54 +0100
Subject: [PATCH v8 1/2] mfd: devicetree: add bindings for Atmel Flexcom
In-Reply-To: <738a001f14a5fa4fa8e5f90ad859a318cba0de42.1437731428.git.cyrille.pitchen@atmel.com>
References: <cover.1437731428.git.cyrille.pitchen@atmel.com>
 <738a001f14a5fa4fa8e5f90ad859a318cba0de42.1437731428.git.cyrille.pitchen@atmel.com>
Message-ID: <20150724150854.GI3436@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT chaps,

Please can you take a look at this binding.

In particular the use of the 'ranges' property to store device 'mode'.

> This patch documents the DT bindings for the Atmel Flexcom which will be
> introduced by sama5d2x SoCs. These bindings will be used by the actual
> Flexcom driver to be sent in another patch.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  .../devicetree/bindings/mfd/atmel-flexcom.txt      | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> new file mode 100644
> index 000000000000..588d527dbfa7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> @@ -0,0 +1,68 @@
> +* Device tree bindings for Atmel Flexcom (Flexible Serial Communication Unit)
> +
> +The Atmel Flexcom is just a wrapper which embeds a SPI controller, an I2C
> +controller and an USART. Only one function can be used at a time and is chosen
> +at boot time according to the device tree.
> +
> +Required properties:
> +- compatible:		Should be "atmel,sama5d2-flexcom"
> +- reg:			Should be the pair (offset, size) for the Flexcom
> +			dedicated I/O registers (without USART, TWI or SPI
> +			registers).
> +- clocks:		Should be the Flexcom peripheral clock from PMC.
> +- #address-cells:	Should be <2>
> +- #size-cells:		Should be <1>
> +- ranges:		Should be a list of ranges.
> +			One range per peripheral wrapped by the Flexcom. So each
> +			range is a triplet (child_addr, parent_addr, size). The
> +			first u32 of "child_addr" is the value to be set in the
> +			Operating Mode bitfield of the Flexcom Mode Register.
> +			Then "parent_addr" stores the base address of the
> +			corresponding peripheral in the system memory. Finally,
> +			"size" if the size of the memory region of this
> +			peripheral.
> +
> +Required child:
> +A single available child for the serial controller to enable.
> +
> +Required properties of this child:
> +- reg:			Should be a pair (child_addr, size) with child_addr
> +			matching one of the parent ranges.
> +- clocks:		Should be the very same phandle as for the parent's one.
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
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	ranges = <1 0 0xf8034200 0x200		/* opmode 1: USART */
> +		  2 0 0xf8034400 0x200		/* opmode 2: SPI */
> +		  3 0 0xf8034600 0x200>;	/* opmode 3: I2C */
> +
> +	spi at 2,0 {
> +		compatible = "atmel,at91rm9200-spi";
> +		reg = <2 0 0x200>;
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
