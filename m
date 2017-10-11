From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 10 Oct 2017 21:18:15 -0500
Subject: [PATCH] PCI: aardvark: Move to struct pci_host_bridge IRQ
 mapping functions
In-Reply-To: <20171009070049.2684-1-thomas.petazzoni@free-electrons.com>
References: <20171009070049.2684-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20171011021815.GC25517@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 09, 2017 at 09:00:49AM +0200, Thomas Petazzoni wrote:
> struct pci_host_bridge gained hooks to map/swizzle IRQs, so that the
> IRQ mapping can be done automatically by PCI core code through the
> pci_assign_irq() function instead of resorting to arch-specific
> implementation callbacks to carry out the same task which force PCI
> host bridge drivers implementation to implement per-arch kludges to
> carry out a task that is inherently architecture agnostic.
> 
> Commit 769b461fc0c0 ("arm64: PCI: Drop DT IRQ allocation from
> pcibios_alloc_irq()") was assuming all PCI host controller drivers had
> been converted to use ->map_irq(), but that wasn't the case:
> pci-aardvark had not been converted. Due to this, it broke the support
> for legacy PCI interrupts when using the pci-aardvark driver (used on
> Marvell Armada 3720 platforms).
> 
> In order to fix this, we make sure the ->map_irq and ->swizzle_irq
> fields of pci_host_bridge are properly filled in.
> 
> Fixes: 769b461fc0c0 ("arm64: PCI: Drop DT IRQ allocation from pcibios_alloc_irq()")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v4.13+

Applied to for-linus for v4.14, thanks!

> ---
> Changes since v2:
>  - Adjust commit title to match other commits doing the same change in
>    other drivers
>  - Improve commit log.
> ---
>  drivers/pci/host/pci-aardvark.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> index 89f4e3d072d7..26ed0c08f209 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c
> @@ -935,6 +935,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  	bridge->sysdata = pcie;
>  	bridge->busnr = 0;
>  	bridge->ops = &advk_pcie_ops;
> +	bridge->map_irq = of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq = pci_common_swizzle;
>  
>  	ret = pci_scan_root_bus_bridge(bridge);
>  	if (ret < 0) {
> -- 
> 2.13.6
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
