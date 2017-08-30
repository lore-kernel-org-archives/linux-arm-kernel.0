From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Aug 2017 16:52:11 +0200
Subject: [PATCH 4/7] ARM: dts: sun8i: h3: Enable AP6212 WiFi on mmc1 on
 Nanopi M1 Plus
In-Reply-To: <1504062070-13523-5-git-send-email-embed3d@gmail.com>
References: <1504062070-13523-1-git-send-email-embed3d@gmail.com>
 <1504062070-13523-5-git-send-email-embed3d@gmail.com>
Message-ID: <20170830145211.snicbwdytobtd7ro@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 30, 2017 at 05:01:07AM +0200, Philipp Rossak wrote:
> From: Philipp Rossak <embed3d@gmail.com>
> 
> The WiFi side of the AP6212 WiFi/BT combo module is connected to
> mmc1. There are also GPIOs for enable and interrupts.
> 
> Enable WiFi on this board by enabling mmc1 and adding the power
> sequencing clocks and GPIO, as well as the chip's interrupt line.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 35 +++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> index b9c6c27..3054308 100644
> --- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> @@ -48,6 +48,7 @@
>  
>  	aliases {
>  		ethernet0 = &emac;
> +		ethernet1 = &ap6212;
>  	};
>  
>  	reg_gmac_3v3: gmac-3v3 {
> @@ -59,6 +60,14 @@
>  		enable-active-high;
>  		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
>  	};
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_en_npi_m1p>;

There's no need for pinctrl nodes when the pin is set to a GPIO.

> +		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
> +	};
> +
>  };
>  
>  &ehci1 {
> @@ -93,6 +102,25 @@
>  	};
>  };
>  
> +&mmc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins_a>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	vqmmc-supply = <&reg_vcc3v3>;

You don't need vqmmc in this case.

> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	bus-width = <4>;
> +	non-removable;
> +	status = "okay";
> +
> +	ap6212: sdio_wifi at 1 {

You're sure you need a label here?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170830/2ef1ada8/attachment.sig>
