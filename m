From: horms@verge.net.au (Simon Horman)
Date: Fri, 12 Dec 2014 12:36:36 +0900
Subject: [PATCH] ARM: shmobile: r8a7794: Add SDHI clocks to device tree
In-Reply-To: <CANqRtoQHebO1aVQPuQ0V7sbzd1QhGtjL7nrkiPPHd5upGnSRCQ@mail.gmail.com>
References: <1418345235-15096-1-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoQHebO1aVQPuQ0V7sbzd1QhGtjL7nrkiPPHd5upGnSRCQ@mail.gmail.com>
Message-ID: <20141212033635.GB16337@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 12, 2014 at 10:01:01AM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Fri, Dec 12, 2014 at 9:47 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> >
> > Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> > [horms: omitted device nodes; only add clock]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > ---
> > Based on the renesas-devel-20141211-v3.18 tag of my renesas tree
> >
> > v1 [Simon Horman]
> > * Removed portions of patch which add device nodes
> > * Renamed patch from
> >   "ARM: shmobile: r8a7794: Add SDHI clocks and devices to device tree" to
> >   "ARM: shmobile: r8a7794: Add SDHI clocks to device tree"
> > ---
> >  arch/arm/boot/dts/r8a7794.dtsi            | 21 +++++++++++++++++++--
> >  include/dt-bindings/clock/r8a7794-clock.h |  3 +++
> >  2 files changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> > index 6d95638..f5a3319 100644
> > --- a/arch/arm/boot/dts/r8a7794.dtsi
> > +++ b/arch/arm/boot/dts/r8a7794.dtsi
> > @@ -293,6 +293,21 @@
> >                         clock-output-names = "main", "pll0", "pll1", "pll3",
> >                                              "lb", "qspi", "sdh", "sd0", "z";
> >                 };
> > +               /* Variable factor clocks */
> > +               sd1_clk: sd2_clk at e6150078 {
> > +                       compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
> > +                       reg = <0 0xe6150078 0 4>;
> > +                       clocks = <&pll1_div2_clk>;
> > +                       #clock-cells = <0>;
> > +                       clock-output-names = "sd1";
> > +               };
> > +               sd2_clk: sd3_clk at e615007c {
> > +                       compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
> > +                       reg = <0 0xe615007c 0 4>;
> > +                       clocks = <&pll1_div2_clk>;
> > +                       #clock-cells = <0>;
> > +                       clock-output-names = "sd2";
> > +               };
> >
> >                 /* Fixed factor clocks */
> >                 pll1_div2_clk: pll1_div2_clk {
> > @@ -496,14 +511,16 @@
> >                 mstp3_clks: mstp3_clks at e615013c {
> >                         compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
> >                         reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
> > -                       clocks = <&rclk_clk>, <&hp_clk>, <&hp_clk>;
> > +                       clocks = <&sd2_clk>, <&sd1_clk>, <&cpg_clocks R8A7794_CLK_SD0>
> > +                                <&rclk_clk>, <&hp_clk>, <&hp_clk>;
> >                         #clock-cells = <1>;
> >                         clock-indices = <
> > +                               R8A7794_CLK_SDHI2 R8A7794_CLK_SDHI1
> >                                 R8A7794_CLK_CMT1 R8A7794_CLK_USBDMAC0
> >                                 R8A7794_CLK_USBDMAC1
> >                         >;
> >                         clock-output-names =
> > -                               "cmt1", "usbdmac0", "usbdmac1";
> > +                               "sdhi2", "sdhi1", "cmt1", "usbdmac0", "usbdmac1";
> 
> This can't be right. SD0 is partially included in some of the changes above.

Thanks, there seem to be some pieces missing.
I'll fix that up.
