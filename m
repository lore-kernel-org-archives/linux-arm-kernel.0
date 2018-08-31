From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 31 Aug 2018 19:10:13 +0800
Subject: [PATCH v4 09/13] ARM: dts: sun8i: r40: add sata node
In-Reply-To: <20180831092934.GC16301@Red>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-10-clabbe.montjoie@gmail.com>
 <20180831073500.zubqpvar4yhjqrge@flea> <20180831075631.GB16301@Red>
 <CAGb2v65dWmFxacx16taTdDf0WO4vCJfJLrf=7Vh6RtJEjHdH5A@mail.gmail.com>
 <20180831092934.GC16301@Red>
Message-ID: <CAGb2v65H_Aog294NYAmcTGARGiOiyCDy=MT9g8ed=Cxr8Bm3Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 5:29 PM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
>
> On Fri, Aug 31, 2018 at 03:58:34PM +0800, Chen-Yu Tsai wrote:
> > On Fri, Aug 31, 2018 at 3:56 PM Corentin Labbe
> > <clabbe.montjoie@gmail.com> wrote:
> > >
> > > On Fri, Aug 31, 2018 at 09:35:00AM +0200, Maxime Ripard wrote:
> > > > On Thu, Aug 30, 2018 at 09:01:16PM +0200, Corentin Labbe wrote:
> > > > > R40 have a sata controller which is the same as A20.
> > > > > This patch adds a DT node for it.
> > > > >
> > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > > > ---
> > > > >  arch/arm/boot/dts/sun8i-r40.dtsi | 23 +++++++++++++++++++++++
> > > > >  1 file changed, 23 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > index 852c2ccc3268..d6b5820da850 100644
> > > > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > @@ -550,6 +550,29 @@
> > > > >                     #size-cells = <0>;
> > > > >             };
> > > > >
> > > > > +           ahci: sata at 1c18000 {
> > > > > +                   compatible = "allwinner,sun8i-r40-ahci";
> > > > > +                   reg = <0x01c18000 0x1000>;
> > > > > +                   interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +                   clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> > > > > +                   resets = <&ccu RST_BUS_SATA>;
> > > > > +                   resets-name = "ahci";
> > > > > +                   #address-cells = <1>;
> > > > > +                   #size-cells = <0>;
> > > > > +                   status = "disabled";
> > > > > +
> > > > > +                   sata_port: sata-port at 0 {
> > > > > +                           reg = <0>;
> > > > > +                           phys = <&sata_phy>;
> > > > > +                   };
> > > > > +           };
> > > > > +
> > > > > +           sata_phy: sata-phy at 1c180c0  {
> > > > > +                   compatible = "allwinner,sun8i-r40-sata-phy";
> > > > > +                   reg = <0x1c180c0 0x200>;
> > > >
> > > > Overlapping devices in the DTS is not ok.
> > > >
> > >
> > > I do the same than arch/arm/boot/dts/berlin2.dtsi (sata at e90000 phy at e900a0)
> > > But since it is not a good justification, it seems that regmap is my only solution ?
> >
> > Since you are effectively splitting one device node into two, you should
> > adjust the original (ahci) device nodes register range.
> >
>
> I cannot do that if I remove patch 13, iow If I keep phy init code in both place as you requested.

Then you need to split the phy handling between a10 and r40. A10 doesn't
need phy-supply at the moment anyway. And migrating A10 to newer binding
is only causing you problems anyway. Just drop that part, and handle the
R40.

ChenYu
