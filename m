From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 7 Jun 2016 18:56:14 -0500
Subject: [PATCH V8 4/9] acpi, pci: Support IO resources when parsing PCI
 host bridge resources.
In-Reply-To: <1464621262-26770-5-git-send-email-tn@semihalf.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-5-git-send-email-tn@semihalf.com>
Message-ID: <20160607235614.GC4759@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 05:14:17PM +0200, Tomasz Nowicki wrote:
> Platforms that have memory mapped IO port (such as ARM64) need special
> handling for PCI I/O resources. For host bridge's resource probing case
> these resources need to be fixed up with pci_register_io_range/pci_remap_iospace etc.
> 
> The same I/O resources need to be released after hotplug
> removal so that it can be re-added back by the pci_remap_iospace
> function during insertion. As a consequence we unmap I/O resources
> with pci_unmap_iospace when we release host bridge resources.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/acpi/pci_root.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index ae3fe4e..ee3b728 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -720,6 +720,40 @@ next:
>  	}
>  }
>  
> +#ifdef PCI_IOBASE
> +static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
> +{
> +	struct resource *res = entry->res;
> +	resource_size_t cpu_addr = res->start;
> +	resource_size_t pci_addr = cpu_addr - entry->offset;
> +	resource_size_t length = resource_size(res);
> +	unsigned long port;
> +
> +	if (pci_register_io_range(cpu_addr, length))
> +		goto err;
> +
> +	port = pci_address_to_pio(cpu_addr);
> +	if (port == (unsigned long)-1)
> +		goto err;
> +
> +	res->start = port;
> +	res->end = port + length - 1;
> +	entry->offset = port - pci_addr;
> +
> +	if (pci_remap_iospace(res, cpu_addr) < 0)
> +		goto err;
> +
> +	pr_info("Remapped I/O %pa to %pR\n", &cpu_addr, res);
> +	return;
> +err:
> +	res->flags |= IORESOURCE_DISABLED;

Trivial, but I might write this as:

    res->flags |= IORESOURCE_DISABLED;
    if (pci_register_io_range(cpu_addr, length))
      return;
    ...
    if (pci_remap_iospace(res, cpu_addr) < 0)
      return;

    res->flags &= ~IORESOURCE_DISABLED;
    pr_info("Remapped I/O %pa to %pR\n", &cpu_addr, res);
  }

to get rid of the gotos.  But I dunno, it's a little ugly to fiddle
with res->flags in the case where everything succeeds.

> +}
> +#else
> +static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
> +{
> +}
> +#endif

Rafael's code here, and I know he had an earlier comment about
in-function #ifdefs, so I don't know what he thinks here.  To me,
it would be simpler to move this ifdef inside so we don't have to
repeat the function signature.
