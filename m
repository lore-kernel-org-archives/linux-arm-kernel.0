From: minghuan.lian@nxp.com (M.h. Lian)
Date: Tue, 20 Nov 2018 11:12:44 +0000
Subject: [PATCHv2 13/25] PCI: mobiveil: move irq chained handler setup out
 of DT parse
In-Reply-To: <20181120092615.11680-14-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-14-Zhiqiang.Hou@nxp.com>
Message-ID: <HE1PR0401MB22357E7A16AD7261C5C6A14AE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
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
> Subject: [PATCHv2 13/25] PCI: mobiveil: move irq chained handler setup out
> of DT parse
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Move irq_set_chained_handler_and_data() out of DT parse function.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
> 
>  drivers/pci/controller/pcie-mobiveil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index c2848c22b466..db7ecb021c63 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -460,8 +460,6 @@ static int mobiveil_pcie_parse_dt(struct
> mobiveil_pcie *pcie)
>  		return -ENODEV;
>  	}
> 
> -	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr,
> pcie);
> -
>  	return 0;
>  }
> 
> @@ -902,6 +900,8 @@ static int mobiveil_pcie_probe(struct platform_device
> *pdev)
>  		goto error;
>  	}
> 
> +	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr,
> pcie);
> +
>  	ret = devm_request_pci_bus_resources(dev, &pcie->resources);
>  	if (ret)
>  		goto error;
> --
> 2.17.1
