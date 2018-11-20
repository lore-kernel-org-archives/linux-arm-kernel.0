From: minghuan.lian@nxp.com (M.h. Lian)
Date: Tue, 20 Nov 2018 10:34:23 +0000
Subject: [PATCHv2 05/25] PCI: mobiveil: correct PCI base address in MEM/IO
 outbound windows
In-Reply-To: <20181120092615.11680-6-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-6-Zhiqiang.Hou@nxp.com>
Message-ID: <HE1PR0401MB2235D9D485A1CC090CC6C6D3E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
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
> Subject: [PATCHv2 05/25] PCI: mobiveil: correct PCI base address in MEM/IO
> outbound windows
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> It should get PCI base address from the DT node property 'ranges'
> to setup MEM/IO outbound windows instead of always zero.
> 
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Added fixes entry.
> 
>  drivers/pci/controller/pcie-mobiveil.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index a0dd337c6214..8ff873023b5f 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -630,8 +630,9 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
> 
>  		/* configure outbound translation window */
>  		program_ob_windows(pcie, pcie->ob_wins_configured,
> -				   win->res->start, 0, type,
> -				   resource_size(win->res));
> +				   win->res->start,
> +				   win->res->start - win->offset,
> +				   type, resource_size(win->res));
>  	}
> 
>  	/* setup MSI hardware registers */
> --
> 2.17.1
