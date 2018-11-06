From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 6 Nov 2018 09:27:38 +0000
Subject: [PATCH 2/3] coresight: etf: Release CLAIM tag after disabling the
 HW
In-Reply-To: <1541456790-28282-3-git-send-email-mathieu.poirier@linaro.org>
References: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
 <1541456790-28282-3-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <a44849f6-c918-8613-db8d-fc32226b5342@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/11/2018 22:26, Mathieu Poirier wrote:
> This patch rectifies the sequence of events in function
> tmc_etb_disable_hw() by disabling the HW first and then releasing the
> CLAIM tag.  Otherwise we could be corrupting the configuration done by an
> external agent that would have claimed the device after we have released
> it.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 5864ac55e275..a5f053f2db2c 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -86,8 +86,8 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>   
>   static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>   {
> -	coresight_disclaim_device(drvdata->base);
>   	__tmc_etb_disable_hw(drvdata);
> +	coresight_disclaim_device(drvdata->base);
>   }
>   

Well spotted.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
