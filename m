From: ck.hu@mediatek.com (CK Hu)
Date: Thu, 6 Sep 2018 13:36:22 +0800
Subject: [PATCH v2 08/13] drm/mediatek: register hdmi codec more earlier
In-Reply-To: <20180905083146.14727-9-bibby.hsieh@mediatek.com>
References: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
 <20180905083146.14727-9-bibby.hsieh@mediatek.com>
Message-ID: <1536212182.4618.36.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bibby:

On Wed, 2018-09-05 at 16:31 +0800, Bibby Hsieh wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> sometimes hdmi reprobe due to encoder probe late,
> but audio dai probe earlier than hdmi. it would make
> audio dai cannot find the hdmi codec. we need to
> register hdmi codec earlier, and the base name which
> used in the register should be PLATFORM_DEVID_NONE,
> otherwise some audio dai dirver could not match it.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index 7c022f3f53ec..2cb33098ec1a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1669,15 +1669,14 @@ static void mtk_hdmi_register_audio_driver(struct device *dev)
>  		.max_i2s_channels = 2,
>  		.i2s = 1,
>  	};
> -	struct platform_device *pdev;
> +	static struct platform_device *pdev;
>  
> -	pdev = platform_device_register_data(dev, HDMI_CODEC_DRV_NAME,
> -					     PLATFORM_DEVID_AUTO, &codec_data,
> -					     sizeof(codec_data));
> -	if (IS_ERR(pdev))
> +	if (!pdev) {
> +		pdev = platform_device_register_data(dev, HDMI_CODEC_DRV_NAME,
> +						     PLATFORM_DEVID_NONE,
> +						     &codec_data,
> +						     sizeof(codec_data));
> +		DRM_INFO("%s driver bound to HDMI\n", HDMI_CODEC_DRV_NAME);
> +	}

In the original code, it only register device but not unregister device.
This looks like a bug in hdmi driver. So we need to register and
unregister. You define a 'static' variable here would make
register/unregister asymmetric. And how do you make sure that hdmi
driver is probed before audio dai driver? By the device tree order?
Device tree older may vary for each SoC. I would like more general
solution to make sure that hdmi driver is probed before audio dai
driver. There are some method to make drivers probe in order, so try to
use the better method.

Regards,
CK

>  		return;
> -
> -	DRM_INFO("%s driver bound to HDMI\n", HDMI_CODEC_DRV_NAME);
>  }
>  
>  static int mtk_drm_hdmi_probe(struct platform_device *pdev)
> @@ -1691,6 +1690,7 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	hdmi->dev = dev;
> +	mtk_hdmi_register_audio_driver(dev);
>  
>  	ret = mtk_hdmi_dt_parse_pdata(hdmi, pdev);
>  	if (ret)
> @@ -1704,8 +1704,6 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	mtk_hdmi_register_audio_driver(dev);
> -
>  	hdmi->bridge.funcs = &mtk_hdmi_bridge_funcs;
>  	hdmi->bridge.of_node = pdev->dev.of_node;
>  	drm_bridge_add(&hdmi->bridge);
