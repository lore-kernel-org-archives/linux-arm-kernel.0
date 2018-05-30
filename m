From: tony@atomide.com (Tony Lindgren)
Date: Wed, 30 May 2018 08:04:02 -0700
Subject: [PATCH v2 5/6] ARM: dts: Add generic interconnect target module
 node for MCAN
In-Reply-To: <20180530141133.3711-6-faiz_abbas@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-6-faiz_abbas@ti.com>
Message-ID: <20180530150402.GE5705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Faiz Abbas <faiz_abbas@ti.com> [180530 14:12]:
> The ti-sysc driver provides support for manipulating the idlemodes
> and interconnect level resets.
...
> --- a/arch/arm/boot/dts/dra76x.dtsi
> +++ b/arch/arm/boot/dts/dra76x.dtsi
> @@ -11,6 +11,25 @@
>  / {
>  	compatible = "ti,dra762", "ti,dra7";
>  
> +	ocp {
> +
> +		target-module at 0x42c00000 {
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

Looks good to me except I think the reset won't do anything currently
with ti-sysc.c unless you specfify also "ti,hwmods" for the module?

Can you please check? It might be worth adding the reset function to
ti-sysc.c for non "ti,hwmods" case and that just might remove the
need for any hwmod code for this module.

Regards,

Tony
