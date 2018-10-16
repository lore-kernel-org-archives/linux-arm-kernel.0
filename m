From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 16 Oct 2018 15:57:41 +0200
Subject: [PATCH 05/10] drm/sun4i: Explicitly list and check formats
 supported by the frontend
In-Reply-To: <20180323100659.vojpyt7eazioevdj@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-6-paul.kocialkowski@bootlin.com>
 <20180323100659.vojpyt7eazioevdj@flea>
Message-ID: <23f66de8a3e55cba253b89328f0f268a7c4df29d.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le vendredi 23 mars 2018 ? 11:06 +0100, Maxime Ripard a ?crit :
> On Wed, Mar 21, 2018 at 04:28:59PM +0100, Paul Kocialkowski wrote:
> > In order to check whether the frontend supports a specific format, an
> > explicit list and a related helper are introduced.
> > 
> > They are then used to determine whether the frontend can actually support
> > the requested format when it was selected to be used.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_backend.c  |  5 ++++
> >  drivers/gpu/drm/sun4i/sun4i_frontend.c | 44 ++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/sun4i/sun4i_frontend.h |  1 +
> >  3 files changed, 50 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > index 7703ba989743..1fad0714c70e 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > @@ -532,6 +532,11 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
> >  		struct drm_format_name_buf format_name;
> >  
> >  		if (sun4i_backend_plane_uses_frontend(plane_state)) {
> > +			if (!sun4i_frontend_format_is_supported(fb->format->format)) {
> > +				DRM_DEBUG_DRIVER("Frontend plane check failed\n");
> > +				return -EINVAL;
> > +			}
> > +
> 
> So you're checking if the frontend doesn't support it and if the
> backend doesn't support it. Who supports it then? :)
> 
> Like I was saying, this should be moved to the previous patch, within
> sun4i_backend_plane_uses_frontend.

You're right, this isn't the right place to put it.
sun4i_backend_plane_uses_frontend should definitely guarantee that the
format is supported.

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

Agreed, this should be updated with the follow-up patch that adds YUV
support.

Cheers,

Paul

-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181016/1e66ee01/attachment.sig>
