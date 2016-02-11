From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 11 Feb 2016 19:39:12 +0100
Subject: [PATCH V4 22/23] arm64, pci, acpi: Assign legacy IRQs once device
 is enable.
In-Reply-To: <20160211171700.GB25235@red-moon>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
 <1454606941-9523-23-git-send-email-tn@semihalf.com>
 <20160211115843.GA24136@red-moon> <20160211171700.GB25235@red-moon>
Message-ID: <56BCD550.2050601@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.02.2016 18:17, Lorenzo Pieralisi wrote:
> Here (on top of your series), ready for flak.
>
> Lorenzo
>
> -- >8 --
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 0b53262..26ee291 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -45,28 +45,23 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>    */
>   int pcibios_enable_device(struct pci_dev *dev, int mask)
>   {
> -	int ret;
> -
>   	if (pci_has_flag(PCI_PROBE_ONLY))
>   		return 0;
>
> -	ret = pci_enable_resources(dev, mask);
> -	if (ret < 0)
> -		return ret;
> -
> -#ifdef CONFIG_ACPI
> -	if (!pci_dev_msi_enabled(dev))
> -		return acpi_pci_irq_enable(dev);
> -#endif
> -	return 0;
> +	return pci_enable_resources(dev, mask);
>   }
>
>   /*
> - * Try to assign the IRQ number from DT when adding a new device
> + * Try to assign the IRQ number when probing a new device
>    */
> -int pcibios_add_device(struct pci_dev *dev)
> +int pcibios_alloc_irq(struct pci_dev *dev)
>   {
> -	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> +	if (acpi_disabled)
> +		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> +#ifdef CONFIG_ACPI
> +	else
> +		return acpi_pci_irq_enable(dev);
> +#endif
>
>   	return 0;
>   }

I miss that way of solving the problem. OK lets try this way. I will 
integrate it.

Tomasz
