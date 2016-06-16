From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 16 Jun 2016 11:04:33 +0800
Subject: [PATCH 1/2] drm/mediatek: Add gamma correction
In-Reply-To: <20160614054322.GL1338@phenom.ffwll.local>
References: <1465872953-47706-1-git-send-email-bibby.hsieh@mediatek.com>
 <20160614054322.GL1338@phenom.ffwll.local>
Message-ID: <1466046273.9460.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Daniel, 

Thank you for your suggestion, I will modify that to use the atomic
color management.

Bibby

On Tue, 2016-06-14 at 07:43 +0200, Daniel Vetter wrote:
> On Tue, Jun 14, 2016 at 10:55:52AM +0800, Bibby Hsieh wrote:
> > Apply gamma function to correct brightness values.
> > It applies arbitrary mapping curve to compensate the
> > incorrect transfer function of the panel.
> > 
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> 
> I think it would be much better to use the new atomic color management
> support, which includes gamma. See drm_crtc_enable_color_mgmt.
> -Daniel
> 
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |   12 ++++++
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |    1 +
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   56 ++++++++++++++++++++++++++-
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |    9 +++++
> >  4 files changed, 77 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > index 24aa3ba..1b38406 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -127,6 +127,16 @@ static void mtk_drm_crtc_reset(struct drm_crtc *crtc)
> >  	state->base.crtc = crtc;
> >  }
> >  
> > +static void mtk_crtc_gamma_set(struct drm_crtc *crtc, u16 *r,
> > +			       u16 *g, u16 *b, uint32_t start, uint32_t size)
> > +{
> > +	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
> > +		mtk_ddp_gamma_set(mtk_crtc->ddp_comp[i], r, g, b, start, size);
> > +}
> > +
> >  static struct drm_crtc_state *mtk_drm_crtc_duplicate_state(struct drm_crtc *crtc)
> >  {
> >  	struct mtk_crtc_state *state;
> > @@ -418,6 +428,7 @@ static const struct drm_crtc_funcs mtk_crtc_funcs = {
> >  	.reset			= mtk_drm_crtc_reset,
> >  	.atomic_duplicate_state	= mtk_drm_crtc_duplicate_state,
> >  	.atomic_destroy_state	= mtk_drm_crtc_destroy_state,
> > +	.gamma_set		= mtk_crtc_gamma_set,
> >  };
> >  
> >  static const struct drm_crtc_helper_funcs mtk_crtc_helper_funcs = {
> > @@ -569,6 +580,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
> >  	if (ret < 0)
> >  		goto unprepare;
> >  
> > +	drm_mode_crtc_set_gamma_size(&mtk_crtc->base, MTK_LUT_SIZE);
> >  	priv->crtc[pipe] = &mtk_crtc->base;
> >  	priv->num_pipes++;
> >  
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> > index 81e5566..d332564 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> > @@ -19,6 +19,7 @@
> >  #include "mtk_drm_plane.h"
> >  
> >  #define OVL_LAYER_NR	4
> > +#define MTK_LUT_SIZE	512
> >  
> >  int mtk_drm_crtc_enable_vblank(struct drm_device *drm, unsigned int pipe);
> >  void mtk_drm_crtc_disable_vblank(struct drm_device *drm, unsigned int pipe);
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > index 3970fcf..3fd5141 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > @@ -24,6 +24,7 @@
> >  #include "mtk_drm_drv.h"
> >  #include "mtk_drm_plane.h"
> >  #include "mtk_drm_ddp_comp.h"
> > +#include "mtk_drm_crtc.h"
> >  
> >  #define DISP_OD_EN				0x0000
> >  #define DISP_OD_INTEN				0x0008
> > @@ -38,6 +39,18 @@
> >  #define DISP_COLOR_WIDTH			0x0c50
> >  #define DISP_COLOR_HEIGHT			0x0c54
> >  
> > +#define DISP_AAL_EN				0x000
> > +#define DISP_AAL_SIZE				0x030
> > +
> > +#define DISP_GAMMA_CFG				0x020
> > +#define DISP_GAMMA_LUT				0x700
> > +
> > +#define LUT_10BIT_MASK				0x3ff
> > +
> > +#define AAL_EN			BIT(0)
> > +
> > +#define GAMMA_LUT_EN		BIT(1)
> > +
> >  #define	OD_RELAY_MODE		BIT(0)
> >  
> >  #define	UFO_BYPASS		BIT(2)
> > @@ -76,6 +89,40 @@ static void mtk_ufoe_start(struct mtk_ddp_comp *comp)
> >  	writel(UFO_BYPASS, comp->regs + DISP_REG_UFO_START);
> >  }
> >  
> > +static void mtk_aal_config(struct mtk_ddp_comp *comp, unsigned int w,
> > +			   unsigned int h, unsigned int vrefresh)
> > +{
> > +	writel(h << 16 | w, comp->regs + DISP_AAL_SIZE);
> > +}
> > +
> > +static void mtk_aal_start(struct mtk_ddp_comp *comp)
> > +{
> > +	writel(AAL_EN, comp->regs  + DISP_AAL_EN);
> > +}
> > +
> > +static void mtk_aal_stop(struct mtk_ddp_comp *comp)
> > +{
> > +	writel_relaxed(0x0, comp->regs  + DISP_AAL_EN);
> > +}
> > +
> > +static void mtk_gamma_set(struct mtk_ddp_comp *comp, u16 *r, u16 *g,
> > +			  u16 *b, uint32_t start, uint32_t size)
> > +{
> > +	int i;
> > +	unsigned int lut;
> > +	int end = (start + size > MTK_LUT_SIZE) ? MTK_LUT_SIZE : start + size;
> > +	void __iomem *lut_base;
> > +
> > +	writel(GAMMA_LUT_EN, comp->regs + DISP_GAMMA_CFG);
> > +	lut_base = comp->regs + DISP_GAMMA_LUT;
> > +	for (i = start; i < end; i++) {
> > +		lut = (((r[i] >> 6) & LUT_10BIT_MASK) << 20) +
> > +			(((g[i] >> 6) & LUT_10BIT_MASK) << 10) +
> > +			((b[i] >> 6) & LUT_10BIT_MASK);
> > +		writel(lut, (lut_base + i * 4));
> > +	}
> > +}
> > +
> >  static const struct mtk_ddp_comp_funcs ddp_color = {
> >  	.config = mtk_color_config,
> >  	.start = mtk_color_start,
> > @@ -90,6 +137,13 @@ static const struct mtk_ddp_comp_funcs ddp_ufoe = {
> >  	.start = mtk_ufoe_start,
> >  };
> >  
> > +static const struct mtk_ddp_comp_funcs ddp_aal = {
> > +	.gamma_set = mtk_gamma_set,
> > +	.config = mtk_aal_config,
> > +	.start = mtk_aal_start,
> > +	.stop = mtk_aal_stop,
> > +};
> > +
> >  static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
> >  	[MTK_DISP_OVL] = "ovl",
> >  	[MTK_DISP_RDMA] = "rdma",
> > @@ -112,7 +166,7 @@ struct mtk_ddp_comp_match {
> >  };
> >  
> >  static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
> > -	[DDP_COMPONENT_AAL]	= { MTK_DISP_AAL,	0, NULL },
> > +	[DDP_COMPONENT_AAL]	= { MTK_DISP_AAL,	0, &ddp_aal },
> >  	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, &ddp_color },
> >  	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, &ddp_color },
> >  	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > index 6b13ba9..0832179 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > @@ -73,6 +73,8 @@ struct mtk_ddp_comp_funcs {
> >  	void (*layer_off)(struct mtk_ddp_comp *comp, unsigned int idx);
> >  	void (*layer_config)(struct mtk_ddp_comp *comp, unsigned int idx,
> >  			     struct mtk_plane_state *state);
> > +	void (*gamma_set)(struct mtk_ddp_comp *comp, u16 *r, u16 *g, u16 *b,
> > +			  u32 start, u32 size);
> >  };
> >  
> >  struct mtk_ddp_comp {
> > @@ -139,6 +141,13 @@ static inline void mtk_ddp_comp_layer_config(struct mtk_ddp_comp *comp,
> >  		comp->funcs->layer_config(comp, idx, state);
> >  }
> >  
> > +static inline void mtk_ddp_gamma_set(struct mtk_ddp_comp *comp, u16 *r, u16 *g,
> > +				     u16 *b, uint32_t start, uint32_t size)
> > +{
> > +	if (comp->funcs && comp->funcs->gamma_set)
> > +		comp->funcs->gamma_set(comp, r, g, b, start, size);
> > +}
> > +
> >  int mtk_ddp_comp_get_id(struct device_node *node,
> >  			enum mtk_ddp_comp_type comp_type);
> >  int mtk_ddp_comp_init(struct device *dev, struct device_node *comp_node,
> > -- 
> > 1.7.9.5
> > 
> 
