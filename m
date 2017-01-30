From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 30 Jan 2017 09:51:53 -0300
Subject: [PATCH] Gpu: drm: exynos - Fix possible NULL derefrence.
In-Reply-To: <1485752523-30029-1-git-send-email-shailendra.v@samsung.com>
References: <CGME20170130050228epcas4p1b880b1ae599b7f7d6c60a4b0554a2162@epcas4p1.samsung.com>
 <1485752523-30029-1-git-send-email-shailendra.v@samsung.com>
Message-ID: <d57ee31f-493c-0f76-65f5-a60babd7b20c@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shailendra,

The subject line is wrong, please always use the convention used in
previous commits, i.e: git log --oneline drivers/gpu/drm/exynos/

On 01/30/2017 02:02 AM, Shailendra Verma wrote:
> of_device_get_match_data could return NULL, and so can cause
> a NULL pointer dereference later.
> 
> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c  |    4 ++++
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c |    4 ++++
>  drivers/gpu/drm/exynos/exynos_hdmi.c     |    4 ++++
>  drivers/gpu/drm/exynos/exynos_mixer.c    |    4 ++++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index e07cb1f..fba0ffc 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1765,6 +1765,10 @@ static int exynos_dsi_probe(struct platform_device *pdev)
>  
>  	dsi->dev = dev;
>  	dsi->driver_data = of_device_get_match_data(dev);
> +	if (!dsi->driver_data) {
> +		dev_err(dev, "no device match found\n");
> +		return -ENODEV;
> +	}
>

I don't think this makes sense for the Exynos driver since Exynos is a
DT-only platform and so the probe callback can only be called if a dev
node with a compatible string in the OF device id table was registered.

All the struct of_device_id in the table have a .data and so this can't
be NULL in this driver.
 
Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
