From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 25 Jul 2018 10:40:54 +0800
Subject: [PATCH v1 06/15] drm/mediatek: add memory mode for RDMA
In-Reply-To: <1532420235-22268-7-git-send-email-stu.hsieh@mediatek.com>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
 <1532420235-22268-7-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1532486454.9280.12.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Tue, 2018-07-24 at 16:17 +0800, Stu Hsieh wrote:
> This patch add memory mode for RDMA
> 
> If use RDMA to read data from memory, it should set memory mode to RDMA
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

[...]

>  static inline struct mtk_disp_rdma *comp_to_rdma(struct mtk_ddp_comp *comp)
> @@ -111,7 +116,8 @@ static void mtk_rdma_start(struct mtk_ddp_comp *comp)
>  
>  static void mtk_rdma_stop(struct mtk_ddp_comp *comp)
>  {
> -	rdma_update_bits(comp, DISP_REG_RDMA_GLOBAL_CON, RDMA_ENGINE_EN, 0);
> +	writel(RDMA_SOFT_RESET, comp->regs + DISP_REG_RDMA_GLOBAL_CON);
> +	writel(0, comp->regs + DISP_REG_RDMA_GLOBAL_CON);

Without reset, what happen to dram mode? Why direct link mode need not
this reset?

>  }
>  
>  static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
> @@ -121,10 +127,18 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
>  	unsigned int threshold;
>  	unsigned int reg;
>  	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
> +	bool *rdma_memory_mode = comp->comp_mode;
>  
>  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xfff, width);
>  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_1, 0xfffff, height);
>  
> +	if (*rdma_memory_mode == true) {
> +		rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xff0000,
> +				 MATRIX_INT_MTX_SEL_DEFAULT);
> +		rdma_update_bits(comp, DISP_REG_RDMA_GLOBAL_CON,
> +				 RDMA_MODE_MEMORY, RDMA_MODE_MEMORY);
> +	}
> +

I would like this to be a kind of 'layer' config. In some SoC, one layer
of OVL could switch to direct link input or dram input. So I think it's
better to move this setting into some layer interface.

Regards,
CK

>  	/*
>  	 * Enable FIFO underflow since DSI and DPI can't be blocked.
>  	 * Keep the FIFO pseudo size reset default of 8 KiB. Set the
