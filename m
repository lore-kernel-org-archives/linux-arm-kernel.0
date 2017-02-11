From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 11 Feb 2017 17:33:16 +0100
Subject: ARM: dts: rockchip: add the MiQi board's fan definition
In-Reply-To: <1486803415-14680-1-git-send-email-w@1wt.eu>
References: <1486803415-14680-1-git-send-email-w@1wt.eu>
Message-ID: <3614963.WjR2ddleWK@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Willy,

Am Samstag, 11. Februar 2017, 09:56:55 CET schrieb Willy Tarreau:
> The MiQi board is sold with an enclosure in which a fan is connected
> to the second LED output, and configured by default in "heartbeat"
> mode so that it rotates slowly and increases when the CPU load
> increases, ensuring appropriate cooling by default. This LED output
> is called "Fan" in the original kernel and connected to GPIO18
> (gpiochip 0, pin 18). Here we called it "miqi:green:fan" to stay
> consistent with the kernel's naming conventions.

I tend to disagree with this approach. A fan is not a led and the devicetree 
is about describing the hardware, not how a specific kernel likes to use things 
:-) .

The kernel already has a gpio-fan driver (drivers/hwmon) or you could 
resurrect the gpio-pwm patch [0] from Olliver Schinagl and use the pwm-fan on 
top of that for more intermediate steps.


> It's worth noting that without this patch the fan doesn't work at
> all, risking to make the board overheat.

At least cpufreq is already hooked to the thermal controller on the rk3288, so 
even without additional cooling it should select lower cpu frequencies keeping 
the heat in line and prevent overheating the board.

Both solutions shown above also hook into the thermal framework and act as 
cooling device according real temperature readings from the chip and not 
trying to determine some sort of cooling from load in a somewhat hacky way. 


Heiko

[0] https://patchwork.kernel.org/patch/7492201/


> 
> Fixes: 162718c (v4.7)
> Cc: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  arch/arm/boot/dts/rk3288-miqi.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-miqi.dts
> b/arch/arm/boot/dts/rk3288-miqi.dts index 2f4c635..ef702db 100644
> --- a/arch/arm/boot/dts/rk3288-miqi.dts
> +++ b/arch/arm/boot/dts/rk3288-miqi.dts
> @@ -67,6 +67,12 @@
>  	leds {
>  		compatible = "gpio-leds";
> 
> +		fan {
> +			gpios = <&gpio0 18 GPIO_ACTIVE_HIGH>;
> +			label = "miqi:green:fan";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
>  		work {
>  			gpios = <&gpio7 2 GPIO_ACTIVE_HIGH>;
>  			label = "miqi:green:user";
