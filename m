From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 08 Nov 2013 11:10:31 +0100
Subject: [PATCH v2 1/2] clocksource: sh_tmu: Release clock when
 sh_tmu_register() fails
In-Reply-To: <1383057097-22689-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383000569-8916-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383057097-22689-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <527CB897.8070107@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2013 03:31 PM, Laurent Pinchart wrote:
> Fix the probe error path to release the clock resource when the
> sh_tmu_register() call fails.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Applied in my tree as 3.13 fixes

> ---
>   drivers/clocksource/sh_tmu.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
> index 78b8dae..1597837 100644
> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c
> @@ -475,9 +475,16 @@ static int sh_tmu_setup(struct sh_tmu_priv *p, struct platform_device *pdev)
>   	p->cs_enabled = false;
>   	p->enable_count = 0;
>
> -	return sh_tmu_register(p, (char *)dev_name(&p->pdev->dev),
> -			       cfg->clockevent_rating,
> -			       cfg->clocksource_rating);
> +	ret = sh_tmu_register(p, (char *)dev_name(&p->pdev->dev),
> +			      cfg->clockevent_rating,
> +			      cfg->clocksource_rating);
> +	if (ret < 0)
> +		goto err2;
> +
> +	return 0;
> +
> + err2:
> +	clk_put(p->clk);
>    err1:
>   	iounmap(p->mapbase);
>    err0:
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
