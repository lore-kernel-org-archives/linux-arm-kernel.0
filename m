From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 14 Apr 2017 18:56:16 +0200
Subject: [PATCH v2 11/11] arm64: allwinner: a64: enable Wi-Fi for Pine64
In-Reply-To: <20170407183441.58750-12-icenowy@aosc.io>
References: <20170407183441.58750-1-icenowy@aosc.io>
 <20170407183441.58750-12-icenowy@aosc.io>
Message-ID: <e51897d2-aa9d-1f4b-3fe0-e88246a9e438@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 07.04.2017 um 20:34 schrieb Icenowy Zheng:
> The Wi-Fi modules of Pine64 is powered via DLDO4 and ELDO1 (the latter

"modules ... are" or "module ... is"

> one provides I/O voltage).
> 
> Add device node for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> index 7da074f95065..9d90bb32aa87 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -64,6 +64,11 @@
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  	};
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
> +	};
>  };
>  
>  &ehci1 {
> @@ -91,6 +96,17 @@
>  	status = "okay";
>  };
>  
> +&mmc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins>;
> +	vmmc-supply = <&reg_dldo4>;
> +	vqmmc-supply = <&reg_eldo1>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	non-removable;
> +	bus-width = <4>;
> +	status = "okay";
> +};

As you mention above, Wi-Fi is a module, so may be absent. Is it really
correct to enable this node and hardcode a certain power sequence? In
theory other modules could be attached.

To me that calls for an overlay instead.

> +
>  &ohci1 {
>  	status = "okay";
>  };

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
