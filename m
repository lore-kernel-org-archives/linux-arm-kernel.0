From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 27 Mar 2018 10:08:48 +0200
Subject: [PATCH 04/10] drm/sun4i: Explicitly list and check formats
 supported by the backend
In-Reply-To: <20180323100330.2sijtsp5bdyyel5a@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-5-paul.kocialkowski@bootlin.com>
 <20180323100330.2sijtsp5bdyyel5a@flea>
Message-ID: <1522138128.1110.11.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2018-03-23 at 11:03 +0100, Maxime Ripard wrote:
> On Wed, Mar 21, 2018 at 04:28:58PM +0100, Paul Kocialkowski wrote:
> > In order to check whether the backend supports a specific format, an
> > explicit list and a related helper are introduced.
> > 
> > They are then used to determine whether the frontend should be used
> > for
> > a layer, when the format is not supported by the backend.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_backend.c | 48
> > ++++++++++++++++++++++++++++++++++-
> >  drivers/gpu/drm/sun4i/sun4i_backend.h |  1 +
> >  2 files changed, 48 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > index 274a1db6fa8e..7703ba989743 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > @@ -172,6 +172,39 @@ static int
> > sun4i_backend_drm_format_to_layer(u32 format, u32 *mode)
> >  	return 0;
> >  }
> >  
> > +static const uint32_t sun4i_backend_formats[] = {
> > +	/* RGB */
> > +	DRM_FORMAT_ARGB4444,
> > +	DRM_FORMAT_RGBA4444,
> > +	DRM_FORMAT_ARGB1555,
> > +	DRM_FORMAT_RGBA5551,
> > +	DRM_FORMAT_RGB565,
> > +	DRM_FORMAT_RGB888,
> > +	DRM_FORMAT_XRGB8888,
> > +	DRM_FORMAT_BGRX8888,
> > +	DRM_FORMAT_ARGB8888,
> > +	/* YUV422 */
> > +	DRM_FORMAT_YUYV,
> > +	DRM_FORMAT_YVYU,
> > +	DRM_FORMAT_UYVY,
> > +	DRM_FORMAT_VYUY,
> 
> Ordering them by alphabetical order would be better.

Frankly I find it a lot harder to read when the formats are not grouped
by "family". This is the drm_fourcc enumeration order, which has some
kind of logic behind it. What is the advantage of alphabetical ordering
here?

> > +};
> > +
> > +bool sun4i_backend_format_is_supported(uint32_t fmt)
> > +{
> > +	bool found = false;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(sun4i_backend_formats); i++) {
> > +		if (sun4i_backend_formats[i] == fmt) {
> > +			found = true;
> > +			break;
> 
> return true?

Definitely.

> > +		}
> > +	}
> > +
> > +	return found;
> > +}
> > +
> >  int sun4i_backend_update_layer_coord(struct sun4i_backend *backend,
> >  				     int layer, struct drm_plane
> > *plane)
> >  {
> > @@ -436,15 +469,28 @@ static bool
> > sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
> >  {
> >  	struct sun4i_layer *layer = plane_to_sun4i_layer(state-
> > >plane);
> >  	struct sun4i_backend *backend = layer->backend;
> > +	struct drm_framebuffer *fb = state->fb;
> >  
> >  	if (IS_ERR(backend->frontend))
> >  		return false;
> >  
> > +	/*
> > +	 * Let's pretend that every format is either supported by
> > the backend or
> > +	 * the frontend. This is not true in practice, as some
> > tiling modes are
> > +	 * not supported by either. There is still room to check
> > this later in
> > +	 * the atomic check process.
> 
> Then I guess there these tiling modes will not be exposed and we won't
> ever get that far, wouldn't we?

This comment is indeed a bit irrelevant at this stage given that the
tiling modifier was not introduced yet. So in practice, this never
happens with this patch. I should probably move it to a subsequent one.

> > +	 */
> > +	if (!sun4i_backend_format_is_supported(fb->format->format))
> > +		return true;
> 
> Even though there's a comment, this is not really natural. We are
> checking whether the frontend supports the current plane_state, so it
> just makes more sense to check whether the frontend supports the
> format, rather than if the backend doesn't support them.

The rationale behind this logic is that we should try to use the backend
first and only use the frontend as a last resort. Some formats are
supported by both and checking that the backend supports a format first
ensures that we don't bring up the frontend without need.

Cheers,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180327/5e887908/attachment.sig>
