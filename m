From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Dec 2015 08:35:51 -0800
Subject: [4.4-rc][PATCH v2] ARM: dts: am4372: fix clock source for arm
 twd and global timers
In-Reply-To: <1448898998-32749-1-git-send-email-grygorii.strashko@ti.com>
References: <1448898998-32749-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20151203163551.GQ23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [151130 07:58]:
> ARM TWD and Global timer are clocked by PERIPHCLK which is MPU_CLK/2.
> But now they are clocked by dpll_mpu_m2_ck == MPU_CLK and, as result.
> Timekeeping core misbehaves. For example, execution of command
> "sleep 5" will take 10 sec instead of 5.
> 
> Hence, fix it by adding mpu_periphclk ("fixed-factor-clock") and use
> it for clocking ARM TWD and Global timer (same way as on OMAP4).
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Fixes:commit 8cbd4c2f6a99 ("arm: boot: dts: am4372: add ARM timers and SCU nodes")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Is this fix alone enough or do you still need to disable other the ARM
timers in the board specific dts file?

Regards,

Tony

> ---
> Changes in v2:
>  - fix: mpu_periphclk should be clocked from dpll_mpu_m2_ck instead of
>    dpll_mpu_ck.
> link on v1:
>  http://www.spinics.net/lists/arm-kernel/msg463898.html
> 
>  arch/arm/boot/dts/am4372.dtsi        | 4 ++--
>  arch/arm/boot/dts/am43xx-clocks.dtsi | 8 ++++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index d83ff9c..de8791a 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -74,7 +74,7 @@
>  		reg = <0x48240200 0x100>;
>  		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-parent = <&gic>;
> -		clocks = <&dpll_mpu_m2_ck>;
> +		clocks = <&mpu_periphclk>;
>  	};
>  
>  	local_timer: timer at 48240600 {
> @@ -82,7 +82,7 @@
>  		reg = <0x48240600 0x100>;
>  		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-parent = <&gic>;
> -		clocks = <&dpll_mpu_m2_ck>;
> +		clocks = <&mpu_periphclk>;
>  	};
>  
>  	l2-cache-controller at 48242000 {
> diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
> index cc88728..a38af2b 100644
> --- a/arch/arm/boot/dts/am43xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
> @@ -259,6 +259,14 @@
>  		ti,invert-autoidle-bit;
>  	};
>  
> +	mpu_periphclk: mpu_periphclk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-factor-clock";
> +		clocks = <&dpll_mpu_m2_ck>;
> +		clock-mult = <1>;
> +		clock-div = <2>;
> +	};
> +
>  	dpll_ddr_ck: dpll_ddr_ck {
>  		#clock-cells = <0>;
>  		compatible = "ti,am3-dpll-clock";
> -- 
> 2.6.3
> 
