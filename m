From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 13 Feb 2017 15:39:49 -0600
Subject: [RFC PATCH 02/33] irqchip/gic-v3: Add VLPI/DirectLPI discovery
In-Reply-To: <1484648454-21216-3-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <778dd3ec-b395-6883-f047-bea56ac54572@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/17/2017 04:20 AM, Marc Zyngier wrote:
> Add helper functions that probe for VLPI and DirectLPI properties.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/irqchip/irq-gic-v3.c       | 22 ++++++++++++++++++++++
>   include/linux/irqchip/arm-gic-v3.h |  3 +++
>   2 files changed, 25 insertions(+)
>
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 5cadec0..8a6de91 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -514,6 +514,24 @@ static int gic_populate_rdist(void)
>   	return -ENODEV;
>   }
>   
> +static int __gic_update_vlpi_properties(struct redist_region *region,
> +					void __iomem *ptr)
> +{
> +	u64 typer = gic_read_typer(ptr + GICR_TYPER);
> +	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
> +	gic_data.rdists.has_direct_lpi &= !!(typer &
> GICR_TYPER_DirectLPIS);
> +
> +	return 1;
> +}
> +
> +static void gic_update_vlpi_properties(void)
> +{
> +	gic_scan_rdist_properties(__gic_update_vlpi_properties);
> +	pr_info("%sVLPI support, %sdirect LPI support\n",
Would be better if we keep one space after 'no'?

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
