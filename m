From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Fri, 29 Jun 2018 21:06:09 +0200
Subject: [PATCH v3 10/24] drm/sun4i: tcon: Generalize engine search
 algorithm
In-Reply-To: <20180628182543.yyja6hiry7rx7fu2@flea>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <1812731.FQOhD8MfmX@jernej-laptop> <20180628182543.yyja6hiry7rx7fu2@flea>
Message-ID: <3257762.ZQzN8rrT6c@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?etrtek, 28. junij 2018 ob 20:25:43 CEST je Maxime Ripard napisal(a):
> On Thu, Jun 28, 2018 at 06:48:50AM +0200, Jernej ?krabec wrote:
> > Dne ?etrtek, 28. junij 2018 ob 04:06:52 CEST je Chen-Yu Tsai napisal(a):
> > > On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec
> > > <jernej.skrabec@siol.net>
> > 
> > wrote:
> > > > Current "old" method to find engine worked pretty well for DE2.
> > > > However,
> > > > it doesn't work when TCON TOP is between  mixer (engine) and TCON.
> > > > TCON
> > > > TOP has multiple input ports, but current engine search algorithm
> > > > expects only one.
> > > > 
> > > > This can be fixed by first looking for output port id and selecting
> > > > matching input by subtracting 1 for the next round. This work even if
> > > > there is only one input and output.
> > > > 
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > ---
> > > > 
> > > >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 22 ++++++++++++++++++----
> > > >  1 file changed, 18 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index 08747fc3ee71..264bcc43da11
> > > > 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > @@ -791,12 +791,14 @@ static int sun4i_tcon_init_regmap(struct device
> > > > *dev,
> > > > 
> > > >   */
> > > >  
> > > >  static struct sunxi_engine *
> > > >  sun4i_tcon_find_engine_traverse(struct sun4i_drv *drv,
> > > > 
> > > > -                               struct device_node *node)
> > > > +                               struct device_node *node,
> > > > +                               u32 port_id)
> > > > 
> > > >  {
> > > >  
> > > >         struct device_node *port, *ep, *remote;
> > > >         struct sunxi_engine *engine = ERR_PTR(-EINVAL);
> > > > 
> > > > +       u32 reg = 0;
> > > > 
> > > > -       port = of_graph_get_port_by_id(node, 0);
> > > > +       port = of_graph_get_port_by_id(node, port_id);
> > > > 
> > > >         if (!port)
> > > >         
> > > >                 return ERR_PTR(-EINVAL);
> > > > 
> > > > @@ -826,8 +828,20 @@ sun4i_tcon_find_engine_traverse(struct sun4i_drv
> > > > *drv,
> > > > 
> > > >                 if (remote == engine->node)
> > > >                 
> > > >                         goto out_put_remote;
> > > > 
> > > > +       /*
> > > > +        * According to device tree binding input ports have even id
> > > > +        * number and output ports have odd id. Since component with
> > > > +        * more than one input and one output (TCON TOP) exits,
> > > > correct
> > > > +        * remote input id has to be calculated by subtracting 1 from
> > > > +        * remote output id. If this for some reason can't be done, 0
> > > > +        * is used as input port id.
> > > > +        */
> > > 
> > > You need to call
> > > 
> > >     of_node_put(port);
> > > 
> > > to drop the reference to the original port.
> > 
> > Thanks for noticing it. I guess I should send fix patch, since patches
> > from
> > drm-misc-next can't be dropped.
> 
> Yeah, please send additional patches for all the issues pointed out by
> Chen-Yu.

Of course. I hope this can be resolved till the end of the next week. After 
that, I will be away from PC for 2 weeks. Feel free to drop DT patches if you 
think that it will come too close to merge window.

Best regards,
Jernej
