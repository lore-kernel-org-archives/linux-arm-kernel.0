From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 27 Oct 2015 09:48:05 -0500
Subject: [PATCH V4 8/8] PCI: ACPI: Add support for PCI device DMA coherency
In-Reply-To: <1445442731-28819-9-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1445442731-28819-9-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <20151027144805.GD8660@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 08:52:11AM -0700, Suravee Suthikulpanit wrote:
> This patch adds support for setting up PCI device DMA coherency from
> ACPI _CCA object that should normally be specified in the DSDT node
> of its PCI host bridge.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  drivers/pci/probe.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 09264f8..6e9f7e6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1642,17 +1642,26 @@ static void pci_set_msi_domain(struct pci_dev *dev)
>   * @dev: ptr to pci_dev struct of the PCI device
>   *
>   * Function to update PCI devices's DMA configuration using the same
> - * info from the OF node of host bridge's parent (if any).
> + * info from the OF node or ACPI node of host bridge's parent (if any).
>   */
>  static void pci_dma_configure(struct pci_dev *dev)
>  {
>  	struct device *bridge = pci_get_host_bridge_device(dev);
>  
>  	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
> -		if (!bridge->parent)
> -			return;
> -
> -		of_dma_configure(&dev->dev, bridge->parent->of_node);
> +		if (bridge->parent)
> +			of_dma_configure(&dev->dev,
> +					 bridge->parent->of_node);

This fixes the leak I mentioned earlier, since we now put the bridge
device before returning.  But I guess I'd still prefer to see the leak
fix as a patch by itself instead of fixing it incidentally here.

> +	} else if (has_acpi_companion(bridge)) {
> +		struct acpi_device *adev = to_acpi_node(bridge->fwnode);
> +		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
> +
> +		if (attr != DEV_DMA_NOT_SUPPORTED)
> +			arch_setup_dma_ops(&dev->dev, 0, 0, NULL,
> +					   attr == DEV_DMA_COHERENT);
> +		else
> +			WARN(1, FW_BUG "PCI device %s fail to setup DMA.\n",
> +			     pci_name(dev));

This should use dev_warn() so the format is the same as for other
messages related to "dev".

Personally, I would write this as:

  if (attr == DEV_DMA_NOT_SUPPORTED)
    dev_warn(&dev->dev, "DMA not supported\n");
  else
    arch_setup_dma_ops(...);

to avoid the double negative in the conditional.

>  	}
>  
>  	pci_put_host_bridge_device(bridge);
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
