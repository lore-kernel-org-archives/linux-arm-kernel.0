From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 26 May 2015 19:11:34 -0500
Subject: [PATCH Part1 v11 1/5] PCI: mvebu: Use pci_common_init_dev() to
 simplify code
In-Reply-To: <1430204499-19571-2-git-send-email-wangyijing@huawei.com>
References: <1430204499-19571-1-git-send-email-wangyijing@huawei.com>
 <1430204499-19571-2-git-send-email-wangyijing@huawei.com>
Message-ID: <20150527001134.GS32152@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 03:01:35PM +0800, Yijing Wang wrote:
> Mvebu_pcie_scan_bus() is not necessary, we could use
> pci_common_init_dev() instead of pci_common_init(),
> and pass the device pointer as the parent. Then
> pci_scan_root_bus() will be called to scan the pci busses.
> 
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> CC: Jason Cooper <jason@lakedaemon.net>

Thomas, Jason, any input?

> ---
>  drivers/pci/host/pci-mvebu.c |   18 +-----------------
>  1 files changed, 1 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 1ab8635..70aa095 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -751,21 +751,6 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
>  	return 1;
>  }
>  
> -static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
> -{
> -	struct mvebu_pcie *pcie = sys_to_pcie(sys);
> -	struct pci_bus *bus;
> -
> -	bus = pci_create_root_bus(&pcie->pdev->dev, sys->busnr,
> -				  &mvebu_pcie_ops, sys, &sys->resources);
> -	if (!bus)
> -		return NULL;
> -
> -	pci_scan_child_bus(bus);
> -
> -	return bus;
> -}
> -
>  static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
>  						 const struct resource *res,
>  						 resource_size_t start,
> @@ -809,12 +794,11 @@ static void mvebu_pcie_enable(struct mvebu_pcie *pcie)
>  	hw.nr_controllers = 1;
>  	hw.private_data   = (void **)&pcie;
>  	hw.setup          = mvebu_pcie_setup;
> -	hw.scan           = mvebu_pcie_scan_bus;
>  	hw.map_irq        = of_irq_parse_and_map_pci;
>  	hw.ops            = &mvebu_pcie_ops;
>  	hw.align_resource = mvebu_pcie_align_resource;
>  
> -	pci_common_init(&hw);
> +	pci_common_init_dev(&pcie->pdev->dev, &hw);
>  }
>  
>  /*
> -- 
> 1.7.1
> 
