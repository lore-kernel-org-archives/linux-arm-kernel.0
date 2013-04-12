From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 12 Apr 2013 13:50:36 +0200
Subject: [PATCH] PM / Runtime: Improve prepare handling at system suspend
 for genpd
In-Reply-To: <1365759704-23722-1-git-send-email-ulf.hansson@stericsson.com>
References: <1365759704-23722-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1844674.ZBv3XGts1U@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 12, 2013 11:41:44 AM Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> When genpd prepares for a system suspend it will fetch a runtime
> reference for the device. When returning it we now use the
> asyncronous runtime PM API. Thus we don't have to wait for the
> device to become idle|suspended before we move on and handle the
> next device in queue.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>

All three patches applied to linux-pm.git/linux-next.

Thanks,
Rafael


> ---
>  drivers/base/power/domain.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 9a6b05a..e6ec4a7 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -920,7 +920,7 @@ static int pm_genpd_prepare(struct device *dev)
>  		pm_wakeup_event(dev, 0);
>  
>  	if (pm_wakeup_pending()) {
> -		pm_runtime_put_sync(dev);
> +		pm_runtime_put(dev);
>  		return -EBUSY;
>  	}
>  
> @@ -961,7 +961,7 @@ static int pm_genpd_prepare(struct device *dev)
>  		pm_runtime_enable(dev);
>  	}
>  
> -	pm_runtime_put_sync(dev);
> +	pm_runtime_put(dev);
>  	return ret;
>  }
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
