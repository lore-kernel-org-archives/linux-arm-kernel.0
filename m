From: ck.hu@mediatek.com (CK Hu)
Date: Fri, 3 Aug 2018 15:30:12 +0800
Subject: [PATCH v1 06/15] drm/mediatek: add memory mode for RDMA
In-Reply-To: <1533209786.11190.60.camel@mtksdccf07>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
 <1532420235-22268-7-git-send-email-stu.hsieh@mediatek.com>
 <1532486454.9280.12.camel@mtksdaap41>
 <1533209786.11190.60.camel@mtksdccf07>
Message-ID: <1533281412.31144.23.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Thu, 2018-08-02 at 19:36 +0800, Stu Hsieh wrote:
> Hi, CK:
> 
> On Wed, 2018-07-25 at 10:40 +0800, CK Hu wrote:
> > Hi, Stu:
> > 
> > On Tue, 2018-07-24 at 16:17 +0800, Stu Hsieh wrote:
> > > This patch add memory mode for RDMA
> > > 
> > > If use RDMA to read data from memory, it should set memory mode to RDMA
> > > 
> > > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 16 +++++++++++++++-
> > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > > 
> > 
> > [...]
> > 
> > >  static inline struct mtk_disp_rdma *comp_to_rdma(struct mtk_ddp_comp *comp)
> > > @@ -111,7 +116,8 @@ static void mtk_rdma_start(struct mtk_ddp_comp *comp)
> > >  
> > >  static void mtk_rdma_stop(struct mtk_ddp_comp *comp)
> > >  {
> > > -	rdma_update_bits(comp, DISP_REG_RDMA_GLOBAL_CON, RDMA_ENGINE_EN, 0);
> > > +	writel(RDMA_SOFT_RESET, comp->regs + DISP_REG_RDMA_GLOBAL_CON);
> > > +	writel(0, comp->regs + DISP_REG_RDMA_GLOBAL_CON);
> > 
> > Without reset, what happen to dram mode? Why direct link mode need not
> > this reset?
> > 
> 
> There is nothing to happen, I would remove it.
> 
> > >  }
> > >  
> > >  static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
> > > @@ -121,10 +127,18 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
> > >  	unsigned int threshold;
> > >  	unsigned int reg;
> > >  	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
> > > +	bool *rdma_memory_mode = comp->comp_mode;
> > >  
> > >  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xfff, width);
> > >  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_1, 0xfffff, height);
> > >  
> > > +	if (*rdma_memory_mode == true) {
> > > +		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xff0000,
> > > +				 MATRIX_INT_MTX_SEL_DEFAULT);
> > > +		rdma_update_bits(comp, DISP_REG_RDMA_GLOBAL_CON,
> > > +				 RDMA_MODE_MEMORY, RDMA_MODE_MEMORY);
> > > +	}
> > > +
> > 
> > I would like this to be a kind of 'layer' config. In some SoC, one layer
> > of OVL could switch to direct link input or dram input. So I think it's
> > better to move this setting into some layer interface.
> > 
> > Regards,
> > CK
> > 
> 
> If move it to layer_config, RDMA would not trigger interrupt.
> In the future, when cmdq patch upstream and accepted, this part can move
> to layer_config. 

I don't know why interrupt would be influenced by moving this to layer
config? In mtk_crtc_ddp_hw_init(), call mtk_ddp_comp_config() first and
then call mtk_ddp_comp_layer_config() later. It's in almost the same
place.

Regards,
CK

> 
> Regard,
> Stu
> 
> > >  	/*
> > >  	 * Enable FIFO underflow since DSI and DPI can't be blocked.
> > >  	 * Keep the FIFO pseudo size reset default of 8 KiB. Set the
> > 
> > 
> 
> 
