From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 26 Apr 2018 14:05:28 +0200
Subject: [PATCH v3 6/6] arm64: dts: rockchip: Specify override mode for
 kevin panel
In-Reply-To: <CAD=FV=WGU+s015DQbNeWHkpqpHLFz+9AjHKAd0N3HWag0p5FWA@mail.gmail.com>
References: <20180208174855.55620-1-seanpaul@chromium.org>
 <20180208174855.55620-7-seanpaul@chromium.org>
 <CAD=FV=WGU+s015DQbNeWHkpqpHLFz+9AjHKAd0N3HWag0p5FWA@mail.gmail.com>
Message-ID: <20180426120528.GA11985@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 10:23:00AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Thu, Feb 8, 2018 at 9:48 AM, Sean Paul <seanpaul@chromium.org> wrote:
> > This patch adds an override mode for kevin devices. The mode increases
> > both back porches to allow a pixel clock of 26666kHz as opposed to the
> > 'typical' value of 252750kHz. This is needed to avoid interference with
> > the touch digitizer on these laptops.
> >
> > Changes in v2:
> >  - Wrap the timing in display-timings node to match binding (Rob/Thierry)
> > Changes in v3:
> >  - Unwrap the timing from display-timings and rename panel-timing (Rob)
> >
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Eric Anholt <eric@anholt.net>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: St?phane Marchesin <marcheu@chromium.org>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: devicetree at vger.kernel.org
> > Cc: dri-devel at lists.freedesktop.org
> > Cc: linux-rockchip at lists.infradead.org
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> > index 191a6bcb1704..658411ce37ea 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> > @@ -98,6 +98,20 @@
> >                 backlight = <&backlight>;
> >                 power-supply = <&pp3300_disp>;
> >
> > +               panel-timing {
> > +                       clock-frequency = <266604720>;
> > +                       hactive = <2400>;
> > +                       hfront-porch = <48>;
> > +                       hback-porch = <84>;
> > +                       hsync-len = <32>;
> > +                       hsync-active = <0>;
> > +                       vactive = <1600>;
> > +                       vfront-porch = <3>;
> > +                       vback-porch = <120>;
> > +                       vsync-len = <10>;
> > +                       vsync-active = <0>;
> > +               };
> > +
> >                 ports {
> >                         panel_in_edp: endpoint {
> >                                 remote-endpoint = <&edp_out_panel>;
> 
> Kristian brought an old bug to my attention
> <https://bugs.chromium.org/p/chromium/issues/detail?id=750354> and it
> made me think.  Should we somehow adjust the bindings here to account
> for the fact that a board may source several different panels?
> 
> AKA: on some boards an ODM may want to second source (or third source,
> or ...) the panel.  They'll randomly connect several different panels
> to the board and ship the boards out.  The panels are all compatible
> electrically (same power sequencing) but might need slightly different
> timings.  In this particular case there's no board-level strappings
> for the different panels--it's assumed that the EDID on the panels can
> be used to distinguish them.
> 
> In that case it seems like it would be nice to allow specifying more
> than one "panel-timing" nodes.  Maybe keyed off some type of ID that's
> present in the EDID?

If you've got an EDID you should be relying on the EDID to provide the
timings. No need to have any timings in the DT in that case.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180426/439f5bec/attachment.sig>
