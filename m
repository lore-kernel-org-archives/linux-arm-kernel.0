From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 17 Mar 2014 14:58:36 +0100
Subject: [PATCH 07/12] drm: drm_display_mode: add signal polarity flags
In-Reply-To: <5326FB75.1050605@samsung.com>
References: <1394731053-6118-1-git-send-email-denis@eukrea.com>
 <1394731053-6118-7-git-send-email-denis@eukrea.com>
 <5326FB75.1050605@samsung.com>
Message-ID: <2166863.3Fn4k2rvaz@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday 17 March 2014 14:41:09 Andrzej Hajda wrote:
> On 03/13/2014 06:17 PM, Denis Carikli wrote:
> > We need a way to pass signal polarity informations
> > between DRM panels, and the display drivers.
> > 
> > To do that, a pol_flags field was added to drm_display_mode.
> > 
> > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > ---
> > ChangeLog v10->v11:
> > - Since the imx-drm won't be able to retrive its regulators
> > 
> >   from the device tree when using display-timings nodes,
> >   and that I was told that the drm simple-panel driver
> >   already supported that, I then, instead, added what was
> >   lacking to make the eukrea displays work with the
> >   drm-simple-panel driver.
> >   
> >   That required a way to get back the display polarity
> >   informations from the imx-drm driver without affecting
> >   userspace.
> > 
> > ---
> > 
> >  include/drm/drm_crtc.h |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> > index f764654..61a4fe1 100644
> > --- a/include/drm/drm_crtc.h
> > +++ b/include/drm/drm_crtc.h
> > @@ -131,6 +131,13 @@ enum drm_mode_status {
> > 
> >  #define DRM_MODE_FLAG_3D_MAX	DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF
> > 
> > +#define DRM_MODE_FLAG_POL_PIXDATA_NEGEDGE	BIT(1)
> > +#define DRM_MODE_FLAG_POL_PIXDATA_POSEDGE	BIT(2)
> > +#define DRM_MODE_FLAG_POL_PIXDATA_PRESERVE	BIT(3)
> > +#define DRM_MODE_FLAG_POL_DE_NEGEDGE		BIT(4)
> > +#define DRM_MODE_FLAG_POL_DE_POSEDGE		BIT(5)
> > +#define DRM_MODE_FLAG_POL_DE_PRESERVE		BIT(6)
> 
> Could you add some description to these flags.
> What are *_PRESERVE flags for?
> Are those flags 1:1 compatible with respective 'videomode:flags'?
> I guess DE flags should be rather DRM_MODE_FLAG_POL_DE_(LOW|HIGH), am I
> right?

Possibly nitpicking, I wouldn't call the clock edge on which data signals are 
generated/sampled "data polarity". This is clock polarity information.

Have you seen cases where pixel data and DE are geenrated or need to be 
sampled on different edges ?

> > +
> >  struct drm_display_mode {
> >  	/* Header */
> >  	struct list_head head;
> > @@ -183,6 +190,7 @@ struct drm_display_mode {
> >  	int vrefresh;		/* in Hz */
> >  	int hsync;		/* in kHz */
> >  	enum hdmi_picture_aspect picture_aspect_ratio;
> > +	unsigned int pol_flags;
> >  };
> >  
> >  static inline bool drm_mode_is_stereo(const struct drm_display_mode
> >  *mode)

-- 
Regards,

Laurent Pinchart
