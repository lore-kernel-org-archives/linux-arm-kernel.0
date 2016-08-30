From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 30 Aug 2016 09:05:06 +0200
Subject: [PATCH] arm64: dts: rockchip: Explicitly set pclk_pmu_src on
 rk3399
In-Reply-To: <57C4DA73.5000505@rock-chips.com>
References: <1472494284-11315-1-git-send-email-dianders@chromium.org>
 <20160829181841.GA8682@localhost> <57C4DA73.5000505@rock-chips.com>
Message-ID: <4298293.ZqJ4n19bHK@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

Am Dienstag, 30. August 2016, 08:59:31 schrieb Elaine Zhang:
> On 08/30/2016 02:18 AM, Brian Norris wrote:
> > On Mon, Aug 29, 2016 at 11:11:24AM -0700, Doug Anderson wrote:
> >> On rk3399 we explicitly set ppll in the device tree to 676000000.  The
> >> ppll has one major child, pclk_pmu_src, that is the parent of lots of
> >> other clocks.  Right now nobody is setting that clock rate and we're
> >> relying on the divider to just happen to be something sane.  Let's be
> >> explicit in our request so we're not relying on the firmware.
> >> 
> >> With the current firmware I tested with this patch has no expected
> >> impact but it's probably good to do anyway.
> >> 
> >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >> ---
> >> 
> >>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index
> >> 62d450935a57..ffb3faa8c176 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> @@ -908,8 +908,8 @@
> >> 
> >>   		reg = <0x0 0xff750000 0x0 0x1000>;
> >>   		#clock-cells = <1>;
> >>   		#reset-cells = <1>;
> >> 
> >> -		assigned-clocks = <&pmucru PLL_PPLL>;
> >> -		assigned-clock-rates = <676000000>;
> >> +		assigned-clocks = <&pmucru PLL_PPLL>, <&pmucru PCLK_SRC_PMU>;
> >> +		assigned-clock-rates = <676000000>, <112666667>;
> > 
> > I think this makes sense and is a good idea. One alternative would be to
> > have the various children actually set a rate that they expect, but
> > several of them don't have a separate driver at all, and that would be
> > of dubious value anyway I think.
> 
> I agree with you. This clk default div is set in the uboot or coreboot.
> And if is need to set in kernel ,I hope the freq is 50M(<48285714>).
> This freq can meet the performance,and the power consumption is not too
> much.

can you maybe also provide a tag like the one Brian did below. Your sentence 
above indicates that you reviewed and approve, but it's helpful to also state 
that explicitly :-)


> > Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks
Heiko


> > 
> >>   	};
> >>   	
> >>   	cru: clock-controller at ff760000 {
> >> 
> >> --
> >> 2.8.0.rc3.226.g39d4020
