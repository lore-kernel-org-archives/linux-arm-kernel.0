From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Thu, 2 Aug 2018 19:45:14 +0800
Subject: [PATCH v1 11/15] drm/mediatek: add dummy buffer for RDMA memory
 mode
In-Reply-To: <1532497379.9280.32.camel@mtksdaap41>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
 <1532420235-22268-12-git-send-email-stu.hsieh@mediatek.com>
 <1532497379.9280.32.camel@mtksdaap41>
Message-ID: <1533210314.11190.69.camel@mtksdccf07>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, CK:

On Wed, 2018-07-25 at 13:42 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Tue, 2018-07-24 at 16:17 +0800, Stu Hsieh wrote:
> > This patch add dummy buffer for RDMA memory mode
> > 
> > When display power on, the drm frame work would modeset and
> > set up the display HW.
> > 
> > In this time, the RDMA would start wroking and read the data from memory.
> > But, user space not send the data to drm yet.
> > 
> > For this case, if user space not send data to display hw(RDMA) yet,
> > RDMA would read the wrong address to show garbage.
> > 
> > Therefore, we create dummy buffer for RDMA reading memory
> > when userspace not send the data yet.
> > 
> 
> Is this the only solution? If panel resolution is 1920x1080, the buffer
> size is 8294400 bytes. How large it is. If we have another solution,
> I'll not accept this one. As far as I know, DSI or DPI could output
> single color even though there is no input data. If this is true, when
> encoder is enabled, it output the single color. When crtc enable, config
> all setting except 'start'. When receive the buffer, 'start' the
> pipeline which include encoder. When encoder 'start', it disable the
> single color function and output the data from input.
> 
> Regards,
> CK
> 

I would remove dummy_buffer patch.
Your idea "use encoder black pattern before the first buffer coming" can
work.
But it need also move "rdma memory mode setting" to layer_config.
Therefore, when cmdq patch accepted, I will commit another patch set to
fix the garbage output to panel.

> 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 23 +++++++++++++++++++++++
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 +
> >  2 files changed, 24 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > index 8d41f5cd485b..e28f368728cd 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > @@ -20,6 +20,7 @@
> >  
> >  #include "mtk_drm_crtc.h"
> >  #include "mtk_drm_ddp_comp.h"
> > +#include "mtk_drm_gem.h"
> >  
> >  #define DISP_REG_RDMA_INT_ENABLE		0x0000
> >  #define DISP_REG_RDMA_INT_STATUS		0x0004
> > @@ -59,6 +60,9 @@
> >  #define MEM_MODE_INPUT_FORMAT_UYVY		(0x004 << 4)
> >  #define MEM_MODE_INPUT_FORMAT_YUYV		(0x005 << 4)
> >  
> > +#define RDMA_DUMMY_BUFFER_SIZE(h, v)		((h) * (v) * 4)
> > +#define RDMA_DUMMY_BUFFER_PITCH(h)		((h) * 4)
> > +
> >  struct mtk_disp_rdma_data {
> >  	unsigned int fifo_size;
> >  };
> > @@ -74,6 +78,7 @@ struct mtk_disp_rdma {
> >  	const struct mtk_disp_rdma_data	*data;
> >  	struct drm_device *drm_dev;
> >  	bool rdma_memory_mode;
> > +	unsigned int dummy_size;
> >  };
> >  
> >  static inline struct mtk_disp_rdma *comp_to_rdma(struct mtk_ddp_comp *comp)
> > @@ -126,14 +131,29 @@ static void mtk_rdma_disable_vblank(struct mtk_ddp_comp *comp)
> >  
> >  static void mtk_rdma_start(struct mtk_ddp_comp *comp)
> >  {
> > +	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
> > +	bool *rdma_memory_mode = comp->comp_mode;
> > +
> > +	if (*rdma_memory_mode == true) {
> > +		comp->mtk_gem = mtk_drm_gem_create(rdma->drm_dev,
> > +						   rdma->dummy_size, false);
> > +		writel(comp->mtk_gem->dma_addr & 0xFFFFFFFF,
> > +		       comp->regs + DISP_RDMA_MEM_START_ADDR);
> > +	}
> > +
> >  	rdma_update_bits(comp, DISP_REG_RDMA_GLOBAL_CON, RDMA_ENGINE_EN,
> >  			 RDMA_ENGINE_EN);
> >  }
> >  
> >  static void mtk_rdma_stop(struct mtk_ddp_comp *comp)
> >  {
> > +	bool *rdma_memory_mode = comp->comp_mode;
> > +
> >  	writel(RDMA_SOFT_RESET, comp->regs + DISP_REG_RDMA_GLOBAL_CON);
> >  	writel(0, comp->regs + DISP_REG_RDMA_GLOBAL_CON);
> > +
> > +	if (*rdma_memory_mode == true)
> > +		mtk_drm_gem_free_object(&comp->mtk_gem->base);
> >  }
> >  
> >  static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
> > @@ -149,8 +169,11 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
> >  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_1, 0xfffff, height);
> >  
> >  	if (*rdma_memory_mode == true) {
> > +		rdma->dummy_size = RDMA_DUMMY_BUFFER_SIZE(width, height);
> >  		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xff0000,
> >  				 MATRIX_INT_MTX_SEL_DEFAULT);
> > +		writel(RDMA_DUMMY_BUFFER_PITCH(width),
> > +		       comp->regs + DISP_RDMA_MEM_SRC_PITCH);
> >  		rdma_update_bits(comp, DISP_REG_RDMA_GLOBAL_CON,
> >  				 RDMA_MODE_MEMORY, RDMA_MODE_MEMORY);
> >  	}
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > index a1988ce15141..6dbb83144a74 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > @@ -92,6 +92,7 @@ struct mtk_ddp_comp {
> >  	int irq;
> >  	struct device *larb_dev;
> >  	enum mtk_ddp_comp_id id;
> > +	struct mtk_drm_gem_obj *mtk_gem;
> >  	const struct mtk_ddp_comp_funcs *funcs;
> >  	void *comp_mode;
> >  };
> 
> 
