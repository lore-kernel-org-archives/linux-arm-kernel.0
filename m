From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Aug 2012 13:14:47 -0700
Subject: [PATCH v3 3/4] arm/dts: AM33XX: Configure pinmuxs for D_CAN1
 on AM335x-EVM
In-Reply-To: <1345119610-5247-4-git-send-email-anilkumar@ti.com>
References: <1345119610-5247-1-git-send-email-anilkumar@ti.com>
 <1345119610-5247-4-git-send-email-anilkumar@ti.com>
Message-ID: <20120824201447.GY11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* AnilKumar Ch <anilkumar@ti.com> [120816 05:20]:
> Add D_CAN1 pinctrl node to am3358_pinmux master node to export
> D_CAN functionality on AM335x EVM according to pinctrl-single
> driver.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
> Changes from v2:
> 	- Incorporated Vaibhav H's comments on v2
> 	  * Added dcan0 instances to am33xx.dtsi file
> 
> Changes from v1:
> 	- These two patches separated from c_can DT support
> 	  patch series.
> 
>  arch/arm/boot/dts/am335x-evm.dts |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 5dd8a6b..a64c30a 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -18,6 +18,18 @@
>  		reg = <0x80000000 0x10000000>; /* 256 MB */
>  	};
>  
> +	am3358_pinmux: pinmux at 44E10800 {

This should be just &am3358_pinmux as you already include it.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&d_can1_pins>;
> +
> +		d_can1_pins: pinmux_d_can_pins {
> +			pinctrl-single,pins = <
> +				0x168 0x2	/* uart0_ctsn.d_can1_tx, OUTPUT | MODE2 */
> +				0x16C 0x32	/* uart0_rtsn.d_can1_rx, INPUT_PULLUP | MODE2 */
> +			>;
> +		};
> +	};
> +

It would better to claim these pins in the dcan driver entry
rather than set them as pins enabled by the pinctrl driver.
The reason is that in case you want to enable runtime PM related
stuff, like some more advanced wake-up features, for the rx pin
you can do it in the driver.

Then one nit.. Please lowercase all hex number in this series as that's the style
here.

Regards,

Tony
