From: leo.yan@linaro.org (leo.yan at linaro.org)
Date: Wed, 7 Nov 2018 11:23:50 +0800
Subject: [PATCH 3/3] coresight: etm3x: Release CLAIM tag when operated
 from perf
In-Reply-To: <1541456790-28282-4-git-send-email-mathieu.poirier@linaro.org>
References: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
 <1541456790-28282-4-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20181107032350.GH3983@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On Mon, Nov 05, 2018 at 03:26:30PM -0700, Mathieu Poirier wrote:
> This patch deals with the release of the CLAIM tag when the ETM is
> operated from perf.  Otherwise the tag is left asserted and subsequent
> requests to use the device fail.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm3x.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index fd5c4cca7db5..000796394662 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -603,6 +603,8 @@ static void etm_disable_perf(struct coresight_device *csdev)
>  	 */
>  	etm_set_pwrdwn(drvdata);
>  
> +	coresight_disclaim_device_unlocked(drvdata->base);
> +

Just remind, this isn't consistent with the sequency in function
etm_disable_hw(), which has the reversed sequence between
etm_set_pwrdwn() and coresight_disclaim_device_unlocked().

Not sure which one sequence is more suitable, at the first glance,
accessing register after pwrdwn related operation might have risk for
deadlock?

Thanks,
Leo Yan

>  	CS_LOCK(drvdata->base);
>  }
>  
> -- 
> 2.7.4
> 
