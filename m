From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 8 Oct 2015 10:02:43 -0500
Subject: [PATCH v4 4/5] PCI: generic: Correct, and avoid overflow, in
 bus_max calculation.
In-Reply-To: <1443811443-18878-5-git-send-email-ddaney.cavm@gmail.com>
References: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com>
 <1443811443-18878-5-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20151008150243.GC3885@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Arnd]

And this one?

On Fri, Oct 02, 2015 at 11:44:02AM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> There are two problems with the bus_max calculation:
> 
> 1) The u8 data type can overflow for large config space windows.
> 
> 2) The calculation is incorrect for a bus range that doesn't start at
>    zero.
> 
> Since the configuration space is relative to bus zero, make bus_max
> just be the size of the config window scaled by bus_shift.  Then clamp
> it to a maximum of 255, per PCI.  Use a data type of int to avoid
> overflow problems.
> 
> Update host-generic-pci.txt to clarify the semantics of the "reg"
> property with respect to non-zero starting bus numbers.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
> Change from V3: Add to explanation of "reg" property in
> host-generic-pci.txt.  Add error message if "reg" property is too big.
> 
>  Documentation/devicetree/bindings/pci/host-generic-pci.txt |  6 +++++-
>  drivers/pci/host/pci-host-generic.c                        | 12 +++++++++---
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.txt b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> index cf3e205..42303bb 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> @@ -34,7 +34,11 @@ Properties of the host controller node:
>  - #size-cells    : Must be 2.
>  
>  - reg            : The Configuration Space base address and size, as accessed
> -                   from the parent bus.
> +                   from the parent bus.  The base address corresponds to
> +                   bus zero, even though the "bus-range" property may specify
> +                   a different starting bus number.  The driver must only map
> +                   or access the portion of the Configuration Space that
> +                   corresponds to the "bus-range"
>  
>  
>  Properties of the /chosen node:
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index 216ded5..5cce837 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -164,7 +164,7 @@ out_release_res:
>  static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>  {
>  	int err;
> -	u8 bus_max;
> +	int bus_max;
>  	resource_size_t busn;
>  	struct resource *bus_range;
>  	struct device *dev = pci->host.dev.parent;
> @@ -177,8 +177,14 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>  	}
>  
>  	/* Limit the bus-range to fit within reg */
> -	bus_max = pci->cfg.bus_range->start +
> -		  (resource_size(&pci->cfg.res) >> pci->cfg.ops->bus_shift) - 1;
> +	bus_max = (resource_size(&pci->cfg.res) >> pci->cfg.ops->bus_shift) - 1;
> +	if (bus_max > 255) {
> +		dev_err(dev,
> +			"\"reg\" size corresponds to bus %d, truncating to 255\n",
> +			bus_max);
> +		bus_max = 255;
> +	}
> +
>  	pci->cfg.bus_range->end = min_t(resource_size_t,
>  					pci->cfg.bus_range->end, bus_max);
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
