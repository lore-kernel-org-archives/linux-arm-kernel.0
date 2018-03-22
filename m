From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 22 Mar 2018 17:18:33 +0100
Subject: [PATCH 03/10] drm/sun4i: Don't pretend to handle ARGB8888 with
 the frontend
In-Reply-To: <20180322161204.dpi6puzvosesm5xt@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-4-paul.kocialkowski@bootlin.com>
 <20180322161204.dpi6puzvosesm5xt@flea>
Message-ID: <1521735513.1175.51.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 2018-03-22 at 17:12 +0100, Maxime Ripard wrote:
> Hi,
> 
> Beside the discussion with Chen-Yu,
> 
> On Wed, Mar 21, 2018 at 04:28:57PM +0100, Paul Kocialkowski wrote:
> > It turns out that the frontend is not capable of preserving the
> > alpha
> > component (that is always set to 0xff), so only support XRGB8888
> > instead.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> 
> [...]
> 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c
> > b/drivers/gpu/drm/sun4i/sun4i_layer.c
> > index eb93df445a10..15238211a61a 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> > @@ -100,9 +100,9 @@ static void
> > sun4i_backend_layer_atomic_update(struct drm_plane *plane,
> >  		sun4i_frontend_update_coord(frontend, plane);
> >  		sun4i_frontend_update_buffer(frontend, plane);
> >  		sun4i_frontend_update_formats(frontend, plane,
> > -					      DRM_FORMAT_ARGB8888);
> > +					      DRM_FORMAT_XRGB8888);
> >  		sun4i_backend_update_layer_frontend(backend, layer-
> > >id, plane,
> > -						    DRM_FORMAT_ARGB
> > 8888);
> > +						    DRM_FORMAT_XRGB
> > 8888);
> 
> Even though it's slightly related, these changes should be justified
> in the commit log. From what you currently explain, this makes 0
> difference, since XRGB and ARGB with an alpha component to 0xff is
> exactly the same thing.

The point of this is mostly to fix
sun4i_frontend_drm_format_to_input_fmt and
sun4i_frontend_drm_format_to_output_fmt, that were reporting the wrong
format (ARGB has never been supported).

The change in the internal format used between the frontend and backend
is a direct consequence of correcting the supported format, but brings
no functional change.

I will update the commit message in the next revision to make it clear
what the nature of this change is.

Thanks for the review!

Paul

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180322/b8bf1114/attachment.sig>
