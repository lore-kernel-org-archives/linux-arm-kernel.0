From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 21 May 2015 01:21:42 +0200
Subject: [PATCH] ARM: berlin: add SPI nodes for BG2Q
In-Reply-To: <1432126385-27402-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1432126385-27402-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <555D1706.7040309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.05.2015 14:53, Antoine Tenart wrote:
> The BG2Q SoC has two SPI controllers. Add the corresponding nodes.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
[...]

Some more I noticed while looking at BG2's spi controllers.

> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 187d056f7ad2..c25ee86b2bfa 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -286,6 +286,20 @@
>   				status = "disabled";
>   			};
>
> +			spi0: spi at 1c00 {
> +				compatible = "snps,dw-apb-ssi";
> +				reg = <0x1c00 0x100>;
> +				interrupt-parrent = <&aic>;
> +				interrupts = <7>;
> +				clocks = <&chip_clk CLKID_CFG>;
> +				pinctrl-0 = <&spi0_pmux>;
> +				pinctrl-names = "default";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				num-cs = <4>;

As you are adding this node to the SoC dtsi, I doubt that all boards
will use the _up to_ 4 available CSn lines. Most likely only one (or
even none) CSn will be used.

Anyway, you can leave the num-cs at 4 but...

> +				status = "disabled";
> +			};
> +
>   			timer0: timer at 2c00 {
>   				compatible = "snps,dw-apb-timer";
>   				reg = <0x2c00 0x14>;
> @@ -383,6 +397,11 @@
>   					groups = "G7";
>   					function = "twsi1";
>   				};
> +
> +				spi0_pmux: spi0-pmux {
> +					groups = "G8", "G9", "G10", "G11";
> +					function = "spi1";
> +				};

... can you check which of G8-G11 are actually clock/data and which
are CSn lines?

CSn lines should all be optional and per-board pinmux - same for the
other spi pinmux.

>   			};
>
>   			chip_rst: reset {
> @@ -473,6 +492,20 @@
>   				};
>   			};
>
> +			spi1: spi at 5000 {
> +				compatible = "snps,dw-apb-ssi";
> +				reg = <0x6000 0x100>;

s/spi at 5000/spi at 6000/

Sebastian
