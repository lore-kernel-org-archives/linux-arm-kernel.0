From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 5 Oct 2017 12:55:47 -0500
Subject: [PATCH v2 7/7] PCI: aardvark: define IRQ related hooks in
 pci_host_bridge
In-Reply-To: <20170928125838.11887-8-thomas.petazzoni@free-electrons.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20170928125838.11887-8-thomas.petazzoni@free-electrons.com>
Message-ID: <20171005175547.GT25517@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Lorenzo]

On Thu, Sep 28, 2017 at 02:58:38PM +0200, Thomas Petazzoni wrote:
> Commit 769b461fc0c0 ("arm64: PCI: Drop DT IRQ allocation from
> pcibios_alloc_irq()") was assuming all PCI host controller drivers had
> been converted to use ->map_irq(), but that wasn't the case:
> pci-aardvark had not been converted. Due to this, it broke the support
> for legacy PCI interrupts when using the pci-aardvark driver (used on
> Marvell Armada 3720 platforms).

Lorenzo is pretty thorough, but maybe pci-aardvark.c got overlooked.
Cc'ing him just to make sure there's nothing deeper than that.

> In order to fix this, we make sure the ->map_irq and ->swizzle_irq
> fields of pci_host_bridge are properly filled in.
> 
> Fixes: 769b461fc0c0 ("arm64: PCI: Drop DT IRQ allocation from pcibios_alloc_irq()")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v4.13+
> ---
>  drivers/pci/host/pci-aardvark.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> index c1093b023e48..249a088b463c 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c
> @@ -998,6 +998,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  	bridge->sysdata = pcie;
>  	bridge->busnr = 0;
>  	bridge->ops = &advk_pcie_ops;
> +	bridge->map_irq = of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq = pci_common_swizzle;
>  
>  	ret = pci_scan_root_bus_bridge(bridge);
>  	if (ret < 0) {
> -- 
> 2.13.5
> 
