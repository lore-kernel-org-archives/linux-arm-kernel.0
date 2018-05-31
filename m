From: robh@kernel.org (Rob Herring)
Date: Wed, 30 May 2018 23:06:38 -0500
Subject: [PATCH v2 5/6] ARM: dts: Add generic interconnect target module
 node for MCAN
In-Reply-To: <20180530141133.3711-6-faiz_abbas@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-6-faiz_abbas@ti.com>
Message-ID: <20180531040638.GA26751@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 07:41:32PM +0530, Faiz Abbas wrote:
> The ti-sysc driver provides support for manipulating the idlemodes
> and interconnect level resets.
> 
> Add the generic interconnect target module node for MCAN to support
> the same.
> 
> CC: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  arch/arm/boot/dts/dra76x.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
> index bfc82636999c..57b8dc0fe719 100644
> --- a/arch/arm/boot/dts/dra76x.dtsi
> +++ b/arch/arm/boot/dts/dra76x.dtsi
> @@ -11,6 +11,25 @@
>  / {
>  	compatible = "ti,dra762", "ti,dra7";
>  
> +	ocp {
> +
> +		target-module at 0x42c00000 {

Build your dtb with W=1 and fix warnings you add (drop '0x').

This is a CAN bus controller? If so, then use 'can' for node name.

> +			compatible = "ti,sysc-dra7-mcan";
> +			ranges = <0x0 0x42c00000 0x2000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x42c01900 0x4>,
> +			      <0x42c01904 0x4>,
> +			      <0x42c01908 0x4>;
> +			reg-names = "rev", "sysc", "syss";
> +			ti,sysc-mask = <(SYSC_OMAP4_SOFTRESET |
> +					 SYSC_DRA7_MCAN_ENAWAKEUP)>;
> +			ti,syss-mask = <1>;
> +			clocks = <&wkupaon_clkctrl DRA7_ADC_CLKCTRL 0>;
> +			clock-names = "fck";
> +		};
> +	};
> +
>  };
>  
>  /* MCAN interrupts are hard-wired to irqs 67, 68 */
> -- 
> 2.17.0
> 
