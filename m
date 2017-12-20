From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 Dec 2017 09:26:10 +0000
Subject: [PATCH] irqchip/gic-v3-its: Flush GICR caching for a cross node
 collection move of an irq
In-Reply-To: <20171220091544.4467-1-ganapatrao.kulkarni@cavium.com>
References: <20171220091544.4467-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <a2754c68-0a6b-e23d-1ed7-693ce4f7f89c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/12/17 09:15, Ganapatrao Kulkarni wrote:
> When an interrupt is moved, it is possible that an implementation that
> supports caching might still have cached data for a previous
> (no longer valid) mapping of the interrupt. In particular, in a distributed
> GIC implementation like multi-socket SoC platfroms. Hence it is necessary
> to flush cached entries after cross node collection migration.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 4039e64..ea849a1 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1119,6 +1119,12 @@ static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>  	if (cpu != its_dev->event_map.col_map[id]) {
>  		target_col = &its_dev->its->collections[cpu];
>  		its_send_movi(its_dev, target_col, id);
> +		/* Issue INV for cross node collection move on
> +		 * multi socket systems.
> +		 */
> +		if (cpu_to_node(cpu) !=
> +				cpu_to_node(its_dev->event_map.col_map[id]))
> +			its_send_inv(its_dev, id);
>  		its_dev->event_map.col_map[id] = cpu;
>  		irq_data_update_effective_affinity(d, cpumask_of(cpu));
>  	}
> 

The MOVI command doesn't have any such requirement (it only mandates
synchronization), and doesn't say anything about distributed vs monolithic.

What am I missing?

	M.
-- 
Jazz is not dead. It just smells funny...
