From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 23 Feb 2016 16:12:41 +0100
Subject: [PATCH v2 2/2] drm/panel: Support for LG lp120up1 panel with eDP
 input
In-Reply-To: <CAGUYZuSVghfC75eWihA82WxC8pF67mWKQMJ-95F2ezqMssyxfQ@mail.gmail.com>
References: <1456138904-15258-1-git-send-email-jitao.shi@mediatek.com>
 <1456138904-15258-2-git-send-email-jitao.shi@mediatek.com>
 <CAGUYZuSsrneg8zQ0Ro8z5C469A2D-TOKpONECxWdoM6T+xNAeg@mail.gmail.com>
 <20160222114308.GA22505@ulmo>
 <CAGUYZuSVghfC75eWihA82WxC8pF67mWKQMJ-95F2ezqMssyxfQ@mail.gmail.com>
Message-ID: <20160223151241.GC27656@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 10:45:01AM +0530, sanjeev sharma wrote:
> Hello Thierry,
> 
> I am not agree here and how it would be redundant ?

The panel being a separate device means that it needs a compatible
value and the compatible value implies a specific video timing. It
would be redundant, therefore, to repeat the video timing in the
panel's device tree node that already has the compatible string.

> please see lvds interface, where panel timing parameter is defined in the
> Device Tree. If there are multiple display panel then we can create a
> separate dtsi file and include in main Board dts file. I believe that, It
> is simpler way to support multiple panel.

Two things: you can define a separate .dtsi file with the panel
definition with the current approach, too. But it would be a waste to do
so because really the only thing you need to change is the compatible
string.

The approach chosen in the DTS that you link to below might seem like a
simpler way, but it completely ignores aspects other than timings. What
if the panel requires a GPIO and or regulator to turn on. How are you
going to represent the power up sequence for that in DT? This was
attempted a long time ago and deemed too complicated to do in DT, hence
why we ended up with what we have now.

There are also panels on more complicated busses, such as DSI. These
panels often require additional register programming, so in addition to
the above you'd need some sort of register programming table in DT for
these to work.

> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/boot/dts/imx6q-sabrelite.dts?h=imx_3.14.38_6qp_beta#n225

That's not an upstream tree, so it isn't relevant to this discussion.
The decision to make the panel a separate device and put the video
timings into the driver was made a couple of years ago and we're not
going to change that. It's fine if you want to disagree, but I'm afraid
it won't change things.

Thierry

> On Mon, Feb 22, 2016 at 5:13 PM, Thierry Reding <thierry.reding@gmail.com>
> wrote:
> 
> > On Mon, Feb 22, 2016 at 04:42:54PM +0530, sanjeev sharma wrote:
> > > Hello Jitao,
> > >
> > > Can't we add this panel information in device tree file instead inside
> > the
> > > device driver ?
> >
> > We could, but that would be redundant. Panels need to be represented by
> > a specific compatible string anyway, and that compatible string implies
> > the video timings, bits-per-color, width and height.
> >
> > Also there's more to panels than just the timings or dimensions. Power
> > up and power down sequences are also implied by the compatible stirng.
> > Describing all of that in the device tree was at some point attempted,
> > but in the end it turned out too complicated and we ended up with what
> > we have now.
> >
> > Thierry
> >
> > > On Mon, Feb 22, 2016 at 4:31 PM, Jitao Shi <jitao.shi@mediatek.com>
> > wrote:
> > >
> > > > The LG lp120up1 TFT LCD panel with eDP interface is a 12.0" 1920x1280
> > > > panel, which can be supported by the simple panel driver
> > > >
> > > > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > > > ---
> > > > Changes since v1:
> > > >  - Add eDP panel type in comment msg
> > > >  - Fixed comment msg with 72 characters width
> > > > ---
> > > >  drivers/gpu/drm/panel/panel-simple.c |   26 ++++++++++++++++++++++++++
> > > >  1 file changed, 26 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/panel/panel-simple.c
> > > > b/drivers/gpu/drm/panel/panel-simple.c
> > > > index f88a631..2030c37 100644
> > > > --- a/drivers/gpu/drm/panel/panel-simple.c
> > > > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > > > @@ -982,6 +982,29 @@ static const struct panel_desc lg_lb070wv8 = {
> > > >         .bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> > > >  };
> > > >
> > > > +static const struct drm_display_mode lg_lp120up1_mode = {
> > > > +       .clock = 162300,
> > > > +       .hdisplay = 1920,
> > > > +       .hsync_start = 1920 + 40,
> > > > +       .hsync_end = 1920 + 40 + 40,
> > > > +       .htotal = 1920 + 40 + 40+ 80,
> > > > +       .vdisplay = 1280,
> > > > +       .vsync_start = 1280 + 4,
> > > > +       .vsync_end = 1280 + 4 + 4,
> > > > +       .vtotal = 1280 + 4 + 4 + 12,
> > > > +       .vrefresh = 60,
> > > > +};
> > > > +
> > > > +static const struct panel_desc lg_lp120up1 = {
> > > > +       .modes = &lg_lp120up1_mode,
> > > > +       .num_modes = 1,
> > > > +       .bpc = 8,
> > > > +       .size = {
> > > > +               .width = 267,
> > > > +               .height = 183,
> > > > +       },
> > > > +};
> > > > +
> > > >  static const struct drm_display_mode lg_lp129qe_mode = {
> > > >         .clock = 285250,
> > > >         .hdisplay = 2560,
> > > > @@ -1256,6 +1279,9 @@ static const struct of_device_id
> > platform_of_match[]
> > > > = {
> > > >                 .compatible = "lg,lb070wv8",
> > > >                 .data = &lg_lb070wv8,
> > > >         }, {
> > > > +               .compatible = "lg,lp120up1",
> > > > +               .data = &lg_lp120up1,
> > > > +       }, {
> > > >                 .compatible = "lg,lp129qe",
> > > >                 .data = &lg_lp129qe,
> > > >         }, {
> > > > --
> > > > 1.7.9.5
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel at lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > >
> >
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160223/84469bc0/attachment.sig>
