From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 29 Jun 2018 14:43:17 +0100
Subject: [PATCH] PCI: xilinx-nwl: add missing of_node_put()
In-Reply-To: <1528967074-30024-1-git-send-email-hofrat@osadl.org>
References: <1528967074-30024-1-git-send-email-hofrat@osadl.org>
Message-ID: <20180629134317.GE9643@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2018 at 11:04:34AM +0200, Nicholas Mc Guire wrote:
>  The call to of_get_next_child() returns a node pointer with
> refcount incremented thus it must be explicitly decremented
> here after the last usage.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe Host Controller")
> ---
> 
> Problem found by an experimental cocinelle script
> 
> Patch was compile tested with: multi_v7_defconfig + ARCH_ZYNQ=y,
> COMPILE_TEST=y, PCIE_XILINX_NWL=y
> (one sparse warning though not related to the change proposed though)
> 
> Patch is against 4.17.0 (localversion-next is next-20180613)
> 
>  drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/controller-fixes to be tentatively merged for
-rc4, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 6a4bbb5..fb32840 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -559,7 +559,7 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
>  							PCI_NUM_INTX,
>  							&legacy_domain_ops,
>  							pcie);
> -
> +	of_node_put(legacy_intc_node);
>  	if (!pcie->legacy_irq_domain) {
>  		dev_err(dev, "failed to create IRQ domain\n");
>  		return -ENOMEM;
> -- 
> 2.1.4
> 
