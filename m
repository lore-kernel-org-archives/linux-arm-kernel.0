From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 4 Apr 2018 10:14:55 +0200
Subject: [PATCH v3 6/7] arm: dts: sun8i: a33: Add the DSI-related nodes
In-Reply-To: <CAGb2v65AfHHUZ=fUB+TPUZaLdYb4mN3hZ=3n5GOAD39C42+Nag@mail.gmail.com>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
 <fbb4d14a83ed80e9740c042cd9df58b8132b4c91.1520344489.git-series.maxime.ripard@bootlin.com>
 <CAGb2v65AfHHUZ=fUB+TPUZaLdYb4mN3hZ=3n5GOAD39C42+Nag@mail.gmail.com>
Message-ID: <20180404081455.radrcx4hs7n3hlzo@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 22, 2018 at 10:23:32AM +0800, Chen-Yu Tsai wrote:
> On Tue, Mar 6, 2018 at 9:56 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > From: Maxime Ripard <maxime.ripard@free-electrons.com>
> >
> > The A33 has a MIPI-DSI block, along with its D-PHY. Let's add it in order
> > to use it in the relevant boards.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/sun8i-a33.dtsi | 44 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
> > index 50eb84fa246a..94cfa7b1bbfa 100644
> > --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> > @@ -236,6 +236,11 @@
> >                                         #address-cells = <1>;
> >                                         #size-cells = <0>;
> >                                         reg = <1>;
> > +
> > +                                       tcon0_out_dsi0: endpoint at 1 {
> > +                                               reg = <1>;
> > +                                               remote-endpoint = <&dsi0_in_tcon0>;
> > +                                       };
> >                                 };
> >                         };
> >                 };
> > @@ -280,6 +285,45 @@
> >                         #io-channel-cells = <0>;
> >                 };
> >
> > +               dsi0: dsi at 1ca0000 {
> 
> Nit: There's only one so you don't need the numbered suffix.

I'll fix it.

> Also, is "dsi" specific enough, or should we use "mipi-dsi"

If we were to be pedantic about it, that would even be MIPI-DSI2, but
I'm not sure it's worth it to be honest.

> > +                       compatible = "allwinner,sun6i-a31-mipi-dsi";
> > +                       reg = <0x01ca0000 0x1000>;
> > +                       interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&ccu CLK_BUS_MIPI_DSI>,
> > +                                <&ccu CLK_DSI_SCLK>;
> > +                       clock-names = "bus", "mod";
> > +                       resets = <&ccu RST_BUS_MIPI_DSI>;
> > +                       phys = <&dphy0>;
> > +                       phy-names = "dphy";
> > +                       status = "disabled";
> > +
> > +                       ports {
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +
> > +                               port at 0 {
> > +                                       #address-cells = <1>;
> > +                                       #size-cells = <0>;
> > +                                       reg = <0>;
> > +
> > +                                       dsi0_in_tcon0: endpoint {
> > +                                               remote-endpoint = <&tcon0_out_dsi0>;
> > +                                       };
> > +                               };
> > +                       };
> > +               };
> > +
> > +               dphy0: d-phy at 1ca1000 {
> 
> Same nit, and "dsi-phy" would be better.

D-PHY is one of the MIPI standards that can be used with DSI, but it
doesn't mean DSI-PHY. You also have C-PHY (that can be used with DSI
as well) and M-PHY (than can be used with UniPro and CSI3). So, no, it
really is a D-PHY controller :)

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/1a87bbed/attachment.sig>
