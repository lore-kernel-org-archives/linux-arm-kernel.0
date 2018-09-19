From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 20 Sep 2018 00:20:19 +0800
Subject: [linux-sunxi] Re: [PATCH 5/5] ARM: sun8i: dts: drop A64 HDMI PHY
 fallback compatible from R40 DT
In-Reply-To: <f968f15fec21ba5b0415b1792536af3e5aba6e57.camel@aosc.io>
References: <20180907072234.48282-1-icenowy@aosc.io>
 <20180907072234.48282-6-icenowy@aosc.io>
 <20180910142354.5ldexkvnan6ohz4x@flea> <1926288.mXGsSvSKgU@jernej-laptop>
 <20180917145452.ewfuqkrxjjosbawd@flea>
 <f968f15fec21ba5b0415b1792536af3e5aba6e57.camel@aosc.io>
Message-ID: <CAGb2v64N16=3APDnNN5R+EB0524KR86eq1itOnQ8bXsv-HDUOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 6:57 AM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> ? 2018-09-17?? 16:54 +0200?Maxime Ripard???
> > On Mon, Sep 10, 2018 at 04:32:30PM +0200, Jernej ?krabec wrote:
> > > Dne ponedeljek, 10. september 2018 ob 16:23:54 CEST je Maxime
> > > Ripard
> > > napisal(a):
> > > > On Fri, Sep 07, 2018 at 03:22:34PM +0800, Icenowy Zheng wrote:
> > > > > The R40 HDMI PHY seems to be different to the A64 one, the A64
> > > > > one
> > > > > has no input mux, but the R40 one has.
> > > > >
> > > > > Drop the A64 fallback compatible from the HDMI PHY node in R40
> > > > > DT.
> > > > >
> > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > ---
> > > > >
> > > > >  arch/arm/boot/dts/sun8i-r40.dtsi | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > b/arch/arm/boot/dts/sun8i-r40.dtsi index
> > > > > ffd9f00f74a4..5f547c161baf
> > > > > 100644
> > > > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > @@ -800,8 +800,7 @@
> > > > >
> > > > >                 };
> > > > >
> > > > >                 hdmi_phy: hdmi-phy at 1ef0000 {
> > > > >
> > > > > -                       compatible = "allwinner,sun8i-r40-hdmi-
> > > > > phy",
> > > > > -                                    "allwinner,sun50i-a64-
> > > > > hdmi-phy";
> > > > > +                       compatible = "allwinner,sun8i-r40-hdmi-
> > > > > phy";
> > > >
> > > > If you could use the A64 phy before, you can still use it now.
> > >
> > > Not exactly. Given that we don't know how to switch between HDMI
> > > PHY clock
> > > parents on A64 (if it is actually connected at all, there is no
> > > information
> > > about that in manual and AW didn't answered our questions, despite
> > > asking them
> > > through different channels), A64 compatible will be associated with
> > > quirk,
> > > which will tell that only one clock parent is usable.
> > >
> > > However, R40 HDMI PHY has definetly two clock parents, as it was
> > > tested by me
> > > and Icenowy and we know how to switch between them without issues.
> > > Technically, we could have A64 compatible there, but that would
> > > mean only
> > > single PHY parent is considered instead of two.
> >
> > The DT change above would mean that you can't operate the R40 phy in
> > the same way than the A64's. From what you're telling me now, this
> > isn't exactly what is going on: you can operate the R40 phy just like
> > the A64: with a single PLL instead of two. You operate in a degraded
> > and non-optimal mode, but it still works.

I suppose it's a slightly different semantic. While we have no definite
data regarding the A64, there are some possibilities:

  1. The muxing mechanism isn't present on the A64, and the HDMI PHY
     only takes one clock.

  2. The muxing is present, but only the first parent is connected.
     Switching to the second input causes it to stop working.

  3. Same as above, but both parents are connected to video0-pll.
     This might be indistinguishable from 1., even if checking whether
     the bit modifications stick or not.

In any case, I think this deserves proper experimentation, and subsequent
documentation in the bindings of our "assumptions" (i.e. educated guess)
about what the hardware is doing.

>
> The status of R40 HDMI PHY input mux is not determined when use A64
> driver, which makes it not working when the bootloader initializes it
> to use the second PLL (the A64 driver will assume the parent is the
> first PLL).

That doesn't sound good. But it really depends on what we assume the
A64 is doing.

ChenYu

> >
> > And it's exactly what the DT is already saying.
> >
> > Maxime
> >
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
