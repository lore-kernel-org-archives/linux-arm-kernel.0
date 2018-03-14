From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Mar 2018 07:41:35 +0000
Subject: [PATCH] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is observed
 before enabling
In-Reply-To: <1520988601-16705-1-git-send-email-shankerd@codeaurora.org>
References: <1520988601-16705-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <86bmfrayts.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shanker,

On Wed, 14 Mar 2018 00:50:01 +0000,
Shanker Donthineni wrote:
> 
> The definition of the GICR_CTLR.RWP control bit was expanded to indicate
> status of changing GICR_CTLR.EnableLPI from 1 to 0 is being in progress
> or completed. Software must observe GICR_CTLR.RWP==0 after clearing
> GICR_CTLR.EnableLPI from 1 to 0 and before writing GICR_PENDBASER and/or
> GICR_PROPBASER, otherwise behavior is UNPREDICTABLE.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c   | 30 +++++++++++++++++++++++-------
>  include/linux/irqchip/arm-gic-v3.h |  1 +
>  2 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 1d3056f..85cd158 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1875,15 +1875,31 @@ static void its_cpu_init_lpis(void)
>  		gic_data_rdist()->pend_page = pend_page;
>  	}
>  
> -	/* Disable LPIs */
>  	val = readl_relaxed(rbase + GICR_CTLR);
> -	val &= ~GICR_CTLR_ENABLE_LPIS;
> -	writel_relaxed(val, rbase + GICR_CTLR);
>  
> -	/*
> -	 * Make sure any change to the table is observable by the GIC.
> -	 */
> -	dsb(sy);
> +	/* Make sure LPIs are disabled before programming PEND/PROP registers */
> +	if (val & GICR_CTLR_ENABLE_LPIS) {
> +		u32 count = 1000000; /* 1s! */
> +
> +		/* Disable LPIs */
> +		val &= ~GICR_CTLR_ENABLE_LPIS;
> +		writel_relaxed(val, rbase + GICR_CTLR);
> +
> +		/* Make sure any change to GICR_CTLR is observable by the GIC */
> +		dsb(sy);
> +
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
> +	}

I can see a couple of issues with this patch:

- Entering the kernel with GICR_CTLR.EnableLPIs set is a recipe for
  memory corruption and is likely to lead to Bad Things(tm). A loud
  warning would be in order, I believe.

- If you're on a system that doesn't allow GICR_CTLR.Enable_LPIs to be
  cleared, we end-up going down the polling path for nothing. It'd be
  worth checking that the bit can be cleared the first place (and
  shout again if it cannot).

- From a cosmetic PoV, please move this to a redist_disable_lpis()
  function.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
