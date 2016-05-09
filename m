From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 9 May 2016 11:31:58 +0300
Subject: [PATCH] ARM: dts: Fix igepv5 audiopwon-gpio
In-Reply-To: <1462474581-13865-1-git-send-email-tony@atomide.com>
References: <1462474581-13865-1-git-send-email-tony@atomide.com>
Message-ID: <ab6e5775-949b-f83a-fc13-1c643181ec2b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/16 21:56, Tony Lindgren wrote:
> Playing audio works on omap5-uevm, but produces an "Unhandled fault:
> imprecise external abort (0x1406) at 0x00000000" error on igepv5.

I assume this is coming from the McPDM driver... If the clock is missing from
the twl6040 the IP is not accessible.
I do have a driver upstream to represent the twl6040 clock to be used by the
McPDM, but did not had time to do the work for integrating that into the clock
tree. Since it is external clock and we need i2c commands to configure things
in twl6040, I'm still not sure how pm_runtime would like this...

> Looks like the twl6040 audpwron GPIO pin is different for these
> boards. Let's fix the issue by configuring the audpwron in the
> board specific dts file.

Acked-by: Peter Ujfalusi <peter.ujflausi@ti com>


> Cc: Agust? Fontquerni <af@iseebcn.com>
> Cc: Eduard Gavin <egavin@iseebcn.com>
> Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/omap5-board-common.dtsi |  3 ++-
>  arch/arm/boot/dts/omap5-igep0050.dts      | 10 ++++++++++
>  arch/arm/boot/dts/omap5-uevm.dts          | 10 ++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
> index 2eea26c..23b1d7c 100644
> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> @@ -642,7 +642,8 @@
>  		pinctrl-0 = <&twl6040_pins>;
>  
>  		interrupts = <GIC_SPI 119 IRQ_TYPE_NONE>; /* IRQ_SYS_2N cascaded to gic */
> -		ti,audpwron-gpio = <&gpio5 13 GPIO_ACTIVE_HIGH>;  /* gpio line 141 */
> +
> +		/* audpwron gpio defined in the board specific dts */
>  
>  		vio-supply = <&smps7_reg>;
>  		v2v1-supply = <&smps9_reg>;
> diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts/omap5-igep0050.dts
> index 72ff6a4..673cdfa 100644
> --- a/arch/arm/boot/dts/omap5-igep0050.dts
> +++ b/arch/arm/boot/dts/omap5-igep0050.dts
> @@ -58,3 +58,13 @@
>  		<&gpio7 3 0>;		/* 195, SDA */
>  };
>  
> +&twl6040 {
> +	ti,audpwron-gpio = <&gpio5 16 GPIO_ACTIVE_HIGH>;  /* gpio line 144 */
> +};
> +
> +&twl6040_pins {
> +	pinctrl-single,pins = <
> +		OMAP5_IOPAD(0x1c4, PIN_OUTPUT | MUX_MODE6)	/* mcspi1_somi.gpio5_144 */
> +		OMAP5_IOPAD(0x1ca, PIN_OUTPUT | MUX_MODE6)	/* perslimbus2_clock.gpio5_145 */
> +	>;
> +};
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 60b3fbb..a51e605 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -51,3 +51,13 @@
>  		<&gpio9 1 GPIO_ACTIVE_HIGH>,	/* TCA6424A P00, LS OE */
>  		<&gpio7 1 GPIO_ACTIVE_HIGH>;	/* GPIO 193, HPD */
>  };
> +
> +&twl6040 {
> +	ti,audpwron-gpio = <&gpio5 13 GPIO_ACTIVE_HIGH>;  /* gpio line 141 */
> +};
> +
> +&twl6040_pins {
> +	pinctrl-single,pins = <
> +		OMAP5_IOPAD(0x1be, PIN_OUTPUT | MUX_MODE6)	/* mcspi1_somi.gpio5_141 */
> +	>;
> +};
> 


-- 
P?ter
