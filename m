From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 13 Jun 2018 14:44:02 +0800
Subject: [PATCH 15/28] drm/mediatek: add connection from RDMA1 to DSI1
In-Reply-To: <1528687580-549-16-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
 <1528687580-549-16-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1528872242.27532.0.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> This patch add the connection from RDMA1 to DSI1
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 4abd5dabeccf..7e4ad5580cf6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -28,6 +28,7 @@
>  #define DISP_REG_CONFIG_DISP_UFOE_MOUT_EN	0x050
>  #define DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x084
>  #define DISP_REG_CONFIG_DISP_COLOR1_SEL_IN	0x088
> +#define DISP_REG_CONFIG_DSIO_SEL_IN		0x0a8
>  #define DISP_REG_CONFIG_DPI_SEL_IN		0x0ac
>  #define DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN	0x0c4
>  #define DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN	0x0c8
> @@ -84,10 +85,12 @@
>  #define RDMA0_MOUT_DPI0			0x2
>  #define RDMA0_MOUT_DSI2			0x4
>  #define RDMA0_MOUT_DSI3			0x5
> +#define RDMA1_MOUT_DSI1			0x1
>  #define RDMA1_MOUT_DPI0			0x2
>  #define RDMA1_MOUT_DPI1			0x3
>  #define DPI0_SEL_IN_RDMA1		0x1
>  #define DPI1_SEL_IN_RDMA1		(0x1 << 8)
> +#define DSI1_SEL_IN_RDMA1		0x1
>  #define COLOR1_SEL_IN_OVL1		0x1
>  
>  #define OVL_MOUT_EN_RDMA		0x1
> @@ -170,6 +173,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI3) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN;
>  		value = RDMA0_MOUT_DSI3;
> +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
> +		value = RDMA1_MOUT_DSI1;
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
>  		value = RDMA1_MOUT_DPI0;
> @@ -198,6 +204,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
>  		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
>  		value = DPI1_SEL_IN_RDMA1;
> +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
> +		*addr = DISP_REG_CONFIG_DSIO_SEL_IN;

Does data sheet use the naming 'DSI0'? You use this register to select
DSI1 input.

Regards,
CK

> +		value = DSI1_SEL_IN_RDMA1;
>  	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
>  		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
>  		value = COLOR1_SEL_IN_OVL1;
