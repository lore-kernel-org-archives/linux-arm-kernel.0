From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 11 Feb 2017 17:30:25 +0100
Subject: ARM: dts: rockchip: fix the MiQi board's LED definition
In-Reply-To: <1486803405-14625-1-git-send-email-w@1wt.eu>
References: <1486803405-14625-1-git-send-email-w@1wt.eu>
Message-ID: <2094417.n6KR7CNSyF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 11. Februar 2017, 09:56:45 CET schrieb Willy Tarreau:
> The MiQi board's green LED doesn't work at all with the mainline kernel.
> There are multiple reasons to this. First, the gpio number is wrong, it
> is declared on gpio220 (chip 7 pin 4) instead of gpio218 (chip 7 pin 2).
> Second, a pinctrl is referenced, also declared with the same wrong value
> while it is not unused. Third, the GPIO polarity was wrong (active low
> instead of active high) with the default value set to "default-on",
> resulting in the LED being turned off even when the GPIO is correct.
> 
> This patch fixes all these inconsistencies at once since these they are
> related to each other, and also restores the "timer" trigger which is
> the same as the one used by the kernels shipped with the board.
> 
> It's important to note that during the port to mainline, the led's label
> was changed from "System" to "miqi:green:user", so scripts making use of
> the name will still not work until they're fixed.
> 
> Fixes: 162718c (v4.7)

Fixes: b1a76f75d76e ("ARM: dts: rockchip: add MiQi board from mqmaker")

Interestingly schematics for MiQi still point to GPIO7_A4 as led pin, but I 
haven't looked at my pre-production miqi for quite some time.

So anyway, applied for 4.12

The led pinctrl could've simply be changed to also use the correct pin instead 
of removing it, but as the pin is used as output only and not requested with 
open-drain/open-source characteristics, this should not matter much.


Heiko

> Cc: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  arch/arm/boot/dts/rk3288-miqi.dts | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-miqi.dts
> b/arch/arm/boot/dts/rk3288-miqi.dts index f751372..2f4c635 100644
> --- a/arch/arm/boot/dts/rk3288-miqi.dts
> +++ b/arch/arm/boot/dts/rk3288-miqi.dts
> @@ -68,11 +68,9 @@
>  		compatible = "gpio-leds";
> 
>  		work {
> -			gpios = <&gpio7 4 GPIO_ACTIVE_LOW>;
> +			gpios = <&gpio7 2 GPIO_ACTIVE_HIGH>;
>  			label = "miqi:green:user";
> -			linux,default-trigger = "default-on";
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&led_ctl>;
> +			linux,default-trigger = "timer";
>  		};
>  	};
> 
> @@ -363,12 +361,6 @@
>  		};
>  	};
> 
> -	leds {
> -		led_ctl: led-ctl {
> -			rockchip,pins = <7 4 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
>  	sdmmc {
>  		/*
>  		 * Default drive strength isn't enough to achieve even
