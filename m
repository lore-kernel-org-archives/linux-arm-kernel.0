From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 21 Jul 2015 16:37:04 -0500
Subject: [PATCH v4 19/19] PCI/MSI: Drop domain field from msi_controller
In-Reply-To: <1436962613-17359-20-git-send-email-marc.zyngier@arm.com>
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
 <1436962613-17359-20-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150721213704.GC3691@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 01:16:53PM +0100, Marc Zyngier wrote:
> The only three users of that field are not using the msi_controller
> structure anymore, so drop it altogether.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi.c   | 2 --
>  include/linux/msi.h | 3 ---
>  2 files changed, 5 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index c77fdaf..31bae50 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -42,8 +42,6 @@ static struct irq_domain *pci_msi_get_domain(struct pci_dev *dev)
>  	struct irq_domain *domain = NULL;
>  
>  	domain = dev_get_msi_domain(&dev->dev);
> -	if (!domain && dev->bus->msi)
> -		domain = dev->bus->msi->domain;
>  	if (!domain)
>  		domain = arch_get_pci_msi_domain(dev);

I guess this takes care of the "assignment inside if" question :)

> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index b55cf63..e29c31f 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -124,9 +124,6 @@ struct msi_controller {
>  	struct device *dev;
>  	struct device_node *of_node;
>  	struct list_head list;
> -#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> -	struct irq_domain *domain;
> -#endif
>  
>  	int (*setup_irq)(struct msi_controller *chip, struct pci_dev *dev,
>  			 struct msi_desc *desc);
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
