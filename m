From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Mon, 20 Feb 2017 19:52:03 +0100
Subject: [PATCH] ARM: dts: sun8i: NanoPi NEO Air add WiFi / eMMC
In-Reply-To: <20170219143848.25911-1-jelle@vdwaa.nl>
References: <20170219143848.25911-1-jelle@vdwaa.nl>
Message-ID: <20170220185202.ficvrxkb26v6enz2@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 19, 2017 at 03:38:48PM +0100, Jelle van der Waa wrote:
> Enable the WiFi (AP6212) chip and eMMC support for the NanoPi NEO Air.
> 
> Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
> ---
>  arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts | 45 +++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
> index 3ba081c1f555..3813156f5d35 100644
> --- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
> @@ -73,6 +73,13 @@
>  			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>; /* PA10 */
>  		};
>  	};
> +
> +	wifi_pwrseq: wifi_pwrseq {

There should not be underscores in node names. See e.g.:
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1122967.html
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1145633.html
https://www.mail-archive.com/netdev%40vger.kernel.org/msg90319.html

> +&r_pio {
> +	wifi_en_nanopi_neo_air: wifi_en_pin {
> +		allwinner,pins = "PL7";
> +		allwinner,function = "gpio_out";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};
> +};

1. Underscores in the node name.
2. Pinmux nodes for GPIO usage is considered unnecessary or even harmful
these days. As a bonus, you avoid a duplicate definition.
3. Please use the generic properties, as in

	pins = "PL7";
	function ="gpio_out";
	drive-strength = <10>;
	bias-disable;

(but you should just drop the node in this case).

(Do we not usually address the dts maintainers directly when submitting
device tree patches? Just wondering.)

-- 
Rask Ingemann Lambertsen
