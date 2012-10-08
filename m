From: florian@openwrt.org (Florian Fainelli)
Date: Mon, 08 Oct 2012 13:50:16 +0200
Subject: [PATCH 2/6] ARM: bcm476x: Add system timer
In-Reply-To: <20121007015406.470633343@gmail.com>
References: <20121007015300.828366635@gmail.com>
 <20121007015406.470633343@gmail.com>
Message-ID: <1822741.oh36baA1m8@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 07 October 2012 03:53:02 Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> System timer implementation for the BCM476x SoCs.
> 
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> ---
>  Documentation/devicetree/bindings/timer/brcm,bcm476x-system-timer.txt |   22 +
>  arch/arm/boot/dts/bcm476x.dtsi                                        |    8 +
>  arch/arm/mach-bcm476x/bcm476x.c                                       |   10 -
>  drivers/clocksource/Makefile                                          |    1 +
>  drivers/clocksource/bcm476x_timer.c                                   |  188 ++++++++++
>  include/linux/bcm476x_timer.h                                         |   24 +
>  6 files changed, 244 insertions(+), 9 deletions(-)
> 
> Index: b/Documentation/devicetree/bindings/timer/brcm,bcm476x-system-timer.txt
> ===================================================================
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/brcm,bcm476x-system-timer.txt
> @@ -0,0 +1,22 @@
> +BCM476x System Timer
> +
> +The System Timer peripheral provides either two or four 32-bit timer
> +channels.  BCM476x has three timers at 0xba000, 0xbb000 and 0xd1000. The
> +first two provide four channels, the last (in the AON - Always ON power
> +domain) provides only two.
> +
> +Required properties:
> +
> +- compatible : should be "brcm,bcm476x-system-timer"
> +- reg : Specifies base physical address and size of the registers.
> +- interrupts : A list of 2 or 4 interrupt sinks; one per timer channel.
> +- clock-frequency : The frequency of the clock that drives the counter, in Hz.
> +
> +Example:
> +
> +timer {
> +	compatible = "brcm,bcm476x-system-timer";
> +	reg = <0xba000 0x1000>;
> +	interrupts = <4>, <11>;
> +	clock-frequency = <24000000>;
> +};
> Index: b/arch/arm/boot/dts/bcm476x.dtsi
> ===================================================================
> --- a/arch/arm/boot/dts/bcm476x.dtsi
> +++ b/arch/arm/boot/dts/bcm476x.dtsi
> @@ -14,6 +14,14 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> +		timer {
> +			compatible = "brcm,bcm476x-system-timer";
> +			reg = <0xba000 0x1000>;
> +			interrupt-parent = <&vic0>;
> +			interrupts = <4>, <11>;
> +			clock-frequency = <24000000>;
> +		};

This should rather be timer: timer at ba0000 for this node to be uniquely named.
--
Florian
