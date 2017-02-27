From: ray.jui@broadcom.com (Ray Jui)
Date: Mon, 27 Feb 2017 13:21:39 -0800
Subject: [PATCH 13/20] PCI: iproc-platform: update PCI config space remap
 function
In-Reply-To: <20170227151436.18698-14-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-14-lorenzo.pieralisi@arm.com>
Message-ID: <84a0b24b-3c88-b750-dd9e-1607bc67a0a8@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 2/27/2017 7:14 AM, Lorenzo Pieralisi wrote:
> PCI configuration space should be mapped with a memory region type that
> generates on the CPU host bus non-posted write transations. Update the
> driver to use the devm_pci_remap_cfg* interface to make sure the correct
> memory mappings for PCI configuration space are used.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Jon Mason <jonmason@broadcom.com>
> ---
>  drivers/pci/host/pcie-iproc-platform.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
> index f4909bb..b48d0db 100644
> --- a/drivers/pci/host/pcie-iproc-platform.c
> +++ b/drivers/pci/host/pcie-iproc-platform.c
> @@ -67,7 +67,8 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	pcie->base = devm_ioremap(dev, reg.start, resource_size(&reg));
> +	pcie->base = devm_pci_remap_cfgspace(dev, reg.start,
> +					     resource_size(&reg));

Note these are NOT config space registers; instead, they are host
controller registers. iProc PCIe controller access config space
registers indirectly through two of the controller registers instead of
directly mapped.

Thanks,

Ray

>  	if (!pcie->base) {
>  		dev_err(dev, "unable to map controller registers\n");
>  		return -ENOMEM;
> 
