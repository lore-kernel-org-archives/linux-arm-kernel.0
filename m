From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 May 2015 08:41:02 +0100
Subject: [PATCH v3] irqchip/gicv3-its: ITS table size should not be
 smaller than PSZ
In-Reply-To: <1432076441-26365-1-git-send-email-stuart.yoder@freescale.com>
References: <1432076441-26365-1-git-send-email-stuart.yoder@freescale.com>
Message-ID: <20150520084102.553de637@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 May 2015 00:00:41 +0100
Stuart Yoder <stuart.yoder@freescale.com> wrote:

> when allocating a device table, if the requested allocation
> is smaller than the default granule size of the ITS
> then, we need to round up to the default size
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.

> ---
>   -v3 changes
>      -updated commit message and added comment
>   -would be nice to get this into 4.1 as the kernel will hang booting
>    on some systems
> 
>  drivers/irqchip/irq-gic-v3-its.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 9687f8a..1b7e155 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -828,7 +828,14 @@ static int its_alloc_tables(struct its_node *its)
>  			u64 typer = readq_relaxed(its->base + GITS_TYPER);
>  			u32 ids = GITS_TYPER_DEVBITS(typer);
>  
> -			order = get_order((1UL << ids) * entry_size);
> +			/*
> +			 * 'order' was initialized earlier to the default page
> +			 * granule of the the ITS.  We can't have an allocation
> +			 * smaller than that.  If the requested allocation
> +			 * is smaller, round up to the default page granule.
> +			 */
> +			order = max(get_order((1UL << ids) * entry_size),
> +				    order);
>  			if (order >= MAX_ORDER) {
>  				order = MAX_ORDER - 1;
>  				pr_warn("%s: Device Table too large, reduce its page order to %u\n",



-- 
Without deviation from the norm, progress is not possible.
