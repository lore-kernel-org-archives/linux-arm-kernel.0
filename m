From: minghuan.lian@nxp.com (M.h. Lian)
Date: Tue, 20 Nov 2018 10:31:53 +0000
Subject: [PATCHv2 03/25] PCI: mobiveil: correct the returned error number
In-Reply-To: <20181120092615.11680-4-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-4-Zhiqiang.Hou@nxp.com>
Message-ID: <HE1PR0401MB223513976E17780C1A19EFEDE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 20, 2018 5:26 PM
> To: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> bhelgaas at google.com; robh+dt at kernel.org; mark.rutland at arm.com;
> l.subrahmanya at mobiveil.co.in; shawnguo at kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com;
> catalin.marinas at arm.com; will.deacon at arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCHv2 03/25] PCI: mobiveil: correct the returned error number
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This patch corrected the returned error number by convention, and removed
> a unnecessary error check.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
> 
>  drivers/pci/controller/pcie-mobiveil.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index b87471f08a40..563210e731d3 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -819,7 +819,7 @@ static int mobiveil_pcie_init_irq_domain(struct
> mobiveil_pcie *pcie)
> 
>  	if (!pcie->intx_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> -		return -ENODEV;
> +		return -ENOMEM;
>  	}
> 
>  	raw_spin_lock_init(&pcie->intx_mask_lock);
> @@ -845,11 +845,9 @@ static int mobiveil_pcie_probe(struct
> platform_device *pdev)
>  	/* allocate the PCIe port */
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
>  	if (!bridge)
> -		return -ENODEV;
> +		return -ENOMEM;
> 
>  	pcie = pci_host_bridge_priv(bridge);
> -	if (!pcie)
> -		return -ENOMEM;
> 
>  	pcie->pdev = pdev;
> 
> @@ -866,7 +864,7 @@ static int mobiveil_pcie_probe(struct platform_device
> *pdev)
>  						    &pcie->resources, &iobase);
>  	if (ret) {
>  		dev_err(dev, "Getting bridge resources failed\n");
> -		return -ENOMEM;
> +		return ret;
>  	}
> 
>  	/*
> --
> 2.17.1
