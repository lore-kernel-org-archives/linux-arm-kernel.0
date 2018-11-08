From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 8 Nov 2018 17:28:13 +0000
Subject: [PATCH v2 4/4] coresight: etm3x: Release CLAIM tag when operated
 from perf
In-Reply-To: <1541632132-1252-5-git-send-email-mathieu.poirier@linaro.org>
References: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
 <1541632132-1252-5-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <597b9fba-5c3f-1718-072a-c984d5709e68@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/11/2018 23:08, Mathieu Poirier wrote:
> This patch deals with the release of the CLAIM tag when the ETM is
> operated from perf.  Otherwise the tag is left asserted and subsequent
> requests to use the device fail.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm3x.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index 4f638d81a66a..d7f452e62193 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -602,6 +602,7 @@ static void etm_disable_perf(struct coresight_device *csdev)
>   	 * power down the tracer.
>   	 */
>   	etm_set_pwrdwn(drvdata);
> +	coresight_disclaim_device_unlocked(drvdata->base);

Thanks for fixing this. IIUC, I think we have a problem in general with
mixing perf vs sysfs. Once a perf session uses the etm3x, we overwrite
the drvdata->config with the perf event specific controls and the sysfs
user may not be aware of that. We may have to do something similar we do
for ETR buf for sysfs/perf sessions. And then we may be able to merge
the enable/disable routines.

For this patch:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
