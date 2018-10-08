From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 8 Oct 2018 21:10:54 +0800
Subject: [PATCH v2 25/29] drm: sun4i: add quirks for TCON TOP
In-Reply-To: <20181008123313.sxqzulfuktslchhy@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-26-jernej.skrabec@siol.net>
 <20181008085112.mejpwvl3dpu7sopy@flea>
 <CAGb2v64avzzrGJeg2HU_Ze686C1nmVsNwXJGzsUbQvQTZKuSMw@mail.gmail.com>
 <20181008102021.ox34mqbw65euvsb4@flea>
 <CAGb2v65vG2sCMLOFSVAko+MUBDQa_A+qrMZLFe20QXJhApd1Gw@mail.gmail.com>
 <20181008123313.sxqzulfuktslchhy@flea>
Message-ID: <CAGb2v64remLNFdX-FT2xcbcSSkeqmFEjQDEJLPQHiNMctcKTfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 8, 2018 at 8:33 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Oct 08, 2018 at 06:50:44PM +0800, Chen-Yu Tsai wrote:
> > On Mon, Oct 8, 2018 at 6:20 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Mon, Oct 08, 2018 at 05:06:45PM +0800, Chen-Yu Tsai wrote:
> > > > On Mon, Oct 8, 2018 at 4:51 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Sun, Oct 07, 2018 at 11:39:01AM +0200, Jernej Skrabec wrote:
> > > > > > From: Icenowy Zheng <icenowy@aosc.io>
> > > > > >
> > > > > > Some SoCs, such as H6, doesn't have a full-featured TCON TOP.
> > > > > >
> > > > > > Add quirks support for TCON TOP.
> > > > > >
> > > > > > Currently the presence of TCON_TV1 and DSI is controlled via the quirks
> > > > > > structure.
> > > > > >
> > > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > > ---
> > > > > >  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 43 ++++++++++++++++++++------
> > > > > >  1 file changed, 34 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > > > index 37158548b447..ed13233cad88 100644
> > > > > > --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > > > +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > > > @@ -9,11 +9,17 @@
> > > > > >  #include <linux/component.h>
> > > > > >  #include <linux/device.h>
> > > > > >  #include <linux/module.h>
> > > > > > +#include <linux/of_device.h>
> > > > > >  #include <linux/of_graph.h>
> > > > > >  #include <linux/platform_device.h>
> > > > > >
> > > > > >  #include "sun8i_tcon_top.h"
> > > > > >
> > > > > > +struct sun8i_tcon_top_quirks {
> > > > > > +     bool has_tcon_tv1;
> > > > > > +     bool has_dsi;
> > > > > > +};
> > > > > > +
> > > > > >  static bool sun8i_tcon_top_node_is_tcon_top(struct device_node *node)
> > > > > >  {
> > > > > >       return !!of_match_node(sun8i_tcon_top_of_table, node);
> > > > > > @@ -121,10 +127,13 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
> > > > > >       struct platform_device *pdev = to_platform_device(dev);
> > > > > >       struct clk_hw_onecell_data *clk_data;
> > > > > >       struct sun8i_tcon_top *tcon_top;
> > > > > > +     const struct sun8i_tcon_top_quirks *quirks;
> > > > > >       struct resource *res;
> > > > > >       void __iomem *regs;
> > > > > >       int ret, i;
> > > > > >
> > > > > > +     quirks = of_device_get_match_data(&pdev->dev);
> > > > > > +
> > > > > >       tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
> > > > > >       if (!tcon_top)
> > > > > >               return -ENOMEM;
> > > > > > @@ -187,15 +196,23 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
> > > > > >                                            &tcon_top->reg_lock,
> > > > > >                                            TCON_TOP_TCON_TV0_GATE, 0);
> > > > > >
> > > > > > -     clk_data->hws[CLK_TCON_TOP_TV1] =
> > > > > > -             sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> > > > > > -                                          &tcon_top->reg_lock,
> > > > > > -                                          TCON_TOP_TCON_TV1_GATE, 1);
> > > > > > +     if (quirks->has_tcon_tv1) {
> > > > > > +             clk_data->hws[CLK_TCON_TOP_TV1] =
> > > > > > +                     sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> > > > > > +                                                  &tcon_top->reg_lock,
> > > > > > +                                                  TCON_TOP_TCON_TV1_GATE, 1);
> > > > > > +     } else {
> > > > > > +             clk_data->hws[CLK_TCON_TOP_TV1] = NULL;
> > > > > > +     }
> > > > > >
> > > > > > -     clk_data->hws[CLK_TCON_TOP_DSI] =
> > > > > > -             sun8i_tcon_top_register_gate(dev, "dsi", regs,
> > > > > > -                                          &tcon_top->reg_lock,
> > > > > > -                                          TCON_TOP_TCON_DSI_GATE, 2);
> > > > > > +     if (quirks->has_dsi) {
> > > > > > +             clk_data->hws[CLK_TCON_TOP_DSI] =
> > > > > > +                     sun8i_tcon_top_register_gate(dev, "dsi", regs,
> > > > > > +                                                  &tcon_top->reg_lock,
> > > > > > +                                                  TCON_TOP_TCON_DSI_GATE, 2);
> > > > > > +     } else {
> > > > > > +             clk_data->hws[CLK_TCON_TOP_DSI] = NULL;
> > > > >
> > > > > clk_data has been kzalloc'd so its content is already NULL.
> > > > >
> > > > > And you shouldn't have brackets for single line blocks.
> > > > >
> > > > > with that fixed,
> > > >
> > > > FYI checkpatch.pl complains if you use brackets for the if block
> > > > but not for the else block. They should be matching.
> > >
> > > Checkpatch might not warn on this, but
> > > https://www.kernel.org/doc/Documentation/process/coding-style.rst,
> > > section 3 is pretty clear on whether we should use them or not.
> >
> > Right. What I'm pointing out what checkpatch.pl complains about is
> > shown in the second last example in section 3:
> >
> >     This does not apply if only one branch of a conditional statement
> > is a single
> >     statement; in the latter case use braces in both branches:
> >
> > Which is where I think your comment on "shouldn't have brackets for
> > single line blocks"
> > is pointing in the opposite direction.
>
> I think we have a communication failure :)
>
> The two blocks above are single line blocks, even though the line is
> wrapped. So whether or not there is an else condition or not doesn't
> matter, you shouldn't have braces at all.

Ah... It was a single line split wrapped to two lines...
Sorry for the noise.

ChenYu
