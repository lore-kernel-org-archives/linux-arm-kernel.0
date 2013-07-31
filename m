From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 31 Jul 2013 09:37:24 +0200
Subject: [PATCH 4/4] ARM: sun6i: Enable clock support in the DTSI
In-Reply-To: <51F86A2E.10505@elopez.com.ar>
References: <1375195462-19566-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375195462-19566-5-git-send-email-maxime.ripard@free-electrons.com>
 <51F86A2E.10505@elopez.com.ar>
Message-ID: <20130731073724.GA24439@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Tue, Jul 30, 2013 at 10:36:46PM -0300, Emilio L?pez wrote:
> Hi Maxime,
> 
> Overall this looks good to me, but I have some small comments:
> 
> El 30/07/13 11:44, Maxime Ripard escribi?:
> > Now that the clock driver has support for the A31 clocks, we can add
> > them to the DTSI and start using them in the relevant hardware blocks.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/sun6i-a31.dtsi | 137 ++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 127 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> > index 0d13dc6..c6a3a91 100644
> > --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> > +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> > @@ -51,13 +51,130 @@
> >  
> >  	clocks {
> >  		#address-cells = <1>;
> > -		#size-cells = <0>;
> > +		#size-cells = <1>;
> > +		ranges;
> >  
> > -		osc: oscillator {
> > +		osc24M: hosc {
> 
> Please use osc24M and osc32k instead of hosc and losc, respectively.

The problem is a bit more complex than that.

On the A31, the losc clock is actually a mux between an external
oscillator running at 32kHz, and the internal oscillator running at
667MHz, that would be scaled down.

Support for this mux is not quite there yet, since I've not seen any
documentation for it, but this would allow to just rearrange losc
parents and compatible when we will had such support.

Hence why I chose these names.

> >  			#clock-cells = <0>;
> >  			compatible = "fixed-clock";
> >  			clock-frequency = <24000000>;
> 
> Is osc24M not gatable on A31?

Nope.

> >  		};
> > +
> > +		osc32k: losc {
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <32768>;
> > +		};
> > +
> > +		pll1: pll1 at 01c20000 {
> > +			#clock-cells = <0>;
> > +			compatible = "allwinner,sun6i-pll1-clk";
> > +			reg = <0x01c20000 0x4>;
> > +			clocks = <&osc24M>;
> > +		};
> > +
> > +		/*
> > +		 * This is a dummy clock, to be used as placeholder on
> > +		 * other mux clocks when a specific parent clock is not
> > +		 * yet implemented. It should be dropped when the driver
> > +		 * is complete.
> > +		 */
> > +		pll6: pll6 {
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <0>;
> > +		};
> > +
> > +		cpu: cpu at 01c20050 {
> > +			#clock-cells = <0>;
> > +			compatible = "allwinner,sun4i-cpu-clk";
> > +			reg = <0x01c20050 0x4>;
> > +			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll1>;
> 
> Listing pll1 twice doesn't sound correct, but vendor code seems to
> indicate so. A comment to clarify it's not a typo would be good I think.

Yes, I suspect an error in the datasheet, but until proven otherwise,
it's that way.

I'll add a comment.

> > +		};
> > +
> > +		axi: axi at 01c20050 {
> > +			#clock-cells = <0>;
> > +			compatible = "allwinner,sun4i-axi-clk";
> > +			reg = <0x01c20050 0x4>;
> > +			clocks = <&cpu>;
> > +		};
> > +
> > +		ahb1_mux: ahb1_mux at 01c20054 {
> > +			#clock-cells = <0>;
> > +			compatible = "allwinner,sun6i-ahb1-mux-clk";
> > +			reg = <0x01c20054 0x4>;
> > +			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6>;
> > +		};
> > +
> > +		ahb1: ahb1 at 01c20054 {
> > +			#clock-cells = <0>;
> > +			compatible = "allwinner,sun4i-ahb-clk";
> > +			reg = <0x01c20054 0x4>;
> > +			clocks = <&ahb1_mux>;
> > +		};
> 
> Depending on when this lands, I believe these two above could be merged
> into one with the refactoring introduced on my patchset.

Since your patchset is still in RFC and we had no comments from Mike so
far, while this one looks pretty similar to the one we had before, I
guess the safest thing to do would be to rebase your patches on top of
this ones.

But it's right those clocks (AHB1 and APB2) will benefit from your work
as well :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130731/458dcc5f/attachment-0001.sig>
