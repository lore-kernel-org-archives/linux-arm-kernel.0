From: zhang.lei@jp.fujitsu.com (Zhang, Lei)
Date: Tue, 19 Jun 2018 14:14:27 +0000
Subject: [PATCH v3] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is
 observed before enabling
In-Reply-To: <86o9jf174o.wl-marc.zyngier@arm.com>
References: <1521683929-15644-1-git-send-email-shankerd@codeaurora.org>
 <d1161c2d-e16d-14e6-5450-be26d348100d@arm.com>
 <8087e009-4eca-ab92-cbca-23ccfb3fafac@codeaurora.org>
 <86o9jf174o.wl-marc.zyngier@arm.com>
Message-ID: <8898674D84E3B24BA3A2D289B872026A69F37935@G01JPEXMBKW03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi shankerd, Marc

I have one question.

Does it means after GICR_CTLR.EnableLPI has been written to 1, 
if the bit GICR_CTLR.EnableLPI becomes RES1, we can't use LPIs?
Because its_cpu_init_lpis and its_cpu_init_collections will not be called. 

> whether
> +	 * the bit GICR_CTLR.EnableLPI becomes RES1 or can be cleared to
> 0.
> +	 * Bail out the driver probe() on systems where it's RES1.
> +	 * 
> +	/**
> +	 * After it has been written to 1, it is IMPLEMENTATION DEFINED
> whether
> +	 * the bit GICR_CTLR.EnableLPI becomes RES1 or can be cleared to
> 0.
> +	 * Bail out the driver probe() on systems where it's RES1.
> +	 */
> +	if (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_ENABLE_LPIS) {
> +		pr_err("CPU%d: Failed to disable LPIs\n",
> smp_processor_id());
> +		return -EBUSY;
> +	}

Best Regards,
Lei Zhang
zhang.lei at jp.fujitsu.com
