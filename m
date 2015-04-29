From: wangyijing@huawei.com (Yijing Wang)
Date: Wed, 29 Apr 2015 09:12:56 +0800
Subject: [PATCH Part1 v11 5/5] PCI: iproc: Use pci_scan_root_bus() instead
 of pci_create_root_bus()
In-Reply-To: <1430204499-19571-6-git-send-email-wangyijing@huawei.com>
References: <1430204499-19571-1-git-send-email-wangyijing@huawei.com>
 <1430204499-19571-6-git-send-email-wangyijing@huawei.com>
Message-ID: <55403018.4020008@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn, please ignore this patch, it's not correct. I prefer to refactor it by add a new pci_host_bridge_ops in later patch.
What do you think about the prior four patches ? I hope they could be merged first, they are independent.

Thanks!
Yijing.

On 2015/4/28 15:01, Yijing Wang wrote:
> Pci_bus_add_devices() was ripped out of pci_scan_root_bus().
> Now pci_scan_root_bus() == pci_create_root_bus() +
> pci_scan_child_bus() if busn resource is supplied.
> iproc added the busn resource to resources list
> in of_pci_get_host_bridge_resources(). So it should be safe
> to use pci_scan_root_bus() instead.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> CC: Ray Jui <rjui@broadcom.com>
> ---
>  drivers/pci/host/pcie-iproc.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 329e1b5..9622ebf 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -210,10 +210,10 @@ int iproc_pcie_setup(struct iproc_pcie *pcie)
>  
>  	pcie->sysdata.private_data = pcie;
>  
> -	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops,
> +	bus = pci_scan_root_bus(pcie->dev, 0, &iproc_pcie_ops,
>  				  &pcie->sysdata, pcie->resources);
>  	if (!bus) {
> -		dev_err(pcie->dev, "unable to create PCI root bus\n");
> +		dev_err(pcie->dev, "unable to scan PCI root bus\n");
>  		ret = -ENOMEM;
>  		goto err_power_off_phy;
>  	}
> @@ -227,7 +227,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie)
>  
>  	iproc_pcie_enable(pcie);
>  
> -	pci_scan_child_bus(bus);
>  	pci_assign_unassigned_bus_resources(bus);
>  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>  	pci_bus_add_devices(bus);
> 


-- 
Thanks!
Yijing
