From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 03 Jun 2013 11:48:45 +0200
Subject: [PATCH 3/3] ARM: DTS: TWL4030: fix mux and wakeup for SYS_NIRQ
 line
In-Reply-To: <1370040357-25794-4-git-send-email-khilman@linaro.org>
References: <1370040357-25794-1-git-send-email-khilman@linaro.org>
 <1370040357-25794-4-git-send-email-khilman@linaro.org>
Message-ID: <51AC667D.6070409@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kevin,

On 06/01/2013 12:45 AM, Kevin Hilman wrote:
> On most OMAP3 platforms, the twl4030 IRQ line is connected to the
> SYS_NIRQ line on OMAP.  Therefore, configure the defaults for the
> SYS_NIRQ pin in the twl4030 DTS file.
>
> Boards that hook up the twl4030 differently can easily override this
> in their board-specific DTS file.
>
> This allows RTC wake from off-mode to work again on OMAP3-based
> platforms with twl4030.  Tested on 3530/Beagle, 3730/Beagle-xM,
> 3530/Overo, 3730/Overo-STORM.
>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
>   arch/arm/boot/dts/twl4030.dtsi | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
> index b3034da..c7fe9f6 100644
> --- a/arch/arm/boot/dts/twl4030.dtsi
> +++ b/arch/arm/boot/dts/twl4030.dtsi
> @@ -13,6 +13,8 @@
>   	compatible = "ti,twl4030";
>   	interrupt-controller;
>   	#interrupt-cells = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&twl4030_pins>;
>
>   	rtc {
>   		compatible = "ti,twl4030-rtc";
> @@ -92,3 +94,18 @@
>   		#pwm-cells = <2>;
>   	};
>   };
> +
> +&omap3_pmx_core {

Here you are making the TWL4030 to explicitly depend on OMAP3. Could 
this chip be
used by another target? If the case, I would put this piece of code in 
the files
including twl4030. Otherwise it's ok here.

> +	/*
> +	 * On most OMAP3 platforms, the twl4030 IRQ line is connected
> +         * to the SYS_NIRQ line on OMAP.  Therefore, configure the
> +         * defaults for the SYS_NIRQ pin here.  Boards that hook up
> +         * the twl4030 differently can easily override this in their
> +         * board-specific DTS file.
> +	 */
> +	twl4030_pins: pinmux_twl4030_pins {
> +		pinctrl-single,pins = <
> +			0x1b0 0x4118 /*	sys_nirq.sys_nirq WAKEUP | INPUT_PULLUP | MODE 0 */

By using pinctrl constants:

			0x1b0 (PIN_INPUT_PULLUP | WAKEUP_EN | MUX_MODE0)	/* sys_nirq.sys_nirq */

> +		>;
> +	};
> +};
>

I will test this afternoon on an Overo.

Regards,

Florian
