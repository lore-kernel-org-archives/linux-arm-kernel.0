From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 24 May 2017 11:50:44 +0200
Subject: [PATCH] ARM: dts: rockchip: add adc button for Firefly
In-Reply-To: <20170507142627.5307-1-ayaka@soulik.info>
References: <20170507142627.5307-1-ayaka@soulik.info>
Message-ID: <2018816.Fb9eUWctIC@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

Am Sonntag, 7. Mai 2017, 22:26:27 CEST schrieb Randy Li:
> The only adc button connected to adc input is recovery button.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  arch/arm/boot/dts/rk3288-firefly-reload.dts | 17 +++++++++++++++++
>  arch/arm/boot/dts/rk3288-firefly.dtsi       | 13 +++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-firefly-reload.dts b/arch/arm/boot/dts/rk3288-firefly-reload.dts
> index d0b3204a..ed1baa8 100644
> --- a/arch/arm/boot/dts/rk3288-firefly-reload.dts
> +++ b/arch/arm/boot/dts/rk3288-firefly-reload.dts
> @@ -48,6 +48,19 @@
>  	model = "Firefly-RK3288-reload";
>  	compatible = "firefly,firefly-rk3288-reload", "rockchip,rk3288";
>  
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 1>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1800000>;
> +
> +		button-recovery {
> +			label = "Recovery";
> +			linux,code = <KEY_BACK>;

I don't think KEY_BACK is really a suitable keycode for your recovery key.

Looking at other devices and already available keycodes. I guess nice
choices would be one of

- KEY_VENDOR
- KEY_MENU
- KEY_CONFIG

With for example meson adding KEY_VENDOR as update key recently
https://lkml.org/lkml/2017/3/7/196

So KEY_VENDOR would look like a good choice for us as well.


Heiko

> +			press-threshold-microvolt = <0>;
> +		};
> +	};
> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  
> @@ -246,6 +259,10 @@
>  	status = "okay";
>  };
>  
> +&saradc {
> +	status = "okay";
> +};
> +
>  &sdmmc {
>  	bus-width = <4>;
>  	cap-mmc-highspeed;
> diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
> index 10793ac..63b8b2d 100644
> --- a/arch/arm/boot/dts/rk3288-firefly.dtsi
> +++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
> @@ -49,6 +49,19 @@
>  		reg = <0 0x80000000>;
>  	};
>  
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 1>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1800000>;
> +
> +		button-recovery {
> +			label = "Recovery";
> +			linux,code = <KEY_BACK>;
> +			press-threshold-microvolt = <0>;
> +		};
> +	};
> +
>  	dovdd_1v8: dovdd-1v8-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "dovdd_1v8";
> 
