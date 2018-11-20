From: minghuan.lian@nxp.com (M.h. Lian)
Date: Tue, 20 Nov 2018 11:26:13 +0000
Subject: [PATCHv2 17/25] PCI: mobiveil: fix the checking of valid device
In-Reply-To: <20181120092615.11680-18-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-18-Zhiqiang.Hou@nxp.com>
Message-ID: <HE1PR0401MB22354A5A97A9E871B99FD42AE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
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
> Subject: [PATCHv2 17/25] PCI: mobiveil: fix the checking of valid device
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Avoid to issue CFG transactions to link partner when the PCIe link is not up.
> And allow CFG transactions to all functions of Endpoint implemented
> multiple functions.
> 
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - New patch
> 
>  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index dc5324d94466..1ae82e790562 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -29,6 +29,10 @@ static bool mobiveil_pcie_valid_device(struct pci_bus
> *bus, unsigned int devfn)  {
>  	struct mobiveil_pcie *pcie = bus->sysdata;
> 
> +	/* If there is no link, then there is no device */
> +	if (bus->number > pcie->rp.root_bus_nr
> && !mobiveil_pcie_link_up(pcie))
> +		return false;
> +
>  	/* Only one device down on each root port */
>  	if ((bus->number == pcie->rp.root_bus_nr) && (devfn > 0))
>  		return false;
> @@ -37,7 +41,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus
> *bus, unsigned int devfn)
>  	 * Do not read more than one device on the bus directly
>  	 * attached to RC
>  	 */
> -	if ((bus->primary == pcie->rp.root_bus_nr) && (devfn > 0))
> +	if ((bus->primary == pcie->rp.root_bus_nr) && (PCI_SLOT(devfn) > 0))
>  		return false;
> 
>  	return true;
> --
> 2.17.1
