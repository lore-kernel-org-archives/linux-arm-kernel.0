From: jm@lentin.co.uk (Jamie Lentin)
Date: Thu, 25 Oct 2012 23:58:37 +0100 (BST)
Subject: [PATCH 3/9] ARM: Kirkwood: Convert dnskw to pinctrl
In-Reply-To: <1351090434-30499-4-git-send-email-andrew@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <1351090434-30499-4-git-send-email-andrew@lunn.ch>
Message-ID: <alpine.DEB.2.02.1210252352360.22302@gonzo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for doing all this. Some typos to fix, I've commented below but 
I thought it might be easier to push a version for you to steal. It's 
here:

git://github.com/lentinj/linux.git v3.7-rc2-pinctrl
https://raw.github.com/lentinj/linux/v3.7-rc2-pinctrl/arch/arm/boot/dts/kirkwood-dnskw.dtsi

Tested on a DNS-320, not a DNS-325 yet.

Similar to lsxl_init, the custom GPIO registrations fail:-

dnskw: failed to configure power-off GPIO
dnskw: Failed to register dnskw:power:sata0
dnskw: Failed to register dnskw:power:sata1
dnskw: Failed to register dnskw:power:recover

So I guess they will need a new home somewhere.

However most things (fan, buttons, SATA detect/power via sysfs, power via 
sysfs) work. The key thing that doesn't is LEDs. Registration looks 
reasonable:

Registered led device: dns320:blue:power
kirkwood-pinctrl f1010000.pinctrl: request pin 43 (PIN43) for mvebu-gpio:43
Registered led device: dns320:blue:usb
kirkwood-pinctrl f1010000.pinctrl: request pin 28 (PIN28) for mvebu-gpio:28
Registered led device: dns320:orange:l_hdd
kirkwood-pinctrl f1010000.pinctrl: request pin 27 (PIN27) for mvebu-gpio:27
Registered led device: dns320:orange:r_hdd
kirkwood-pinctrl f1010000.pinctrl: request pin 35 (PIN35) for mvebu-gpio:35
Registered led device: dns320:orange:usb

However setting brightness on/off does the following:
cat /sys/class/leds/dns320\:blue\:power/trigger

dns320:blue:power - No effect, LED continues to blink as bootloader 
configures it
dns320:orange:l_hdd - Works fine
dns320:orange:r_hdd - Works fine
dns320:orange:usb - Turns on, turning off locks NAS hard
dns320:blue:usb - Turns on, turning off locks NAS hard

Any ideas?

Cheers,

On Wed, 24 Oct 2012, Andrew Lunn wrote:

> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> arch/arm/boot/dts/kirkwood-dnskw.dtsi |  136 +++++++++++++++++++++++++++++++++
> arch/arm/mach-kirkwood/board-dnskw.c  |   37 ---------
> 2 files changed, 136 insertions(+), 37 deletions(-)
>
> diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
> index 9b32d02..5d8cf93 100644
> --- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
> @@ -36,6 +36,142 @@
> 	};
>
> 	ocp at f1000000 {
> +		pinctrl: pinctrl at 10000 {
> +			compatible = "marvell,88f6281-pinctrl";
> +			reg = <0x10000 0x20>;
> +
> +			pinctrl-0 = < &pmx_uart1 &pmx_sata1

Need a &pmx_sata0 too (see below).

> +				      &pmx_gpio_24 &pmx_gpio_25
> +				      &pmx_led_power &pmx_led_power

Shouldn't be repeated, I'm guessing.

> +				      &pmx_led_red_right_hdd
> +				      &pmx_led_red_left_hdd
> +				      &pmx_led_red_usb_325
> +				      &pmx_gpio_30 &pmx_gpio_31
> +				      &pmx_gpio_32 &pmx_gpio_33
> +				      &pmx_button_power
> +				      &pmx_led_red_usb_320
> +				      &pmx_power_off &pmx_power_back_on
> +				      &pmx_power_sata0 &pmx_power_sata1
> +				      &pmx_present_sata0 &pmx_present_sata1
> +				      &pmx_led_white_usb &pmx_fan_tacho
> +				      &pmx_fan_high_speed &pmx_fan_low_speed
> +				      &pmx_button_unmount &pmx_button_reset
> +				      &pmx_temp_alarm >;
> +			pinctrl-names = "default";
> +
> +			pmx_uart1: pmx-uart1 {
> +				marvell,pins = "mpp13", "mpp14";
> +				marvell,function = "uart1";
> +			};
> +			pmx_sata1: pmx-sata1 {
> +				marvell,pins = "mpp4", "mpp20", "mpp22";

mpp4 is for the NAND. I'm guessing mpp22 should be mpp21, but this should 
have the "sata0" function.

On a related note, the NAND pins aren't registered. I probably should have 
done this before, although if the bootloader didn't set up the NAND pins 
then it'd probably not get this far :)

> +				marvell,function = "sata1";
> +			};
> +			pmx_gpio_24: pmx-gpio-24 {
> +				marvell,pins = "mpp24";
> +				marvell,function = "gpio";
> +			};
> +			pmx_gpio_25: pmx-gpio-25 {
> +				marvell,pins = "mpp25";
> +				marvell,function = "gpio";
> +			};

These don't actually do anything (there's no more NAS functions left to 
find now), so could they just be left out? They didn't serve any purpose
before other than making it easy to see where the gaps were.

> +			pmx_led_power: pmx-led-power {
> +				marvell,pins = "mpp26";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_red_right_hdd: pmx-led-red-right-hdd {
> +				marvell,pins = "mpp27";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_red_left_hdd: pmx-led-red-left-hdd {
> +				marvell,pins = "mpp28";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_red_usb_325: pmx-led-red-usb-325 {
> +				marvell,pins = "mpp29";
> +				marvell,function = "gpio";
> +			};
> +			pmx_gpio_30: pmx-gpio-30 {
> +				marvell,pins = "mpp30";
> +				marvell,function = "gpio";
> +			};
> +			pmx_gpio_31: pmx-gpio-31 {
> +				marvell,pins = "mpp31";
> +				marvell,function = "gpio";
> +			};
> +			pmx_gpio_32: pmx-gpio-32 {
> +				marvell,pins = "mpp32";
> +				marvell,function = "gpio";
> +			};
> +			pmx_gpio_33: pmx-gpio-33 {
> +				marvell,pins = "mpp33";
> +				marvell,function = "gpio";
> +			};

Should be "gpo", but could just leave out all 4.

> +			pmx_button_power: pmx-button-power {
> +				marvell,pins = "mpp34";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_red_usb_320: pmx-led-red-usb-320 {
> +				marvell,pins = "mpp35";
> +				marvell,function = "gpio";
> +			};
> +			pmx_power_off: pmx-power-off {
> +				marvell,pins = "mpp36";
> +				marvell,function = "gpio";
> +			};
> +			pmx_power_back_on: pmx-power-back-on {
> +				marvell,pins = "mpp37";
> +				marvell,function = "gpio";
> +			};
> +			pmx_gpio_38: pmx-gpio-38 {
> +				marvell,pins = "mpp38";
> +				marvell,function = "gpio";
> +			};

This one wasn't registered above, but not a used pin.

> +			pmx_power_sata0: pmx-power-sata0 {
> +				marvell,pins = "mpp39";
> +				marvell,function = "gpio";
> +			};
> +			pmx_power_sata1: pmx-power-sata1 {
> +				marvell,pins = "mpp40";
> +				marvell,function = "gpio";
> +			};
> +			pmx_present_sata0: pmx-present-sata0 {
> +				marvell,pins = "mpp41";
> +				marvell,function = "gpio";
> +			};
> +			pmx_present_sata1: pmx-present-sata1 {
> +				marvell,pins = "mpp42";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_white_usb: pmx-led-white-usb {
> +				marvell,pins = "mpp43";
> +				marvell,function = "gpio";
> +			};
> +			pmx_fan_tacho: pmx-fan-tacho {
> +				marvell,pins = "mpp44";
> +				marvell,function = "gpio";
> +			};
> +			pmx_fan_high_speed: pmx-fan-high-speed {
> +				marvell,pins = "mpp45";
> +				marvell,function = "gpio";
> +			};
> +			pmx_fan_low_speed: pmx-fan-low-speed {
> +				marvell,pins = "mpp46";
> +				marvell,function = "gpio";
> +			};
> +			pmx_button_unmount: pmx-button-unmount {
> +				marvell,pins = "mpp47";
> +				marvell,function = "gpio";
> +			};
> +			pmx_button_reset: pmx-button-reset {
> +				marvell,pins = "mpp48";
> +				marvell,function = "gpio";
> +			};
> +			pmx_temp_alarm: pmx-temp-alarm {
> +				marvell,pins = "mpp49";
> +				marvell,function = "gpio";
> +			};
> +		};
> 		sata at 80000 {
> 			status = "okay";
> 			nr-ports = <2>;
> diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
> index 43d16d6..ed93c09 100644
> --- a/arch/arm/mach-kirkwood/board-dnskw.c
> +++ b/arch/arm/mach-kirkwood/board-dnskw.c
> @@ -17,46 +17,11 @@
> #include <linux/mv643xx_eth.h>
> #include <linux/gpio.h>
> #include "common.h"
> -#include "mpp.h"
>
> static struct mv643xx_eth_platform_data dnskw_ge00_data = {
> 	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
> };
>
> -static unsigned int dnskw_mpp_config[] __initdata = {
> -	MPP13_UART1_TXD,	/* Custom ... */
> -	MPP14_UART1_RXD,	/* ... Controller (DNS-320 only) */
> -	MPP20_SATA1_ACTn,	/* LED: White Right HDD */
> -	MPP21_SATA0_ACTn,	/* LED: White Left HDD */
> -	MPP24_GPIO,
> -	MPP25_GPIO,
> -	MPP26_GPIO,	/* LED: Power */
> -	MPP27_GPIO,	/* LED: Red Right HDD */
> -	MPP28_GPIO,	/* LED: Red Left HDD */
> -	MPP29_GPIO,	/* LED: Red USB (DNS-325 only) */
> -	MPP30_GPIO,
> -	MPP31_GPIO,
> -	MPP32_GPIO,
> -	MPP33_GPO,
> -	MPP34_GPIO,	/* Button: Front power */
> -	MPP35_GPIO,	/* LED: Red USB (DNS-320 only) */
> -	MPP36_GPIO,	/* Power: Turn off board */
> -	MPP37_GPIO,	/* Power: Turn back on after power failure */
> -	MPP38_GPIO,
> -	MPP39_GPIO,	/* Power: SATA0 */
> -	MPP40_GPIO,	/* Power: SATA1 */
> -	MPP41_GPIO,	/* SATA0 present */
> -	MPP42_GPIO,	/* SATA1 present */
> -	MPP43_GPIO,	/* LED: White USB */
> -	MPP44_GPIO,	/* Fan: Tachometer Pin */
> -	MPP45_GPIO,	/* Fan: high speed */
> -	MPP46_GPIO,	/* Fan: low speed */
> -	MPP47_GPIO,	/* Button: Back unmount */
> -	MPP48_GPIO,	/* Button: Back reset */
> -	MPP49_GPIO,	/* Temp Alarm (DNS-325) Pin of U5 (DNS-320) */
> -	0
> -};
> -
> static void dnskw_power_off(void)
> {
> 	gpio_set_value(36, 1);
> @@ -76,8 +41,6 @@ static void __init dnskw_gpio_register(unsigned gpio, char *name, int def)
>
> void __init dnskw_init(void)
> {
> -	kirkwood_mpp_conf(dnskw_mpp_config);
> -
> 	kirkwood_ehci_init();
> 	kirkwood_ge00_init(&dnskw_ge00_data);
>
>

-- 
Jamie Lentin
