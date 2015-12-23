From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 23 Dec 2015 12:37:43 +0100
Subject: [PATCH 2/4] irqchip: irq-armada-370-xp: use the generic MSI
 infrastructure
In-Reply-To: <1450707546-15060-3-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Mon, 21 Dec 2015 15:19:04 +0100")
References: <1450707546-15060-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1450707546-15060-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87si2te6pk.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On lun., d?c. 21 2015, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> This commit moves the irq-armada-370-xp driver from using the
> PCI-specific MSI infrastructure to the generic MSI infrastructure, to
> which drivers are progressively converted.
>
> In this hardware, the MSI controller is directly bundled inside the
> interrupt controller, so we have a single Device Tree node to which
> multiple IRQ domaines are attached: the wired interrupt domain and the
> MSI interrupt domain. In order to ensure that they can be
> differentiated, we have to force the bus_token of the wired interrupt
> domain to be DOMAIN_BUS_WIRED. The MSI domain bus_token is
> automatically set to the appropriate value by
> pci_msi_create_irq_domain().

the way git generated the patch make it difficult to read, furthermore I
don't know too much about MSI. So for the bulk of this patch I trust you
and I let the irq experts comment if needed. I still have a minor remark,
see below:

>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/Kconfig             |   1 +
>  drivers/irqchip/irq-armada-370-xp.c | 151 +++++++++++++++---------------------
>  2 files changed, 65 insertions(+), 87 deletions(-)
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index ab672b0..8ccb60e 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -51,6 +51,7 @@ config ARMADA_370_XP_IRQ
>  	bool
>  	default y if ARCH_MVEBU
>  	select GENERIC_IRQ_CHIP
> +	select PCI_MSI_IRQ_DOMAIN if PCI_MSI
>  
>  config ATMEL_AIC_IRQ
>  	bool
> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
> index 3f3a8c3..304166b 100644
> --- a/drivers/irqchip/irq-armada-370-xp.c
> +++ b/drivers/irqchip/irq-armada-370-xp.c
> @@ -71,6 +71,7 @@ static u32 doorbell_mask_reg;
>  static int parent_irq;
>  #ifdef CONFIG_PCI_MSI
>  static struct irq_domain *armada_370_xp_msi_domain;
> +static struct irq_domain *armada_370_xp_msi_inner_domain;
>  static DECLARE_BITMAP(msi_used, PCI_MSI_DOORBELL_NR);
>  static DEFINE_MUTEX(msi_used_lock);
>  static phys_addr_t msi_doorbell_addr;
> @@ -115,127 +116,102 @@ static void armada_370_xp_irq_unmask(struct irq_data *d)
>  
>  #ifdef CONFIG_PCI_MSI
>  
> -static int armada_370_xp_alloc_msi(void)
> -{
> -	int hwirq;
> -
> -	mutex_lock(&msi_used_lock);
> -	hwirq = find_first_zero_bit(&msi_used, PCI_MSI_DOORBELL_NR);
> -	if (hwirq >= PCI_MSI_DOORBELL_NR)
> -		hwirq = -ENOSPC;
> -	else
> -		set_bit(hwirq, msi_used);
> -	mutex_unlock(&msi_used_lock);
> +static struct irq_chip armada_370_xp_msi_irq_chip = {
> +	.name = "armada_370_xp_msi_irq",
> +	.irq_enable = pci_msi_unmask_irq,
> +	.irq_disable = pci_msi_mask_irq,
> +	.irq_mask = pci_msi_mask_irq,
> +	.irq_unmask = pci_msi_unmask_irq,
> +};
>  
> -	return hwirq;
> -}
> +static struct msi_domain_info armada_370_xp_msi_domain_info = {
> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		   MSI_FLAG_MULTI_PCI_MSI),
> +	.chip	= &armada_370_xp_msi_irq_chip,
> +};
>  
> -static void armada_370_xp_free_msi(int hwirq)
> +static void armada_370_xp_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  {
> -	mutex_lock(&msi_used_lock);
> -	if (!test_bit(hwirq, msi_used))
> -		pr_err("trying to free unused MSI#%d\n", hwirq);
> -	else
> -		clear_bit(hwirq, msi_used);
> -	mutex_unlock(&msi_used_lock);
> +	msg->address_lo = lower_32_bits(msi_doorbell_addr);
> +	msg->address_hi = upper_32_bits(msi_doorbell_addr);
> +	msg->data = 0xf00 | (data->hwirq + PCI_MSI_DOORBELL_START);

So here instead of using the 16 value you use PCI_MSI_DOORBELL_START
which seems better. What about using it also in
armada_370_xp_handle_msi_irq?

>  }
>  
> -static int armada_370_xp_setup_msi_irq(struct msi_controller *chip,
> -				       struct pci_dev *pdev,
> -				       struct msi_desc *desc)
> +static int armada_370_xp_msi_set_affinity(struct irq_data *irq_data,
> +					  const struct cpumask *mask, bool force)
>  {
> -	struct msi_msg msg;
> -	int virq, hwirq;
> +	 return -EINVAL;
> +}
>  
> -	/* We support MSI, but not MSI-X */
> -	if (desc->msi_attrib.is_msix)
> -		return -EINVAL;
> +static struct irq_chip armada_370_xp_msi_bottom_irq_chip = {
> +	.name			= "MPIC MSI",
> +	.irq_compose_msi_msg	= armada_370_xp_compose_msi_msg,
> +	.irq_set_affinity	= armada_370_xp_msi_set_affinity,
> +};
>  
> -	hwirq = armada_370_xp_alloc_msi();
> -	if (hwirq < 0)
> -		return hwirq;
> +static int armada_370_xp_msi_alloc(struct irq_domain *domain, unsigned int virq,
> +				   unsigned int nr_irqs, void *args)
> +{
> +	int hwirq;
>  
> -	virq = irq_create_mapping(armada_370_xp_msi_domain, hwirq);
> -	if (!virq) {
> -		armada_370_xp_free_msi(hwirq);
> -		return -EINVAL;
> +	mutex_lock(&msi_used_lock);
> +	hwirq = find_first_zero_bit(&msi_used, PCI_MSI_DOORBELL_NR);
> +	if (hwirq >= PCI_MSI_DOORBELL_NR) {
> +		mutex_unlock(&msi_used_lock);
> +		return -ENOSPC;
>  	}
>  
> -	irq_set_msi_desc(virq, desc);
> +	set_bit(hwirq, msi_used);
> +	mutex_unlock(&msi_used_lock);
>  
> -	msg.address_lo = msi_doorbell_addr;
> -	msg.address_hi = 0;
> -	msg.data = 0xf00 | (hwirq + 16);
> +	irq_domain_set_info(domain, virq, hwirq, &armada_370_xp_msi_bottom_irq_chip,
> +			    domain->host_data, handle_simple_irq,
> +			    NULL, NULL);
>  
> -	pci_write_msi_msg(virq, &msg);
> -	return 0;
> +	return hwirq;
>  }
>  
> -static void armada_370_xp_teardown_msi_irq(struct msi_controller *chip,
> -					   unsigned int irq)
> +static void armada_370_xp_msi_free(struct irq_domain *domain,
> +				   unsigned int virq, unsigned int nr_irqs)
>  {
> -	struct irq_data *d = irq_get_irq_data(irq);
> -	unsigned long hwirq = d->hwirq;
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
>  
> -	irq_dispose_mapping(irq);
> -	armada_370_xp_free_msi(hwirq);
> -}
> -
> -static struct irq_chip armada_370_xp_msi_irq_chip = {
> -	.name = "armada_370_xp_msi_irq",
> -	.irq_enable = pci_msi_unmask_irq,
> -	.irq_disable = pci_msi_mask_irq,
> -	.irq_mask = pci_msi_mask_irq,
> -	.irq_unmask = pci_msi_unmask_irq,
> -};
> -
> -static int armada_370_xp_msi_map(struct irq_domain *domain, unsigned int virq,
> -				 irq_hw_number_t hw)
> -{
> -	irq_set_chip_and_handler(virq, &armada_370_xp_msi_irq_chip,
> -				 handle_simple_irq);
> -
> -	return 0;
> +	mutex_lock(&msi_used_lock);
> +	if (!test_bit(d->hwirq, msi_used))
> +		pr_err("trying to free unused MSI#%lu\n", d->hwirq);
> +	else
> +		clear_bit(d->hwirq, msi_used);
> +	mutex_unlock(&msi_used_lock);
>  }
>  
> -static const struct irq_domain_ops armada_370_xp_msi_irq_ops = {
> -	.map = armada_370_xp_msi_map,
> +static const struct irq_domain_ops armada_370_xp_msi_domain_ops = {
> +	.alloc	= armada_370_xp_msi_alloc,
> +	.free	= armada_370_xp_msi_free,
>  };
>  
>  static int armada_370_xp_msi_init(struct device_node *node,
>  				  phys_addr_t main_int_phys_base)
>  {
> -	struct msi_controller *msi_chip;
>  	u32 reg;
> -	int ret;
>  
>  	msi_doorbell_addr = main_int_phys_base +
>  		ARMADA_370_XP_SW_TRIG_INT_OFFS;
>  
> -	msi_chip = kzalloc(sizeof(*msi_chip), GFP_KERNEL);
> -	if (!msi_chip)
> +	armada_370_xp_msi_inner_domain =
> +		irq_domain_add_linear(NULL, PCI_MSI_DOORBELL_NR,
> +				      &armada_370_xp_msi_domain_ops, NULL);
> +	if (!armada_370_xp_msi_inner_domain)
>  		return -ENOMEM;
>  
> -	msi_chip->setup_irq = armada_370_xp_setup_msi_irq;
> -	msi_chip->teardown_irq = armada_370_xp_teardown_msi_irq;
> -	msi_chip->of_node = node;
> -
>  	armada_370_xp_msi_domain =
> -		irq_domain_add_linear(NULL, PCI_MSI_DOORBELL_NR,
> -				      &armada_370_xp_msi_irq_ops,
> -				      NULL);
> +		pci_msi_create_irq_domain(of_node_to_fwnode(node),
> +					  &armada_370_xp_msi_domain_info,
> +					  armada_370_xp_msi_inner_domain);
>  	if (!armada_370_xp_msi_domain) {
> -		kfree(msi_chip);
> +		irq_domain_remove(armada_370_xp_msi_inner_domain);
>  		return -ENOMEM;
>  	}
>  
> -	ret = of_pci_msi_chip_add(msi_chip);
> -	if (ret < 0) {
> -		irq_domain_remove(armada_370_xp_msi_domain);
> -		kfree(msi_chip);
> -		return ret;
> -	}
> -
>  	reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS)
>  		| PCI_MSI_DOORBELL_MASK;
>  
> @@ -427,12 +403,12 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs *regs, bool is_chained)
>  			continue;
>  
>  		if (is_chained) {
> -			irq = irq_find_mapping(armada_370_xp_msi_domain,
> +			irq = irq_find_mapping(armada_370_xp_msi_inner_domain,
>  					       msinr - 16);
Could we use also PCI_MSI_DOORBELL_START here?

>  			generic_handle_irq(irq);
>  		} else {
>  			irq = msinr - 16;
and here?

> -			handle_domain_irq(armada_370_xp_msi_domain,
> +			handle_domain_irq(armada_370_xp_msi_inner_domain,
>  					  irq, regs);
>  		}
>  	}
> @@ -604,6 +580,7 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
>  	armada_370_xp_mpic_domain =
>  		irq_domain_add_linear(node, nr_irqs,
>  				&armada_370_xp_mpic_irq_ops, NULL);
> +	armada_370_xp_mpic_domain->bus_token = DOMAIN_BUS_WIRED;
>  
>  	BUG_ON(!armada_370_xp_mpic_domain);
>  
> -- 
> 2.6.4
>
Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
