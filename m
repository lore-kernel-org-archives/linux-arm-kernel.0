From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Oct 2016 23:09:28 +0200
Subject: [PATCH] drm/sun4i: Check that the plane coordinates are not
 negative
In-Reply-To: <20161003181840.0cb369d8@bbrezillon>
References: <20160930143320.26241-1-maxime.ripard@free-electrons.com>
 <20160930180826.169e3daf@bbrezillon>
 <20161003125811.GH5228@lukather>
 <20161003181840.0cb369d8@bbrezillon>
Message-ID: <20161012210928.GB9245@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2016 at 06:18:40PM +0200, Boris Brezillon wrote:
> On Mon, 3 Oct 2016 14:58:11 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > Hi Boris,
> > 
> > On Fri, Sep 30, 2016 at 06:08:26PM +0200, Boris Brezillon wrote:
> > > On Fri, 30 Sep 2016 16:33:20 +0200
> > > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> > >   
> > > > Our planes cannot be set at negative coordinates. Make sure we reject such
> > > > configuration.
> > > > 
> > > > Reported-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > > ---
> > > >  drivers/gpu/drm/sun4i/sun4i_layer.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
> > > > index f0035bf5efea..f5463c4c2cde 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> > > > @@ -29,6 +29,9 @@ struct sun4i_plane_desc {
> > > >  static int sun4i_backend_layer_atomic_check(struct drm_plane *plane,
> > > >  					    struct drm_plane_state *state)
> > > >  {
> > > > +	if ((state->crtc_x < 0) || (state->crtc_y < 0))
> > > > +		return -EINVAL;
> > > > +  
> > > 
> > > Hm, I think it's a perfectly valid use case from the DRM framework and
> > > DRM user PoV: you may want to place your plane at a negative CRTC
> > > offset (which means part of the plane will be hidden).
> > > 
> > > Maybe I'm wrong, but it seems you can support that by adapting the
> > > start address of your framebuffer pointer and the layer size.  
> > 
> > Indeed, that would probably work. This is even somewhat what we've
> > been using to implement the VGA hack we use on the CHIP.
> > 
> > Can you send that patch?
> 
> Actually, Ville suggested a slightly different approach: use the
> ->src and ->dst in drm_plane_state.

After more tests, it turns out that it's actually simpler than
that....

The hardware is able to take negative coordinates.

Sorry for the noise,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161012/14a89d77/attachment.sig>
