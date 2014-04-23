From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 23 Apr 2014 13:28:03 +0200
Subject: [PATCH v2 29/38] ARM: orion5x: use DT to describe I2C devices
 on edmini_v2
In-Reply-To: <1398202002-28530-30-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-30-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5357A3C3.8030805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 11:26 PM, Thomas Petazzoni wrote:
> This commit converts the already partially DT-converted edmini_v2
> platform to use the Device Tree for I2C bus and devices.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    | 14 +++++++++++++
>   arch/arm/mach-orion5x/edmini_v2-setup.c            | 24 ----------------------
>   2 files changed, 14 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> index aa74b00..41b2ab5 100644
> --- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> +++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> @@ -10,6 +10,7 @@
>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
>   #include "orion5x-mv88f5182.dtsi"
>
>   / {
> @@ -63,6 +64,19 @@
>   	};
>   };
>
> +&i2c {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +	#address-cells = <1>;
> +
> +	rtc at 32 {
> +		compatible = "ricoh,rs5c372a";
> +		reg = <0x32>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
>   &mdio {
>   	status = "okay";
>
> diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion5x/edmini_v2-setup.c
> index c50469e..75648ab 100644
> --- a/arch/arm/mach-orion5x/edmini_v2-setup.c
> +++ b/arch/arm/mach-orion5x/edmini_v2-setup.c
> @@ -96,17 +96,6 @@ static struct platform_device edmini_v2_nor_flash = {
>   };
>
>   /*****************************************************************************
> - * RTC 5C372a on I2C bus
> - ****************************************************************************/
> -
> -#define EDMINIV2_RTC_GPIO	3
> -
> -static struct i2c_board_info __initdata edmini_v2_i2c_rtc = {
> -	I2C_BOARD_INFO("rs5c372a", 0x32),
> -	.irq = 0,
> -};
> -
> -/*****************************************************************************
>    * General Setup
>    ****************************************************************************/
>
> @@ -125,17 +114,4 @@ void __init edmini_v2_init(void)
>
>   	pr_notice("edmini_v2: USB device port, flash write and power-off "
>   		  "are not yet supported.\n");
> -
> -	/* Get RTC IRQ and register the chip */
> -	if (gpio_request(EDMINIV2_RTC_GPIO, "rtc") == 0) {
> -		if (gpio_direction_input(EDMINIV2_RTC_GPIO) == 0)
> -			edmini_v2_i2c_rtc.irq = gpio_to_irq(EDMINIV2_RTC_GPIO);
> -		else
> -			gpio_free(EDMINIV2_RTC_GPIO);
> -	}
> -
> -	if (edmini_v2_i2c_rtc.irq == 0)
> -		pr_warning("edmini_v2: failed to get RTC IRQ\n");
> -
> -	i2c_register_board_info(0, &edmini_v2_i2c_rtc, 1);
>   }
>
