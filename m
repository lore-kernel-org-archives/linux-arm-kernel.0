From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 15 Jun 2015 19:27:15 +0200
Subject: [PATCH linux-next 1/2] mfd: devicetree: add bindings for Atmel
 Flexcom
In-Reply-To: <9cb26f42aaba9629e48d3def610ce90aa8574e06.1434386119.git.cyrille.pitchen@atmel.com>
References: <cover.1434386119.git.cyrille.pitchen@atmel.com>
 <9cb26f42aaba9629e48d3def610ce90aa8574e06.1434386119.git.cyrille.pitchen@atmel.com>
Message-ID: <20150615192715.31a387c8@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyrille,

On Mon, 15 Jun 2015 18:38:04 +0200
Cyrille Pitchen <cyrille.pitchen@atmel.com> wrote:

> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  .../devicetree/bindings/mfd/atmel-flexcom.txt      | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> new file mode 100644
> index 0000000..6b1a32e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> @@ -0,0 +1,28 @@
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
> +- ranges: must be present
> +- atmel,flexcom-mode: shall be a string among { "spi", "usart", "i2c", "twi" }.
> +  "i2c" and "twi" are synonymous.
> +
> +Example:
> +
> +flx0: flexcom at f8034000 {
> +	compatible = "atmel,sama5d2-flexcom";
> +	reg = <0xf8034000 0x200>;
> +	clocks = <&flx0_clk>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges;
> +	atmel,flexcom-mode = "spi";
> +};

Since the subdevices are using a set of registers contained by the
flexcom device I would define it like this:

flx0: flexcom at f8034000 {
	compatible = "atmel,sama5d2-flexcom";
	reg = <0xf8034000 0x800>;
	clocks = <&flx0_clk>;
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0x0 0xf8034000 0x800>;
	atmel,flexcom-mode = "spi";

	usart at 200 {
		reg = <0x200 0x100>;
		/* ... */
	};

	spi at 400 {
		reg = <0x400 0x100>;
		/* ... */
	};

	i2c at 600 {
		reg = <0x600 0x100>;
		/* ... */
	};
};

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
