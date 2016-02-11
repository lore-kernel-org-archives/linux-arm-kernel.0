From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 11 Feb 2016 11:58:53 +0000
Subject: [PATCH V4 22/23] arm64, pci, acpi: Assign legacy IRQs once
 device is enable.
In-Reply-To: <1454606941-9523-23-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
 <1454606941-9523-23-git-send-email-tn@semihalf.com>
Message-ID: <20160211115843.GA24136@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 06:29:00PM +0100, Tomasz Nowicki wrote:
> This is the last step before enabling generic ACPI PCI host controller
> for ARM64. We need to take care of legacy IRQ mapping for non-MSI(X)
> PCI devices. pcibios_enable_device() boot order is not sensitive to
> ACPI device enumeration, so it is the best place to assign device's IRQs.

I guess you are referring to:

https://lists.linaro.org/pipermail/linaro-acpi/2015-October/005944.html

It is weird that the dependency can't be enforced, I will have a look
into this, it would be nice to have DT and ACPI legacy IRQs mapping
confined in pcibios_add_device() so that we can remove them in one go
when Matthew's series is merged.

As for the MSI check, by reading commit history its need I think
it harks back to bba6f6fc, which was supposed to be a quick hack and it
has been in the kernel for 9 years :), is it really needed ?

> NOTE: *This is going to be temporary solution*. There is ongoing work
> which aims for cleaning legacy IRQ allocation, see [1].
> We can consider this patch as the necessary evil which will be removed
> once [1] series hits mailnline in the near future.
> 
> 1. http://comments.gmane.org/gmane.linux.kernel.pci/46461
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  arch/arm64/kernel/pci.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 023b983..d1a701f 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -39,16 +39,26 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  }
>  
>  /**
> - * pcibios_enable_device - Enable I/O and memory.
> + * pcibios_enable_device - Enable I/O, memory and legacy IRQs for ACPI.
>   * @dev: PCI device to be enabled
>   * @mask: bitmask of BARs to enable
>   */
>  int pcibios_enable_device(struct pci_dev *dev, int mask)
>  {
> +	int ret;
> +
>  	if (pci_has_flag(PCI_PROBE_ONLY))
>  		return 0;
>  
> -	return pci_enable_resources(dev, mask);
> +	ret = pci_enable_resources(dev, mask);
> +	if (ret < 0)
> +		return ret;
> +
> +#ifdef CONFIG_ACPI
> +	if (!pci_dev_msi_enabled(dev))
> +		return acpi_pci_irq_enable(dev);

You need a guard here anyway, we do not want to probe ACPI IRQ if
it is disabled (ie acpi_pci_disabled). Same goes for DT in
pcibios_add_device(), which is not making this code any nicer.

Lorenzo

> +#endif
> +	return 0;
>  }
>  
>  /*
> -- 
> 1.9.1
> 
