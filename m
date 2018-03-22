From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 22 Mar 2018 09:41:04 +0100
Subject: [PATCH 03/10] drm/sun4i: Don't pretend to handle ARGB8888 with
 the frontend
In-Reply-To: <CAGb2v66ih3VaMcqUcuEQC9WKoULgFPUx8o7GjECGeuUv8a7d+g@mail.gmail.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-4-paul.kocialkowski@bootlin.com>
 <CAGb2v65JqT2go2kX+yEWeWiQX6U5PFoXEbbatBXRyLyujxyouw@mail.gmail.com>
 <1521706988.1175.4.camel@bootlin.com>
 <CAGb2v66ih3VaMcqUcuEQC9WKoULgFPUx8o7GjECGeuUv8a7d+g@mail.gmail.com>
Message-ID: <1521708064.1175.5.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 2018-03-22 at 16:37 +0800, Chen-Yu Tsai wrote:
> On Thu, Mar 22, 2018 at 4:23 PM, Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > Hi Chen-Yu,
> > 
> > On Thu, 2018-03-22 at 14:47 +0800, Chen-Yu Tsai wrote:
> > > On Wed, Mar 21, 2018 at 11:28 PM, Paul Kocialkowski
> > > <paul.kocialkowski@bootlin.com> wrote:
> > > > It turns out that the frontend is not capable of preserving the
> > > > alpha
> > > > component (that is always set to 0xff), so only support XRGB8888
> > > > instead.
> > > > 
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >  drivers/gpu/drm/sun4i/sun4i_backend.c  | 4 ++++
> > > >  drivers/gpu/drm/sun4i/sun4i_frontend.c | 3 +--
> > > >  drivers/gpu/drm/sun4i/sun4i_layer.c    | 4 ++--
> > > >  3 files changed, 7 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > > b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > > index b98dafda52f8..274a1db6fa8e 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > > @@ -440,6 +440,10 @@ static bool
> > > > sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
> > > >         if (IS_ERR(backend->frontend))
> > > >                 return false;
> > > > 
> > > > +       /*
> > > > +        * TODO: Don't use the frontend for x2/x4 scaling and
> > > > allow
> > > > RGB formats
> > > > +        * with an alpha component then.
> > > 
> > > This and the commit log are kind of conflicting. Is it just the
> > > scalar
> > > that doesn't
> > > work with an alpha component, or the whole frontend?
> > 
> > It's the whole frontend that does not support alpha in its output
> > formats. I'm talking about scaling here because that's still the
> > main
> > reason to use the frontend. On the other hand, the backend allows
> > integer scaling with an alpha component, hence the comment.
> 
> I see. I parsed the TODO note incorrectly.
> 
> > Do you think I need to rework the comment/commit log?
> 
> I think
> 
>     Allow integer scaling with alpha using just the backend.
> 
> would be slightly clearer.

I agree, will do in the next version!

Cheers,

Paul

> > Thanks for the review,
> > 
> > Paul
> > 
> > > > +        */
> > > >         return sun4i_backend_plane_uses_scaler(state);
> > > >  }
> > > > 
> > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > > > b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > > > index ddf6cfa6dd23..3ea925584891 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> > > > @@ -107,7 +107,7 @@ EXPORT_SYMBOL(sun4i_frontend_update_buffer);
> > > >  static int sun4i_frontend_drm_format_to_input_fmt(uint32_t fmt,
> > > > u32
> > > > *val)
> > > >  {
> > > >         switch (fmt) {
> > > > -       case DRM_FORMAT_ARGB8888:
> > > > +       case DRM_FORMAT_XRGB8888:
> > > >                 *val = 5;
> > > >                 return 0;
> > > > 
> > > > @@ -120,7 +120,6 @@ static int
> > > > sun4i_frontend_drm_format_to_output_fmt(uint32_t fmt, u32 *val)
> > > >  {
> > > >         switch (fmt) {
> > > >         case DRM_FORMAT_XRGB8888:
> > > > -       case DRM_FORMAT_ARGB8888:
> > > >                 *val = 2;
> > > >                 return 0;
> > > > 
> > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c
> > > > b/drivers/gpu/drm/sun4i/sun4i_layer.c
> > > > index eb93df445a10..15238211a61a 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> > > > @@ -100,9 +100,9 @@ static void
> > > > sun4i_backend_layer_atomic_update(struct drm_plane *plane,
> > > >                 sun4i_frontend_update_coord(frontend, plane);
> > > >                 sun4i_frontend_update_buffer(frontend, plane);
> > > >                 sun4i_frontend_update_formats(frontend, plane,
> > > > -                                             DRM_FORMAT_ARGB888
> > > > 8);
> > > > +                                             DRM_FORMAT_XRGB888
> > > > 8);
> > > >                 sun4i_backend_update_layer_frontend(backend,
> > > > layer-
> > > > > id, plane,
> > > > 
> > > > -                                                   DRM_FORMAT_A
> > > > RGB8
> > > > 888);
> > > > +                                                   DRM_FORMAT_X
> > > > RGB8
> > > > 888);
> > > >                 sun4i_frontend_enable(frontend);
> > > >         } else {
> > > >                 sun4i_backend_update_layer_formats(backend,
> > > > layer-
> > > > > id, plane);
> > > > 
> > > > --
> > > > 2.16.2
> > > > 
> > > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel at lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> > --
> > Paul Kocialkowski, Bootlin (formerly Free Electrons)
> > Embedded Linux and kernel engineering
> > https://bootlin.com
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180322/b47e0ae9/attachment-0001.sig>
