From: ville.syrjala@linux.intel.com (Ville =?iso-8859-1?Q?Syrj=E4l=E4?=)
Date: Thu, 11 Aug 2016 10:44:10 +0300
Subject: [PATCH v4 3/4] drm/mediatek: Add gamma correction.
In-Reply-To: <1470900779.2493.20.camel@pengutronix.de>
References: <1469672575-5847-1-git-send-email-bibby.hsieh@mediatek.com>
 <1469672575-5847-4-git-send-email-bibby.hsieh@mediatek.com>
 <1470900779.2493.20.camel@pengutronix.de>
Message-ID: <20160811074410.GF4329@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2016 at 09:32:59AM +0200, Philipp Zabel wrote:
> Am Donnerstag, den 28.07.2016, 10:22 +0800 schrieb Bibby Hsieh:
> > Add gamma set function to correct brightness values.
> > It applies arbitrary mapping curve to compensate the
> > incorrect transfer function of the panel.
> > 
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |    8 ++++++-
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |    1 +
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   31 +++++++++++++++++++++++++++
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   10 +++++++++
> >  4 files changed, 49 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > index 24aa3ba..cbb460a5 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -409,6 +409,9 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
> >  	}
> >  	if (pending_planes)
> >  		mtk_crtc->pending_planes = true;
> > +	if (crtc->state->color_mgmt_changed)
> > +		for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
> > +			mtk_ddp_gamma_set(mtk_crtc->ddp_comp[i], crtc->state);
> >  }
> >  
> >  static const struct drm_crtc_funcs mtk_crtc_funcs = {
> > @@ -418,6 +421,7 @@ static const struct drm_crtc_funcs mtk_crtc_funcs = {
> >  	.reset			= mtk_drm_crtc_reset,
> >  	.atomic_duplicate_state	= mtk_drm_crtc_duplicate_state,
> >  	.atomic_destroy_state	= mtk_drm_crtc_destroy_state,
> > +	.gamma_set		= drm_atomic_helper_legacy_gamma_set,
> >  };
> >  
> >  static const struct drm_crtc_helper_funcs mtk_crtc_helper_funcs = {
> > @@ -568,7 +572,9 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
> >  				&mtk_crtc->planes[1].base, pipe);
> >  	if (ret < 0)
> >  		goto unprepare;
> > -
> > +	drm_mode_crtc_set_gamma_size(&mtk_crtc->base, MTK_LUT_SIZE);
> > +	drm_helper_crtc_enable_color_mgmt(&mtk_crtc->base, MTK_LUT_SIZE,
> > +					  MTK_LUT_SIZE);
> 
> I have applied all four patches and rebased onto v4.8-rc1, replacing
> drm_helper_crtc_enable_color_mgmt with:
> 
> 	drm_crtc_enable_color_mgmt(&mtk_crtc->base, MTK_LUT_SIZE,
> 				   true, MTK_LUT_SIZE);

BTW that looks wrong (already in the original). AFAICS the patch just
handled the gamma_lut, not the degamma_lut, so telling you have both
is not right.

> 
> (See https://patchwork.kernel.org/patch/9160987/)
> 
> regards
> Philipp
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrj?l?
Intel OTC
