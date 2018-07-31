From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 31 Jul 2018 11:07:31 -0600
Subject: [PATCH v3 02/13] coresight: etb10: Fix handling of perf mode
In-Reply-To: <1532609691-16863-3-git-send-email-suzuki.poulose@arm.com>
References: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
 <1532609691-16863-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180731170731.GA11692@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jul 26, 2018 at 01:54:40PM +0100, Suzuki K Poulose wrote:
> If the ETB is already enabled in sysfs mode, the ETB reports
> success even if a perf mode is requested. Fix this by checking
> the requested mode.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 306119e..e5808fd 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -148,8 +148,12 @@ static int etb_enable(struct coresight_device *csdev, u32 mode)
>  		return -EBUSY;
>  
>  	/* Nothing to do, the tracer is already enabled. */
> -	if (val == CS_MODE_SYSFS)
> -		goto out;
> +	if (val == CS_MODE_SYSFS) {
> +		if (mode == CS_MODE_SYSFS)
> +			goto out;
> +		else
> +			return -EBUSY;
> +	}

How about:

        if (val == CS_MODE_PERF)
                return -EBUSY;
 
+       /* Don't let perf disturb sysFS sessions */
+       if (val == CS_MODE_SYSFS && mode = CS_MODE_PERF)
+               return -EBUSY;
+
        /* Nothing to do, the tracer is already enabled. */
        if (val == CS_MODE_SYSFS)
                goto out;


I just find it more readable that way.

Thanks,
Mathieu

>  
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
>  	etb_enable_hw(drvdata);
> -- 
> 2.7.4
> 
