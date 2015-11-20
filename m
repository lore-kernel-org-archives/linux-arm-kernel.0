From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Nov 2015 15:38:47 +0100
Subject: [PATCH] ARM: dts: sun8i-h3-orangepi-plus: Enable USB host
 controllers
In-Reply-To: <564B51D7.7090500@gmail.com>
References: <1447616777-24660-1-git-send-email-hdegoede@redhat.com>
 <1447616777-24660-5-git-send-email-hdegoede@redhat.com>
 <CAGb2v669Cu6+G=P8yH-g5KbOsWTHBgnYUYf2fGt+jKXbqVAKfQ@mail.gmail.com>
 <56498FA8.3050908@redhat.com> <564B51D7.7090500@gmail.com>
Message-ID: <564F3077.7020104@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17-11-15 17:12, Jens Kuske wrote:
> Enable the 2 USB host controllers used on the Orange Pi Plus
> and add the necessary regulators.
>
> Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> ---
>
> Hi Hans,
>
> with these regulators USB works on the Orange Pi Plus too.
> I don't know if adding the regulators in the dts is okay, since most
> regulators are defined in the sunxi-common-regulators.dtsi, but
> we use different pins.

Thanks, I've added this to my sunxi-wip branch for now.

Regards,

Hans

p.s.

Any progress on getting the "core" H3 kernel support upstream ?

Given Arnd's remarks about how we should not hard-code the
indices in the clk driver + the very KISS nature of the
change to 1 parent-clk per gate setup I still believe
that that one is best.

Maxime ? Chen-Yu ? It would be really good to be able to
move forward with this, how do you want to proceed ?


>
> Jens
>
>
>   arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 44 ++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> index e67df59..1cb6c66 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> @@ -58,6 +58,35 @@
>   	chosen {
>   		stdout-path = "serial0:115200n8";
>   	};
> +
> +	reg_usb3_vbus: usb3-vbus {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb3_vbus_pin_a>;
> +		regulator-name = "usb3-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&ehci3 {
> +	status = "okay";
> +};
> +
> +&pio {
> +	usb3_vbus_pin_a: usb3_vbus_pin at 0 {
> +		allwinner,pins = "PG11";
> +		allwinner,function = "gpio_out";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};
>   };
>
>   &mmc0 {
> @@ -70,8 +99,23 @@
>   	status = "okay";
>   };
>
> +&reg_usb1_vbus {
> +	gpio = <&pio 6 13 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
>   &uart0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&uart0_pins_a>;
>   	status = "okay";
>   };
> +
> +&usb1_vbus_pin_a {
> +	allwinner,pins = "PG13";
> +};
> +
> +&usbphy {
> +	usb1_vbus-supply = <&reg_usb1_vbus>;
> +	usb3_vbus-supply = <&reg_usb3_vbus>;
> +	status = "okay";
> +};
>
