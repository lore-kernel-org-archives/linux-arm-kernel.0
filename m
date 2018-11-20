From: minghuan.lian@nxp.com (M.h. Lian)
Date: Tue, 20 Nov 2018 11:26:28 +0000
Subject: [PATCHv2 18/25] PCI: mobiveil: continue to initialize the host
 upon no PCIe link
In-Reply-To: <20181120092615.11680-19-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-19-Zhiqiang.Hou@nxp.com>
Message-ID: <HE1PR0401MB223595ADCC743237CC48E3A8E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 20, 2018 5:27 PM
> To: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> bhelgaas at google.com; robh+dt at kernel.org; mark.rutland at arm.com;
> l.subrahmanya at mobiveil.co.in; shawnguo at kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com;
> catalin.marinas at arm.com; will.deacon at arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCHv2 18/25] PCI: mobiveil: continue to initialize the host upon
> no PCIe link
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Sometimes there is not a PCIe Endpoint in the PCIe slot, so do not exit when
> the PCIe link is not up. And degrade the print level of link up info.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
> 
>  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 1 -
>  drivers/pci/controller/mobiveil/pcie-mobiveil.c      | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index 1ae82e790562..d1765d572f44 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -596,7 +596,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie
> *pcie)
>  	ret = mobiveil_bringup_link(pcie);
>  	if (ret) {
>  		dev_info(dev, "link bring-up failed\n");
> -		goto error;
>  	}
> 
>  	/* setup the kernel resources for the newly added PCIe root bus */
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> index ee678a60825d..370658d6546d 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> @@ -222,7 +222,7 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
>  		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
>  	}
> 
> -	dev_err(&pcie->pdev->dev, "link never came up\n");
> +	dev_info(&pcie->pdev->dev, "link never came up\n");
> 
>  	return -ETIMEDOUT;
>  }
> --
> 2.17.1
