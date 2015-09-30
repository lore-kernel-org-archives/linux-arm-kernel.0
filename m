From: inki.dae@samsung.com (Inki Dae)
Date: Wed, 30 Sep 2015 20:26:37 +0900
Subject: [PATCH] drm/exynos: Avoid NULL pointer dereference in resume if
 bind failed
In-Reply-To: <1443370306-15429-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1443370306-15429-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Message-ID: <560BC6ED.3090205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2015? 09? 28? 01:11, Charles Keepax wrote:
> If binding failed calling exynos_dp_enable in exynos_dp_resume will
> result in several NULL pointer dereferences. It is much better to
> simply skip suspend/resume handling if bind has failed, do so by
> checking if a drm_dev exists.

Thanks for your patch. However, the pm interfaces of KMS drivers aren't
required because these are controlled by top of Exynos drm driver and
connector dpms. So I posted a patch that it removes pm interfaces of dp
driver.

Thanks,
Inki Dae

> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  drivers/gpu/drm/exynos/exynos_dp_core.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/exynos/exynos_dp_core.c
> index d66ade0..48baf07 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp_core.c
> +++ b/drivers/gpu/drm/exynos/exynos_dp_core.c
> @@ -1388,6 +1388,9 @@ static int exynos_dp_suspend(struct device *dev)
>  {
>  	struct exynos_dp_device *dp = dev_get_drvdata(dev);
>  
> +	if (!dp->drm_dev)
> +		return 0;
> +
>  	exynos_dp_disable(&dp->encoder);
>  	return 0;
>  }
> @@ -1396,6 +1399,9 @@ static int exynos_dp_resume(struct device *dev)
>  {
>  	struct exynos_dp_device *dp = dev_get_drvdata(dev);
>  
> +	if (!dp->drm_dev)
> +		return 0;
> +
>  	exynos_dp_enable(&dp->encoder);
>  	return 0;
>  }
> 
