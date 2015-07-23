From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 23 Jul 2015 08:14:21 -0500
Subject: [PATCH v5 07/19] PCI/MSI: Let pci_msi_get_domain use struct
 device's msi_domain
In-Reply-To: <1437643598-19795-8-git-send-email-marc.zyngier@arm.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
 <1437643598-19795-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150723131421.GU21967@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 10:26:26AM +0100, Marc Zyngier wrote:
> Now that we can easily find which MSI domain a PCI device is
> using, use dev_get_msi_domain as a way to retrieve the information.
> 
> The original code is still used as a fallback.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index ef4ec6e..da3c607 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -39,14 +39,16 @@ struct irq_domain * __weak arch_get_pci_msi_domain(struct pci_dev *dev)
>  
>  static struct irq_domain *pci_msi_get_domain(struct pci_dev *dev)
>  {
> -	struct irq_domain *domain = NULL;
> +	struct irq_domain *domain;
> +
> +	domain = dev_get_msi_domain(&dev->dev);
> +	if (domain)
> +		return domain;
>  
> -	if (dev->bus->msi)
> -		domain = dev->bus->msi->domain;
> -	if (!domain)
> -		domain = arch_get_pci_msi_domain(dev);
> +	if (dev->bus->msi && (domain = dev->bus->msi->domain))
> +		return domain;
>  
> -	return domain;
> +	return arch_get_pci_msi_domain(dev);
>  }
>  
>  static int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> -- 
> 2.1.4
> 
