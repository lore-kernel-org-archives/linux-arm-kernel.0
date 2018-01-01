From: david@lechnology.com (David Lechner)
Date: Mon, 1 Jan 2018 13:14:32 -0600
Subject: [PATCH v2] ARM: dts: Add TVE/TVC and ILI9322 panel to DIR-685
In-Reply-To: <20171222085151.17635-1-linus.walleij@linaro.org>
References: <20171222085151.17635-1-linus.walleij@linaro.org>
Message-ID: <b929dd94-44e8-517a-7934-e0deb035faf5@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2017 02:51 AM, Linus Walleij wrote:
> This adds the TVE200/TVC TV-encoder and the Ilitek ILI9322 panel
> to the DIR-685 device tree.
> 
> This brings graphics to this funky router and it is possible to
> even run a console on its tiny screen.
> 
> Incidentally this requires us to disable the access to the
> parallel (NOR) flash, as the communication pins to the panel
> are shared with the flash memory.
> 
> To access the flash, a separate kernel with the panel disabled
> and the flash enabled should be booted. The pin control selecting
> whether to use the lines cannot be altered at runtime due to
> hardware constraints.
> 
> Cc: David Lechner <david@lechnology.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Rename node from "tvc" to "display-controller"
> - Drop all the surplus device tree config that we are now
>    instead open coding in the driver, as per the request of
>    the DT maintainers.
> - Tested on the D-Link DIR-685.
> ---
>   arch/arm/boot/dts/gemini-dlink-dir-685.dts | 63 +++++++++++++++++++++++++++++-
>   1 file changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
> index e75e2d44371c..0a86b784cf7f 100644
> --- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
> +++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
> @@ -45,6 +45,47 @@
>   		};
>   	};
>   
> +	vdisp: regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "display-power";
> +		regulator-min-microvolt = <3600000>;
> +		regulator-max-microvolt = <3600000>;
> +		/* Collides with LCD E */
> +		gpio = <&gpio0 16 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	spi {
> +		compatible = "spi-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* Collides with IDE pins, that's cool (we do not use them) */
> +		gpio-sck = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> +		gpio-miso = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> +		gpio-mosi = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> +		/* Collides with pflash CE1, not so cool */
> +		cs-gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
> +		num-chipselects = <1>;
> +
> +		panel: display at 0 {
> +			compatible = "dlink,dir-685-panel", "ilitek,ili9322";
> +			reg = <0>;
> +			/* 50 ns min period = 20 MHz */
> +			spi-max-frequency = <20000000>;
> +			spi-cpol; /* Clock active low */
> +			vcc-supply = <&vdisp>;
> +			iovcc-supply = <&vdisp>;
> +			vci-supply = <&vdisp>;
> +
> +			port {
> +				panel_in: endpoint {
> +					remote-endpoint = <&display_out>;
> +				};
> +			};
> +		};
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		led-wps {
> @@ -115,7 +156,16 @@
>   
>   	soc {
>   		flash at 30000000 {
> -			status = "okay";
> +			/*
> +			 * Flash access is by default disabled, because it
> +			 * collides with the Chip Enable signal for the display
> +			 * panel, that reuse the parallel flash Chip Select 1
> +			 * (CS1). Enabling flash makes graphics stop working.
> +			 *
> +			 * We might be able to hack around this by letting
> +			 * GPIO poke around in the flash controller registers.
> +			 */
> +			/* status = "okay"; */

Isn't the default status = "okay"? So you would need to explicitly say status = "disabled".

>   			/* 32MB of flash */
>   			reg = <0x30000000 0x02000000>;
>   
> @@ -242,5 +292,16 @@
>   		ata at 63000000 {
>   			status = "okay";
>   		};
> +
> +		display-controller at 6a000000 {
> +			status = "okay";
> +
> +			port at 0 {
> +				reg = <0>;
> +				display_out: endpoint {
> +					remote-endpoint = <&panel_in>;
> +				};
> +			};
> +		};
>   	};
>   };
> 
