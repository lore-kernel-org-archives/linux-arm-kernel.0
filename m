From: nm@ti.com (Nishanth Menon)
Date: Fri, 17 May 2013 11:15:25 -0500
Subject: [PATCH v6] ARM:dts:omap4-panda: Update the LED support for the
 panda DTS
In-Reply-To: <1368806552-8851-1-git-send-email-dmurphy@ti.com>
References: <1368806552-8851-1-git-send-email-dmurphy@ti.com>
Message-ID: <20130517161525.GA30014@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:02-20130517, Dan Murphy wrote:
> The GPIO for LED D1 on the omap4-panda a1-a3 rev and the omap4-panda-es
> are different.
> 
> A1-A3 = gpio_wk7
> ES = gpio_110
> 
> There is no change to LED D2
> 
> Abstract away the pinmux and the LED definitions for the two boards into
> the respective DTS files.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> Changes in this version:
> 	- review comments incorporated.
> Previous version of this patch was discussed in:
> 	https://patchwork.kernel.org/patch/2582771/
one minor nit,
$subject could do with space after the ':'
otherwise, it looks fine to me. Will suggest waiting for further
reviewers if they have an opinion prior to a new rev.

> 
>  arch/arm/boot/dts/omap4-panda-common.dtsi |   16 +++++++++++++++-
>  arch/arm/boot/dts/omap4-panda-es.dts      |   28 ++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
> index 03bd60d..5fd59b3 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -16,8 +16,13 @@
>  		reg = <0x80000000 0x40000000>; /* 1 GB */
>  	};
>  
> -	leds {
> +	leds: leds {
>  		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <
> +			&led_wkgpio_pins
> +		>;
> +
>  		heartbeat {
>  			label = "pandaboard::status1";
>  			gpios = <&gpio1 7 0>;
> @@ -137,6 +142,15 @@
>  	};
>  };
>  
> +&omap4_pmx_wkup {
> +	led_wkgpio_pins: pinmux_leds_wkpins {
> +		pinctrl-single,pins = <
> +			0x1a 0x3	/* gpio_wk7 OUTPUT | MODE 3 */
> +			0x1c 0x3	/* gpio_wk8 OUTPUT | MODE 3 */
> +		>;
> +	};
> +};
> +
>  &i2c1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c1_pins>;
> diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
> index f1d8c21..c968a3b 100644
> --- a/arch/arm/boot/dts/omap4-panda-es.dts
> +++ b/arch/arm/boot/dts/omap4-panda-es.dts
> @@ -34,3 +34,31 @@
>  		0x5e 0x100	/* hdmi_sda.hdmi_sda INPUT | MODE 0 */
>  		>;
>  };
> +
> +&omap4_pmx_core {
> +	led_gpio_pins: gpio_led_pmx {
> +		pinctrl-single,pins = <
> +			0xb6 0x3	/* gpio_110 OUTPUT | MODE 3 */
> +		>;
> +	};
> +};
> +
> +&led_wkgpio_pins {
> +	pinctrl-single,pins = <
> +		0x1c 0x3	/* gpio_wk8 OUTPUT | MODE 3 */
> +	>;
> +};
> +
> +&leds {
> +	pinctrl-0 = <
> +		&led_gpio_pins
> +		&led_wkgpio_pins
> +	>;
> +
> +	heartbeat {
> +		gpios = <&gpio4 14 0>;
> +	};
> +	mmc {
> +		gpios = <&gpio1 8 0>;
> +	};
> +};

-- 
Regards,
Nishanth Menon
