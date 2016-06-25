From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 25 Jun 2016 09:16:33 +0200
Subject: [PATCH v2 10/14] ARM: dts: sun8i: Add r_twi I2C controller
In-Reply-To: <20160625034511.7966-11-megous@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-11-megous@megous.com>
Message-ID: <20160625071633.GD4000@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jun 25, 2016 at 05:45:07AM +0200, megous at megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> H3 SoC contains I2C controller optionally available
> on the PL0 and PL1 pins. This patch makes this controller
> available.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 56f211e..e32f211 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -322,8 +322,9 @@
>  			reg = <0x01f01428 0x4>;
>  			#clock-cells = <1>;
>  			clocks = <&apb0>;
> -			clock-indices = <0>, <1>;
> -			clock-output-names = "apb0_pio", "apb0_ir";
> +			clock-indices = <0>, <1>, <6>;
> +			clock-output-names = "apb0_pio", "apb0_ir", "apb0_i2c";
> +

The new line is not needed, and it should be part of a separate patch.

>  		};
>  
>  		ir_clk: ir_clk at 01f01454 {
> @@ -656,6 +657,20 @@
>  			status = "disabled";
>  		};
>  
> +		r_twi: i2c at 01f02400 {

We call it i2c everywhere, please call it that way too.

> +			compatible = "allwinner,sun6i-a31-i2c";
> +			reg = <0x01f02400 0x400>;
> +			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&r_twi_pins_a>;
> +			clocks = <&apb0_gates 6>;
> +			clock-frequency = <100000>;
> +			resets = <&apb0_reset 6>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
>  		gic: interrupt-controller at 01c81000 {
>  			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
>  			reg = <0x01c81000 0x1000>,
> @@ -707,6 +722,13 @@
>  				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>  				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  			};
> +
> +			r_twi_pins_a: r_twi at 0 {
> +				allwinner,pins = "PL0", "PL1";
> +				allwinner,function = "s_twi";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;

Separate patch please.

Thanks!

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160625/5c48f897/attachment.sig>
