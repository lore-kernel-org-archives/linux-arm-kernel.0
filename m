From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Thu, 28 Feb 2013 23:03:57 +0100
Subject: [PATCH v9 2/2] video: drm: exynos: Add pinctrl support to fimd
In-Reply-To: <1362024762-28406-3-git-send-email-vikas.sajjan@linaro.org>
References: <1362024762-28406-1-git-send-email-vikas.sajjan@linaro.org>
 <1362024762-28406-3-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <512FD44D.1070408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2013 05:12 AM, Vikas Sajjan wrote:
> Adds support for pinctrl to drm fimd
>
> Signed-off-by: Leela Krishna Amudala<l.krishna@samsung.com>
> Signed-off-by: Vikas Sajjan<vikas.sajjan@linaro.org>
> ---
>   drivers/gpu/drm/exynos/exynos_drm_fimd.c |    9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> index e323cf9..21ada8d 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> @@ -19,6 +19,7 @@
>   #include<linux/clk.h>
>   #include<linux/of_device.h>
>   #include<linux/pm_runtime.h>
> +#include<linux/pinctrl/consumer.h>
>
>   #include<video/of_display_timing.h>
>   #include<video/samsung_fimd.h>
> @@ -879,6 +880,7 @@ static int fimd_probe(struct platform_device *pdev)
>   	struct exynos_drm_fimd_pdata *pdata;
>   	struct exynos_drm_panel_info *panel;
>   	struct resource *res;
> +	struct pinctrl *pctrl;
>   	int win;
>   	int ret = -EINVAL;
>
> @@ -897,6 +899,13 @@ static int fimd_probe(struct platform_device *pdev)
>   			DRM_ERROR("failed: of_get_fb_videomode() : %d\n", ret);
>   			return ret;
>   		}
> +		pctrl = devm_pinctrl_get_select_default(dev);
> +		if (IS_ERR_OR_NULL(pctrl)) {
> +			DRM_ERROR("failed: devm_pinctrl_get_select_default():"
> +				"%d\n", PTR_RET(pctrl));
> +			return PTR_ERR(pctrl);

In situations like this I really side attempts to remove IS_ERR_OR_NULL()
macro from the kernel completely ([1], [2]). What is the value returned 
from
fimd_probe() when devm_pinctrl_get_select_default() returns NULL ?

What header file have you added to use struct pinctrl in this driver ?
Is this data structure fully declared there ? Are drivers supposed to
dereference struct pinctrl at all ?

I believe original intention was to have the pinctrl handle as an opaque
cookie, and as long as it is used with the pinctrl API only and tested
for errors with *IS_ERR()*, everything should be fine. The pinctrl API
should handle any NULL pointer as it returned it to a driver in the first
place.

Please just use IS_ERR(), let's stop this IS_ERR_OR_NULL() insanity.

> +		}
> +
>   	} else {
>   		pdata = pdev->dev.platform_data;
>   		if (!pdata) {

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/140543.html
[2] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg78030.html
