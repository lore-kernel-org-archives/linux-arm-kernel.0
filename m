From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 22 Jun 2016 11:46:28 +0100
Subject: [PATCH] coresight: etm4x: request to retain power to the trace
 unit when active
In-Reply-To: <1466590513-22505-1-git-send-email-sudeep.holla@arm.com>
References: <1466590513-22505-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <576A6C84.4090304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/06/16 11:15, Sudeep Holla wrote:
> The Coresight ETMv4 architecture provides a way to request to keep the
> power to the trace unit. This might help to collect the traces without
> the need to disable the CPU power management(entering/exiting deeper
> idle states).
>
> Trace PowerDown Control Register provides powerup request bit which when
> set requests the system to retain power to the trace unit and emulate
> the powerdown request.
>
> Typically, a trace unit drives a signal to the power controller to
> request that the trace unit core power domain is powered up. However,
> if the trace unit and the CPU are in the same power domain then the
> implementation might combine the trace unit power up status with a
> signal from the CPU.
>
> This patch requests to retain power to the trace unit when active and
> to remove when inactive. Note this change will only request but the
> behaviour depends on the implementation. However, it matches the
> exact behaviour expected when the external debugger is connected with
> respect to CPU power states.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>


Thanks for debugging this issue patiently and fixing it :)
One comment below.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index d6f1d6d874eb..301ee3232f3d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -163,6 +163,12 @@ static void etm4_enable_hw(void *info)
>   	writel_relaxed(config->vmid_mask0, drvdata->base + TRCVMIDCCTLR0);
>   	writel_relaxed(config->vmid_mask1, drvdata->base + TRCVMIDCCTLR1);
>

> +	/*
> +	 * Request to keep the trace unit powered and also
> +	 * emulation of powerdown
> +	 */
> +	writel_relaxed(TRCPDCR_PU, drvdata->base + TRCPDCR);
> +

>
> @@ -293,6 +299,9 @@ static void etm4_disable_hw(void *info)

>
> +	/* power can be removed from the trace unit now */
> +	writel_relaxed(0, drvdata->base + TRCPDCR);
> +

At the moment the other bits in TRCPDCR are reserved (RES0). However
to prevent issues in the future, it would be safer to read the value
and set/clear the Bit of our interest than blindly writing those values.

Suzuki
