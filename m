From: jonmason@broadcom.com (Jon Mason)
Date: Fri, 9 Oct 2015 14:27:28 -0400
Subject: [PATCH 04/10] ARM: dts: enable clock support for BCM5301X
In-Reply-To: <20151009073540.GO26883@codeaurora.org>
References: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
 <1443826665-17570-5-git-send-email-jonmason@broadcom.com>
 <20151009073540.GO26883@codeaurora.org>
Message-ID: <20151009182728.GD17527@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 12:35:40AM -0700, Stephen Boyd wrote:
> On 10/02, Jon Mason wrote:
> > Replace current device tree dummy clocks with real clock support for
> > Broadcom Northstar SoCs.
> > 
> > Signed-off-by: Jon Mason <jonmason@broadcom.com>
> > ---
> 
> I'd rather not take any dts changes through clk tree.

Ok, I'll split off the device tree portion of this patch series, and
submit that after the clk driver portion has been accepted and pushed
upstream.

> 
> >  arch/arm/boot/dts/bcm5301x.dtsi | 67 ++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 60 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
> > index 6f50f67..f717859 100644
> > --- a/arch/arm/boot/dts/bcm5301x.dtsi
> > +++ b/arch/arm/boot/dts/bcm5301x.dtsi
> > @@ -55,14 +56,14 @@
> >  			compatible = "arm,cortex-a9-global-timer";
> >  			reg = <0x0200 0x100>;
> >  			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > -			clocks = <&clk_periph>;
> > +			clocks = <&periph_clk>;
> >  		};
> >  
> >  		local-timer at 0600 {
> >  			compatible = "arm,cortex-a9-twd-timer";
> >  			reg = <0x0600 0x100>;
> >  			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> > -			clocks = <&clk_periph>;
> > +			clocks = <&periph_clk>;
> >  		};
> >  
> >  		gic: interrupt-controller at 1000 {
> > @@ -94,14 +95,66 @@
> >  
> >  	clocks {
> 
> I'd expect this to only contain nodes that don't have a reg
> property. Clock providers that have a reg property would go into
> some soc node or bus. Perhaps that's the chipcommonA node, or
> axi?

This might get a little ugly, as some of the clocks are in the
0x18000000 and others are in 0x19000000.  I would think it better to
have them all in one place (as that is more readable).  Do you preferr
I split the pieces up into their respective DT nodes?

> 
> >  		#address-cells = <1>;
> > -		#size-cells = <0>;
> > +		#size-cells = <1>;
> > +		ranges;
> >  
> > -		/* As long as we do not have a real clock driver us this
> > -		 * fixed clock */
> > -		clk_periph: periph {
> > +		osc: oscillator {
> > +			#clock-cells = <0>;
> >  			compatible = "fixed-clock";
> > +			clock-frequency = <25000000>;
> > +		};
> > +
> > +		lcpll0: lcpll0 at 1800c100 {
> > +			#clock-cells = <1>;
> > +			compatible = "brcm,nsp-lcpll0";
> > +			reg = <0x1800c100 0x14>;
> > +			clocks = <&osc>;
> > +			clock-output-names = "lcpll0", "pcie_phy", "sdio",
> > +					     "ddr_phy";
> > +		};
> > +
> > +		genpll: genpll at 1800c140 {
> > +			#clock-cells = <1>;
> > +			compatible = "brcm,nsp-genpll";
> > +			reg = <0x1800c140 0x24>;
> > +			clocks = <&osc>;
> > +			clock-output-names = "genpll", "phy", "ethernetclk",
> > +					     "usbclk", "iprocfast", "sata1",
> > +					     "sata2";
> > +		};
> > +
> > +		iprocmed: iprocmed {
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-factor-clock";
> > +			clocks = <&genpll BCM_NSP_GENPLL_IPROCFAST_CLK>;
> > +			clock-div = <2>;
> > +			clock-mult = <1>;
> > +			clock-output-names = "iprocmed";
> > +		};
> > +
> > +		iprocslow: iprocslow {
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-factor-clock";
> > +			clocks = <&genpll BCM_NSP_GENPLL_IPROCFAST_CLK>;
> > +			clock-div = <4>;
> > +			clock-mult = <1>;
> > +			clock-output-names = "iprocslow";
> > +		};
> > +
> > +
> > +		a9pll: arm_clk at 19000000 {
> > +			#clock-cells = <0>;
> > +			compatible = "brcm,nsp-armpll";
> > +			clocks = <&osc>;
> > +			reg = <0x19000000 0x1000>;
> > +		};
> > +
> > +		periph_clk: periph_clk {
> >  			#clock-cells = <0>;
> > -			clock-frequency = <400000000>;
> > +			compatible = "fixed-factor-clock";
> > +			clocks = <&a9pll>;
> > +			clock-div = <2>;
> > +			clock-mult = <1>;
> >  		};
> >  	};
> >  
> 
> We're trying to move away from putting individual clocks into DT
> like this. Is there some sort of clock controller that's at
> 0x1800c000, but we're just not exposing all the clocks in there?
> See this thread for more information on why we'd like to avoid
> this sort of design:
> 
> http://lkml.kernel.org/r/<20150416192014.19585.9663@quantum>

Okay, I'll clean-up the clock-output-names, per the referenced email.

Thanks,
Jon

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
