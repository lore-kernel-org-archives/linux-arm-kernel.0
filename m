From: ck.hu@mediatek.com (CK Hu)
Date: Tue, 23 May 2017 17:33:04 +0800
Subject: [PATCH v3] drm/mediatek: Support UYVY and YUYV format for overlay
In-Reply-To: <1485232858-40418-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1485232858-40418-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1495531984.20811.21.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bibby:

I've applied this patch to my branch mediatek-drm-next-4.13, thanks.

Regards,
CK

On Tue, 2017-01-24 at 12:40 +0800, Bibby Hsieh wrote:
> MT8173 overlay can support UYVY and YUYV format,
> we add the format in DRM driver.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c  | 7 +++++++
>  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 2 ++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index c703102..53f2001 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -40,10 +40,13 @@
>  #define	OVL_RDMA_MEM_GMC	0x40402020
>  
>  #define OVL_CON_BYTE_SWAP	BIT(24)
> +#define OVL_CON_MTX_YUV_TO_RGB	(6 << 16)
>  #define OVL_CON_CLRFMT_RGB565	(0 << 12)
>  #define OVL_CON_CLRFMT_RGB888	(1 << 12)
>  #define OVL_CON_CLRFMT_RGBA8888	(2 << 12)
>  #define OVL_CON_CLRFMT_ARGB8888	(3 << 12)
> +#define OVL_CON_CLRFMT_UYVY	(4 << 12)
> +#define OVL_CON_CLRFMT_YUYV	(5 << 12)
>  #define	OVL_CON_AEN		BIT(8)
>  #define	OVL_CON_ALPHA		0xff
>  
> @@ -162,6 +165,10 @@ static unsigned int ovl_fmt_convert(unsigned int fmt)
>  	case DRM_FORMAT_XBGR8888:
>  	case DRM_FORMAT_ABGR8888:
>  		return OVL_CON_CLRFMT_RGBA8888 | OVL_CON_BYTE_SWAP;
> +	case DRM_FORMAT_UYVY:
> +		return OVL_CON_CLRFMT_UYVY | OVL_CON_MTX_YUV_TO_RGB;
> +	case DRM_FORMAT_YUYV:
> +		return OVL_CON_CLRFMT_YUYV | OVL_CON_MTX_YUV_TO_RGB;
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> index c461a23..8c02d1d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> @@ -28,6 +28,8 @@
>  	DRM_FORMAT_XRGB8888,
>  	DRM_FORMAT_ARGB8888,
>  	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_UYVY,
> +	DRM_FORMAT_YUYV,
>  };
>  
>  static void mtk_plane_reset(struct drm_plane *plane)
