From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Tue, 10 Jul 2018 18:18:43 +0200
Subject: [PATCH 16/17] drm/sun4i: tcon-top: Remove mux configuration at
 probe time
In-Reply-To: <CAGb2v64rjUnwnXbWxTSYJyhMyCV5QmV9YSr+Jryx3nEeMP8GJg@mail.gmail.com>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-17-jernej.skrabec@siol.net>
 <CAGb2v64rjUnwnXbWxTSYJyhMyCV5QmV9YSr+Jryx3nEeMP8GJg@mail.gmail.com>
Message-ID: <1843348.gnui32CGBV@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne torek, 10. julij 2018 ob 18:09:26 CEST je Chen-Yu Tsai napisal(a):
> On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > Now that R40 TCON migrated to runtime mux configuration, old code can be
> > removed.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 81 +++-----------------------
> >  1 file changed, 7 insertions(+), 74 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c index c09b15b64192..78795d6cb174
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > @@ -87,34 +87,6 @@ int sun8i_tcon_top_de_config(struct device *dev, int
> > mixer, int tcon)> 
> >  }
> >  EXPORT_SYMBOL(sun8i_tcon_top_de_config);
> > 
> > -static int sun8i_tcon_top_get_connected_ep_id(struct device_node *node,
> > -                                             int port_id)
> > -{
> > -       struct device_node *ep, *remote, *port;
> > -       struct of_endpoint endpoint;
> > -
> > -       port = of_graph_get_port_by_id(node, port_id);
> > -       if (!port)
> > -               return -ENOENT;
> > -
> > -       for_each_available_child_of_node(port, ep) {
> > -               remote = of_graph_get_remote_port_parent(ep);
> > -               if (!remote)
> > -                       continue;
> > -
> > -               if (of_device_is_available(remote)) {
> > -                       of_graph_parse_endpoint(ep, &endpoint);
> > -
> > -                       of_node_put(remote);
> > -
> > -                       return endpoint.id;
> > -               }
> > -
> > -               of_node_put(remote);
> > -       }
> > -
> > -       return -ENOENT;
> > -}
> > 
> >  static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
> >  
> >                                                    const char *parent,
> > 
> > @@ -149,11 +121,9 @@ static int sun8i_tcon_top_bind(struct device *dev,
> > struct device *master,> 
> >         struct platform_device *pdev = to_platform_device(dev);
> >         struct clk_hw_onecell_data *clk_data;
> >         struct sun8i_tcon_top *tcon_top;
> > 
> > -       bool mixer0_unused = false;
> > 
> >         struct resource *res;
> >         void __iomem *regs;
> > 
> > -       int ret, i, id;
> > -       u32 val;
> > +       int ret, i;
> > 
> >         tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
> >         if (!tcon_top)
> > 
> > @@ -198,49 +168,12 @@ static int sun8i_tcon_top_bind(struct device *dev,
> > struct device *master,> 
> >                 goto err_assert_reset;
> >         
> >         }
> > 
> > -       val = 0;
> > -
> > -       /* check if HDMI mux output is connected */
> > -       if (sun8i_tcon_top_get_connected_ep_id(dev->of_node, 5) >= 0) {
> > -               /* find HDMI input endpoint id, if it is connected at
> > all*/
> > -               id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 4);
> > -               if (id >= 0)
> > -                       val = FIELD_PREP(TCON_TOP_HDMI_SRC_MSK, id + 1);
> > -               else
> > -                       DRM_DEBUG_DRIVER("TCON TOP HDMI input is not
> > connected\n"); -       } else {
> > -               DRM_DEBUG_DRIVER("TCON TOP HDMI output is not
> > connected\n"); -       }
> > -
> > -       writel(val, regs + TCON_TOP_GATE_SRC_REG);
> > -
> > -       val = 0;
> > -
> > -       /* process mixer0 mux output */
> > -       id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 1);
> > -       if (id >= 0) {
> > -               val = FIELD_PREP(TCON_TOP_PORT_DE0_MSK, id);
> > -       } else {
> > -               DRM_DEBUG_DRIVER("TCON TOP mixer0 output is not
> > connected\n"); -               mixer0_unused = true;
> > -       }
> > -
> > -       /* process mixer1 mux output */
> > -       id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 3);
> > -       if (id >= 0) {
> > -               val |= FIELD_PREP(TCON_TOP_PORT_DE1_MSK, id);
> > -
> > -               /*
> > -                * mixer0 mux has priority over mixer1 mux. We have to
> > -                * make sure mixer0 doesn't overtake TCON from mixer1.
> > -                */
> > -               if (mixer0_unused && id == 0)
> > -                       val |= FIELD_PREP(TCON_TOP_PORT_DE0_MSK, 1);
> > -       } else {
> > -               DRM_DEBUG_DRIVER("TCON TOP mixer1 output is not
> > connected\n"); -       }
> > -
> > -       writel(val, regs + TCON_TOP_PORT_SEL_REG);
> > +       /*
> > +        * Default register values might have some reserved bits set,
> > which
> > +        * prevents TCON TOP from working properly. Set them to 0 here.
> > +        */
> > +       writel(0, regs + TCON_TOP_GATE_SRC_REG);
> > +       writel(0, regs + TCON_TOP_PORT_SEL_REG);
> 
> Would it make sense to just force a reset using the reset control?

I wrote TCON TOP driver for H6 at first. For some reason, some registers had 
reserved bits set after reset line was released. TCON TOP was not used in U-
Boot, so I guess this counts as full reset.

I never tried to find out how it behaves on R40 because setting those 
registers to 0 seems like simple, good enough solution, which works 
everywhere.

Best regards,
Jernej
