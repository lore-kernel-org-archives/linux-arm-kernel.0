From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 16 Jan 2017 09:09:36 +0800
Subject: [PATCH v11 02/12] drm/mediatek: add helpers for coverting from
 the generic components
In-Reply-To: <1484117473-46644-3-git-send-email-yt.shen@mediatek.com>
References: <1484117473-46644-1-git-send-email-yt.shen@mediatek.com>
 <1484117473-46644-3-git-send-email-yt.shen@mediatek.com>
Message-ID: <1484528976.11503.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-01-11 at 14:51 +0800, YT Shen wrote:
> define helpers for converting from 'mtk_ddp_comp' to 'mtk_disp_ovl'
> define helpers for converting from 'mtk_ddp_comp' to 'mtk_disp_rdma'
> 
> Signed-off-by: YT Shen <yt.shen@mediatek.com>

Acked-by CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c  | 15 +++++++++------
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 15 +++++++++------
>  2 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index c703102..ce2759f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -57,6 +57,11 @@ struct mtk_disp_ovl {
>  	struct drm_crtc			*crtc;
>  };
>  
> +static inline struct mtk_disp_ovl *comp_to_ovl(struct mtk_ddp_comp *comp)
> +{
> +	return container_of(comp, struct mtk_disp_ovl, ddp_comp);
> +}
> +
>  static irqreturn_t mtk_disp_ovl_irq_handler(int irq, void *dev_id)
>  {
>  	struct mtk_disp_ovl *priv = dev_id;
> @@ -76,20 +81,18 @@ static irqreturn_t mtk_disp_ovl_irq_handler(int irq, void *dev_id)
>  static void mtk_ovl_enable_vblank(struct mtk_ddp_comp *comp,
>  				  struct drm_crtc *crtc)
>  {
> -	struct mtk_disp_ovl *priv = container_of(comp, struct mtk_disp_ovl,
> -						 ddp_comp);
> +	struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
>  
> -	priv->crtc = crtc;
> +	ovl->crtc = crtc;
>  	writel(0x0, comp->regs + DISP_REG_OVL_INTSTA);
>  	writel_relaxed(OVL_FME_CPL_INT, comp->regs + DISP_REG_OVL_INTEN);
>  }
>  
>  static void mtk_ovl_disable_vblank(struct mtk_ddp_comp *comp)
>  {
> -	struct mtk_disp_ovl *priv = container_of(comp, struct mtk_disp_ovl,
> -						 ddp_comp);
> +	struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
>  
> -	priv->crtc = NULL;
> +	ovl->crtc = NULL;
>  	writel_relaxed(0x0, comp->regs + DISP_REG_OVL_INTEN);
>  }
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index 0df05f9..21eff6f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -49,6 +49,11 @@ struct mtk_disp_rdma {
>  	struct drm_crtc			*crtc;
>  };
>  
> +static inline struct mtk_disp_rdma *comp_to_rdma(struct mtk_ddp_comp *comp)
> +{
> +	return container_of(comp, struct mtk_disp_rdma, ddp_comp);
> +}
> +
>  static irqreturn_t mtk_disp_rdma_irq_handler(int irq, void *dev_id)
>  {
>  	struct mtk_disp_rdma *priv = dev_id;
> @@ -77,20 +82,18 @@ static void rdma_update_bits(struct mtk_ddp_comp *comp, unsigned int reg,
>  static void mtk_rdma_enable_vblank(struct mtk_ddp_comp *comp,
>  				   struct drm_crtc *crtc)
>  {
> -	struct mtk_disp_rdma *priv = container_of(comp, struct mtk_disp_rdma,
> -						  ddp_comp);
> +	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
>  
> -	priv->crtc = crtc;
> +	rdma->crtc = crtc;
>  	rdma_update_bits(comp, DISP_REG_RDMA_INT_ENABLE, RDMA_FRAME_END_INT,
>  			 RDMA_FRAME_END_INT);
>  }
>  
>  static void mtk_rdma_disable_vblank(struct mtk_ddp_comp *comp)
>  {
> -	struct mtk_disp_rdma *priv = container_of(comp, struct mtk_disp_rdma,
> -						  ddp_comp);
> +	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
>  
> -	priv->crtc = NULL;
> +	rdma->crtc = NULL;
>  	rdma_update_bits(comp, DISP_REG_RDMA_INT_ENABLE, RDMA_FRAME_END_INT, 0);
>  }
>  
