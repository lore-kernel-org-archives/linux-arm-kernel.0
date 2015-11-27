From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 27 Nov 2015 13:42:00 +0800
Subject: [PATCH v3 4/5] ARM: dts: sun9i: Add A80 PRCM clocks and reset
 control nodes
In-Reply-To: <20151126200942.GQ32142@lukather>
References: <1448357536-26613-1-git-send-email-wens@csie.org>
 <1448357536-26613-5-git-send-email-wens@csie.org>
 <20151124182709.7671f12f@xhacker>	<20151126200942.GQ32142@lukather>
Message-ID: <20151127134200.0df10f37@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime,

On Thu, 26 Nov 2015 21:09:42 +0100
Maxime Ripard wrote:

> On Tue, Nov 24, 2015 at 06:27:09PM +0800, Jisheng Zhang wrote:
> > + Sebastian
> > 
> > On Tue, 24 Nov 2015 17:32:15 +0800
> > Chen-Yu Tsai wrote:
> >   
> > > This adds the supported PRCM clocks and reset controls to the A80 dtsi.
> > > The DAUDIO module clocks are not supported yet.
> > > 
> > > Also update clock and reset phandles for r_uart.
> > > 
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > ---
> > >  arch/arm/boot/dts/sun9i-a80.dtsi | 79 +++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 78 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> > > index 1118bf5cc4fb..a4ce348c0831 100644
> > > --- a/arch/arm/boot/dts/sun9i-a80.dtsi
> > > +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> > > @@ -164,6 +164,14 @@
> > >  					     "usb_phy2", "usb_hsic_12M";
> > >  		};
> > >  
> > > +		pll3: clk at 06000008 {
> > > +			/* placeholder until implemented */
> > > +			#clock-cells = <0>;
> > > +			compatible = "fixed-clock";
> > > +			clock-rate = <0>;
> > > +			clock-output-names = "pll3";
> > > +		};
> > > +
> > >  		pll4: clk at 0600000c {
> > >  			#clock-cells = <0>;
> > >  			compatible = "allwinner,sun9i-a80-pll4-clk";
> > > @@ -350,6 +358,68 @@
> > >  					"apb1_uart2", "apb1_uart3",
> > >  					"apb1_uart4", "apb1_uart5";
> > >  		};
> > > +
> > > +		cpus_clk: clk at 08001410 {
> > > +			compatible = "allwinner,sun9i-a80-cpus-clk";
> > > +			reg = <0x08001410 0x4>;
> > > +			#clock-cells = <0>;
> > > +			clocks = <&osc32k>, <&osc24M>, <&pll4>, <&pll3>;
> > > +			clock-output-names = "cpus";
> > > +		};
> > > +
> > > +		ahbs: ahbs_clk {
> > > +			compatible = "fixed-factor-clock";
> > > +			#clock-cells = <0>;
> > > +			clock-div = <1>;
> > > +			clock-mult = <1>;
> > > +			clocks = <&cpus_clk>;
> > > +			clock-output-names = "ahbs";
> > > +		};  
> > 
> > Dear Sebastian and all,
> > 
> > I just want to take the sunxi clk support in mainline for example.
> > 
> > I'm not sure I understand correctly, it seems to me that some maintainers draw a
> > line: "having a node for every clock" is a no, no[1]. But here we saw one node for
> > cpus_clk and apbs below. And <0x08001410 0x4>; <0x0800141c 0x4>; shows they
> > are close each other, so should we merge them into a single clock complex node
> > then use mfd, regmap in clk driver?
> > 
> > But IMHO, sunxi dts nodes really represent real HW, so I still can't understand
> > why we could not have each node for cpus_clk and apbs. Can you please kindly
> > teach me?  
> 
> I'm totally lacking any context, but I'll reply. My view on this is
> that they both represent the hardware, simply with a different model.
> 
> This preference of the clk maintainers and active clk developers
> regarding the model to choose has evolved over time. When we started
> the sunxi support, having one node per clock was the preferred way to
> do things.
> 
> Berlin came much later, and the preference at that time was to have
> the entire clock controller represented as single opaque block to the
> consumers.
> 
> Both have pros and cons. The approach we took allows for an easier mix
> and match, especially if the clocks you have in one SoC are reused in
> others, without modifying the source code (or barely). AFAIK, this is
> also the approach took by mvebu, except that their clock tree is much
> much much simpler.
> 
> The approach Berlin took allows to have an easier maintainance and
> more flexibility, for example to deal with clock registration
> ordering, or clocks that share registers.
> 
> Our approach works just fine in our case, and I feel no incentive to
> move to the new model (quite the opposite actually), but I guess it
> also depends on how your clock controller is built, how many SoCs you
> have to support, and how much clocks they are sharing.

Great! Thank you a lot for the detailed explanation. Now I can understand
why the clk drivers follow different models, I think I get Sebastian and
Stephen's view points. Although the BG4CT clock/pll IP are shared in all
newer than BG2Q SoCs (the only difference is how many clocks, how many plls,
and their register address), I'll follow Sebastian's suggestions -- one
entire clock controller node for all clocks/plls block

> 
> I hope it clears things up.

Yes, it's clear now. I knew the history and the reason why there are different
models in clk drivers.

Will cook a newer BG4CT clk series for review.

Thank you,
Jisheng
