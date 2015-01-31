From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 30 Jan 2015 16:30:04 -0800
Subject: [PATCH] irqchip: gic: ignore empty processor target registers
In-Reply-To: <1422663970-3563-1-git-send-email-stefan@agner.ch>
References: <1422663970-3563-1-git-send-email-stefan@agner.ch>
Message-ID: <54CC220C.2030202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/15 16:26, Stefan Agner wrote:
> On initialization time, the GIC driver reads the processor target
> register (ICDIPTR) to determine the CPU's mask. On uniprocessor
> systems with GIC controller (e.g. Cortex-A5 SoC's) this register
> is RAZ/WI and hence the mask ends up being zero. This leads to the
> somewhat confusing boot message:
> [    0.000000] GIC CPU mask not found - kernel will fail to boot.
>
> To avoid the message, print the error only on SMP systems.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> I would like to get rid of this critical message in my bootlog, it
> sounds somewhat... intimidating...

Agreed. I sent a patch to do this a while ago but it never went anywhere
because of maintainership confusions.

http://marc.info/?l=linux-arm-kernel&m=137723356232002&w=2

>
> Actually the driver could also conditionally avoid setting up
> GIC_DIST_TARGET, since it's RAZ/WI (write ignored) on uniprocessor
> systems. But I'm not sure if is_smp() is really reflecting all
> SoC's using GIC which need the Interrupt Processor Targets register
> configured.
>
>  drivers/irqchip/irq-gic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index d617ee5..7d4f0f5 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -346,7 +346,7 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
>  			break;
>  	}
>  
> -	if (!mask)
> +	if (!mask && is_smp())
>  		pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
>  
>  	return mask;


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
