From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 2 Sep 2016 09:42:39 +0100
Subject: [PATCH 1/3] pci: pci-aardvark: move to MSI handling using generic
 MSI support
In-Reply-To: <1472744284-18305-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1472744284-18305-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1472744284-18305-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <57C93B7F.8050909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

I haven't checked things is details (mostly because the resulting diff
is impossible to read), but one thing caught my eye:

On 01/09/16 16:38, Thomas Petazzoni wrote:
> The MSI support introduced with the initial Aardvark driver was based
> on the msi_controller structure and the of_pci_msi_chip_add() /
> of_pci_find_msi_chip_by_node() API, which are being deprecated in
> favor of the generic MSI support.
> 
> Therefore, this commit updates the Aardvark driver to use the generic
> MSI support.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/host/pci-aardvark.c | 172 ++++++++++++++++------------------------
>  1 file changed, 67 insertions(+), 105 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> index ef9893f..0675cfa 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c

[...]

> -static int advk_pcie_setup_msi_irq(struct msi_controller *chip,
> -				   struct pci_dev *pdev,
> -				   struct msi_desc *desc)
> +static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
> +				     unsigned int virq,
> +				     unsigned int nr_irqs, void *args)
>  {
> -	struct advk_pcie *pcie = pdev->bus->sysdata;
> -	struct msi_msg msg;
> -	int virq, hwirq;
> -	phys_addr_t msi_msg_phys;
> -
> -	/* We support MSI, but not MSI-X */
> -	if (desc->msi_attrib.is_msix)
> -		return -EINVAL;

You used not to support MSIX...

[...]

> @@ -677,30 +650,25 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
>  {
>  	struct device *dev = &pcie->pdev->dev;
>  	struct device_node *node = dev->of_node;
> -	struct irq_chip *msi_irq_chip;
> -	struct msi_controller *msi;
> +	struct irq_chip *bottom_ic, *msi_ic;
> +	struct msi_domain_info *msi_di;
>  	phys_addr_t msi_msg_phys;
> -	int ret;
> -
> -	msi_irq_chip = &pcie->msi_irq_chip;
>  
> -	msi_irq_chip->name = devm_kasprintf(dev, GFP_KERNEL, "%s-msi",
> -					    dev_name(dev));
> -	if (!msi_irq_chip->name)
> -		return -ENOMEM;
> +	mutex_init(&pcie->msi_used_lock);
>  
> -	msi_irq_chip->irq_enable = pci_msi_unmask_irq;
> -	msi_irq_chip->irq_disable = pci_msi_mask_irq;
> -	msi_irq_chip->irq_mask = pci_msi_mask_irq;
> -	msi_irq_chip->irq_unmask = pci_msi_unmask_irq;
> +	bottom_ic = &pcie->msi_bottom_irq_chip;
>  
> -	msi = &pcie->msi;
> +	bottom_ic->name = "MSI";
> +	bottom_ic->irq_compose_msi_msg = advk_msi_irq_compose_msi_msg;
> +	bottom_ic->irq_set_affinity = advk_msi_set_affinity;
>  
> -	msi->setup_irq = advk_pcie_setup_msi_irq;
> -	msi->teardown_irq = advk_pcie_teardown_msi_irq;
> -	msi->of_node = node;
> +	msi_ic = &pcie->msi_irq_chip;
> +	msi_ic->name = "advk-MSI";
>  
> -	mutex_init(&pcie->msi_used_lock);
> +	msi_di = &pcie->msi_domain_info;
> +	msi_di->flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		MSI_FLAG_PCI_MSIX;

And yet you now advertize MSIX support. Was this an oversight in the
original code?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
