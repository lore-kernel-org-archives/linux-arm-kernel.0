From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Aug 2012 13:35:06 -0700
Subject: [PATCH RESEND v4 2/3] arm/dts: AM33XX: Configure pinmuxs for
 user leds control on Bone
In-Reply-To: <1346141454-18786-3-git-send-email-anilkumar@ti.com>
References: <1346141454-18786-1-git-send-email-anilkumar@ti.com>
 <1346141454-18786-3-git-send-email-anilkumar@ti.com>
Message-ID: <20120830203505.GB1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* AnilKumar Ch <anilkumar@ti.com> [120828 01:11]:
> Adds GPIO pinctrl nodes to am3358_pinmux master node to control
> user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am335x-bone.dts |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index a7906cb..58f5042 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -18,6 +18,20 @@
>  		reg = <0x80000000 0x10000000>; /* 256 MB */
>  	};
>  
> +	am3358_pinmux: pinmux at 44E10800 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&userled_pins>;
> +
> +		userled_pins: pinmux_userled_pins {
> +			pinctrl-single,pins = <
> +				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
> +				0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
> +				0x5C 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
> +				0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
> +			>;
> +		};
> +	};
> +

Looks like this patch should also claim these pins by the led driver.
Then the led driver should just do pinctrl_get_select_default(&pdev->dev)
in it's probe function to set the pins.

Tony
