From: ray.jui@broadcom.com (Ray Jui)
Date: Thu, 12 Jan 2017 16:40:31 -0800
Subject: [PATCH] PCI: iproc: fix resource allocation for BCMA PCIe
In-Reply-To: <1484265521-13497-1-git-send-email-aospan@netup.ru>
References: <1484265521-13497-1-git-send-email-aospan@netup.ru>
Message-ID: <988ae7dc-ff41-0a06-903f-8681b8ddf13f@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abylay,

On 1/12/2017 3:58 PM, Abylay Ospan wrote:
> Resource allocated on stack was saved by 'devm_request_resource' to
> global 'iomem_resource' but become invalid after 'iproc_pcie_bcma_probe' exit.
> So the global 'iomem_resource' was poisoned. This may cause kernel crash
> or second PCIe bridge registration failure.
> 
> Tested on Broadcom NorthStar machine ('Edgecore ECW7220-L') with two PCIe wifi
> adapters (b43 BCM4331 and ath10k QCA988X).
> 
> Signed-off-by: Abylay Ospan <aospan@netup.ru>

I have not yet looked into this in great details. But if what you
claimed is true, do we have the same problem with multiple PCIe host
drivers that all have their resource allocated on the stack and have
'devm_request_resource' called to save it?

Thanks,

Ray

> ---
>  drivers/pci/host/pcie-iproc-bcma.c | 18 ++++++++----------
>  drivers/pci/host/pcie-iproc.h      |  2 ++
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
> index bd4c9ec..28f9b89 100644
> --- a/drivers/pci/host/pcie-iproc-bcma.c
> +++ b/drivers/pci/host/pcie-iproc-bcma.c
> @@ -44,8 +44,6 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
>  {
>  	struct device *dev = &bdev->dev;
>  	struct iproc_pcie *pcie;
> -	LIST_HEAD(res);
> -	struct resource res_mem;
>  	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> @@ -62,21 +60,21 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
>  	}
>  
>  	pcie->base_addr = bdev->addr;
> +	INIT_LIST_HEAD(&pcie->resources);
>  
> -	res_mem.start = bdev->addr_s[0];
> -	res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
> -	res_mem.name = "PCIe MEM space";
> -	res_mem.flags = IORESOURCE_MEM;
> -	pci_add_resource(&res, &res_mem);
> +	pcie->res_mem.start = bdev->addr_s[0];
> +	pcie->res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
> +	pcie->res_mem.name = "PCIe MEM space";
> +	pcie->res_mem.flags = IORESOURCE_MEM;
> +	pcie->res_mem.child = NULL;
> +	pci_add_resource(&pcie->resources, &pcie->res_mem);
>  
>  	pcie->map_irq = iproc_pcie_bcma_map_irq;
>  
> -	ret = iproc_pcie_setup(pcie, &res);
> +	ret = iproc_pcie_setup(pcie, &pcie->resources);
>  	if (ret)
>  		dev_err(dev, "PCIe controller setup failed\n");
>  
> -	pci_free_resource_list(&res);
> -
>  	bcma_set_drvdata(bdev, pcie);
>  	return ret;
>  }
> diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
> index 04fed8e..866d649 100644
> --- a/drivers/pci/host/pcie-iproc.h
> +++ b/drivers/pci/host/pcie-iproc.h
> @@ -105,6 +105,8 @@ struct iproc_pcie {
>  
>  	bool need_msi_steer;
>  	struct iproc_msi *msi;
> +	struct resource res_mem;
> +	struct list_head resources;
>  };
>  
>  int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res);
> 
