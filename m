From: horms@verge.net.au (Simon Horman)
Date: Thu, 21 Jan 2016 21:15:27 +0900
Subject: [PATCH 1/2] ARM: dts: r8a7793: add CAN clocks
In-Reply-To: <CAMuHMdX5sZ7yNjgu8Ns26+91+ui2YuVfGavJi_XRa6Kd-yzoBQ@mail.gmail.com>
References: <1453352981-16104-1-git-send-email-horms+renesas@verge.net.au>
 <1453352981-16104-2-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdX5sZ7yNjgu8Ns26+91+ui2YuVfGavJi_XRa6Kd-yzoBQ@mail.gmail.com>
Message-ID: <20160121121525.GA6833@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?,  1? 21, 2016 at 09:38:21?? +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Jan 21, 2016 at 6:09 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > The R-Car CAN controllers can derive the CAN bus clock not only from their
> > peripheral clock input (clkp1) but also from the other internal clock
> > (clkp2) and external clock fed on CAN_CLK pin. Describe those clocks in
> > the device tree along with  the USB_EXTAL clock from which clkp2 is
> > derived.
> >
> > Based on work by Sergei Shtylyov for the r8a7791 SoC.
> >
> > Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/boot/dts/r8a7793.dtsi | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> > index 0ce7cc420c9d..5d9375fa6759 100644
> > --- a/arch/arm/boot/dts/r8a7793.dtsi
> > +++ b/arch/arm/boot/dts/r8a7793.dtsi
> > @@ -706,12 +706,30 @@
> >                         clock-output-names = "extal";
> >                 };
> >
> > +               /* External USB clock - can be overridden by the board */
> > +               usb_extal_clk: usb_extal_clk {
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       clock-frequency = <48000000>;
> > +                       clock-output-names = "usb_extal";
> > +               };
> > +
> > +               /* External CAN clock */
> > +               can_clk: can_clk {
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       /* This value must be overridden by the board. */
> > +                       clock-frequency = <0>;
> > +                       clock-output-names = "can_clk";
> > +                       status = "disabled";
> > +               };
> > +
> >                 /* Special CPG clocks */
> >                 cpg_clocks: cpg_clocks at e6150000 {
> >                         compatible = "renesas,r8a7793-cpg-clocks",
> >                                      "renesas,rcar-gen2-cpg-clocks";
> >                         reg = <0 0xe6150000 0 0x1000>;
> > -                       clocks = <&extal_clk>;
> > +                       clocks = <&extal_clk &usb_extal_clk>;
> >                         #clock-cells = <1>;
> >                         clock-output-names = "main", "pll0", "pll1", "pll3",
> >                                              "lb", "qspi", "sdh", "sd0", "z",
> 
> To create the "rcan" clock, it should be listed in clock-output-names.

Thanks, sorry for missing that.
