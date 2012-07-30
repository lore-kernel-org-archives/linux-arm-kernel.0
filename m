From: linux@baker-net.org.uk (Adam Baker)
Date: Mon, 30 Jul 2012 22:35:34 +0100
Subject: [PATCH 15/16] ARM: Kirkwood: Describe iConnect LEDs in DT.
In-Reply-To: <1342805751-18048-16-git-send-email-andrew@lunn.ch>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
 <1342805751-18048-16-git-send-email-andrew@lunn.ch>
Message-ID: <5016FE26.8090509@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/07/12 18:35, Andrew Lunn wrote:

Sorry it's taken a while to spot this but I've got one comment below

> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>   arch/arm/boot/dts/kirkwood-iconnect.dts |   34 +++++++++++++++++++++++
>   arch/arm/mach-kirkwood/board-iconnect.c |   46 -------------------------------
>   2 files changed, 34 insertions(+), 46 deletions(-)
>
> diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
> index a7dd07b..b77b38f 100644
> --- a/arch/arm/boot/dts/kirkwood-iconnect.dts
> +++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
> @@ -31,4 +31,38 @@
>   			status = "ok";
>   		};
>   	};
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		led-level {
> +			label = "led_level";
> +			gpios = <&gpio1 9 0>;
> +			linux,default-trigger = "default-on";
> +		};
> +		power-blue {
> +			label = "power:blue";
> +			gpios = <&gpio1 11 0>;
> +			linux,default-trigger = "timer";
> +		};

Is there any reason that power:red is missing here?

> +		usb1 {
> +			label = "usb1:blue";
> +			gpios = <&gpio1 12 0>;
> +		};
> +		usb2 {
> +			label = "usb2:blue";
> +			gpios = <&gpio1 13 0>;
> +		};
> +		usb3 {
> +			label = "usb3:blue";
> +			gpios = <&gpio1 14 0>;
> +		};
> +		usb4 {
> +			label = "usb4:blue";
> +			gpios = <&gpio1 15 0>;
> +		};
> +		otb {
> +			label = "otb:blue";
> +			gpios = <&gpio1 16 0>;
> +		};
> +	};
>   };
> diff --git a/arch/arm/mach-kirkwood/board-iconnect.c b/arch/arm/mach-kirkwood/board-iconnect.c
> index df043aa..d7a9198 100644
> --- a/arch/arm/mach-kirkwood/board-iconnect.c
> +++ b/arch/arm/mach-kirkwood/board-iconnect.c
> @@ -19,7 +19,6 @@
>   #include <linux/mtd/partitions.h>
>   #include <linux/mv643xx_eth.h>
>   #include <linux/gpio.h>
> -#include <linux/leds.h>
>   #include <linux/input.h>
>   #include <linux/gpio_keys.h>
>   #include <asm/mach/arch.h>
> @@ -31,50 +30,6 @@ static struct mv643xx_eth_platform_data iconnect_ge00_data = {
>   	.phy_addr	= MV643XX_ETH_PHY_ADDR(11),
>   };
>
> -static struct gpio_led iconnect_led_pins[] = {
> -	{
> -		.name		= "led_level",
> -		.gpio		= 41,
> -		.default_trigger = "default-on",
> -	}, {
> -		.name		= "power:blue",
> -		.gpio		= 42,
> -		.default_trigger = "timer",
> -	}, {
> -		.name		= "power:red",
> -		.gpio		= 43,
> -	}, {
> -		.name		= "usb1:blue",
> -		.gpio		= 44,
> -	}, {
> -		.name		= "usb2:blue",
> -		.gpio		= 45,
> -	}, {
> -		.name		= "usb3:blue",
> -		.gpio		= 46,
> -	}, {
> -		.name		= "usb4:blue",
> -		.gpio		= 47,
> -	}, {
> -		.name		= "otb:blue",
> -		.gpio		= 48,
> -	},
> -};
> -
> -static struct gpio_led_platform_data iconnect_led_data = {
> -	.leds		= iconnect_led_pins,
> -	.num_leds	= ARRAY_SIZE(iconnect_led_pins),
> -	.gpio_blink_set	= orion_gpio_led_blink_set,
> -};
> -
> -static struct platform_device iconnect_leds = {
> -	.name	= "leds-gpio",
> -	.id	= -1,
> -	.dev	= {
> -		.platform_data	= &iconnect_led_data,
> -	}
> -};
> -
>   static unsigned int iconnect_mpp_config[] __initdata = {
>   	MPP12_GPIO,
>   	MPP35_GPIO,
> @@ -140,7 +95,6 @@ void __init iconnect_init(void)
>   	kirkwood_ge00_init(&iconnect_ge00_data);
>
>   	platform_device_register(&iconnect_button_device);
> -	platform_device_register(&iconnect_leds);
>   }
>
>   static int __init iconnect_pci_init(void)
>
