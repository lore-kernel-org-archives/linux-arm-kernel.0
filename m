From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 2 May 2017 17:20:18 +0800
Subject: [PATCH v7 5/7] coresight: add support for CPU debug module
In-Reply-To: <1493713805-26920-6-git-send-email-leo.yan@linaro.org>
References: <1493713805-26920-1-git-send-email-leo.yan@linaro.org>
 <1493713805-26920-6-git-send-email-leo.yan@linaro.org>
Message-ID: <20170502092018.GB20225@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 02, 2017 at 04:30:03PM +0800, Leo Yan wrote:

[...]

> +static void debug_force_cpu_powered_up(struct debug_drvdata *drvdata)
> +{
> +	u32 edprcr;
> +
> +try_again:
> +
> +	/*
> +	 * Send request to power management controller and assert
> +	 * DBGPWRUPREQ signal; if power management controller has
> +	 * sane implementation, it should enable CPU power domain
> +	 * in case CPU is in low power state.
> +	 */
> +	edprcr = readl_relaxed(drvdata->base + EDPRCR);
> +	edprcr |= EDPRCR_COREPURQ;
> +	writel_relaxed(edprcr, drvdata->base + EDPRCR);
> +
> +	/* Wait for CPU to be powered up (timeout~=32ms) */
> +	if (readx_poll_timeout_atomic(readl_relaxed, drvdata->base + EDPRSR,
> +			drvdata->edprsr, (drvdata->edprsr & EDPRSR_PU),
> +			DEBUG_WAIT_SLEEP, DEBUG_WAIT_TIMEOUT)) {
> +		/*
> +		 * Unfortunately the CPU cannot be powered up, so return
> +		 * back and later has no permission to access other
> +		 * registers. For this case, should disable CPU low power
> +		 * states to ensure CPU power domain is enabled!
> +		 */
> +		pr_err("%s: power up request for CPU%d failed\n",
> +			__func__, drvdata->cpu);
> +		return;
> +	}
> +
> +	/*
> +	 * At this point the CPU is powered up, so set the no powerdown
> +	 * request bit so we don't lose power and emulate power down.
> +	 */
> +	edprcr = readl_relaxed(drvdata->base + EDPRCR);
> +	edprcr |= EDPRCR_COREPURQ | EDPRCR_CORENPDRQ;
> +	writel_relaxed(edprcr, drvdata->base + EDPRCR);
> +
> +	drvdata->edprsr = readl_relaxed(drvdata->base + EDPRSR);
> +
> +	/* The core power domain got switched off on use, try again */
> +	if (unlikely(!drvdata->edprsr & EDPRSR_PU))

Here have error introduced by operator priority. Should change to

        if (unlikely(!(drvdata->edprsr & EDPRSR_PU)))

Will send new version soon for this fixing.

> +		goto try_again;
> +}

[...]

Thanks,
Leo Yan
