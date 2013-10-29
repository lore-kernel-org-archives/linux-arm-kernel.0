From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 29 Oct 2013 15:17:01 +0400
Subject: [PATCH 03/12] clocksource: sh_tmu: Add clk_prepare/unprepare
 support
In-Reply-To: <1383000569-8916-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <526F992D.2000309@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-10-2013 2:49, Laurent Pinchart wrote:

> Prepare the clock at probe time, as there is no other appropriate place
> in the driver where we're allowed to sleep.

> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   drivers/clocksource/sh_tmu.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)

> diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
> index 78b8dae..63557cd 100644
> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c
> @@ -472,12 +472,26 @@ static int sh_tmu_setup(struct sh_tmu_priv *p, struct platform_device *pdev)
>   		ret = PTR_ERR(p->clk);
>   		goto err1;
>   	}
> +
> +	ret = clk_prepare(p->clk);
> +	if (ret < 0)
> +		goto err2;
> +
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
> +		goto err3;
> +
> +	return 0;
> +
> + err3:
> +	clk_unprepare(p->clk);
> + err2:
> +	clk_put(p->clk);

    This one seems to be a fix, and should be done separately.

WBR, Sergei
