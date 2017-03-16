From: eric.auger@redhat.com (Auger Eric)
Date: Thu, 16 Mar 2017 22:58:03 +0100
Subject: [RFC PATCH 27/33] irqchip/gic-v3-its: Add VPE interrupt masking
In-Reply-To: <1484648454-21216-28-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-28-git-send-email-marc.zyngier@arm.com>
Message-ID: <971d3d21-d811-7259-3d0c-7cac532743cf@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,
On 17/01/2017 11:20, Marc Zyngier wrote:
> When masking/unmasking a doorbell interrupt, it is necessary
> to issue an invalidation to the corresponding redistributor.
> We use the DirectLPI feature by writting directly to the corresponding
s/writting/writing
is DirectLPI always supported? I can see the GICR_TYPER advertises (or
not) the modality.
> redistributor.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 06e959f..008fb71 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -950,14 +950,19 @@ static inline u32 its_get_event_id(struct irq_data *d)
>  	return d->hwirq - its_dev->event_map.lpi_base;
>  }
>  
> +static inline bool its_is_vpe_lpi(struct irq_data *d)
> +{
> +	return !irq_desc_get_msi_desc(irq_data_to_desc(d));
> +}
> +
>  static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
>  {
> -	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>  	irq_hw_number_t hwirq;
>  	struct page *prop_page;
>  	u8 *cfg;
>  
>  	if (irqd_is_forwarded_to_vcpu(d)) {
> +		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
nit: leave blank line (sorry I need to find something ;-)
>  		u32 event = its_get_event_id(d);
>  		prop_page = its_dev->event_map.vlpi_map->vpes[0]->its_vm->vprop_page;
>  		hwirq = its_dev->event_map.vlpi_map->vlpis[event].vintid;
> @@ -979,7 +984,18 @@ static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
>  		gic_flush_dcache_to_poc(cfg, sizeof(*cfg));
>  	else
>  		dsb(ishst);
> -	its_send_inv(its_dev, its_get_event_id(d));
> +
> +	if (!its_is_vpe_lpi(d)) {
> +		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
> +
> +		its_send_inv(its_dev, its_get_event_id(d));
> +	} else {
> +		struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
> +		void __iomem *rdbase;
> +
> +		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
> +		writeq_relaxed(d->hwirq, rdbase + GICR_INVLPIR);
> +	}
>  }
>  
>  static void its_vlpi_set_doorbell(struct irq_data *d, bool enable)
> @@ -2196,6 +2212,9 @@ static int its_vpe_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
>  
>  static struct irq_chip its_vpe_irq_chip = {
>  	.name			= "GICv4-vpe",
> +	.irq_mask		= its_mask_irq,
> +	.irq_unmask		= its_unmask_irq,
> +	.irq_eoi		= irq_chip_eoi_parent,
not documented in the commit msg?

Eric
>  	.irq_set_affinity	= its_vpe_set_affinity,
>  	.irq_set_vcpu_affinity	= its_vpe_set_vcpu_affinity,
>  };
> 
