From: inki.dae@samsung.com (Inki Dae)
Date: Mon, 19 Jun 2017 11:03:32 +0900
Subject: [PATCH] drm: exynos: dsi: fix to return -ENODEV when
 DSI_PORT_OUT is not found
In-Reply-To: <20170616225659.23569-1-shuahkh@osg.samsung.com>
References: <CGME20170616225706epcas4p44502071f08fc1e097cbbedce05b7106b@epcas4p4.samsung.com>
 <20170616225659.23569-1-shuahkh@osg.samsung.com>
Message-ID: <594730F4.6060507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shuah,

2017? 06? 17? 07:56? Shuah Khan ?(?) ? ?:
> Fix exynos_dsi_parse_dt() to return -ENODEV when of_graph_get_remote_node()
> doesn't find DSI_PORT_OUT. -ENODEV is the correct error code to return and
> this change makes exynos behavior consistent with rest of the drm drivers.

For this, there is one relevant patch below,
https://patchwork.kernel.org/patch/9785517/

In case of Exynos SoC, bridge node is required optionally - one bridge device such as mDNIe or MIC could be placed between FIMD and MIPI-DSI devices but this pipeline is configurable - user can decide Display hardware pipeline by setting the sysreg register.
So no error should be returned.

Thanks,
Inki Dae

> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index e337cd2..cb99e82 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1652,7 +1652,7 @@ static int exynos_dsi_parse_dt(struct exynos_dsi *dsi)
>  
>  	dsi->bridge_node = of_graph_get_remote_node(node, DSI_PORT_OUT, 0);
>  	if (!dsi->bridge_node)
> -		return -EINVAL;
> +		return -ENODEV;
>  
>  	return 0;
>  }
> 
