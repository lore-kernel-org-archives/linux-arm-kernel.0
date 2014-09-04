From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 04 Sep 2014 13:00:37 +0200
Subject: [BUG] staging: imx-drm: clock reparent fails for LDB channel 1
 on i.MX53
In-Reply-To: <CAOMZO5AEKmFg-eM=b6WWYG4qy-1PRcsSHfoKG2aZFMmQBgw5Hw@mail.gmail.com>
References: <54074359.5090500@tqsc.de>
 <CAOMZO5AEKmFg-eM=b6WWYG4qy-1PRcsSHfoKG2aZFMmQBgw5Hw@mail.gmail.com>
Message-ID: <1409828437.3931.19.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, den 03.09.2014, 13:48 -0300 schrieb Fabio Estevam:
> On Wed, Sep 3, 2014 at 1:35 PM, Markus Niebel <list-09_linux_arm@tqsc.de> wrote:
> > Hello,
> >
> > playing with LVDS channel 1 on a TQMa53 with MBa53 mainboard we see error
> >
> > imx-ldb 53fa8008.ldb: unable to set di0 parent clock to ldb_di1
> >
> > this comes from imx_ldb_set_clock with mux = 0. If setting mux parameter hard to "1"
> > LVDS on channel 1 works just fine. The value of the mux param comes from device tree
> > port settings.
> >
> > The following device tree change fixes the issue, but im not sure if this is the
> > correct way.
> >
> > diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> > index 6456a00..acdfabf 100644
> > --- a/arch/arm/boot/dts/imx53.dtsi
> > +++ b/arch/arm/boot/dts/imx53.dtsi
> > @@ -419,10 +419,14 @@
> >                                 status = "disabled";
> >
> >                                 lvds-channel at 0 {
> > +                                       #address-cells = <1>;
> > +                                       #size-cells = <0>;
> >                                         reg = <0>;
> >                                         status = "disabled";
> >
> >                                         port {

This should be port at 0.

> > +                                               reg = <0>;
> > +
> >                                                 lvds0_in: endpoint {
> >                                                         remote-endpoint = <&ipu_di0_lvds0>;
> >                                                 };
> > @@ -430,10 +434,14 @@
> >                                 };
> >
> >                                 lvds-channel at 1 {
> > +                                       #address-cells = <1>;
> > +                                       #size-cells = <0>;
> >                                         reg = <1>;
> >                                         status = "disabled";
> >
> >                                         port {

port at 1

> > +                                               reg = <1>;
> > +
> >                                                 lvds1_in: endpoint {
> >                                                         remote-endpoint = <&ipu_di1_lvds1>;
> >                                                 };
>
> > In my understanding the i.MX53 has no multiplexer for the input, so
> > DI1 -> LVDS1 in case of single channel or separate channels
> 
> Your change looks good. Adding Philipp and Shawn on Cc.

Apart from the comments, this looks good to me, too.
In Documentation/devicetree/bindings/staging/imx-drm/ldb.txt the example
should be updated with the above changes, and an explanation should be
added to the port documentation in there:

"On i.MX5, the internal two-input-multiplexer is used.
 Due to hardware limitations, only one port (port@[0,1])
 can be used for each channel (lvds-channel@[0,1], respectively)"

Is this clear enough? In principle each channel could have two input
ports on i.MX5, but there is no way to properly route the ldb di clock
to the other display interface.

regards
Philipp
