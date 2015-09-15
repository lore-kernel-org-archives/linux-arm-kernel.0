From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Sep 2015 18:55:20 +0100
Subject: [PATCH 5/6] PCI: generic: Pass proper starting bus number to
 pci_scan_root_bus().
In-Reply-To: <1442013719-5001-6-git-send-email-ddaney.cavm@gmail.com>
References: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
 <1442013719-5001-6-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20150915175519.GN31157@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 12, 2015 at 12:21:58AM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> If the bus is being configured with a bus-range that does not start at
> zero, pass that starting bus number to pci_scan_root_bus().  Passing
> the incorrect value of zero causes attempted config accesses outside
> of the supported range, which cascades to an OOPs spew and eventual
> kernel panic.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/pci/host/pci-host-generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index fce5bf7..8219c0b 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -265,7 +265,7 @@ static int gen_pci_probe(struct platform_device *pdev)
>  	if (!pci_has_flag(PCI_PROBE_ONLY))
>  		pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
>  
> -	bus = pci_scan_root_bus(dev, 0,
> +	bus = pci_scan_root_bus(dev, pci->cfg.bus_range->start,
>  				&pci->cfg.ops.ops, pci, &pci->resources);
>  	if (!bus) {
>  		dev_err(dev, "Scanning rootbus failed");

Acked-by: Will Deacon <will.deacon@arm.com>

Will
