From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 20 Apr 2017 08:43:40 +0200
Subject: [PATCH v3 2/5] ARM: dts: rockchip: add ARM Mali GPU node for
 rk3288
In-Reply-To: <319a2a72-ca25-08d7-68dc-7eae74f1a622@collabora.com>
References: <cover.1492588180.git.guillaume.tucker@collabora.com>
 <5403013.fQWx48MQOq@phil>
 <319a2a72-ca25-08d7-68dc-7eae74f1a622@collabora.com>
Message-ID: <20465416.u9Y0ETYs62@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guillaume,

Am Donnerstag, 20. April 2017, 06:44:56 CEST schrieb Guillaume Tucker:
> On 19/04/17 09:59, Heiko Stuebner wrote:
> > Am Mittwoch, 19. April 2017, 09:06:18 CEST schrieb Guillaume Tucker:
> >> Add Mali GPU device tree node for the rk3288 SoC, with devfreq
> >> opp table.
> >>
> >> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> >> ---
> >>  arch/arm/boot/dts/rk3288.dtsi | 22 ++++++++++++++++++++++
> >>  1 file changed, 22 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> >> index df8a0dbe9d91..187eed528f83 100644
> >> --- a/arch/arm/boot/dts/rk3288.dtsi
> >> +++ b/arch/arm/boot/dts/rk3288.dtsi
> >> @@ -43,6 +43,7 @@
> >>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>  #include <dt-bindings/pinctrl/rockchip.h>
> >>  #include <dt-bindings/clock/rk3288-cru.h>
> >> +#include <dt-bindings/power/rk3288-power.h>
> >>  #include <dt-bindings/thermal/thermal.h>
> >>  #include <dt-bindings/power/rk3288-power.h>
> >>  #include <dt-bindings/soc/rockchip,boot-mode.h>
> >> @@ -227,6 +228,27 @@
> >>  		ports = <&vopl_out>, <&vopb_out>;
> >>  	};
> >>
> >> +	gpu: mali at ffa30000 {
> >
> > please sort nodes by address. ffa30000 should be placed below hdmi at ff980000
> > and above qos at ffaa0000 .
> 
> Sure, will fix that in v4.
> 
> >> +		compatible = "arm,mali-t760", "arm,mali-midgard";
> >
> > As indicated before I don't trust that a generic binding will work for
> > everything, so I would feel safer if we had a "rockchip,rk3288-mali" in
> > front for future purposes, making it a
> >
> > 		compatible = "rockchip,rk3288-mali", "arm,mali-t760", "arm,mali-midgard";
> 
> OK, sorry I overlooked this part.  I'll add it in v4 with a
> vendor compatible string in the binding documentation.

great, thanks :-)

> 
> >> +		reg = <0xffa30000 0x10000>;
> >> +		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> >> +			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> >> +			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> >> +		interrupt-names = "job", "mmu", "gpu";
> >> +		clocks = <&cru ACLK_GPU>;
> >> +		operating-points = <
> >> +			/* KHz uV */
> >> +			100000 950000
> >> +			200000 950000
> >> +			300000 1000000
> >> +			400000 1100000
> >> +			500000 1200000
> >> +			600000 1250000
> >> +		>;
> >
> > Wasn't there a wish for opp-v2 in a previous version?
> 
> Well it wasn't entirely clear to me in Rob's email whether it was
> necessary to use opp-v2 now or rather if it would be a potential
> option whenever opp-v2 was needed.  If operating-points (v1) are
> being deprecated then I can change that in my next patch v4.
> Using operating-points-v2 with the Mali driver works as far as I
> can tell on rk3288 so that's not an issue.

I don't care to much either way, just remembered it being mentioned
in the previous version. So lets see what Rob says.


Heiko
