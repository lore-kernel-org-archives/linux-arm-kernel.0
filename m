From: ladis@linux-mips.org (Ladislav Michl)
Date: Thu, 26 Jul 2018 20:54:26 +0200
Subject: [PATCH v2] pwm: pwm-omap-dmtimer: return -EPROBE_DEFER if no
 dmtimer platform data
In-Reply-To: <20180726133658.23902-1-drivshin@awxrd.com>
References: <20180726133658.23902-1-drivshin@awxrd.com>
Message-ID: <20180726185426.GA3546@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 09:36:58AM -0400, David Rivshin wrote:
> From: David Rivshin <DRivshin@allworx.com>
> 
> If a pwm-omap-dmtimer is probed before the dmtimer it uses, the platform
> data won't be set yet.
> 
> Fixes: ac30751df953 ("ARM: OMAP: pdata-quirks: Remove unused timer pdata")
> Cc: <stable@vger.kernel.org> # 4.17+
> Signed-off-by: David Rivshin <drivshin@allworx.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> ---
> Changes in v2:
> * Added Pavel's Acked-by/Tested-by [1]
> 
> [1] https://lkml.org/lkml/2018/7/16/346
> 
>  drivers/pwm/pwm-omap-dmtimer.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> index 665da3c8fbceb..d3d7ea7a53146 100644
> --- a/drivers/pwm/pwm-omap-dmtimer.c
> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> @@ -264,8 +264,9 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>  
>  	timer_pdata = dev_get_platdata(&timer_pdev->dev);
>  	if (!timer_pdata) {
> -		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
> -		ret = -EINVAL;
> +		dev_info(&pdev->dev,
> +			 "dmtimer pdata structure NULL, deferring probe\n");

This seems to be a bit verbose for EPROBE_DEFER case. Could we either remove
it as it is done later in pdata->request_by_node(timer) failure case or at
least make it dev_dbg? Otherwise thank you and with mentioned change
Acked-by: Ladislav Michl <ladis@linux-mips.org>

> +		ret = -EPROBE_DEFER;
>  		goto put;
>  	}
>  
> 
> base-commit: d72e90f33aa4709ebecc5005562f52335e106a60
> -- 
> 2.17.1
