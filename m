From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 12 Jan 2017 12:37:53 +0100
Subject: [PATCH] rtc: armada38x: avoid unused-function warning
In-Reply-To: <20170112111321.3219446-1-arnd@arndb.de>
References: <20170112111321.3219446-1-arnd@arndb.de>
Message-ID: <20170112113753.bwaux5fjptlayu2r@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/01/2017 at 12:13:08 +0100, Arnd Bergmann wrote :
> When CONFIG_PM_SLEEP is not set, rtc_update_mbus_timing_params becomes
> unused, now that armada38x_rtc_probe() no longer calls
> rtc_update_mbus_timing_params on startup:
> 
> drivers/rtc/rtc-armada38x.c:79:13: error: 'rtc_update_mbus_timing_params' defined but not used [-Werror=unused-function]
> 
> This addresses the warning by marking the PM functions as __maybe_unused,
> so the unused functions get silently dropped. I could not tell from
> the changelog if dropping the call to armada38x_rtc_probe() was
> intended here, and if that is the correct thing to do without
> CONFIG_PM_SLEEP, so we might need a different fix that brings it back.
> 

Thanks for the report, Russell's patch didn't apply cleanly and it seems
I messed up when applying. I've just restored the
rtc_update_mbus_timing_params() call in probe as this should be.


Thanks again and sorry about this.

> Fixes: 4c492eb022c2 ("rtc: armada38x: make struct rtc_class_ops const")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-armada38x.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
> index 4f75c619bbba..2e451acccd9c 100644
> --- a/drivers/rtc/rtc-armada38x.c
> +++ b/drivers/rtc/rtc-armada38x.c
> @@ -338,8 +338,7 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int armada38x_rtc_suspend(struct device *dev)
> +static int __maybe_unused armada38x_rtc_suspend(struct device *dev)
>  {
>  	if (device_may_wakeup(dev)) {
>  		struct armada38x_rtc *rtc = dev_get_drvdata(dev);
> @@ -350,7 +349,7 @@ static int armada38x_rtc_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int armada38x_rtc_resume(struct device *dev)
> +static int __maybe_unused armada38x_rtc_resume(struct device *dev)
>  {
>  	if (device_may_wakeup(dev)) {
>  		struct armada38x_rtc *rtc = dev_get_drvdata(dev);
> @@ -363,7 +362,6 @@ static int armada38x_rtc_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static SIMPLE_DEV_PM_OPS(armada38x_rtc_pm_ops,
>  			 armada38x_rtc_suspend, armada38x_rtc_resume);
> -- 
> 2.9.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
