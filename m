From: Ying.Liu@freescale.com (Liu Ying)
Date: Fri, 13 Feb 2015 13:01:14 +0800
Subject: [PATCH RFC v9 09/20] drm/dsi: Add a helper to get bits per pixel
 of MIPI DSI pixel format
In-Reply-To: <20150212092642.GY24485@phenom.ffwll.local>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
 <1423720903-24806-10-git-send-email-Ying.Liu@freescale.com>
 <20150212092642.GY24485@phenom.ffwll.local>
Message-ID: <20150213050112.GA18793@victor>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 10:26:42AM +0100, Daniel Vetter wrote:
> On Thu, Feb 12, 2015 at 02:01:32PM +0800, Liu Ying wrote:
> > Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> > ---
> > v8->v9:
> >  * Rebase onto the imx-drm/next branch of Philipp Zabel's open git repository.
> > 
> > v7->v8:
> >  * None.
> > 
> > v6->v7:
> >  * None.
> > 
> > v5->v6:
> >  * Address the over 80 characters in one line warning reported by the
> >    checkpatch.pl script.
> > 
> > v4->v5:
> >  * None.
> > 
> > v3->v4:
> >  * None.
> > 
> > v2->v3:
> >  * None.
> > 
> > v1->v2:
> >  * Thierry Reding suggested that the mipi_dsi_pixel_format_to_bpp() function
> >    could be placed at the common DRM MIPI DSI driver.
> >    This patch is newly added.
> > 
> >  include/drm/drm_mipi_dsi.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> > index f1d8d0d..3662021 100644
> > --- a/include/drm/drm_mipi_dsi.h
> > +++ b/include/drm/drm_mipi_dsi.h
> > @@ -163,6 +163,20 @@ static inline struct mipi_dsi_device *to_mipi_dsi_device(struct device *dev)
> >  	return container_of(dev, struct mipi_dsi_device, dev);
> >  }
> >  
> > +static inline int mipi_dsi_pixel_format_to_bpp(enum mipi_dsi_pixel_format fmt)
> 
> Kerneldoc seems to be missing for this one.

I'll add it.  Thanks for pointing out this.

Regards,
Liu Ying

> -Daniel
> 
> > +{
> > +	switch (fmt) {
> > +	case MIPI_DSI_FMT_RGB888:
> > +	case MIPI_DSI_FMT_RGB666:
> > +		return 24;
> > +	case MIPI_DSI_FMT_RGB666_PACKED:
> > +		return 18;
> > +	case MIPI_DSI_FMT_RGB565:
> > +		return 16;
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> >  struct mipi_dsi_device *of_find_mipi_dsi_device_by_node(struct device_node *np);
> >  int mipi_dsi_attach(struct mipi_dsi_device *dsi);
> >  int mipi_dsi_detach(struct mipi_dsi_device *dsi);
> > -- 
> > 2.1.0
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel at lists.freedesktop.org
> > http://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
