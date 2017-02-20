From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 20 Feb 2017 09:40:24 +0800
Subject: [PATCH] drm/rockchip: cdn-dp: Fix error handling
In-Reply-To: <20170219165942.17268-1-christophe.jaillet@wanadoo.fr>
References: <20170219165942.17268-1-christophe.jaillet@wanadoo.fr>
Message-ID: <58AA4908.2000808@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?02?20? 00:59, Christophe JAILLET wrote:
> It is likely that both 'clk_disable_unprepare()' should be called if
> 'pm_runtime_get_sync()' fails.
>
> Add a new label for that, because 'err_set_rate' is not meaningful in this
> case.
>
>
> Fixes: 1a0f7ed3abe2 ("drm/rockchip: cdn-dp: add cdn DP support for rk3399")
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not sure but a 'pm_runtime_get_sync()' is maybe also required in the
> 'err_set_rate' path.
> ---
>   drivers/gpu/drm/rockchip/cdn-dp-core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> index 9ab67a670885..0fe1ec8b8fb1 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -111,7 +111,7 @@ static int cdn_dp_clk_enable(struct cdn_dp_device *dp)
>   	ret = pm_runtime_get_sync(dp->dev);
>   	if (ret < 0) {
>   		DRM_DEV_ERROR(dp->dev, "cannot get pm runtime %d\n", ret);
> -		goto err_pclk;
> +		goto err_sync;

I think the name err_pm_runtime_get is better.
err_sync is not a clear name for the pm_runtime_get_sync.

>   	}
>   
>   	reset_control_assert(dp->core_rst);
> @@ -133,6 +133,7 @@ static int cdn_dp_clk_enable(struct cdn_dp_device *dp)
>   	return 0;
>   
>   err_set_rate:
> +err_sync:

miss pm_runtime_put, it should be:

err_set_rate:
     pm_runtime_put(dp->dev);
err_pm_runtime_get:
     clk_disable_unprepare(dp->core_clk);
err_core_clk:

>   	clk_disable_unprepare(dp->core_clk);
>   err_core_clk:
>   	clk_disable_unprepare(dp->pclk);


-- 
?ark Yao
