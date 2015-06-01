From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 01 Jun 2015 09:55:25 +0100
Subject: [PATCH 2/4]: Change msi to support the Mbigen interrupt
In-Reply-To: <55692C2D.50005@huawei.com>
References: <55692C2D.50005@huawei.com>
Message-ID: <556C1DFD.6000907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/15 04:19, majun (F) wrote:
> This patch is applied to support the interrupts from Mbigen.
> 
> As a interrupt controller, Mbigen is used as a child domain of MSI
> domain just like pci device.
> 
> Change log:
> --add IRQ_DOMAIN_FLAG_MBIGEN to presents the interrupt from mbigen
> --add function is_mbigen_domain to check the interrupt domain
> --modified irq_chip_write_msi_msg to use the different message write function
>   for interrupt from mbigen
> 
> Signed-off-by: Ma Jun <majun258@huawei.com>
> ---
>  include/linux/irqdomain.h |    2 +-
>  include/linux/msi.h       |    1 +
>  kernel/irq/msi.c          |   22 +++++++++++++++++++++-
>  3 files changed, 23 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 include/linux/msi.h
>  mode change 100644 => 100755 kernel/irq/msi.c
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 676d730..cb6b33a 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -136,7 +136,7 @@ enum {
> 
>  	/* Core calls alloc/free recursive through the domain hierarchy. */
>  	IRQ_DOMAIN_FLAG_AUTO_RECURSIVE	= (1 << 1),
> -
> +	IRQ_DOMAIN_FLAG_MBIGEN = (1 << 2),
>  	/*
>  	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
>  	 * for implementation specific purposes and ignored by the
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> old mode 100644
> new mode 100755
> index 8ac4a68..3e2b6c7
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -239,5 +239,6 @@ irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
>  int pci_msi_domain_check_cap(struct irq_domain *domain,
>  			     struct msi_domain_info *info, struct device *dev);
>  #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
> +bool is_mbigen_domain(struct irq_data *data);
> 
>  #endif /* LINUX_MSI_H */
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> old mode 100644
> new mode 100755
> index 474de5c..1dba07e
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -31,11 +31,31 @@ void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
>  }
>  EXPORT_SYMBOL_GPL(get_cached_msi_msg);
> 
> +bool is_mbigen_domain(struct irq_data *data)
> +{
> +	int virq;
> +	struct irq_domain *domain;
> +	struct irq_data *source_irq_data;
> +
> +	virq = data->irq;
> +	source_irq_data = irq_get_irq_data(virq);
> +	domain = source_irq_data->domain;
> +
> +	if (domain->flags & IRQ_DOMAIN_FLAG_MBIGEN)
> +		return true;
> +	else
> +		return false;
> +
> +}
> +
>  #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
>  static inline void irq_chip_write_msi_msg(struct irq_data *data,
>  					  struct msi_msg *msg)
>  {
> -	data->chip->irq_write_msi_msg(data, msg);
> +	if (is_mbigen_domain(data))
> +		data->chip->irq_write_mbi_msg(data, msg);
> +	else
> +		data->chip->irq_write_msi_msg(data, msg);
>  }
> 
>  /**
> 

This is exactly why I dislike your approach. You start inventing weird
and wonderful callbacks that serve no real purpose. What is wrong with
the existing callback? you are passing the same times to it...

	M.
-- 
Jazz is not dead. It just smells funny...
