From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 26 Jun 2017 09:02:35 +0200
Subject: [PATCH] drm: exynos: dsi: release DSI_PORT_OUT node right after
 of_drm_find_bridge()
In-Reply-To: <20170624005628.5896-1-shuahkh@osg.samsung.com>
References: <CGME20170626004946epcas4p40785020666ae6d43476822d067604baa@epcas4p4.samsung.com>
 <20170624005628.5896-1-shuahkh@osg.samsung.com>
Message-ID: <5d308e03-e92a-7bac-f65e-23c2ccbe161a@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shuah,


On 24.06.2017 02:56, Shuah Khan wrote:
> Fix to call of_node_put() right after of_drm_find_bridge() instead of
> holding on to it until exynos_dsi_remove().

I think the current implementation is OK, node is get in probe and put
in remove.
There could be many bind/unbind during lifetime of the bound driver.
For example, there is possible sequence:
1. probe -
2. bind
3. unbind
4. bind

With this patch on 2nd bind (point 4) driver will call
of_drm_find_bridge on dsi->bridge_node which was put earlier (point 2.).

Regards
Andrzej


>
> Suggested-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index e337cd2..7513b88 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1689,6 +1689,7 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
>  
>  	if (dsi->bridge_node) {
>  		bridge = of_drm_find_bridge(dsi->bridge_node);
> +		of_node_put(dsi->bridge_node);
>  		if (bridge)
>  			drm_bridge_attach(encoder, bridge, NULL);
>  	}
> @@ -1807,10 +1808,6 @@ static int exynos_dsi_probe(struct platform_device *pdev)
>  
>  static int exynos_dsi_remove(struct platform_device *pdev)
>  {
> -	struct exynos_dsi *dsi = platform_get_drvdata(pdev);
> -
> -	of_node_put(dsi->bridge_node);
> -
>  	pm_runtime_disable(&pdev->dev);
>  
>  	component_del(&pdev->dev, &exynos_dsi_component_ops);
