From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 20 May 2014 14:07:35 +0200
Subject: [PATCH] ARM: sun6i: Enable USB Host support on the Colombus board
In-Reply-To: <1400587155-19387-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1400587155-19387-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <537B4587.5020803@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/20/2014 01:59 PM, Maxime Ripard wrote:
> The colombus board has a on-board USB hub, that is enabled through the pin
> PH24, and wired to the first EHCI controller.

ehci0 is not hooked up at all on this board ? I would expect it to go to
a usb wifi card for example.

Assuming that ehci0 is not hooked up, this is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

If it is hooked up I believe both usb controllers should be enabled.

Regards,

Hans


> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun6i-a31-colombus.dts | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
> index 3898a7bce831..a907c1d3e939 100644
> --- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
> +++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
> @@ -13,6 +13,7 @@
>  
>  /dts-v1/;
>  /include/ "sun6i-a31.dtsi"
> +/include/ "sunxi-common-regulators.dtsi"
>  
>  / {
>  	model = "WITS A31 Colombus Evaluation Board";
> @@ -23,6 +24,24 @@
>  	};
>  
>  	soc at 01c00000 {
> +		pio: pinctrl at 01c20800 {
> +			usb2_vbus_pin_colombus: usb2_vbus_pin at 0 {
> +				allwinner,pins = "PH24";
> +				allwinner,function = "gpio_out";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +		};
> +
> +		usbphy: phy at 01c19400 {
> +			usb2_vbus-supply = <&reg_usb2_vbus>;
> +			status = "okay";
> +		};
> +
> +		ehci1: usb at 01c1b000 {
> +			status = "okay";
> +		};
> +
>  		uart0: serial at 01c28000 {
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&uart0_pins_a>;
> @@ -47,4 +66,11 @@
>  			status = "okay";
>  		};
>  	};
> +
> +	reg_usb2_vbus: usb2-vbus {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb2_vbus_pin_colombus>;
> +		gpio = <&pio 7 24 0>;
> +		status = "okay";
> +	};
>  };
> 
