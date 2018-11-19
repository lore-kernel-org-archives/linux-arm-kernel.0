From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 19 Nov 2018 16:52:17 +0530
Subject: [PATCH v2 04/12] drm/sun4i: sun6i_mipi_dsi: Simplify drq set to
 support all modes
In-Reply-To: <20181119083243.4njj2p2sy2xf2zyf@flea>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-5-jagan@amarulasolutions.com>
 <20181119083243.4njj2p2sy2xf2zyf@flea>
Message-ID: <CAMty3ZAKL2fZqwLwd_WiQpzz+cOETMR7ES7HQsBo3PsAvjM+6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 2:02 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Nov 16, 2018 at 10:09:08PM +0530, Jagan Teki wrote:
> > Allwinner MIPI DSI DRQ set value can be varied with respective
> > video modes.
> > - burst mode the set value is always 0
> > - video modes whose front porch greater than 20, the set value
> >   can be computed based front porch and bpp.
> > - video modes whose front porch is not greater than 20, the set value
> >   is simply 0
> >
> > This patch simplifies existing drq set value code by grouping
> > into sun6i_dsi_get_drq and support all video modes.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 38 ++++++++++++++++----------
> >  1 file changed, 23 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index efd08bfd0cb8..d60955880c43 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -363,6 +363,26 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
> >                    SUN6I_DSI_INST_JUMP_CFG_NUM(1));
> >  };
> >
> > +static int sun6i_dsi_get_drq(struct sun6i_dsi *dsi,
> > +                           struct drm_display_mode *mode)
> > +{
> > +     struct mipi_dsi_device *device = dsi->device;
> > +     int drq = 0;
>
> So, here, you declaring a variable called drq, set to 0.
>
> > +     if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
> > +             return drq;
>
> That you return here. You could just return 0, to be clearer.
>
> > +     if ((mode->hsync_start - mode->hdisplay) > 20) {
> > +             /* Maaaaaagic */
> > +             u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
>
> You re-declare a variable with the same name here, but a different
> type....
>
> > +             drq *= mipi_dsi_pixel_format_to_bpp(device->format);
> > +             drq /= 32;
> > +     }
> > +
> > +     return drq;
>
> And then return the first one? How is that even working?

Will fix this.

>
> > +
> >  static u16 sun6i_dsi_get_timings_vblk(struct sun6i_dsi *dsi,
> >                                     struct drm_display_mode *mode, u16 hblk)
> >  {
> > @@ -478,21 +498,9 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
> >  static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
> >                                 struct drm_display_mode *mode)
> >  {
> > -     struct mipi_dsi_device *device = dsi->device;
> > -     u32 val = 0;
> > -
> > -     if ((mode->hsync_start - mode->hdisplay) > 20) {
> > -             /* Maaaaaagic */
> > -             u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
> > -
> > -             drq *= mipi_dsi_pixel_format_to_bpp(device->format);
> > -             drq /= 32;
> > -
> > -             val = (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
> > -                    SUN6I_DSI_TCON_DRQ_SET(drq));
> > -     }
> > -
> > -     regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, val);
> > +     regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG,
> > +                  SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
> > +                  SUN6I_DSI_TCON_DRQ_SET(sun6i_dsi_get_drq(dsi, mode)));
>
> On top of that, you now enable the DRQ stuff all the time, while it

Earlier the val value is ENABLE_MODE ORed with drq value. for the
condition drq is computed in if block otherwise the val is 0.
So as I explained in commit message the drq value is 0
- for video modes whose front porch is not greater than 20 and
- for burst mode the val

ie reason I mode it common.
