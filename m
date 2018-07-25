From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 25 Jul 2018 11:02:50 +0800
Subject: [PATCH v1 12/15] drm/mediatek: add layer number condition for
 RDMA to control plane
In-Reply-To: <1532420235-22268-13-git-send-email-stu.hsieh@mediatek.com>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
 <1532420235-22268-13-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1532487770.9280.17.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Tue, 2018-07-24 at 16:17 +0800, Stu Hsieh wrote:
> This patch add layer number condition for RDMA to control plane
> 
> When plane init in crtc create,
> it use the number of OVL layer to init plane.
> That's OVL can read 4 memory address.
> 
> For mt2712 third ddp, it use RDMA to read memory.
> RDMA can read 1 memory address, so it just init one plane.
> 
> For compatibility, this patch use two define OVL_LAYER_NR and
> RDMA_LAYER_NR to distingush two difference HW engine.
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 25 +++++++++++++++++--------
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.h |  2 ++
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 

[...]

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> index 9d9410c67ae9..b44fefadf14a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> @@ -18,7 +18,9 @@
>  #include "mtk_drm_ddp_comp.h"
>  #include "mtk_drm_plane.h"
>  
> +#define MAX_LAYER_NR	4
>  #define OVL_LAYER_NR	4
> +#define RDMA_LAYER_NR	1
>  #define MTK_LUT_SIZE	512
>  #define MTK_MAX_BPC	10
>  #define MTK_MIN_BPC	3

If the layer number is not fixed in '4', I would like to get this value
from component because in some SoC, OVL may have 6 layer. So add an
interface to get the max layer number and OVL, RDMA driver would return
the number for this SoC.

Regards,
CK
