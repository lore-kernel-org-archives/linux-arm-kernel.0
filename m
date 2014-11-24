From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Mon, 24 Nov 2014 22:57:50 +0800
Subject: [PATCH v3 06/13] irqchip: GICv3: ITS: LPI allocator
In-Reply-To: <1416839720-18400-7-git-send-email-marc.zyngier@arm.com>
References: <1416839720-18400-1-git-send-email-marc.zyngier@arm.com>
 <1416839720-18400-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <5473476E.5070305@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2014/11/24 22:35, Marc Zyngier wrote:
> LPIs are the type of interrupts that are used by the ITS. Given
> the size of the namespace (anywhere between 16 and 32bit), interrupt
> IDs are allocated in chunks of 32.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 103 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index d24bebd..4154a16 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -586,3 +586,106 @@ static struct irq_chip its_irq_chip = {
>  	.irq_eoi		= its_eoi_irq,
>  	.irq_set_affinity	= its_set_affinity,
>  };
> +
> +/*
> + * How we allocate LPIs:
> + *
> + * The GIC has id_bits bits for interrupt identifiers. From there, we
> + * must subtract 8192 which are reserved for SGIs/PPIs/SPIs. Then, as
> + * we allocate LPIs by chunks of 32, we can shift the whole thing by 5
> + * bits to the right.
Just curious, why 32? sizeof(long) is 4 on ARM64?
