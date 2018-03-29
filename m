From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 29 Mar 2018 09:56:21 +0200
Subject: [PATCH 04/10] drm/sun4i: Explicitly list and check formats
 supported by the backend
In-Reply-To: <1522138128.1110.11.camel@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-5-paul.kocialkowski@bootlin.com>
 <20180323100330.2sijtsp5bdyyel5a@flea>
 <1522138128.1110.11.camel@bootlin.com>
Message-ID: <20180329075621.it3xltsqw4tbgeyu@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 10:08:48AM +0200, Paul Kocialkowski wrote:
> On Fri, 2018-03-23 at 11:03 +0100, Maxime Ripard wrote:
> > On Wed, Mar 21, 2018 at 04:28:58PM +0100, Paul Kocialkowski wrote:
> > > In order to check whether the backend supports a specific format, an
> > > explicit list and a related helper are introduced.
> > > 
> > > They are then used to determine whether the frontend should be used
> > > for
> > > a layer, when the format is not supported by the backend.
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun4i_backend.c | 48
> > > ++++++++++++++++++++++++++++++++++-
> > >  drivers/gpu/drm/sun4i/sun4i_backend.h |  1 +
> > >  2 files changed, 48 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > index 274a1db6fa8e..7703ba989743 100644
> > > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > > @@ -172,6 +172,39 @@ static int
> > > sun4i_backend_drm_format_to_layer(u32 format, u32 *mode)
> > >  	return 0;
> > >  }
> > >  
> > > +static const uint32_t sun4i_backend_formats[] = {
> > > +	/* RGB */
> > > +	DRM_FORMAT_ARGB4444,
> > > +	DRM_FORMAT_RGBA4444,
> > > +	DRM_FORMAT_ARGB1555,
> > > +	DRM_FORMAT_RGBA5551,
> > > +	DRM_FORMAT_RGB565,
> > > +	DRM_FORMAT_RGB888,
> > > +	DRM_FORMAT_XRGB8888,
> > > +	DRM_FORMAT_BGRX8888,
> > > +	DRM_FORMAT_ARGB8888,
> > > +	/* YUV422 */
> > > +	DRM_FORMAT_YUYV,
> > > +	DRM_FORMAT_YVYU,
> > > +	DRM_FORMAT_UYVY,
> > > +	DRM_FORMAT_VYUY,
> > 
> > Ordering them by alphabetical order would be better.
> 
> Frankly I find it a lot harder to read when the formats are not grouped
> by "family". This is the drm_fourcc enumeration order, which has some
> kind of logic behind it. What is the advantage of alphabetical ordering
> here?

It's self-sufficient and self-explanatory. The sorting here, while it
would make sense lack both: you need to refer to the drm_fourcc.h file
to get the sorting right (which makes it harder to edit and review,
and thus more error prone), and it assumes that the editor knows about
that sorting in the first place.

And it's an assumption we can't really make, since some people will
edit that structure in the first place without any background at all
with DRM, or even graphics in general.

While the assumption you have to make for the alphabetical order is
that one knows the latin alphabet, which is a pretty obvious one when
you're doing C programming.

> > > +	 */
> > > +	if (!sun4i_backend_format_is_supported(fb->format->format))
> > > +		return true;
> > 
> > Even though there's a comment, this is not really natural. We are
> > checking whether the frontend supports the current plane_state, so it
> > just makes more sense to check whether the frontend supports the
> > format, rather than if the backend doesn't support them.
> 
> The rationale behind this logic is that we should try to use the backend
> first and only use the frontend as a last resort. Some formats are
> supported by both and checking that the backend supports a format first
> ensures that we don't bring up the frontend without need.

You can achieve pretty much the same thing by doing:

if (!sun4i_frontend_format_is_supported())
	return false;

if (!using_scaling)
	return false;

if (using_2x_or_4x_scaling)
	return false;

return true;

This is really about whitelisting vs blacklisting, so I'm not sure
what that would really change in the case you described above.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180329/2901345e/attachment.sig>
