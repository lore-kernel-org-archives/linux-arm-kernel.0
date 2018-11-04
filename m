From: jagan@amarulasolutions.com (Jagan Teki)
Date: Sun, 4 Nov 2018 22:15:12 +0530
Subject: [PATCH 01/10] drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop
 N1 instruction delay
In-Reply-To: <8365df14-3397-b395-48eb-3070da3b65fc@orpaltech.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
 <20181103100900.30313-2-jagan@amarulasolutions.com>
 <8365df14-3397-b395-48eb-3070da3b65fc@orpaltech.com>
Message-ID: <CAMty3ZBGR9bgoN2cidcFMhCTinOcGP11332CgCvi_UhvQBOQjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 3, 2018 at 8:53 PM Sergey Suloev <ssuloev@orpaltech.com> wrote:
>
> Hi, Jagan,
>
> On 11/3/18 1:08 PM, Jagan Teki wrote:
> > Loop N1 instruction delay for burst mode lcd panel are
> > computed as per BSP code.
> >
> > Reference code is available in BSP
> > (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=
> > (panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
> > => (((mode->htotal - mode->hdisplay) * 150) / ((mode->clock / 1000) * 8)) - 50;
> >
> > So use the similar computation for loop N1 delay.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >   drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index 86430efd9054..da152c21ec62 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -394,7 +394,14 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
> >   static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
> >                                     struct drm_display_mode *mode)
> >   {
> > -     u16 delay = 50 - 1;
> > +     struct mipi_dsi_device *device = dsi->device;
> > +     u16 delay;
> > +
> > +     if (device->mode_flags == MIPI_DSI_MODE_VIDEO_BURST)
> > +             delay = (((mode->htotal - mode->hdisplay) * 150) /
> > +                     ((mode->clock / 1000) * 8)) - 50;
> > +     else
> > +             delay = 50 - 1;
> >
> >       regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
> >                    SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
>
>
> is this patch series comes in addition to the previous MIPI DSI series
> or in its stead?

Yes, all changes were added on top of previous MIPI DSI series(ie what
I mentioned in cover-letter) since it require clock patches from
previous version.
