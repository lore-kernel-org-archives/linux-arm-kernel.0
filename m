From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 18 Jun 2015 17:59:35 +0200
Subject: [PATCH 09/20] ARM: dts: sun4i: Enable USB DRC on the Cubieboard
In-Reply-To: <1433530943-12599-10-git-send-email-hdegoede@redhat.com>
References: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
 <1433530943-12599-10-git-send-email-hdegoede@redhat.com>
Message-ID: <20150618155935.GR11732@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Fri, Jun 05, 2015 at 09:02:12PM +0200, Hans de Goede wrote:
> Enable the otg/drc usb controller on the Cubieboard. Note that the
> 5V of the otg is directly connected to the general 5V, so we only use
> the id pin.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> index 9afb4e0..046a84d 100644
> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> @@ -155,6 +155,10 @@
>  	status = "okay";
>  };
>  
> +&otg_sram {
> +	status = "okay";
> +};
> +
>  &pio {
>  	led_pins_cubieboard: led_pins at 0 {
>  		allwinner,pins = "PH20", "PH21";
> @@ -162,6 +166,13 @@
>  		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
>  		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  	};
> +
> +	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
> +		allwinner,pins = "PH4";
> +		allwinner,function = "gpio_in";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> +	};
>  };
>  
>  &reg_ahci_5v {
> @@ -216,7 +227,15 @@
>  	status = "okay";
>  };
>  
> +&usb_otg {
> +	dr_mode = "otg";
> +	status = "okay";
> +};
> +
>  &usbphy {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb0_id_detect_pin>;
> +	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */

Does that work? 

Your phy driver seem to actively check at probe time for both the ID
detect and VBUS detect pins to be set in the DT, which is not the case
here.

I don't really get either why VBUS detect has to be set. Can't it work
just fine if you have a regulator that you can control and the ID pin
alone ?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150618/c483ce68/attachment.sig>
