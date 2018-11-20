From: minghuan.lian@nxp.com (M.h. Lian)
Date: Tue, 20 Nov 2018 11:30:58 +0000
Subject: [PATCHv2 21/25] PCI: mobiveil: make mobiveil_host_init can be
 used to re-init host
In-Reply-To: <20181120092615.11680-22-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-22-Zhiqiang.Hou@nxp.com>
Message-ID: <HE1PR0401MB223545A1B302BE7B5BC816FCE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 20, 2018 5:28 PM
> To: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> bhelgaas at google.com; robh+dt at kernel.org; mark.rutland at arm.com;
> l.subrahmanya at mobiveil.co.in; shawnguo at kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com;
> catalin.marinas at arm.com; will.deacon at arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCHv2 21/25] PCI: mobiveil: make mobiveil_host_init can be used
> to re-init host
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Make the mobiveil_host_init function can be used to re-init host controller's
> PAB and GPEX CSR register block, as NXP integrated Mobiveil IP has to reset
> and then re-init the PAB and GPEX CSR registers upon Hot-reset.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Reset the statistic of IB/OB windows configured.
>  - Change the type of member 'resources' to pointer to record the parsed
>    resources for re-init the outbound windows.
> 
>  .../controller/mobiveil/pcie-mobiveil-host.c  | 32 +++++++++++--------
>  .../pci/controller/mobiveil/pcie-mobiveil.h   |  3 +-
>  2 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index d028cdf31d0e..c85f00d3cfcf 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -217,7 +217,7 @@ static void mobiveil_pcie_enable_msi(struct
> mobiveil_pcie *pcie)
>  	writel_relaxed(1, pcie->apb_csr_base + MSI_ENABLE_OFFSET);  }
> 
> -static int mobiveil_host_init(struct mobiveil_pcie *pcie)
> +int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit)
>  {
>  	u32 value, pab_ctrl, type;
>  	struct resource_entry *win;
> @@ -229,11 +229,16 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
>  	for (i = 0; i < pcie->ppio_wins; i++)
>  		mobiveil_pcie_disable_ib_win(pcie, i);
> 
> -	/* setup bus numbers */
> -	value = csr_readl(pcie, PCI_PRIMARY_BUS);
> -	value &= 0xff000000;
> -	value |= 0x00ff0100;
> -	csr_writel(pcie, value, PCI_PRIMARY_BUS);
> +	pcie->ib_wins_configured = 0;
> +	pcie->ob_wins_configured = 0;
> +
> +	if (!reinit) {
> +		/* setup bus numbers */
> +		value = csr_readl(pcie, PCI_PRIMARY_BUS);
> +		value &= 0xff000000;
> +		value |= 0x00ff0100;
> +		csr_writel(pcie, value, PCI_PRIMARY_BUS);
> +	}
> 
>  	/*
>  	 * program Bus Master Enable Bit in Command Register in PAB Config
> @@ -279,7 +284,7 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
>  	program_ib_windows(pcie, WIN_NUM_0, 0, 0,
> MEM_WINDOW_TYPE, IB_WIN_SIZE);
> 
>  	/* Get the I/O and memory ranges from DT */
> -	resource_list_for_each_entry(win, &pcie->resources) {
> +	resource_list_for_each_entry(win, pcie->resources) {
>  		if (resource_type(win->res) == IORESOURCE_MEM) {
>  			type = MEM_WINDOW_TYPE;
>  		} else if (resource_type(win->res) == IORESOURCE_IO) { @@ -
> 550,8 +555,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>  	resource_size_t iobase;
>  	int ret;
> 
> -	INIT_LIST_HEAD(&pcie->resources);
> -
>  	ret = mobiveil_pcie_parse_dt(pcie);
>  	if (ret) {
>  		dev_err(dev, "Parsing DT failed, ret: %x\n", ret); @@ -565,17
> +568,19 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
> 
>  	/* parse the host bridge base addresses from the device tree file */
>  	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> -						    &pcie->resources, &iobase);
> +						    &bridge->windows,
> &iobase);
>  	if (ret) {
>  		dev_err(dev, "Getting bridge resources failed\n");
>  		return ret;
>  	}
> 
> +	pcie->resources = &bridge->windows;
> +
>  	/*
>  	 * configure all inbound and outbound windows and prepare the RC
> for
>  	 * config access
>  	 */
> -	ret = mobiveil_host_init(pcie);
> +	ret = mobiveil_host_init(pcie, false);
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize host\n");
>  		goto error;
> @@ -587,12 +592,11 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie
> *pcie)
>  		goto error;
>  	}
> 
> -	ret = devm_request_pci_bus_resources(dev, &pcie->resources);
> +	ret = devm_request_pci_bus_resources(dev, pcie->resources);
>  	if (ret)
>  		goto error;
> 
>  	/* Initialize bridge */
> -	list_splice_init(&pcie->resources, &bridge->windows);
>  	bridge->dev.parent = dev;
>  	bridge->sysdata = pcie;
>  	bridge->busnr = pcie->rp.root_bus_nr;
> @@ -619,6 +623,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie
> *pcie)
> 
>  	return 0;
>  error:
> -	pci_free_resource_list(&pcie->resources);
> +	pci_free_resource_list(pcie->resources);
>  	return ret;
>  }
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 933c2f34bc52..0f5303962e88 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -152,7 +152,7 @@ struct mobiveil_pab_ops {
> 
>  struct mobiveil_pcie {
>  	struct platform_device *pdev;
> -	struct list_head resources;
> +	struct list_head *resources;
>  	void __iomem *csr_axi_slave_base;	/* PAB registers base */
>  	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
>  	void __iomem *apb_csr_base;	/* MSI register base */
> @@ -165,6 +165,7 @@ struct mobiveil_pcie {  };
> 
>  int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie);
> +int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit);
>  bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie);  int
> mobiveil_bringup_link(struct mobiveil_pcie *pcie);  void
> program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64
> cpu_addr,
> --
> 2.17.1
