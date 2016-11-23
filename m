From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Nov 2016 08:59:50 +0100
Subject: [PATCH 3/3] ARM: dts: sunxi: enable SDIO Wi-Fi on Orange Pi Zero
In-Reply-To: <20161121162421.800-3-icenowy@aosc.xyz>
References: <20161121162421.800-1-icenowy@aosc.xyz>
 <20161121162421.800-3-icenowy@aosc.xyz>
Message-ID: <20161123075950.fjtplylunwale6j4@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 22, 2016 at 12:24:21AM +0800, Icenowy Zheng wrote:
> There's a Allwinner's XR819 SDIO Wi-Fi module soldered on the board of
> Orange Pi Zero, which used a dedicated regulator to power.
> 
> Add the device tree node of the regulator, the enable gpio (with
> mmc-pwrseq) and the sdio controller.
> 
> There's a out-of-tree driver tested to work with this device tree.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> New patch in the patchset, since a out-of-tree working xradio driver is done.
> 
> If there is any problem in this patch, it can be omitted.

No particular problem with this one, however it can and should be
merged with the previous one.

Minor comments below though.

> 
>  arch/arm/boot/dts/sun8i-h2plus-orangepi-zero.dts | 42 ++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h2plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2plus-orangepi-zero.dts
> index b428e47..39cac26 100644
> --- a/arch/arm/boot/dts/sun8i-h2plus-orangepi-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2plus-orangepi-zero.dts
> @@ -79,6 +79,24 @@
>  			gpios = <&pio 0 17 GPIO_ACTIVE_HIGH>;
>  		};
>  	};
> +
> +	reg_vcc_wifi: reg_vcc_wifi {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc_wifi_pin_opi0>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-name = "vcc-wifi";
> +		enable-active-high;
> +		gpio = <&pio 0 20 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_pwrseq_pin_opi0>;
> +		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>;
> +	};
>  };
>  
>  &ehci1 {
> @@ -95,6 +113,20 @@
>  	status = "okay";
>  };
>  
> +&mmc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins_a>;
> +	vmmc-supply = <&reg_vcc_wifi>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	bus-width = <4>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&mmc1_pins_a {
> +	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;

This should be bias-pull-up.

> +};
> +
>  &ohci1 {
>  	status = "okay";
>  };
> @@ -104,6 +136,11 @@
>  		pins = "PA17";
>  		function = "gpio_out";
>  	};
> +
> +	vcc_wifi_pin_opi0: vcc_wifi_pin at 0 {
> +		allwinner,pins = "PA20";

This should be pins

> +		allwinner,function = "gpio_out";

This should be function

> +	};
>  };
>  
>  &r_pio {
> @@ -111,6 +148,11 @@
>  		pins = "PL10";
>  		function = "gpio_out";
>  	};
> +
> +	wifi_pwrseq_pin_opi0: wifi_pwrseq_pin at 0 {
> +		allwinner,pins = "PL7";
> +		allwinner,function = "gpio_out";

And same thing here.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161123/d0892fbe/attachment.sig>
