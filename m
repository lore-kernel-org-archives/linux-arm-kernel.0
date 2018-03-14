From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Mar 2018 10:38:23 +0000
Subject: [PATCH] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is observed
 before enabling
In-Reply-To: <1520988601-16705-1-git-send-email-shankerd@codeaurora.org>
References: <1520988601-16705-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <20180314103823.roo7qt7htcr27dkt@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 07:50:01PM -0500, Shanker Donthineni wrote:
> The definition of the GICR_CTLR.RWP control bit was expanded to indicate
> status of changing GICR_CTLR.EnableLPI from 1 to 0 is being in progress
> or completed. Software must observe GICR_CTLR.RWP==0 after clearing
> GICR_CTLR.EnableLPI from 1 to 0 and before writing GICR_PENDBASER and/or
> GICR_PROPBASER, otherwise behavior is UNPREDICTABLE.

> +	/* Make sure LPIs are disabled before programming PEND/PROP registers */
> +	if (val & GICR_CTLR_ENABLE_LPIS) {
> +		u32 count = 1000000; /* 1s! */

Please use USEC_PER_SEC from <linux/time64.h>.

> +		/* Wait for GICR_CTLR.RWP==0 or timeout */
> +		while (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_RWP) {
> +			if (!count) {
> +				pr_err("CPU%d: Failed to disable LPIs\n",
> +				       smp_processor_id());
> +				return;
> +			}
> +			cpu_relax();
> +			udelay(1);
> +			count--;
> +		};

Please use readl_relaxed_poll_timeout() from <linux/iopoll.h>.

	/* Wait for GICR_CTLR.RWP==0 or timeout */
	ret = readl_relaxed_poll_timeout(rbase + GICR_CTLR, reg,
					 !(reg & GICR_CTLR_RWP), 1,
					 USEC_PER_SEC);
	if (ret) {
		pr_err("CPU%d: Failed to disable LPIs\n",
			smp_processor_id());
		return;
	}

Thanks,
Mark.
