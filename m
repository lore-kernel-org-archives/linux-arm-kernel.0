From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 5 Nov 2018 16:56:35 +0530
Subject: [PATCH 02/10] drm/sun4i: sun6i_mipi_dsi: Support instruction loop
 selection
In-Reply-To: <20181105103857.lp7ayw3p6dbthehg@flea>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
 <20181103100900.30313-3-jagan@amarulasolutions.com>
 <20181105103857.lp7ayw3p6dbthehg@flea>
Message-ID: <CAMty3ZBje8F4YEfWC4qoxADhgdFjbcwZBKJwak633pUAwKAftA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 5, 2018 at 4:09 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sat, Nov 03, 2018 at 03:38:52PM +0530, Jagan Teki wrote:
> > Instruction loop selection would require before writing
> > loop number registers, so enable idle, LP11 bits on
> > loop selection register.
> >
> > Reference code available in BSP
> > (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > (dsi_dev[sel]->dsi_inst_loop_sel.dwval = 2<<(4*DSI_INST_ID_LP11) |
> >       3<<(4*DSI_INST_ID_DLY);
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index da152c21ec62..077b57ec964c 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -397,6 +397,10 @@ static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
> >       struct mipi_dsi_device *device = dsi->device;
> >       u16 delay;
> >
> > +     regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_SEL_REG,
> > +                  DSI_INST_ID_HSC  << (4 * DSI_INST_ID_LP11) |
> > +                  DSI_INST_ID_HSD  << (4 * DSI_INST_ID_DLY));
> > +
>
> Please put this with the other instructions settings below.

Does that mean after computation delay code?
