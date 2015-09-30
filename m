From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 30 Sep 2015 14:16:42 +0300
Subject: [RFC PATCH 03/20] coresight: etm3x: implementing 'cpu_id()' API
In-Reply-To: <1442593594-10665-4-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <1442593594-10665-4-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <87h9mcjgx1.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> Adding an interface to lookup the CPU a tracer has been affined
> to along with a source operation allowing external customers to
> access it.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm3x.c | 14 ++++++++++++++
>  include/linux/coresight.h                     |  3 +++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index a44bc3532585..4ce9cfc06e93 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -441,6 +441,19 @@ static void etm_config_enable(void *info)
>  	spin_unlock(&drvdata->spinlock);
>  }
>  
> +static int etm_cpu_id(struct coresight_device *csdev)
> +{
> +	int cpu;
> +	unsigned long flags;
> +	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	cpu = drvdata->cpu;
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);

Why do you need a spinlock here? Afaict, it never changes and if it
would, things would go really bad really fast.

Regards,
--
Alex
