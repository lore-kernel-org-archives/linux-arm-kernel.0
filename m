From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 12 Apr 2018 11:54:00 +0200
Subject: [PATCH v6 23/30] drm/rockchip: analogix_dp: Do not call
 Analogix code before bind
In-Reply-To: <20180405095000.9756-24-enric.balletbo@collabora.com>
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
 <CGME20180405095337epcas3p1a8750649c8032d844991db91595da8e5@epcas3p1.samsung.com>
 <20180405095000.9756-24-enric.balletbo@collabora.com>
Message-ID: <2fde5d53-0e8d-6a15-7962-0e76532d0926@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.04.2018 11:49, Enric Balletbo i Serra wrote:
> From: Tomasz Figa <tfiga@chromium.org>
>
> Driver callbacks, such as system suspend or resume can be called any
> time, specifically they can be called before the component bind
> callback. Let's use dp->adp pointer as a safeguard and skip calling
> Analogix entry points if it is an ERR_PTR().

>From purity PoV I would store either 0 either valid pointer in dp->adp,
but functionally it should be the same.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

?--
Regards
Andrzej


>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 23317a2269e1..6d45d62466b3 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -368,6 +368,8 @@ static void rockchip_dp_unbind(struct device *dev, struct device *master,
>  	analogix_dp_unbind(dp->adp);
>  	rockchip_drm_psr_unregister(&dp->encoder);
>  	dp->encoder.funcs->destroy(&dp->encoder);
> +
> +	dp->adp = ERR_PTR(-ENODEV);
>  }
>  
>  static const struct component_ops rockchip_dp_component_ops = {
> @@ -391,6 +393,7 @@ static int rockchip_dp_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	dp->dev = dev;
> +	dp->adp = ERR_PTR(-ENODEV);
>  	dp->plat_data.panel = panel;
>  
>  	ret = rockchip_dp_of_probe(dp);
> @@ -414,6 +417,9 @@ static int rockchip_dp_suspend(struct device *dev)
>  {
>  	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
>  
> +	if (IS_ERR(dp->adp))
> +		return 0;
> +
>  	return analogix_dp_suspend(dp->adp);
>  }
>  
> @@ -421,6 +427,9 @@ static int rockchip_dp_resume(struct device *dev)
>  {
>  	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
>  
> +	if (IS_ERR(dp->adp))
> +		return 0;
> +
>  	return analogix_dp_resume(dp->adp);
>  }
>  #endif
