From: horms@verge.net.au (Simon Horman)
Date: Mon, 14 Dec 2015 10:49:06 +0900
Subject: [PATCH/RFC 08/19] ARM: shmobile: r8a7793: add R-Car sound
 support to device tree
In-Reply-To: <CAMuHMdWfWcZ9jGvgZBgAXH7z7OZ79LJJ+-ki+REamBJBJc5ZQw@mail.gmail.com>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
 <1449802376-11301-9-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWfWcZ9jGvgZBgAXH7z7OZ79LJJ+-ki+REamBJBJc5ZQw@mail.gmail.com>
Message-ID: <20151214014906.GB13945@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 10:44:11AM +0100, Geert Uytterhoeven wrote:
> On Fri, Dec 11, 2015 at 3:52 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Instantiate R-Car sound node in r8a7793 device tree.
> > This only supports PIO transfers.
> >
> > Based on similar work for the r8a7791 by Kuninori Morimoto.
> >
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/boot/dts/r8a7793.dtsi | 83 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> > index 99ee88e0e8be..5b02b0b1d7ac 100644
> > --- a/arch/arm/boot/dts/r8a7793.dtsi
> > +++ b/arch/arm/boot/dts/r8a7793.dtsi
> > @@ -1093,4 +1093,87 @@
> >                 #iommu-cells = <1>;
> >                 status = "disabled";
> >         };
> > +
> > +       rcar_sound: sound at ec500000 {
> > +               /*
> > +                * #sound-dai-cells is required
> > +                *
> > +                * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
> > +                * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
> > +                */
> > +               compatible =  "renesas,rcar_sound-r8a7793", "renesas,rcar_sound-gen2";
> > +               reg =   <0 0xec500000 0 0x1000>, /* SCU */
> > +                       <0 0xec5a0000 0 0x100>,  /* ADG */
> > +                       <0 0xec540000 0 0x1000>, /* SSIU */
> > +                       <0 0xec541000 0 0x280>;  /* SSI */
> > +               reg-names = "scu", "adg", "ssiu", "ssi";
> 
> Missing "audmapp", for Audio DMAC peri peri?

Thanks! I have added peri peri and Audio appears to now work with DMA
(though I only have remote access to the gose board so I can't verify
 audio actually works).
