From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 08 Nov 2013 11:10:15 +0100
Subject: [PATCH v2 1/2] clocksource: sh_mtu2: Release clock when
 sh_mtu2_register() fails
In-Reply-To: <1383057045-22608-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383000569-8916-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383057045-22608-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <527CB887.8090703@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2013 03:30 PM, Laurent Pinchart wrote:
> Fix the probe error path to release the clock resource when the
> sh_mtu2_register() call fails.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Applied in my tree as 3.13 fixes

> ---
>   drivers/clocksource/sh_mtu2.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
> index 4aac9ee..e6cfb32 100644
> --- a/drivers/clocksource/sh_mtu2.c
> +++ b/drivers/clocksource/sh_mtu2.c
> @@ -313,8 +313,15 @@ static int sh_mtu2_setup(struct sh_mtu2_priv *p, struct platform_device *pdev)
>   		goto err1;
>   	}
>
> -	return sh_mtu2_register(p, (char *)dev_name(&p->pdev->dev),
> -				cfg->clockevent_rating);
> +	ret = sh_mtu2_register(p, (char *)dev_name(&p->pdev->dev),
> +			       cfg->clockevent_rating);
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
