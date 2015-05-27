From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 27 May 2015 10:03:01 +0200
Subject: [PATCH v2] ARM: berlin: add SPI nodes for BG2Q
In-Reply-To: <1432713573-32147-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1432713573-32147-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <55657A35.2090402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.05.2015 09:59, Antoine Tenart wrote:
> The BG2Q SoC has two SPI controllers. Add the corresponding nodes.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>
> Changes since v1:
> 	- reworked the pinmux
> 	- removed useless interrupt-parent properties
> 	- typo
>
>   arch/arm/boot/dts/berlin2q.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 187d056f7ad2..9f42ebfa50f2 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -286,6 +286,19 @@
>   				status = "disabled";
>   			};
>
> +			spi0: spi at 1c00 {
> +				compatible = "snps,dw-apb-ssi";
> +				reg = <0x1c00 0x100>;
> +				interrupts = <7>;
> +				clocks = <&chip_clk CLKID_CFG>;
> +				pinctrl-0 = <&spi1_pmux>;

Antoine,

you missed s/spi0/spi1/ and the same for the node below?

BTW, you have any SPI device to test this? If you are brave
enough you could read the flash from the Berlin secure boot
SPI key ;)

Sebastian

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
> @@ -383,6 +396,11 @@
>   					groups = "G7";
>   					function = "twsi1";
>   				};
> +
> +				spi1_pmux: spi1-pmux {
> +					groups = "G8";
> +					function = "spi1";
> +				};
>   			};
>
>   			chip_rst: reset {
> @@ -473,6 +491,19 @@
>   				};
>   			};
>
> +			spi1: spi at 6000 {
> +				compatible = "snps,dw-apb-ssi";
> +				reg = <0x6000 0x100>;
> +				interrupts = <5>;
> +				clocks = <&refclk>;
> +				pinctrl-0 = <&spi2_pmux>;
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
> @@ -564,6 +595,11 @@
>   						groups = "GSM14";
>   						function = "twsi3";
>   					};
> +
> +					spi2_pmux: spi2-pmux {
> +						groups = "GSM3";
> +						function = "spi2";
> +					};
>   				};
>   			};
>
>
