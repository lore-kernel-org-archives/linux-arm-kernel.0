From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 6 Mar 2013 19:16:48 +0100
Subject: [PATCH 2/3] arm: kirkwood: factor pinmux descriptors for
 OpenBlocks A6
In-Reply-To: <1362587021-32762-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362587021-32762-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362587021-32762-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130306181648.GE3904@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 05:23:40PM +0100, Thomas Petazzoni wrote:
> The OpenBlocks A6 .dts file was using a long list of pinmux
> descriptors to select each GPIO of the external GPIO connector and the
> internal DIP switch, for no apparent reason. This commit factors those
> GPIO pins into two descriptors: one for the external GPIO connector
> and one for the internal DIP switch.

Hi Thomas

There is no need to pinmux gpio pins at all. The pinctrl driver does
it when the gpio driver requests the pins.

This stems from an error i made. I also didn't know this and added
hogs for gpio pins as i converted some boards. Others have then just
cut/paste my error.....

	  Andrew

> 
> As an added bonus, this commit also adds comments that says what those
> GPIOs are used for.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/kirkwood-openblocks_a6.dts |   74 +++++---------------------
>  1 file changed, 14 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> index 087681d..0488d6a 100644
> --- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> +++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> @@ -85,12 +85,7 @@
>  		};
>  
>  		pinctrl: pinctrl at 10000 {
> -			pinctrl-0 = <&pmx_dip_sw0 &pmx_dip_sw1
> -				&pmx_dip_sw2 &pmx_dip_sw3
> -				&pmx_gpio_0 &pmx_gpio_1
> -				&pmx_gpio_2 &pmx_gpio_3
> -				&pmx_gpio_4 &pmx_gpio_5
> -				&pmx_gpio_6 &pmx_gpio_7>;
> +			pinctrl-0 = <&pmx_dip_sw &pmx_ext_gpios>;
>  			pinctrl-names = "default";
>  
>  			pmx_uart0: pmx-uart0 {
> @@ -110,63 +105,22 @@
>  				marvell,function = "sysrst";
>  			};
>  
> -			pmx_dip_sw0: pmx-dip-sw0 {
> -				marvell,pins = "mpp20";
> +			/*
> +			 * Four input GPIOs connected to the 4-way
> +			 * DIP-switch inside the device.
> +			 */
> +			pmx_dip_sw: pmx-dip-sw {
> +				marvell,pins = "mpp20", "mpp21", "mpp22", "mpp23";
>  				marvell,function = "gpio";
>  			};
>  
> -			pmx_dip_sw1: pmx-dip-sw1 {
> -				marvell,pins = "mpp21";
> -				marvell,function = "gpio";
> -			};
> -
> -			pmx_dip_sw2: pmx-dip-sw2 {
> -				marvell,pins = "mpp22";
> -				marvell,function = "gpio";
> -			};
> -
> -			pmx_dip_sw3: pmx-dip-sw3 {
> -				marvell,pins = "mpp23";
> -				marvell,function = "gpio";
> -			};
> -
> -			pmx_gpio_0: pmx-gpio-0 {
> -				marvell,pins = "mpp24";
> -				marvell,function = "gpio";
> -			};
> -
> -			pmx_gpio_1: pmx-gpio-1 {
> -				marvell,pins = "mpp25";
> -				marvell,function = "gpio";
> -			};
> -
> -			pmx_gpio_2: pmx-gpio-2 {
> -				marvell,pins = "mpp26";
> -				marvell,function = "gpio";
> -			};
> -
> -			pmx_gpio_3: pmx-gpio-3 {
> -				marvell,pins = "mpp27";
> -				marvell,function = "gpio";
> -			};
> -
> -			pmx_gpio_4: pmx-gpio-4 {
> -				marvell,pins = "mpp28";
> -				marvell,function = "gpio";
> -			};
> -
> -			pmx_gpio_5: pmx-gpio-5 {
> -				marvell,pins = "mpp29";
> -				marvell,function = "gpio";
> -			};
> -
> -			pmx_gpio_6: pmx-gpio-6 {
> -				marvell,pins = "mpp30";
> -				marvell,function = "gpio";
> -			};
> -
> -			pmx_gpio_7: pmx-gpio-7 {
> -				marvell,pins = "mpp31";
> +			/*
> +			 * 8 GPIOs available through the Hirose 16
> +			 * pins header at the back of the device.
> +			 */
> +			pmx_ext_gpios: pmx-ext-gpios {
> +				marvell,pins = "mpp24", "mpp25", "mpp26", "mpp27",
> +					"mpp28", "mpp29", "mpp30", "mpp31";
>  				marvell,function = "gpio";
>  			};
>  
> -- 
> 1.7.9.5
> 
