From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 23 Nov 2017 09:54:42 +0100
Subject: [PATCH 1/8] drm/mediatek: Use regmap for register access
In-Reply-To: <20171114214114.15793-2-mbrugger@suse.com>
References: <20171114214114.15793-1-mbrugger@suse.com>
 <20171114214114.15793-2-mbrugger@suse.com>
Message-ID: <1511427282.7685.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Tue, 2017-11-14 at 22:41 +0100, Matthias Brugger wrote:
> The mmsys memory space is shared between the drm and the
> clk driver. Use regmap to access it.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  4 ++--
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c  | 30 +++++++++++++++++-------------
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.h  |  4 ++--
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 13 ++++---------
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h  |  2 +-
>  5 files changed, 26 insertions(+), 27 deletions(-)
[...]
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 8130f3dab661..1227d6db07da 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -185,16 +185,16 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
>  	return value;
>  }
>  
> -static void mtk_ddp_sout_sel(void __iomem *config_regs,
> +static void mtk_ddp_sout_sel(struct regmap *config_regs,
>  			     enum mtk_ddp_comp_id cur,
>  			     enum mtk_ddp_comp_id next)
>  {
>  	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0)
> -		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
> -			       config_regs + DISP_REG_CONFIG_OUT_SEL);
> +		regmap_write(config_regs, DISP_REG_CONFIG_OUT_SEL,
> +				BLS_TO_DSI_RDMA1_TO_DPI1);
>  }
>  
> -void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
> +void mtk_ddp_add_comp_to_path(struct regmap *config_regs,
>  			      enum mtk_ddp_comp_id cur,
>  			      enum mtk_ddp_comp_id next)
>  {
> @@ -202,20 +202,22 @@ void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
>  
>  	value = mtk_ddp_mout_en(cur, next, &addr);
>  	if (value) {
> -		reg = readl_relaxed(config_regs + addr) | value;
> -		writel_relaxed(reg, config_regs + addr);
> +		regmap_read(config_regs, addr, &reg);
> +		reg |= value;
> +		regmap_write(config_regs, addr, reg);

You can use

		regmap_update_bits(config_regs, addr, value, value);

here and drop the local variable reg.

>  	}
>  
>  	mtk_ddp_sout_sel(config_regs, cur, next);
>  
>  	value = mtk_ddp_sel_in(cur, next, &addr);
>  	if (value) {
> -		reg = readl_relaxed(config_regs + addr) | value;
> -		writel_relaxed(reg, config_regs + addr);
> +		regmap_read(config_regs, addr, &reg);
> +		reg |= value;
> +		regmap_write(config_regs, addr, reg);

		regmap_update_bits(config_regs, addr, value, value);

>  	}
>  }
>  
> -void mtk_ddp_remove_comp_from_path(void __iomem *config_regs,
> +void mtk_ddp_remove_comp_from_path(struct regmap *config_regs,
>  				   enum mtk_ddp_comp_id cur,
>  				   enum mtk_ddp_comp_id next)
>  {
> @@ -223,14 +225,16 @@ void mtk_ddp_remove_comp_from_path(void __iomem *config_regs,
>  
>  	value = mtk_ddp_mout_en(cur, next, &addr);
>  	if (value) {
> -		reg = readl_relaxed(config_regs + addr) & ~value;
> -		writel_relaxed(reg, config_regs + addr);
> +		regmap_read(config_regs, addr, &reg);
> +		reg &= ~value;
> +		regmap_write(config_regs, addr, reg);

		regmap_update_bits(config_regs, addr, value, 0);

>  	}
>  
>  	value = mtk_ddp_sel_in(cur, next, &addr);
>  	if (value) {
> -		reg = readl_relaxed(config_regs + addr) & ~value;
> -		writel_relaxed(reg, config_regs + addr);
> +		regmap_read(config_regs, addr, &reg);
> +		reg &= ~value;
> +		regmap_write(config_regs, addr, reg);

		regmap_update_bits(config_regs, addr, value, 0);

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
