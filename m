From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 7 Apr 2017 18:18:12 +0100
Subject: [PATCH] arm64: acpi: Support PCI devices numa_node property in
 ACPI mode
In-Reply-To: <20170406114711.17261-1-s.temerkhanov@gmail.com>
References: <20170406114711.17261-1-s.temerkhanov@gmail.com>
Message-ID: <20170407171812.GA12012@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergey,

On Thu, Apr 06, 2017 at 11:47:11AM +0000, Sergey Temerkhanov wrote:
> This commit modifies ARM64-specific ACPI PCI support functions to
> properly set the numa_node property on host bridges and thus on PCI
> devices. Such support requires _PXM objects to be set in DSDT/SSDT
> tables describing PCI root bridges
> 
> Signed-off-by: Sergey Temerkhanov <s.temerkhanov@gmail.com>
> ---
>  arch/arm64/kernel/pci.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 4f0e3ebfea4b..c45c7a26f984 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -81,7 +81,16 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
>  
>  int pcibus_to_node(struct pci_bus *bus)
>  {
> -	return dev_to_node(&bus->dev);
> +	struct pci_config_window *cfg = bus->sysdata;

Well, this implicit cast is a guess (ie it might be a DT sysdata
and there you can't have a clue on what it really is).

> +	struct acpi_device *adev = NULL;
> +	struct device *dev;
> +
> +	if (!acpi_disabled)
> +		adev = to_acpi_device(cfg->parent);
> +
> +	dev = adev ? &adev->dev : &bus->dev;
> +
> +	return dev_to_node(dev);
>  }
>  EXPORT_SYMBOL(pcibus_to_node);
>  
> @@ -186,6 +195,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	struct pci_bus *bus, *child;
>  	struct acpi_pci_root_ops *root_ops;
>  
> +	set_dev_node(&root->device->dev, node);

Ok I suspect this is one of those catch-22 issues with host bridge
creation/scan code (like domain nr), let me have a look I will send
you a patch next week when I figure out the call ordering required
to make this work, I want to make sure we can make this work with
DT and ACPI alike.

Thanks !
Lorenzo

> +
>  	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
>  	if (!ri)
>  		return NULL;
> -- 
> 2.12.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
