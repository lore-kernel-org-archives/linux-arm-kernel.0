From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 06 Jul 2015 13:10:56 +0100
Subject: [PATCH 1/4] irqchip, gicv3-its: Read typer register outside the
 loop
In-Reply-To: <1435673643-31676-2-git-send-email-rric@kernel.org>
References: <1435673643-31676-1-git-send-email-rric@kernel.org>
 <1435673643-31676-2-git-send-email-rric@kernel.org>
Message-ID: <559A7050.4060404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/06/15 15:14, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> No need to read the typer register in the loop. Values do not change.
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 1b7e155869f6..c5ce21277920 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -803,6 +803,8 @@ static int its_alloc_tables(struct its_node *its)
>  	int psz = SZ_64K;
>  	u64 shr = GITS_BASER_InnerShareable;
>  	u64 cache = GITS_BASER_WaWb;
> +	u64 typer = readq_relaxed(its->base + GITS_TYPER);
> +	u32 ids = GITS_TYPER_DEVBITS(typer);
>  
>  	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
>  		u64 val = readq_relaxed(its->base + GITS_BASER + i * 8);
> @@ -825,9 +827,6 @@ static int its_alloc_tables(struct its_node *its)
>  		 * For other tables, only allocate a single page.
>  		 */
>  		if (type == GITS_BASER_TYPE_DEVICE) {
> -			u64 typer = readq_relaxed(its->base + GITS_TYPER);
> -			u32 ids = GITS_TYPER_DEVBITS(typer);
> -
>  			/*
>  			 * 'order' was initialized earlier to the default page
>  			 * granule of the the ITS.  We can't have an allocation
> 

The TYPER value certainly don't change, but there is also only one
device table per ITS instance, so we only read it once. What do we gain
here?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
