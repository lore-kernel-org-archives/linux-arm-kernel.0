From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 18 Jan 2018 08:25:21 +0100
Subject: [PATCH v3 09/13] drm/sun4i: backend: Wire in the frontend
In-Reply-To: <CAGb2v64zBzvH0b7fjQ_oaX=T=av=fV5pJOtvfj3FYCGjnWKnrg@mail.gmail.com>
References: <cover.8538fc1191390239557a21e2b0444c81eef1c581.1515492513.git-series.maxime.ripard@free-electrons.com>
 <936ca493795fe9a223f2958bdf8e7b6c874522ec.1515492513.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v64zBzvH0b7fjQ_oaX=T=av=fV5pJOtvfj3FYCGjnWKnrg@mail.gmail.com>
Message-ID: <20180118072521.dgneqicglb3jen7j@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 17, 2018 at 09:46:13PM +0800, Chen-Yu Tsai wrote:
> > +       for_each_available_child_of_node(port, ep) {
> > +               remote = of_graph_get_remote_port_parent(ep);
> > +               if (!remote)
> > +                       continue;
> > +
> > +               /* does this node match any registered engines? */
> > +               list_for_each_entry(frontend, &drv->frontend_list, list) {
> > +                       if (remote == frontend->node) {
> > +                               of_node_put(remote);
> > +                               of_node_put(port);
> > +                               return frontend;
> > +                       }
> > +               }
> 
> I assume that since you are only enabling support on the A33, you are
> not considering dual display pipeline cases. We have cross connections
> in the of graph for those situations, i.e. frontend0 can output to both
> backend0 and backend1, as described in the following link:
> 
> http://elixir.free-electrons.com/linux/v4.15-rc8/source/arch/arm/boot/dts/sun6i-a31.dtsi#L1177
> 
> So with your code, both backends would end up using frontend0, and
> if both display pipelines are active, one would potentially step on
> the other.
> 
> Instead, have the frontend store its ID in its data structure, and
> have the backend look through the list of frontends to find a match
> for the backend's ID. This is what we already do for engine <-> TCON:
> 
> http://elixir.free-electrons.com/linux/v4.15-rc8/source/drivers/gpu/drm/sun4i/sun4i_tcon.c#L583
> 
> Or just leave a TODO note and I can do it later. :)

We discussed it on IRC, and yes, I don't have a test setup right now
with two pipelines being used, and there's a few changes that need to
be made for it to operate properly on the A10/A20. That's why I only
added the A33 in the supported list at the moment.

I'll add a TODO note

> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180118/e68aee04/attachment.sig>
