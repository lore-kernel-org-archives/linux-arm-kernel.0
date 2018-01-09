From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 Jan 2018 14:28:33 +0100
Subject: [PATCH 01/19] drm/fourcc: Add a function to tell if the format
 embeds alpha
In-Reply-To: <1796930.sWoKI78acY@avalon>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
 <b58c65b26e59dff7917d90846cb797a11ca09efa.1515494838.git-series.maxime.ripard@free-electrons.com>
 <1796930.sWoKI78acY@avalon>
Message-ID: <20180109132833.petfgnh3fvbbvosv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, Jan 09, 2018 at 02:29:58PM +0200, Laurent Pinchart wrote:
> On Tuesday, 9 January 2018 12:56:20 EET Maxime Ripard wrote:
> > There's a bunch of drivers that duplicate the same function to know if a
> > particular format embeds an alpha component or not.
> > 
> > Let's create a helper to avoid duplicating that logic.
> > 
> > Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Cc: Eric Anholt <eric@anholt.net>
> > Cc: Inki Dae <inki.dae@samsung.com>
> > Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Mark Yao <mark.yao@rock-chips.com>
> > Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/gpu/drm/drm_fourcc.c | 43 +++++++++++++++++++++++++++++++++++++-
> >  include/drm/drm_fourcc.h     |  1 +-
> >  2 files changed, 44 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> > index 9c0152df45ad..6e6227d6a46b 100644
> > --- a/drivers/gpu/drm/drm_fourcc.c
> > +++ b/drivers/gpu/drm/drm_fourcc.c
> > @@ -348,3 +348,46 @@ int drm_format_plane_height(int height, uint32_t
> > format, int plane) return height / info->vsub;
> >  }
> >  EXPORT_SYMBOL(drm_format_plane_height);
> > +
> > +/**
> > + * drm_format_has_alpha - get whether the format embeds an alpha component
> > + * @format: pixel format (DRM_FORMAT_*)
> > + *
> > + * Returns:
> > + * true if the format embeds an alpha component, false otherwise.
> > + */
> > +bool drm_format_has_alpha(uint32_t format)
> > +{
> > +	switch (format) {
> > +	case DRM_FORMAT_ARGB4444:
> > +	case DRM_FORMAT_ABGR4444:
> > +	case DRM_FORMAT_RGBA4444:
> > +	case DRM_FORMAT_BGRA4444:
> > +	case DRM_FORMAT_ARGB1555:
> > +	case DRM_FORMAT_ABGR1555:
> > +	case DRM_FORMAT_RGBA5551:
> > +	case DRM_FORMAT_BGRA5551:
> > +	case DRM_FORMAT_ARGB8888:
> > +	case DRM_FORMAT_ABGR8888:
> > +	case DRM_FORMAT_RGBA8888:
> > +	case DRM_FORMAT_BGRA8888:
> > +	case DRM_FORMAT_ARGB2101010:
> > +	case DRM_FORMAT_ABGR2101010:
> > +	case DRM_FORMAT_RGBA1010102:
> > +	case DRM_FORMAT_BGRA1010102:
> > +	case DRM_FORMAT_AYUV:
> > +	case DRM_FORMAT_XRGB8888_A8:
> > +	case DRM_FORMAT_XBGR8888_A8:
> > +	case DRM_FORMAT_RGBX8888_A8:
> > +	case DRM_FORMAT_BGRX8888_A8:
> > +	case DRM_FORMAT_RGB888_A8:
> > +	case DRM_FORMAT_BGR888_A8:
> > +	case DRM_FORMAT_RGB565_A8:
> > +	case DRM_FORMAT_BGR565_A8:
> > +		return true;
> > +
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +EXPORT_SYMBOL(drm_format_has_alpha);
> 
> How about adding the information to struct drm_format_info instead ? 
> drm_format_has_alpha() could then be implemented as
> 
> bool drm_format_has_alpha(uint32_t format)
> {
> 	const struct drm_format_info *info;
> 
> 	info = drm_format_info(format);
> 	return info ? info->has_alpha : false;
> }

I considered it, and wasn't too sure about if adding more fields to
drm_format_info was ok. I can definitely do it that way.

> although drivers should really use the drm_framebuffer::format field directly 
> in most cases, so the helper might not be needed at all.

The drivers converted in my serie shouldn't be too hard to convert to
use drm_format_info directly, so that can be removed as well.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180109/4e77d4e3/attachment.sig>
