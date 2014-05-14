From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 May 2014 09:50:17 +0200
Subject: [PATCH v6 3/3] ARM: sunxi: Add IR controller support in DT on A20
In-Reply-To: <1400006342-2968-4-git-send-email-bay@hackerdom.ru>
References: <1400006342-2968-1-git-send-email-bay@hackerdom.ru>
 <1400006342-2968-4-git-send-email-bay@hackerdom.ru>
Message-ID: <20140514075017.GH29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 12:39:02AM +0600, Alexander Bersenev wrote:
> This patch adds IR controller in A20 Device-Tree:
> - Two IR devices found in A20 user manual
> - Pins for two devices
> - One IR device physically found on Cubieboard 2
> - One IR device physically found on Cubietruck
> 
> Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
> Signed-off-by: Alexsey Shestacov <wingrime@linux-sunxi.org>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts |  6 ++++++
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts  |  6 ++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi            | 31 +++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> index feeff64..2564e8c 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -164,6 +164,12 @@
>  				reg = <1>;
>  			};
>  		};
> +
> +		ir0: ir at 01c21800 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&ir0_pins_a>;
> +			status = "okay";
> +		};
>  	};
>  
>  	leds {
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index e288562..e375e89 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -232,6 +232,12 @@
>  				reg = <1>;
>  			};
>  		};
> +
> +		ir0: ir at 01c21800 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&ir0_pins_a>;
> +			status = "okay";
> +		};
>  	};
>  
>  	leds {

Please make these two changes a separate patch.

> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 0ae2b77..40ded74 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -724,6 +724,19 @@
>  				allwinner,drive = <2>;
>  				allwinner,pull = <0>;
>  			};
> +
> +			ir0_pins_a: ir0 at 0 {
> +				    allwinner,pins = "PB3","PB4";
> +				    allwinner,function = "ir0";
> +				    allwinner,drive = <0>;
> +				    allwinner,pull = <0>;
> +			};

Extra line

> +			ir1_pins_a: ir1 at 0 {
> +				    allwinner,pins = "PB22","PB23";
> +				    allwinner,function = "ir1";
> +				    allwinner,drive = <0>;
> +				    allwinner,pull = <0>;
> +			};
>  		};

Do you use ir1_pins_a at all?

I also prefer whenever such additions are in a patch of their own.

>  		timer at 01c20c00 {
> @@ -937,5 +950,23 @@
>  			#interrupt-cells = <3>;
>  			interrupts = <1 9 0xf04>;
>  		};
> +
> +		ir0: ir at 01c21800 {
> +			compatible = "allwinner,sun7i-a20-ir";
> +			clocks = <&apb0_gates 6>, <&ir0_clk>;
> +			clock-names = "apb", "ir";
> +			interrupts = <0 5 4>;
> +			reg = <0x01c21800 0x40>;
> +			status = "disabled";
> +		};
> +
> +		ir1: ir at 01c21c00 {
> +			compatible = "allwinner,sun7i-a20-ir";
> +			clocks = <&apb0_gates 7>, <&ir1_clk>;
> +			clock-names = "apb", "ir";
> +			interrupts = <0 6 4>;
> +			reg = <0x01C21c00 0x40>;

You're mixing upper and lower case letters here, please make it lower
case.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/b6ddd821/attachment.sig>
