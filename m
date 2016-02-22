From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 22 Feb 2016 12:43:08 +0100
Subject: [PATCH v2 2/2] drm/panel: Support for LG lp120up1 panel with eDP
 input
In-Reply-To: <CAGUYZuSsrneg8zQ0Ro8z5C469A2D-TOKpONECxWdoM6T+xNAeg@mail.gmail.com>
References: <1456138904-15258-1-git-send-email-jitao.shi@mediatek.com>
 <1456138904-15258-2-git-send-email-jitao.shi@mediatek.com>
 <CAGUYZuSsrneg8zQ0Ro8z5C469A2D-TOKpONECxWdoM6T+xNAeg@mail.gmail.com>
Message-ID: <20160222114308.GA22505@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 04:42:54PM +0530, sanjeev sharma wrote:
> Hello Jitao,
> 
> Can't we add this panel information in device tree file instead inside the
> device driver ?

We could, but that would be redundant. Panels need to be represented by
a specific compatible string anyway, and that compatible string implies
the video timings, bits-per-color, width and height.

Also there's more to panels than just the timings or dimensions. Power
up and power down sequences are also implied by the compatible stirng.
Describing all of that in the device tree was at some point attempted,
but in the end it turned out too complicated and we ended up with what
we have now.

Thierry

> On Mon, Feb 22, 2016 at 4:31 PM, Jitao Shi <jitao.shi@mediatek.com> wrote:
> 
> > The LG lp120up1 TFT LCD panel with eDP interface is a 12.0" 1920x1280
> > panel, which can be supported by the simple panel driver
> >
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > ---
> > Changes since v1:
> >  - Add eDP panel type in comment msg
> >  - Fixed comment msg with 72 characters width
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c |   26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c
> > b/drivers/gpu/drm/panel/panel-simple.c
> > index f88a631..2030c37 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -982,6 +982,29 @@ static const struct panel_desc lg_lb070wv8 = {
> >         .bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> >  };
> >
> > +static const struct drm_display_mode lg_lp120up1_mode = {
> > +       .clock = 162300,
> > +       .hdisplay = 1920,
> > +       .hsync_start = 1920 + 40,
> > +       .hsync_end = 1920 + 40 + 40,
> > +       .htotal = 1920 + 40 + 40+ 80,
> > +       .vdisplay = 1280,
> > +       .vsync_start = 1280 + 4,
> > +       .vsync_end = 1280 + 4 + 4,
> > +       .vtotal = 1280 + 4 + 4 + 12,
> > +       .vrefresh = 60,
> > +};
> > +
> > +static const struct panel_desc lg_lp120up1 = {
> > +       .modes = &lg_lp120up1_mode,
> > +       .num_modes = 1,
> > +       .bpc = 8,
> > +       .size = {
> > +               .width = 267,
> > +               .height = 183,
> > +       },
> > +};
> > +
> >  static const struct drm_display_mode lg_lp129qe_mode = {
> >         .clock = 285250,
> >         .hdisplay = 2560,
> > @@ -1256,6 +1279,9 @@ static const struct of_device_id platform_of_match[]
> > = {
> >                 .compatible = "lg,lb070wv8",
> >                 .data = &lg_lb070wv8,
> >         }, {
> > +               .compatible = "lg,lp120up1",
> > +               .data = &lg_lp120up1,
> > +       }, {
> >                 .compatible = "lg,lp129qe",
> >                 .data = &lg_lp129qe,
> >         }, {
> > --
> > 1.7.9.5
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160222/036840e4/attachment.sig>
