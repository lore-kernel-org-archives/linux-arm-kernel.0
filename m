From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Nov 2015 14:15:38 +0000
Subject: [4.4-rc][PATCH] ARM: dts: am4372: disable arm twd and global
 timer's nodes
In-Reply-To: <1447855315-419-1-git-send-email-grygorii.strashko@ti.com>
References: <1447855315-419-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20151118141537.GC10644@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 04:01:55PM +0200, Grygorii Strashko wrote:
> Keep ARM TWD and Global timer's nodes disabled by default - if someone
> would like to use them then those nodes have to be enabled explicitly
> in board file.
> 
> The reason for this change is:
> - ARM TWD is not always-on timer on am437x and it will stop in low
>   CPUIdle states and, therefore, broadcast timer has to configured
>   properly if CPU_IDLE=y.
> - ARM Global timer is not always-on timer on am437x and it can't be
>   used as clocksource device if CPU_IDLE=y.

I don't understand. What timer do you use in the absence of a TWD, and
if it is better why is it not used even if TWD is present?

> - ARM Global timer driver doesn't support CPUfreq now.

Surely that should be fixed in the driver (e.g. make it fail to probe if
CPUfreq is present)? It's broken for any other users too...

Mark.

> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  arch/arm/boot/dts/am4372.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index d83ff9c..11376e3 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -75,6 +75,7 @@
>  		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-parent = <&gic>;
>  		clocks = <&dpll_mpu_m2_ck>;
> +		status = "disabled";
>  	};
>  
>  	local_timer: timer at 48240600 {
> @@ -83,6 +84,7 @@
>  		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-parent = <&gic>;
>  		clocks = <&dpll_mpu_m2_ck>;
> +		status = "disabled";
>  	};
>  
>  	l2-cache-controller at 48242000 {
> -- 
> 2.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
