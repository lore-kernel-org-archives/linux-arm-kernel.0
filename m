From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 30 Dec 2013 10:31:57 +0900
Subject: [PATCH 23/25] thermal: exynos: fix error return code
In-Reply-To: <1388357260-4843-24-git-send-email-Julia.Lawall@lip6.fr>
References: <1388357260-4843-1-git-send-email-Julia.Lawall@lip6.fr>
 <1388357260-4843-24-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <000001cf04fe$edccf3f0$c966dbd0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 30, 2013 7:48 AM, Julia Lawall wrote:
> 
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Set the return variable to an error code as done elsewhere in the function.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> (
> if at p1 (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret at p1 = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> 
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

(+cc Amit Daniel Kachhap, Jonghwa Lee)

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> 
> ---
> Not tested.
> 
>  drivers/thermal/samsung/exynos_tmu.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 32f38b9..0d96a51 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -205,6 +205,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>  skip_calib_data:
>  	if (pdata->max_trigger_level > MAX_THRESHOLD_LEVS) {
>  		dev_err(&pdev->dev, "Invalid max trigger level\n");
> +		ret = -EINVAL;
>  		goto out;
>  	}
> 
> 
> --
