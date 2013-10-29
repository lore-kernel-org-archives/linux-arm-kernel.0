From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 29 Oct 2013 15:15:09 +0400
Subject: [PATCH 02/12] clocksource: sh_mtu2: Add clk_prepare/unprepare
 support
In-Reply-To: <1383000569-8916-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <526F98BD.9000904@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 29-10-2013 2:49, Laurent Pinchart wrote:

> Prepare the clock at probe time, as there is no other appropriate place
> in the driver where we're allowed to sleep.

> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   drivers/clocksource/sh_mtu2.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)

> diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
> index 4aac9ee..3cf1283 100644
> --- a/drivers/clocksource/sh_mtu2.c
> +++ b/drivers/clocksource/sh_mtu2.c
> @@ -313,8 +313,20 @@ static int sh_mtu2_setup(struct sh_mtu2_priv *p, struct platform_device *pdev)
>   		goto err1;
>   	}
>
> -	return sh_mtu2_register(p, (char *)dev_name(&p->pdev->dev),
> -				cfg->clockevent_rating);
> +	ret = clk_prepare(p->clk);
> +	if (ret < 0)
> +		goto err2;
> +
> +	ret = sh_mtu2_register(p, (char *)dev_name(&p->pdev->dev),
> +			       cfg->clockevent_rating);
> +	if (ret < 0)
> +		goto err3;
> +
> +	return 0;
> + err3:
> +	clk_unprepare(p->clk);
> + err2:
> +	clk_put(p->clk);

    This one seems to be a fix and so needs to be in a separate patch...

WBR, Sergei
