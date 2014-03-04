From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Mar 2014 23:28:51 +0100
Subject: [PATCH v5 3/3] arm64: Add architecture support for PCI
In-Reply-To: <1393948216-11599-4-git-send-email-Liviu.Dudau@arm.com>
References: <1393948216-11599-1-git-send-email-Liviu.Dudau@arm.com>
 <1393948216-11599-4-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <201403042328.51361.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 March 2014, Liviu Dudau wrote:

> +extern int isa_dma_bridge_buggy;

As commented before, I still think we can hardcode this to off

> +unsigned long pci_address_to_pio(phys_addr_t address)
> +{
> +	struct ioresource *res;
> +
> +	list_for_each_entry(res, &io_list, list) {
> +		if (address >= res->start &&
> +			address < res->start + res->size) {
> +			return res->start - address;
> +		}
> +	}
> +
> +	return (unsigned long)-1;
> +}
> +EXPORT_SYMBOL_GPL(pci_address_to_pio);

This has two problems:

- You return the address in bus space not the logical Linux
  port number as powerpc and microblaze do.
- You imply that the window starts at bus address zero, which
  might not be the case.

> +EXPORT_SYMBOL(pcibios_fixup_bus);

no need for this export.

> +/*
> + * We don't have to worry about legacy ISA devices, so nothing to do here
> + */
> +resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> +				resource_size_t size, resource_size_t align)
> +{
> +	return ALIGN(res->start, align);
> +}
> +EXPORT_SYMBOL(pcibios_align_resource);

or this one. Also, the ALIGN() is already done by the PCI core.

	Arnd
