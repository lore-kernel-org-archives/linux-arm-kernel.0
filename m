From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Mon, 08 Oct 2018 16:30:51 +0200
Subject: [PATCH v2 25/29] drm: sun4i: add quirks for TCON TOP
In-Reply-To: <20181008085112.mejpwvl3dpu7sopy@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-26-jernej.skrabec@siol.net>
 <20181008085112.mejpwvl3dpu7sopy@flea>
Message-ID: <15704955.mQ5FZSihaB@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ponedeljek, 08. oktober 2018 ob 10:51:12 CEST je Maxime Ripard napisal(a):
> On Sun, Oct 07, 2018 at 11:39:01AM +0200, Jernej Skrabec wrote:
> > From: Icenowy Zheng <icenowy@aosc.io>
> > 
> > Some SoCs, such as H6, doesn't have a full-featured TCON TOP.
> > 
> > Add quirks support for TCON TOP.
> > 
> > Currently the presence of TCON_TV1 and DSI is controlled via the quirks
> > structure.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 43 ++++++++++++++++++++------
> >  1 file changed, 34 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c index 37158548b447..ed13233cad88
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > @@ -9,11 +9,17 @@
> > 
> >  #include <linux/component.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> > 
> > +#include <linux/of_device.h>
> > 
> >  #include <linux/of_graph.h>
> >  #include <linux/platform_device.h>
> >  
> >  #include "sun8i_tcon_top.h"
> > 
> > +struct sun8i_tcon_top_quirks {
> > +	bool has_tcon_tv1;
> > +	bool has_dsi;
> > +};
> > +
> > 
> >  static bool sun8i_tcon_top_node_is_tcon_top(struct device_node *node)
> >  {
> >  
> >  	return !!of_match_node(sun8i_tcon_top_of_table, node);
> > 
> > @@ -121,10 +127,13 @@ static int sun8i_tcon_top_bind(struct device *dev,
> > struct device *master,> 
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	struct clk_hw_onecell_data *clk_data;
> >  	struct sun8i_tcon_top *tcon_top;
> > 
> > +	const struct sun8i_tcon_top_quirks *quirks;
> > 
> >  	struct resource *res;
> >  	void __iomem *regs;
> >  	int ret, i;
> > 
> > +	quirks = of_device_get_match_data(&pdev->dev);
> > +
> > 
> >  	tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
> >  	if (!tcon_top)
> >  	
> >  		return -ENOMEM;
> > 
> > @@ -187,15 +196,23 @@ static int sun8i_tcon_top_bind(struct device *dev,
> > struct device *master,> 
> >  					     &tcon_top->reg_lock,
> >  					     TCON_TOP_TCON_TV0_GATE, 0);
> > 
> > -	clk_data->hws[CLK_TCON_TOP_TV1] =
> > -		sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> > -					     &tcon_top->reg_lock,
> > -					     TCON_TOP_TCON_TV1_GATE, 1);
> > +	if (quirks->has_tcon_tv1) {
> > +		clk_data->hws[CLK_TCON_TOP_TV1] =
> > +			sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
> > +						     &tcon_top->reg_lock,
> > +						     TCON_TOP_TCON_TV1_GATE, 1);
> > +	} else {
> > +		clk_data->hws[CLK_TCON_TOP_TV1] = NULL;
> > +	}
> > 
> > -	clk_data->hws[CLK_TCON_TOP_DSI] =
> > -		sun8i_tcon_top_register_gate(dev, "dsi", regs,
> > -					     &tcon_top->reg_lock,
> > -					     TCON_TOP_TCON_DSI_GATE, 2);
> > +	if (quirks->has_dsi) {
> > +		clk_data->hws[CLK_TCON_TOP_DSI] =
> > +			sun8i_tcon_top_register_gate(dev, "dsi", regs,
> > +						     &tcon_top->reg_lock,
> > +						     TCON_TOP_TCON_DSI_GATE, 2);
> > +	} else {
> > +		clk_data->hws[CLK_TCON_TOP_DSI] = NULL;
> 
> clk_data has been kzalloc'd so its content is already NULL.
> 
> And you shouldn't have brackets for single line blocks.

Ah, yes. I'm not original author so I missed that during a review. I'll fix it 
in new revision.

Best regards,
Jernej

> 
> with that fixed,
> 
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Maxime
