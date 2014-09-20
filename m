From: robherring2@gmail.com (Rob Herring)
Date: Fri, 19 Sep 2014 19:34:48 -0500
Subject: [PATCH v11 10/10] PCI: Introduce pci_remap_iospace() for remapping
 PCI I/O bus resources into CPU space
In-Reply-To: <1411003825-21521-11-git-send-email-Liviu.Dudau@arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-11-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <541CCBA8.8030406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2014 08:30 PM, Liviu Dudau wrote:
> Introduce a default implementation for remapping PCI bus I/O resources
> onto the CPU address space. Architectures with special needs may
> provide their own version, but most should be able to use this one.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

One nit below, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>

> ---
>  drivers/pci/pci.c             | 33 +++++++++++++++++++++++++++++++++
>  include/asm-generic/pgtable.h |  4 ++++
>  include/linux/pci.h           |  3 +++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 2c9ac70..654b44c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2704,6 +2704,39 @@ int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
>  }
>  EXPORT_SYMBOL(pci_request_regions_exclusive);
>  
> +/**
> + *	pci_remap_iospace - Remap the memory mapped I/O space
> + *	@res: Resource describing the I/O space
> + *	@phys_addr: physical address where the range will be mapped.
> + *
> + *	Remap the memory mapped I/O space described by the @res
> + *	into the CPU physical address space. Only architectures
> + *	that have memory mapped IO defined (and hence PCI_IOBASE)
> + *	should call this function.
> + */
> +int __weak pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> +{
> +	int err = -ENODEV;
> +
> +#ifdef PCI_IOBASE
> +	if (!(res->flags & IORESOURCE_IO))
> +		return -EINVAL;
> +
> +	if (res->end > IO_SPACE_LIMIT)
> +		return -EINVAL;
> +
> +	err = ioremap_page_range(res->start + (unsigned long)PCI_IOBASE,
> +				res->end + 1 + (unsigned long)PCI_IOBASE,
> +				phys_addr, pgprot_device(PAGE_KERNEL));
> +#else
> +	/* this architecture does not have memory mapped I/O space,
> +	   so this function should never be called */
> +	WARN_ON(1);

Printing what the comment says in the warning would be better than
making the user look-up why they got a warning.

Rob
