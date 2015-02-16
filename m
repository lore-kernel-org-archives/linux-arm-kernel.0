From: horms@verge.net.au (Simon Horman)
Date: Mon, 16 Feb 2015 08:57:54 -0500
Subject: [PATCH/RFC] ARM: shmobile: r8a7790: Fix HSUSB clock to hp_clk
 from mp_clk
In-Reply-To: <CAMuHMdX=cdHaiHCnYsJvZFc2RNv=Pk8cLXuvkezg4Ht4U4mXsg@mail.gmail.com>
References: <1424011746-3787-2-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdX=cdHaiHCnYsJvZFc2RNv=Pk8cLXuvkezg4Ht4U4mXsg@mail.gmail.com>
Message-ID: <20150216135754.GA5479@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 16, 2015 at 10:20:10AM +0100, Geert Uytterhoeven wrote:
> Hi Kaneko-san, Mizuguchi-san,
> 
> On Sun, Feb 15, 2015 at 3:49 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> > From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >
> > HSUSB uses hp_clk for H/W register access.
> 
> That indeed seems to be true, and that's what this patch is changing.
> 
> > HSUSB uses mp_clk for USB-DMAC access.
> 
> However, page 64-2 doesn't mention the MP clock for USB-DMAC:
>    "AXI bus clock (ZS?: 260 MHz), HPB bus clock (HP?: 130 MHz).
>     USB local bus clock (48 MHz)"
> So your statement doesn't seem to be true?

Thanks, I see that too.

> Note that mstp3_clks in dtsi has hp_clk as the parent for both usbdmac0 and
> usbdmac1, so if your statement would be true, that has to changed, too?
> 
> The same is true for other members of the R-Car Gen2 family, e.g. your patch
> for r8a7791.

It seems to me that we could:

1. Apply this patch with the changelog updated and;
2. Follow up on the DMAC clocks

Does that sound reasonable to you?

> > The clock is defined for H/W register access.
> >
> > Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > ---
> >
> > This patch is based on devel branch of Simon Horman's renesas tree.
> >
> >  arch/arm/boot/dts/r8a7790.dtsi | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> > index 24de994..113edf2 100644
> > --- a/arch/arm/boot/dts/r8a7790.dtsi
> > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> 
> > @@ -1132,7 +1133,7 @@
> >                 mstp7_clks: mstp7_clks at e615014c {
> >                         compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
> >                         reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
> > -                       clocks = <&mp_clk>, <&mp_clk>, <&zs_clk>, <&zs_clk>, <&p_clk>,
> > +                       clocks = <&mp_clk>, <&hp_clk>, <&zs_clk>, <&zs_clk>, <&p_clk>,
> >                                  <&p_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>,
> >                                  <&zx_clk>;
> >                         #clock-cells = <1>;
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
