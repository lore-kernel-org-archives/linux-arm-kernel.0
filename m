From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 Jan 2017 11:50:14 +0000
Subject: [PATCH v7 13/19] irqdomain: Add irq domain MSI and MSI_REMAP flags
In-Reply-To: <1483969570-3154-14-git-send-email-eric.auger@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
 <1483969570-3154-14-git-send-email-eric.auger@redhat.com>
Message-ID: <fc33abb4-21a3-c94d-9417-4022e33217f8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 09/01/17 13:46, Eric Auger wrote:
> We introduce two new enum values for the irq domain flag:
> - IRQ_DOMAIN_FLAG_MSI indicates the irq domain corresponds to
>   an MSI domain
> - IRQ_DOMAIN_FLAG_MSI_REMAP indicates the irq domain has MSI
>   remapping capabilities.
> 
> Those values will be useful to check all MSI irq domains have
> MSI remapping support when assessing the safety of IRQ assignment
> to a guest.
> 
> irq_domain_hierarchical_is_msi_remap() allows to check if an
> irq domain or any parent implements MSI remapping.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v6:
> - add IRQ_DOMAIN_FLAG_MSI as suggested by Marc
> - add irq_domain_is_msi, irq_domain_is_msi_remap and
>   irq_domain_hierarchical_is_msi_remap
> ---
>  include/linux/irqdomain.h | 35 +++++++++++++++++++++++++++++++++++
>  kernel/irq/irqdomain.c    | 16 ++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index ffb8460..bc2f571 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -183,6 +183,12 @@ enum {
>  	/* Irq domain is an IPI domain with single virq */
>  	IRQ_DOMAIN_FLAG_IPI_SINGLE	= (1 << 3),
>  
> +	/* Irq domain implements MSIs */
> +	IRQ_DOMAIN_FLAG_MSI		= (1 << 4),
> +
> +	/* Irq domain implements MSI remapping */
> +	IRQ_DOMAIN_FLAG_MSI_REMAP	= (1 << 5),
> +
>  	/*
>  	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
>  	 * for implementation specific purposes and ignored by the
> @@ -446,6 +452,19 @@ static inline bool irq_domain_is_ipi_single(struct irq_domain *domain)
>  {
>  	return domain->flags & IRQ_DOMAIN_FLAG_IPI_SINGLE;
>  }
> +
> +static inline bool irq_domain_is_msi(struct irq_domain *domain)
> +{
> +	return domain->flags & IRQ_DOMAIN_FLAG_MSI;
> +}
> +
> +static inline bool irq_domain_is_msi_remap(struct irq_domain *domain)
> +{
> +	return domain->flags & IRQ_DOMAIN_FLAG_MSI_REMAP;
> +}
> +
> +extern bool irq_domain_hierarchical_is_msi_remap(struct irq_domain *domain);
> +
>  #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
>  static inline void irq_domain_activate_irq(struct irq_data *data) { }
>  static inline void irq_domain_deactivate_irq(struct irq_data *data) { }
> @@ -477,6 +496,22 @@ static inline bool irq_domain_is_ipi_single(struct irq_domain *domain)
>  {
>  	return false;
>  }
> +
> +static inline bool irq_domain_is_msi(struct irq_domain *domain)
> +{
> +	return false;
> +}
> +
> +static inline bool irq_domain_is_msi_remap(struct irq_domain *domain)
> +{
> +	return false;
> +}
> +
> +static inline bool
> +irq_domain_hierarchical_is_msi_remap(struct irq_domain *domain)
> +{
> +	return false;
> +}
>  #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
>  
>  #else /* CONFIG_IRQ_DOMAIN */
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 8c0a0ae..101ee8f 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -1392,6 +1392,22 @@ static void irq_domain_check_hierarchy(struct irq_domain *domain)
>  	if (domain->ops->alloc)
>  		domain->flags |= IRQ_DOMAIN_FLAG_HIERARCHY;
>  }
> +
> +/**
> + * irq_domain_hierarchical_is_msi_remap - Check if the domain or any
> + * parent has MSI remapping support
> + * @domain: domain pointer
> + */
> +bool irq_domain_hierarchical_is_msi_remap(struct irq_domain *domain)
> +{
> +	struct irq_domain *h = domain;
> +
> +	for (; h; h = h->parent) {
> +		if (irq_domain_is_msi_remap(h))

nit: Why do you need to go via this extra 'h' variable?

	for (; domain; domain = domain->parent) {
		if (irq_domain_is_msi_remap(domain))

should work just as well.

> +			return true;
> +	}
> +	return false;
> +}
>  #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
>  /**
>   * irq_domain_get_irq_data - Get irq_data associated with @virq and @domain
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
