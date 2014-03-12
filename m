From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Mar 2014 17:43:56 +0900
Subject: [PATCH v3 04/20] ARM: shmobile: r8a7779: Add clocks
In-Reply-To: <7964326.0VzqzhpvEl@avalon>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-5-git-send-email-horms+renesas@verge.net.au>
 <7964326.0VzqzhpvEl@avalon>
Message-ID: <20140312084355.GD25813@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 03:45:03PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> One more comment.
> 
> On Wednesday 26 February 2014 16:33:20 Simon Horman wrote:
> > Declare all core and MSTP clocks currently used by r8a7779-based boards.
> > 
> > Based on work by Laurent Pinchart for the r8a7790 and r8a7791 SoCs.
> > 
> > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > ---
> > v3
> > * As suggested by Laurent Pinchart
> >   - Add and use extal_clk
> >   - Fix bogus status register use for MSTP clocks
> >   - Fix bogus mstp3_cls to use its own entries rather than
> >     that of mstp1_clks
> > 
> > * Update to use "main" in cpg_clocks as per updated
> >   binding in previous patch
> > * Update for new, consolidated and renamed index macros
> >   - R8A7779_CLK_ETHER
> >   - R8A7779_CLK_HSCIF
> >   - R8A7779_CLK_HSPI
> >   - R8A7779_CLK_MMC0,1
> >   - R8A7779_CLK_PCIE
> >   - R8A7779_CLK_USB01,2
> > ---
> >  arch/arm/boot/dts/r8a7779.dtsi | 129 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 129 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> > index d0561d4..240a03e 100644
> > --- a/arch/arm/boot/dts/r8a7779.dtsi
> > +++ b/arch/arm/boot/dts/r8a7779.dtsi
> > @@ -11,6 +11,7 @@
> > 
> >  /include/ "skeleton.dtsi"
> > 
> > +#include <dt-bindings/clock/r8a7779-clock.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> > 
> >  / {
> > @@ -278,4 +279,132 @@
> >  		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
> >  		status = "disabled";
> >  	};
> > +
> > +	clocks {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		/* External root clock */
> > +		extal_clk: extal_clk {
> > +			compatible = "fixed-clock";
> > +			#clock-cells = <0>;
> > +			/* This value must be overriden by the board. */
> > +			clock-frequency = <0>;
> > +			clock-output-names = "extal";
> > +		};
> > +
> > +		/* Special CPG clocks */
> > +		cpg_clocks: cpg_clocks at 0xe6150000 {
> > +			compatible = "renesas,r8a7779-cpg-clocks";
> > +			reg = <0 0xe6150000 0 0x1000>;
> 
> Copied from H2 ? :-) This should probably be

Thanks :)
