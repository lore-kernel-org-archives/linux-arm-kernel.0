From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 29 Jun 2016 14:46:00 +0800
Subject: [PATCH 12/21] usb: chipidea: msm: Keep device runtime enabled
In-Reply-To: <20160626072838.28082-13-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-13-stephen.boyd@linaro.org>
Message-ID: <20160629064600.GG25236@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2016 at 12:28:29AM -0700, Stephen Boyd wrote:
> Sometimes the usb wrapper device is part of a power domain that
> needs to stay on as long as the device is active. Let's get and
> put the device in driver probe/remove so that we keep the power
> domain powered as long as the device is attached. We can fine
> tune this later to handle wakeup interrupts, etc. for finer grain
> power management later, but this is necessary to make sure we can
> keep accessing the device right now.

Since some of the controllers work abnormal if we enables runtime
pm unconditionally, so I use one system flag CI_HDRC_SUPPORTS_RUNTIME_PM
for it. I can't understand why you can't access device without enable
parent's runtime pm, the controller will not enter runtime suspend
without that flag.

Peter
> 
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/usb/chipidea/ci_hdrc_msm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
> index 520c85e701ef..430856ef1be3 100644
> --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> @@ -80,6 +80,7 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
>  
>  	pm_runtime_no_callbacks(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get(&pdev->dev);
>  
>  	return 0;
>  }
> @@ -88,6 +89,7 @@ static int ci_hdrc_msm_remove(struct platform_device *pdev)
>  {
>  	struct platform_device *plat_ci = platform_get_drvdata(pdev);
>  
> +	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	ci_hdrc_remove_device(plat_ci);
>  
> -- 
> 2.9.0.rc2.8.ga28705d
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
