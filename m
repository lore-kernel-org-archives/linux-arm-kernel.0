From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 7 Apr 2016 18:19:10 +0100
Subject: [PATCH 09/14] coresight: tmc: adding mode of operation for
 link/sinks
In-Reply-To: <1458678202-3447-10-git-send-email-mathieu.poirier@linaro.org>
References: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
 <1458678202-3447-10-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <5706968E.1050409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/03/16 20:23, Mathieu Poirier wrote:
> Moving tmc_drvdata::enable to a local_t mode.  That way the
> sink interface is aware of it's orgin and the foundation for
> mutual exclusion between the sysFS and Perf interface can be
> laid out.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>   static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
>   {
> +	u32 val;
>   	bool allocated = false;
>   	char *buf = NULL;
>   	unsigned long flags;
> @@ -125,6 +126,15 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
>   		return -EBUSY;
>   	}
>
> +	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);

Since we don't support PERF mode yet, should we check that before setting the mode ?

>
>   static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
>   {
> +	u32 val;
>   	bool allocated = false;
>   	unsigned long flags;
>   	void __iomem *vaddr;
> @@ -107,6 +108,15 @@ static int tmc_enable_etr_sink(struct coresight_device *csdev, u32 mode)
>   		return -EBUSY;
>   	}
>
> +	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
> +	/*
> +	 * In sysFS mode we can have multiple writers per sink.  Since this
> +	 * sink is already enabled no memory is needed and the HW need not be
> +	 * touched.
> +	 */
> +	if (val == CS_MODE_SYSFS)
> +		goto out;
> +

Should we make sure 'mode' is not PERF ? Since we assume that the mode is
could be SYSFS in disable below ?


> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 6b11caf77ad1..6dbd70861b17 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -18,6 +18,7 @@
>   #ifndef _CORESIGHT_TMC_H
>   #define _CORESIGHT_TMC_H
>
> +#include <linux/io.h>

Why ?

Suzuki
