From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Dec 2014 13:06:53 -0800
Subject: GPMC clock question
In-Reply-To: <54933CC1.9010301@vanguardiasur.com.ar>
References: <54933CC1.9010301@vanguardiasur.com.ar>
Message-ID: <20141218210653.GI23854@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> [141218 12:49]:
> Tony, Roger:
> 
> As far as I can see, the GPMC interface clock (GPMC_FCLK) is not
> properly modeled in the devicetree. Instead, hwmod magic seems to be used.

I guess you mean the functional clock not interface clock?
 
> arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c:
> struct omap_hwmod_ocp_if am33xx_l3_s__gpmc = {
>         .master         = &am33xx_l3_s_hwmod,
>         .slave          = &am33xx_gpmc_hwmod,
>         .clk            = "l3s_gclk",
>         .addr           = am33xx_gpmc_addr_space,
>         .user           = OCP_USER_MPU,
> };
> 
> I'd like to know what would be the appropriate DT model for this clock.
> Perhaps, as child of CORE_M4_CLK, divided by 2:
> 
> gpmc_fclk: gpmc_fclk {
>                 #clock-cells = <0>;
>                 compatible = "fixed-factor-clock";
>                 clocks = <&dpll_core_m4_ck>;
>                 clock-mult = <1>;
>                 clock-div = <2>;
>         };
> 
> How does it look? Also, I'm wondering if this works OK when used with
> the hwmod stuff.

Hmm we do have clocks or aliases for l3s_gclk, so it's there as otherwise
the GPMC would not work at all :) Sure with device tree only systems we
should have the clock phandle directly available though.

Note that the hwmod code takes care of runtime PM clock gating for the
drivers. But the clock entry for am33xx_l3_s__gpmc should be coming
from .dts. Please also check out the hwmod dts related changes Felipe
posted last week, that might allow populating .clk from .dts already.

Regards,

Tony
