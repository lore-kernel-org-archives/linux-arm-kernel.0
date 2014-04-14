From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Apr 2014 12:51:24 +0200
Subject: [PATCH 20/29] ARM: orion5x: convert edmini_v2 to DT pinctrl
In-Reply-To: <1397400006-4315-21-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-21-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <534BBDAC.2010801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2014 04:39 PM, Thomas Petazzoni wrote:
> This commit converts the already partially DT-converted edmini_v2
> platform to use the Device Tree for pinctrl.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>   .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    | 31 ++++++++++++++++++++++
>   arch/arm/mach-orion5x/edmini_v2-setup.c            | 28 -------------------
>   2 files changed, 31 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> index d66d2fa..eee42f7 100644
> --- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> +++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> @@ -29,12 +29,39 @@
>   			 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>;
>
>   		internal-regs {
> +			pinctrl at 10000 {

Use node label reference:

&pinctrl {
	...
};

> +				pinctrl-0 = <&pmx_rtc &pmx_power_led_ctrl>;
> +				pinctrl-names = "default";
> +
> +				pmx_rtc: pmx-rtc {

Andrew already mentioned, please sort by node labels.

> +					marvell,pins = "mpp3";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_power_led: pmx-power-led {
> +					marvell,pins = "mpp16";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_power_led_ctrl: pmx-power-led-ctrl {
> +					marvell,pins = "mpp17";
> +					marvell,function = "gpio";
> +				};
> +
> +				pmx_power_button: pmx-power-button {
> +					marvell,pins = "mpp18";
> +					marvell,function = "gpio";
> +				};
> +			};
> +
>   			serial at 12000 {
>   				clock-frequency = <166666667>;
>   				status = "okay";
>   			};
>
>   			sata at 80000 {
> +				pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
> +				pinctrl-names = "default";
>   				status = "okay";
>   				nr-ports = <2>;
>   			};
> @@ -43,6 +70,8 @@
>
>   	gpio_keys {

ePAPR does allow _ in node names, but it seems to be more common
(or at least we should pick one) to use gpio-keys instead.

>   		compatible = "gpio-keys";
> +		pinctrl-0 = <&pmx_power_button>;
> +		pinctrl-names = "default";
>   		#address-cells = <1>;
>   		#size-cells = <0>;
>   		button at 1 {
> @@ -54,6 +83,8 @@
>
>   	gpio_leds {

ditto.

Sebastian

>   		compatible = "gpio-leds";
> +		pinctrl-0 = <&pmx_power_led>;
> +		pinctrl-names = "default";
>
>   		led at 1 {
>   			label = "power:blue";
> diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion5x/edmini_v2-setup.c
> index f66c1b2..c50469e 100644
> --- a/arch/arm/mach-orion5x/edmini_v2-setup.c
> +++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
> @@ -109,37 +109,9 @@ static struct i2c_board_info __initdata edmini_v2_i2c_rtc = {
>   /*****************************************************************************
>    * General Setup
>    ****************************************************************************/
> -static unsigned int edminiv2_mpp_modes[] __initdata = {
> -	MPP0_UNUSED,
> -	MPP1_UNUSED,
> -	MPP2_UNUSED,
> -	MPP3_GPIO,	/* RTC interrupt */
> -	MPP4_UNUSED,
> -	MPP5_UNUSED,
> -	MPP6_UNUSED,
> -	MPP7_UNUSED,
> -	MPP8_UNUSED,
> -	MPP9_UNUSED,
> -	MPP10_UNUSED,
> -	MPP11_UNUSED,
> -	MPP12_SATA_LED,	/* SATA 0 presence */
> -	MPP13_SATA_LED,	/* SATA 1 presence */
> -	MPP14_SATA_LED,	/* SATA 0 active */
> -	MPP15_SATA_LED,	/* SATA 1 active */
> -	/* 16: Power LED control (0 = On, 1 = Off) */
> -	MPP16_GPIO,
> -	/* 17: Power LED control select (0 = CPLD, 1 = GPIO16) */
> -	MPP17_GPIO,
> -	/* 18: Power button status (0 = Released, 1 = Pressed) */
> -	MPP18_GPIO,
> -	MPP19_UNUSED,
> -	0,
> -};
>
>   void __init edmini_v2_init(void)
>   {
> -	orion5x_mpp_conf(edminiv2_mpp_modes);
> -
>   	/*
>   	 * Configure peripherals.
>   	 */
>
