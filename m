From: robh@kernel.org (Rob Herring)
Date: Thu, 25 Oct 2018 14:59:07 -0500
Subject: [PATCH] spi: uniphier: fix incorrect property items
In-Reply-To: <1540373669-18969-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1540373669-18969-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <20181025195906.GA22391@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 06:34:29PM +0900, Keiji Hayashibara wrote:
> This commit fixes incorrect property because it was different
> from the actual.
> The parameters of '#address-cells' and '#size-cells' were removed,
> and 'interrupts', 'pinctrl-names' and 'pinctrl-0' were added.
> 
> Fixes: 4dcd5c2781f3 ("spi: add DT bindings for UniPhier SPI controller")
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-uniphier.txt | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-uniphier.txt b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
> index 504a4ec..b04e66a 100644
> --- a/Documentation/devicetree/bindings/spi/spi-uniphier.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
> @@ -5,18 +5,20 @@ UniPhier SoCs have SCSSI which supports SPI single channel.
>  Required properties:
>   - compatible: should be "socionext,uniphier-scssi"
>   - reg: address and length of the spi master registers
> - - #address-cells: must be <1>, see spi-bus.txt
> - - #size-cells: must be <0>, see spi-bus.txt

How is removing these correct? They are needed if you have any child 
devices.

> - - clocks: A phandle to the clock for the device.
> - - resets: A phandle to the reset control for the device.
> + - interrupts: a single interrupt specifier
> + - pinctrl-names: should be "default"
> + - pinctrl-0: pin control state for the default mode
> + - clocks: a phandle to the clock for the device
> + - resets: a phandle to the reset control for the device
>  
>  Example:
>  
>  spi0: spi at 54006000 {
>  	compatible = "socionext,uniphier-scssi";
>  	reg = <0x54006000 0x100>;
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> +	interrupts = <0 39 4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi0>;
>  	clocks = <&peri_clk 11>;
>  	resets = <&peri_rst 11>;
>  };
> -- 
> 2.7.4
> 
