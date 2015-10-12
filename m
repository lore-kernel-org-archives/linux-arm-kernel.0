From: jonmason@broadcom.com (Jon Mason)
Date: Mon, 12 Oct 2015 13:57:06 -0400
Subject: [PATCH 04/10] ARM: dts: enable clock support for BCM5301X
In-Reply-To: <20151010001408.GX26883@codeaurora.org>
References: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
 <1443826665-17570-5-git-send-email-jonmason@broadcom.com>
 <20151009073540.GO26883@codeaurora.org>
 <20151009182728.GD17527@broadcom.com>
 <20151010001408.GX26883@codeaurora.org>
Message-ID: <20151012175706.GF20867@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 05:14:08PM -0700, Stephen Boyd wrote:
> On 10/09, Jon Mason wrote:
> > On Fri, Oct 09, 2015 at 12:35:40AM -0700, Stephen Boyd wrote:
> > > On 10/02, Jon Mason wrote:
> > > 
> > > >  arch/arm/boot/dts/bcm5301x.dtsi | 67 ++++++++++++++++++++++++++++++++++++-----
> > > >  1 file changed, 60 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
> > > > index 6f50f67..f717859 100644
> > > > --- a/arch/arm/boot/dts/bcm5301x.dtsi
> > > > +++ b/arch/arm/boot/dts/bcm5301x.dtsi
> > > > @@ -55,14 +56,14 @@
> > > >  			compatible = "arm,cortex-a9-global-timer";
> > > >  			reg = <0x0200 0x100>;
> > > >  			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > > > -			clocks = <&clk_periph>;
> > > > +			clocks = <&periph_clk>;
> > > >  		};
> > > >  
> > > >  		local-timer at 0600 {
> > > >  			compatible = "arm,cortex-a9-twd-timer";
> > > >  			reg = <0x0600 0x100>;
> > > >  			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> > > > -			clocks = <&clk_periph>;
> > > > +			clocks = <&periph_clk>;
> > > >  		};
> > > >  
> > > >  		gic: interrupt-controller at 1000 {
> > > > @@ -94,14 +95,66 @@
> > > >  
> > > >  	clocks {
> > > 
> > > I'd expect this to only contain nodes that don't have a reg
> > > property. Clock providers that have a reg property would go into
> > > some soc node or bus. Perhaps that's the chipcommonA node, or
> > > axi?
> > 
> > This might get a little ugly, as some of the clocks are in the
> > 0x18000000 and others are in 0x19000000.  I would think it better to
> > have them all in one place (as that is more readable).  Do you preferr
> > I split the pieces up into their respective DT nodes?
> 
> Are there two clock controllers? Sorry I don't understand the
> architecture here very well. Nodes with reg properties in the
> same range should be near each other. We don't group all i2c
> controllers into the same node because they're logically i2c
> controllers. We express the hierarchy of devices with container
> nodes. The clocks node is only useful for board-level clocks, not
> things that are inside the SoC.

3 clock sources: a9pll, lcpll, and genpll. The first one resides in
the IP block living at the 0x19000000 address range, while the latter
two live in the 0x18000000 address range.

I'll split up the clocks amongst the respective entries, per your
suggestion.

Thanks,
Jon 




> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
