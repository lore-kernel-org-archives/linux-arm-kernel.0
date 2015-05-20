From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 20 May 2015 18:58:35 +0200
Subject: [PATCH] ARM: berlin: add SPI nodes for BG2Q
In-Reply-To: <1432126385-27402-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1432126385-27402-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <555CBD3B.1000809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.05.2015 14:53, Antoine Tenart wrote:
> The BG2Q SoC has two SPI controllers. Add the corresponding nodes.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>
> Based on top of the Berlin clock rework series.
>
>   arch/arm/boot/dts/berlin2q.dtsi | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>
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

Antoine,

the same question as for the ADC node patch: IIRC you don't have
to repeat the interrupt-parent property as long as any node upstream
will have it already.

> +				interrupts = <7>;
> +				clocks = <&chip_clk CLKID_CFG>;
> +				pinctrl-0 = <&spi0_pmux>;
> +				pinctrl-names = "default";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				num-cs = <4>;
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

Hmm, "spi0_pmux" but "spi1" function?

> +				};
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
> +				interrupt-parent = <&sic>;
> +				interrupts = <5>;
> +				clocks = <&refclk>;
> +				pinctrl-0 = <&spi1_pmux>;
> +				pinctrl-names = "default";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				num-cs = <4>;
> +				status = "disabled";
> +			};
> +
>   			i2c2: i2c at 7000 {
>   				compatible = "snps,designware-i2c";
>   				#address-cells = <1>;
> @@ -564,6 +597,11 @@
>   						groups = "GSM14";
>   						function = "twsi3";
>   					};
> +
> +					spi1_pmux: spi1-pmux {
> +						groups = "GSM0", "GSM1", "GSM2", "GSM3";
> +						function = "spi2";

ditto.

I know the internal numbering scheme on BG-SoCs is weird, but it looks 
like that either you are missing the third SPI or there is only 2 and
numbering starts with 1 *sigh* ;)

Anyway, the numbering should be consistent with pinctrl function names
although I would have preferred to start counting with 0.

Sebastian

> +					};
>   				};
>   			};
>
>
