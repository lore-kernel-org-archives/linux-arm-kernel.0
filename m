From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 19 Oct 2018 09:39:15 +0100
Subject: [PATCH] coresight: tmc: Fix bad register address for CLAIM
In-Reply-To: <1539924983-18503-1-git-send-email-leo.yan@linaro.org>
References: <1539924983-18503-1-git-send-email-leo.yan@linaro.org>
Message-ID: <9b6a508d-5c4b-ffd8-7f6b-3f4e6db26571@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

On 10/19/2018 05:56 AM, Leo Yan wrote:
> Commit 4d3ebd3658d8 ("coreisght: tmc: Claim device before use") uses
> CLAIM tag to validate if the device is available, it needs to pass
> the device base address to access related registers.
> 
> In the function tmc_etb_disable_hw() it wrongly passes the driver data
> pointer as register base address, thus it's easily to produce the kernel
> warning info like below:
> 
> [   83.579898] WARNING: CPU: 4 PID: 2970 at drivers/hwtracing/coresight/coresight.c:207 coresight_disclaim_device_unlocked+0x44/0x80
> [   83.591448] Modules linked in:
> [   83.594485] CPU: 4 PID: 2970 Comm: uname Not tainted 4.19.0-rc6-00417-g721b509 #110

Oops! Thanks for fixing !


> 
> This patch is to fix this bug by using 'drvdata->base' as the
> register base address for CLAIM related operation.
> 
> Fixes: 4d3ebd3658d8 ("coreisght: tmc: Claim device before use")
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 53fc83b..5864ac5 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -86,7 +86,7 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>   
>   static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>   {
> -	coresight_disclaim_device(drvdata);
> +	coresight_disclaim_device(drvdata->base);
>   	__tmc_etb_disable_hw(drvdata);
>   }
>   
> 
