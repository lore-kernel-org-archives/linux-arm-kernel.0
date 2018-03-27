From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 27 Mar 2018 10:24:17 +0200
Subject: [PATCH 05/10] drm/sun4i: Explicitly list and check formats
 supported by the frontend
In-Reply-To: <20180323100659.vojpyt7eazioevdj@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-6-paul.kocialkowski@bootlin.com>
 <20180323100659.vojpyt7eazioevdj@flea>
Message-ID: <1522139057.1110.24.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2018-03-23 at 11:06 +0100, Maxime Ripard wrote:
> On Wed, Mar 21, 2018 at 04:28:59PM +0100, Paul Kocialkowski wrote:
> > In order to check whether the frontend supports a specific format,
> > an
> > explicit list and a related helper are introduced.
> > 
> > They are then used to determine whether the frontend can actually
> > support
> > the requested format when it was selected to be used.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_backend.c  |  5 ++++
> >  drivers/gpu/drm/sun4i/sun4i_frontend.c | 44
> > ++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/sun4i/sun4i_frontend.h |  1 +
> >  3 files changed, 50 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > index 7703ba989743..1fad0714c70e 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > @@ -532,6 +532,11 @@ static int sun4i_backend_atomic_check(struct
> > sunxi_engine *engine,
> >  		struct drm_format_name_buf format_name;
> >  
> >  		if (sun4i_backend_plane_uses_frontend(plane_state))
> > {
> > +			if (!sun4i_frontend_format_is_supported(fb-
> > >format->format)) {
> > +				DRM_DEBUG_DRIVER("Frontend plane
> > check failed\n");
> > +				return -EINVAL;
> > +			}
> > +
> 
> So you're checking if the frontend doesn't support it and if the
> backend doesn't support it. Who supports it then? :)

That's the case case where the format is not supported by either of the
hardware blocks. For instance, requesting ARGB with tiling will fail,
although ARGB without tiling will work. It seems that modetest assumes
that modifiers only apply to YUV (in which case there are no unsupported
cases), but I think userspace might still request RGB+tiling
combinations. I don't currently see a way to report to which format the
tiling applies (thus we have to expect that it can come with any of the
supported formats).

> Like I was saying, this should be moved to the previous patch, within
> sun4i_backend_plane_uses_frontend.

If we get both tests (no backend support and frontend support) into one
function, we cannot detect that the format is actually unsupported and
return an error in the atomic check.

> > +static const uint32_t sun4i_frontend_formats[] = {
> > +	/* RGB */
> > +	DRM_FORMAT_XRGB8888,
> > +	DRM_FORMAT_BGRX8888,
> > +	/* YUV444 */
> > +	DRM_FORMAT_YUV444,
> > +	DRM_FORMAT_YVU444,
> > +	/* YUV422 */
> > +	DRM_FORMAT_YUYV,
> > +	DRM_FORMAT_YVYU,
> > +	DRM_FORMAT_UYVY,
> > +	DRM_FORMAT_VYUY,
> > +	DRM_FORMAT_NV16,
> > +	DRM_FORMAT_NV61,
> > +	DRM_FORMAT_YUV422,
> > +	DRM_FORMAT_YVU422,
> > +	/* YUV420 */
> > +	DRM_FORMAT_NV12,
> > +	DRM_FORMAT_NV21,
> > +	DRM_FORMAT_YUV420,
> > +	DRM_FORMAT_YVU420,
> > +	/* YUV411 */
> > +	DRM_FORMAT_YUV411,
> > +	DRM_FORMAT_YVU411,
> > +};
> 
> I think this list should reflect what the driver currently supports,
> not what the hardware supports.

This list is not indended to reflect what the driver supports, but only
what the backend can support (to correctly select whether a
format/modifier couple should go to the frontend or backend)!

The complete list that is reported to userspace for global driver
support is sun4i_layer_formats in sun4i_layer.c.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180327/8a8e3029/attachment.sig>
