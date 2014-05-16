From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 May 2014 09:35:40 -0400
Subject: [PATCH v2 2/3] ARM: dts: kirkwood: add kirkwood-km_common DTSI
 files
In-Reply-To: <1400230143-15620-3-git-send-email-valentin.longchamp@keymile.com>
References: <1400230143-15620-1-git-send-email-valentin.longchamp@keymile.com>
 <1400230143-15620-3-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <20140516133540.GJ27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 10:49:02AM +0200, Valentin Longchamp wrote:
> This file allows to factor the common parts between the various Keymile
> Kirkwood Designs.
> 
> kirkwood-km_common configures the peripherals that are currently
> common to all our Kirkwood designs: PCIe, pinctrl, bitbang I2C, NAND
> Flash controller.
> 
> The kirkwood-km_kirkwood file is then changed to include this common
> file.
> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> 
> ---
> 
> Changes in v2:
> - introduce kirkwood-km_common.dtsi to allow factoring some nodes
>   between boards
> 
>  arch/arm/boot/dts/kirkwood-km_common.dtsi  | 48 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-km_kirkwood.dts | 38 +----------------------
>  2 files changed, 49 insertions(+), 37 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-km_common.dtsi
> 
> diff --git a/arch/arm/boot/dts/kirkwood-km_common.dtsi b/arch/arm/boot/dts/kirkwood-km_common.dtsi
> new file mode 100644
> index 0000000..b241135
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-km_common.dtsi
> @@ -0,0 +1,48 @@
> +/ {
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +		stdout-path = &uart0;
> +	};
> +
> +	mbus {
> +		pcie-controller {
> +			status = "okay";
> +
> +			pcie at 1,0 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	ocp at f1000000 {
> +		pinctrl: pin-controller at 10000 {
> +			pinctrl-0 = < &pmx_i2c_gpio_sda &pmx_i2c_gpio_scl >;
> +			pinctrl-names = "default";
> +
> +			pmx_i2c_gpio_sda: pmx-gpio-sda {
> +				marvell,pins = "mpp8";
> +				marvell,function = "gpio";
> +			};
> +			pmx_i2c_gpio_scl: pmx-gpio-scl {
> +				marvell,pins = "mpp9";
> +				marvell,function = "gpio";
> +			};
> +		};
> +
> +		serial at 12000 {
> +			status = "ok";

nit: This should match the other status properties and use "okay".

> +		};
> +	};
> +
> +	i2c at 0 {
> +		compatible = "i2c-gpio";
> +		gpios = < &gpio0 8 GPIO_ACTIVE_HIGH		/* sda */
> +			  &gpio0 9 GPIO_ACTIVE_HIGH>;		/* scl */
> +		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
> +	};
> +};
> +
> +&nand {
> +	status = "okay";
> +	chip-delay = <25>;
> +};
> diff --git a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
> index 61139bf..235bf38 100644
> --- a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
> +++ b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
> @@ -2,6 +2,7 @@
>  
>  #include "kirkwood.dtsi"
>  #include "kirkwood-98dx4122.dtsi"
> +#include "kirkwood-km_common.dtsi"
>  
>  / {
>  	model = "Keymile Kirkwood Reference Design";
> @@ -11,43 +12,6 @@
>  		device_type = "memory";
>  		reg = <0x00000000 0x08000000>;
>  	};
> -
> -	chosen {
> -		bootargs = "console=ttyS0,115200n8 earlyprintk";
> -		stdout-path = &uart0;
> -	};
> -
> -	ocp at f1000000 {
> -		pinctrl: pin-controller at 10000 {
> -			pinctrl-0 = < &pmx_i2c_gpio_sda &pmx_i2c_gpio_scl >;
> -			pinctrl-names = "default";
> -
> -			pmx_i2c_gpio_sda: pmx-gpio-sda {
> -				marvell,pins = "mpp8";
> -				marvell,function = "gpio";
> -			};
> -			pmx_i2c_gpio_scl: pmx-gpio-scl {
> -				marvell,pins = "mpp9";
> -				marvell,function = "gpio";
> -			};
> -		};
> -
> -		serial at 12000 {
> -			status = "ok";

Yeah, I probably let it in in the first place :)

If that is all there is with this series, I'll fix it up when I pull it
in.

thx,

Jason.
